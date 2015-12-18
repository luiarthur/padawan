// my_gsl.h is included in bayesMLR.c
// Contains wrapper funtions 
// References: 
// https://www.gnu.org/software/gsl/manual/html_node/Matrices.html
// https://github.com/Blei-Lab/diln/blob/master/gsl_wrapper.c
#include <stdio.h>             // standard input/output
#include <stdlib.h>            // malloc
#include <math.h>              // fabs, sqrt, etc.
#include <time.h>              // time / set seed
#include <gsl/gsl_rng.h>       // GNU Scientific Library
#include <gsl/gsl_cdf.h>       // GNU Scientific Library
#include <gsl/gsl_randist.h>   // GNU Scientific Library
#include <gsl/gsl_linalg.h>    // GNU Scientific Library
#include <gsl/gsl_matrix.h>    // GNU Scientific Library
#include <gsl/gsl_statistics.h>// GNU Scientific Library
#include <gsl/gsl_blas.h>      // GSL Basic Linear Algebra
#define pi 3.14159265358979323846

// Reading Matrices ////////////////////////////////////////////////
int countFileRows(char* filename) {
  // Count number of rows in file "filename"
  FILE *fp;
  int count = 0;  // Line counter (result)
  char c;  // To store a character read from file

  fp = fopen(filename, "r");
  // Extract characters from file and store in character c
  if (fp) { // check file existence
  for (c = getc(fp); c != EOF; c = getc(fp))
      if (c == '\n') // Increment count if this character is newline
          count = count + 1;
  }
  fclose(fp);

  return count;
}

int countFileCols(char* filename, char delim) {
  // Count number of columns in file "filename" (with delimiter delim)
  FILE *fp = fopen(filename, "r");
  char c;
  int count = 0;

  while( c=fgetc(fp) ) {
    if(c == EOF) {
      break; /* break if end of file */
    } else if (c == delim) {
      count += 1; /* otherwise add one to the count */
    } else if (c == '\n') {
      count += 1;
      break;
    }
  }
  fclose(fp);

  return count;
}

void read_csv(char* filename, gsl_matrix* m) {
  // Read a csv into matrix m
  FILE* f = fopen(filename, "r");
  gsl_matrix_fscanf(f, m);
  fclose(f);
}

// Printing Matrix Info ////////////////////////////
void print_vector(gsl_matrix* v, char* filename) {
  FILE* f;
  if (filename == "") {
    f = stdout;
    printf("\n");
  } else {
    f = fopen(filename, "w");
  }

  gsl_vector_fprintf(f,v,"%g");
}

void print_matrix(gsl_matrix* m, char* filename) {
  // print matrix to filename or stdout if filename == ""
  FILE* f;
  if (filename == "") {
    f = stdout;
    printf("\n");
  } else {
    f = fopen(filename, "w");
  }
  int n = m->size1;
  int k = m->size2;
  
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < k; j++) {
      fprintf (f, "%g\t", gsl_matrix_get (m, i, j));
    }
    fprintf (f, "\n");
  }

  if (filename == "") {
    printf("\n");
  } else {
    fclose(f);
  }
}

void print_matrix_dims(gsl_matrix* m) {
  // print dimensions of matrix m
  printf("%d%s%d\n",m->size1,"x",m->size2);
}

// Access Matrix Elements: //////////////////////////////////
void mat_sub(gsl_matrix* X, size_t r1, size_t r2, size_t c1, size_t c2, gsl_matrix* X_new) {
  gsl_matrix_view x = gsl_matrix_submatrix(X,r1,c1,r2-r1+1,c2-c1+1);
  gsl_matrix_memcpy(X_new,&x.matrix);
}

// Random Number Functions: /////////////////////////////////
double runif() {
  // Returns a random number b/w 0 & 1
  return (double) rand() / (double) RAND_MAX;
}

void mvrnorm(gsl_vector* m, gsl_matrix* cholS, gsl_rng* r, gsl_vector* out) {
  // vector addition, vector prod
  // m + cholS * e

  int n = m->size;
  double tmp;
  gsl_vector* e = gsl_vector_alloc(n);

  for (int i=0; i<n; i++) {
    tmp = 0;
    for (int j=0; j<n; j++) {
      if (i==0) gsl_vector_set(e,j,gsl_ran_gaussian(r,1.0));
      tmp += gsl_matrix_get(cholS,i,j) * gsl_vector_get(e,j);
    }
    gsl_vector_set(out,i,gsl_vector_get(m,i) + tmp);
  }

  gsl_vector_free(e);
}


// Linear Algebra Wrappers //////////////////////////////////
// mm: matrix-matrix
// mv: matrix-vector
// ms: matrix-scalar
//  d: double real
// ge: general matrix
void mm_prod(gsl_matrix* A, gsl_matrix* B, double a, double b, gsl_matrix* out) {
}

void mm_add(gsl_matrix* A, gsl_matrix* B, double a, double b, gsl_matrix* out) {
}

void mv_prod(gsl_matrix* A, gsl_vector* x, double a, gsl_vector* out) {
  gsl_blas_dgemv(CblasNoTrans,a,A,x,0.0,out);
}

