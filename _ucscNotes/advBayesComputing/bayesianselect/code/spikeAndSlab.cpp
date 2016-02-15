//[[Rcpp::depends(RcppArmadillo)]]
#include <func.cpp> // wsample, ldnorm, mvrnorm

//Working!

//[[Rcpp::export]]
List spikeAndSlab(vec y, mat x, vec tau2, double g, vec w, int B, int burn, bool printProg, bool returnHyper) {
  int n = y.size();
  int J = x.n_cols;
  mat beta = ones<mat>(B,J);
  double p1, p0, lp1, lp0;
  mat gam = zeros<mat>(B,J);
  mat xx = x.t() * x;
  mat xy = x.t() * y;
  //mat D2 = eye<mat>(J,J);
  mat D2i = eye<mat>(J,J);
  int dummy;
  List ret;
  vec m;
  mat S;


  for (int b=1; b<B; b++) {

    // Update beta
    S = (xx + D2i).i();//(xx + D2.i()).i();
    m = S * xy;
    beta.row(b) = reshape(mvrnorm(m,S),1,J);

    // Update gamma
    for (int j=0; j<J; j++) {
      //w[j] = rbeta(1,.5+gam(b-1,j),.5+1-gam(b-1,j))[0];
      lp1 = ldnorm(beta(b,j),0,g*tau2[j]) + log(w[j]);
      lp0 = ldnorm(beta(b,j),0,tau2[j]) + log(1-w[j]);

      p0 = exp( lp0 - max({lp0,lp1}) );
      p1 = exp( lp1 - max({lp0,lp1}) );

      gam(b,j) = wsample( {0,1}, {p0,p1} );
      if ( gam(b,j) == 1 ) {
        D2i(j,j) = 1 / (g * tau2[j]);
        //D2(j,j) = g * tau2[j];
      } else {
        D2i(j,j) = 1 / tau2[j];
        //D2(j,j) = tau2[j];
      }
    }

    if (printProg) Rcout << "\rProgress: " << b << "/" << B;
  }

  ret["beta"] = beta.tail_rows(B-burn);

  if (returnHyper) {
    ret["gam"] = gam.tail_rows(B-burn);
  }

  return ret;
}
