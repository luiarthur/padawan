//[[Rcpp::depends(RcppArmadillo)]]
#include <func.cpp> // wsample, ldnorm, mvrnorm


//[[Rcpp::export]]
List blasso(vec y, mat x, double r, double delta, int B, int burn, bool printProg, bool returnHyper) {
  int n = y.size();
  int J = x.n_cols;
  mat beta = ones<mat>(B,J);
  vec lam = ones<vec>(B);
  mat xx = x.t() * x;
  mat xy = x.t() * y;
  mat outvec = zeros<mat>(B-burn,1);
  mat S = zeros<mat>(J,J);
  mat D = eye(J,J);
  mat t2 = ones<mat>(B,J);
  double sh = J+r;
  double sc;
  double l2;
  double tin;
  List ret;


  for (int b=1; b<B; b++) {

    // Update t2
    for (int j=0; j<J; j++) {
      tin = rinvGaussian( lam[b-1]/abs(beta(b-1,j)), lam[b-1]*lam[b-1]);
      //cout << tin << ",  ";
      //if (tin < .0001) {
      //  tin = .0001;
      //}
      t2(b,j) = 1 / tin;
      D(j,j) = t2(b,j);
    }

    // Update beta
    S = (xx + D.i()).i();
    beta.row(b) = reshape(mvrnorm(S*xy,S),1,J);
    
    // Update lambda
    sc = 1 / (sum(t2.row(b))/2 + delta);
    lam[b] = sqrt( rgamma(1,sh,sc)[0] ); // shape and scale
    
    if (printProg) Rcout << "\rProgress: " << b << "/" << B;
  }

  ret["beta"] = beta.tail_rows(B-burn);
  if (returnHyper) {
    outvec = reshape(lam,B,1);
    ret["lambda"] = outvec.tail_rows(B-burn);
    ret["t2"] = t2.tail_rows(B-burn);
  }

  return ret;
}