void vv_add(gsl_vector* x, gsl_vector* y, gsl_vector *out) {
  // sum two vectors
  if (x->size != y->size)
    error("Error in vv_add(): input vectors must have the same dimensionality");
  else if (x->size != out->size || y->size != out->size)
    error("Error in vv_add(): output vector has incorrect dimensions");

  double tmp;
  int n = x->size;

  for (int i=0; i<n; i++) {
    tmp = gsl_vector_get(x,i) + gsl_vector_get(y,i);
    gsl_vector_set(out,i,tmp);
  }
}

double vv_prod(gsl_vector* x, gsl_vector* y) {
  // dot product
  if (x->size != y->size)
    error("Error in vv_prod(): input vectors must have the same dimensionality");

  double out = 0;
  int n = x->size;

  for (int i=0; i<n; i++) {
    out += gsl_vector_get(x,i) * gsl_vector_get(y,i);
  }

  return out;
}


void mat_inv(gsl_matrix * X, gsl_matrix * invX) {
// invert the matrix X
    int signum;
    gsl_matrix * LU = gsl_matrix_calloc(X->size1,X->size2);
    gsl_permutation * p = gsl_permutation_calloc(X->size1);
    gsl_matrix_memcpy(LU,X);

    gsl_linalg_LU_decomp (LU,p,&signum);
    gsl_linalg_LU_invert(LU,p,invX);

    gsl_matrix_free(LU);
    gsl_permutation_free(p);
}

void xxi_m(gsl_matrix* X, gsl_matrix* xxi) {
  int n = X->size1;
  int k = X->size2;
  double dot;
  gsl_matrix* xx = gsl_matrix_alloc(k,k);

  for (int i=0; i<k; i++) {
    for (int j=0; j<=i; j++) {
      dot = 0;
      for (int z=0; z<n; z++) {
        dot += gsl_matrix_get(X,z,i) * gsl_matrix_get(X,z,j);
      }
      gsl_matrix_set(xx,j,i,dot);
      gsl_matrix_set(xx,i,j,dot);
    }
  }

  mat_inv(xx,xxi);
  gsl_matrix_free(xx);
}


int my_gsl_linalg_cholesky_decomp (gsl_matrix * A)
{
  const size_t M = A->size1;
  const size_t N = A->size2;

  if (M != N)
    {
      GSL_ERROR("cholesky decomposition requires square matrix", GSL_ENOTSQR);
    }
  else
    {
      size_t i,j,k;
      int status = 0;

      /* Do the first 2 rows explicitly.  It is simple, and faster.  And
       * one can return if the matrix has only 1 or 2 rows.  
       */

      double A_00 = gsl_matrix_get (A, 0, 0);
      
      double L_00 = sqrt(A_00);
      
      if (A_00 <= 0)
        {
          status = GSL_EDOM ;
        }

      gsl_matrix_set (A, 0, 0, L_00);
  
      if (M > 1)
        {
          double A_10 = gsl_matrix_get (A, 1, 0);
          double A_11 = gsl_matrix_get (A, 1, 1);
          
          double L_10 = A_10 / L_00;
          double diag = A_11 - L_10 * L_10;
          double L_11 = sqrt(diag);
          
          if (diag <= 0)
            {
              status = GSL_EDOM;
            }

          gsl_matrix_set (A, 1, 0, L_10);        
          gsl_matrix_set (A, 1, 1, L_11);
        }
      
      for (k = 2; k < M; k++)
        {
          double A_kk = gsl_matrix_get (A, k, k);
          
          for (i = 0; i < k; i++)
            {
              double sum = 0;

              double A_ki = gsl_matrix_get (A, k, i);
              double A_ii = gsl_matrix_get (A, i, i);

              gsl_vector_view ci = gsl_matrix_row (A, i);
              gsl_vector_view ck = gsl_matrix_row (A, k);

              if (i > 0) {
                gsl_vector_view di = gsl_vector_subvector(&ci.vector, 0, i);
                gsl_vector_view dk = gsl_vector_subvector(&ck.vector, 0, i);
                
                gsl_blas_ddot (&di.vector, &dk.vector, &sum);
              }

              A_ki = (A_ki - sum) / A_ii;
              gsl_matrix_set (A, k, i, A_ki);
            } 

          {
            gsl_vector_view ck = gsl_matrix_row (A, k);
            gsl_vector_view dk = gsl_vector_subvector (&ck.vector, 0, k);
            
            double sum = gsl_blas_dnrm2 (&dk.vector);
            double diag = A_kk - sum * sum;

            double L_kk = sqrt(diag);
            
            if (diag <= 0)
              {
                status = GSL_EDOM;
              }
            
            gsl_matrix_set (A, k, k, L_kk);
          }
        }

      /* Now copy the transposed lower triangle to the upper triangle,
       * the diagonal is common.  
       */
      
      for (i = 1; i < M; i++)
        {
          for (j = 0; j < i; j++)
            {
              double A_ij = 0;//gsl_matrix_get (A, i, j);
              gsl_matrix_set (A, j, i, A_ij);
            }
        } 
      
      if (status == GSL_EDOM)
        {
          GSL_ERROR ("matrix must be positive definite", GSL_EDOM);
        }
      
      return GSL_SUCCESS;
    }
}

void chol(gsl_matrix* X, gsl_matrix* cholS) {
  int n = X->size1;
  gsl_matrix_memcpy(cholS,X);
  my_gsl_linalg_cholesky_decomp(cholS);

  // lower tri stored in cholS.
  // So: mvrnorm <- function(M,S,n=nrow(S)) M + chol(S) %*% rnorm(n)
}
