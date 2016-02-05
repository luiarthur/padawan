#include "my_gsl.h" // print & read matrices / other functions

double lpb(gsl_vector* b, gsl_matrix* XXi, double s2) {
  // b' XXi b / (-2*s2)
  int n = b->size;
  double out = 0;
  double rowSum;

  gsl_vector* XXib = gsl_vector_alloc(n);
  mv_prod(XXi,b,1.0,XXib);
  out = vv_prod(b,XXib);
  gsl_vector_free(XXib);

  out = out / -(2*s2);

  return out;
}

double lps(double s2, double a, double b) {
  return (a-1) * log(s2) - s2/b;
}

double ll(gsl_vector* b, double s2, gsl_vector* y, gsl_matrix* X) {
  // c = y-X*be
  // c'c/(-2sig2)-n*log(sig2)/2 

  int n = y->size;
  double out;
  gsl_vector* c = gsl_vector_alloc(n);
  gsl_vector_memcpy(c,y);
  gsl_blas_dgemv(CblasNoTrans,-1.0,X,b,1.0,c);
  out = vv_prod(c,c) / (-2*s2) - n * log(s2) / 2;
  gsl_vector_free(c);

  return out;
}

int main(int argc, char* argv[]) {
  // chol
  gsl_rng* r = gsl_rng_alloc(gsl_rng_taus);
  char* filename = "../data/dat.txt";
  int n = countFileRows(filename);
  int k1 = countFileCols(filename,' ');
  int k = k1 - 1;

  gsl_matrix* M = gsl_matrix_alloc(n,k1);
  gsl_matrix* X = gsl_matrix_alloc(n,k);
  gsl_vector* y = gsl_vector_alloc(n);
  gsl_matrix* XXi = gsl_matrix_alloc(k,k);
  gsl_matrix* csb = gsl_matrix_alloc(k,k);
  gsl_matrix* cholS = gsl_matrix_alloc(k,k);

  read_csv(filename, M);
  mat_sub(M,0,n-1,1,k,X);
  gsl_matrix_get_col(y,M,0);

  xxi_m(X,XXi);
  gsl_matrix_memcpy(csb,XXi);
  gsl_matrix_scale(csb,4);
  chol(csb,cholS);

  int B = 100000;
  int acc_b = 0;
  int acc_s = 0;
  gsl_matrix* bb = gsl_matrix_alloc(B,k);
  gsl_vector* ss = gsl_vector_alloc(B);
  gsl_matrix_set_zero(bb);
  gsl_vector_set_all(ss,1);
  gsl_vector* candb = gsl_vector_alloc(k);
  gsl_vector* currb = gsl_vector_alloc(k);
  double cands;
  double sc = 1;
  double css = 1;
  double q;
  double a = 1;
  double b = 1;

  for (int b=1; b<B; b++) {

    // update beta
    mvrnorm(currb,cholS,r,candb);
    q = ll(candb,sc,y,X) + lpb(candb,XXi,sc)-
        ll(currb,sc,y,X) - lpb(currb,XXi,sc);

    if (q>log(runif())) {
      gsl_vector_memcpy(currb,candb);
      acc_b += 1;
    }

    // update s2
    cands = sc + gsl_ran_gaussian(r,css);
    if (cands > 0) {
      q = ll(currb,cands,y,X) + lps(cands,a,b) -
          ll(currb,sc,y,X)    - lps(sc,a,b);
      if (q>log(runif())) {
        sc = cands;
        acc_s += 1;
      }
    }

    // set bb, ss
    gsl_matrix_set_row(bb,b,currb);
    gsl_vector_set(ss,b,sc);

    printf("\r%d%s", (b+1)*100/B, "%");
  }


  print_matrix(bb,"out/beta.dat");
  print_vector(ss,"out/s2.dat");
  // Free Memory:
  gsl_matrix_free(cholS);
  gsl_vector_free(candb);
  gsl_vector_free(ss);
  gsl_vector_free(currb);
  gsl_matrix_free(bb);
  gsl_matrix_free(csb);
  gsl_matrix_free(XXi);
  gsl_vector_free(y);
  gsl_matrix_free(X);
  gsl_matrix_free(M);
  gsl_rng_free(r);

  return 0;
}
