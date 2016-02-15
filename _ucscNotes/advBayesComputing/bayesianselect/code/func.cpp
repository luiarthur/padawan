//[[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
#include <iostream>
#include <algorithm> // unique
#include <RcppArmadilloExtensions/sample.h> // For wsample

using namespace std;
using namespace arma;
using namespace Rcpp;

const double pi  =3.141592653589793238462;

double wsample( vec x, vec prob ) {
  NumericVector ret = Rcpp::RcppArmadillo::sample(
      as<NumericVector>(wrap(x)), 1, true, 
      as<NumericVector>(wrap(prob))) ;
  return ret[0] ;
}

double ldnorm (double x, double m, double s2) {
  return -.5*log(s2) -.5 * pow(x-m, 2.0) / s2;
}

vec mvrnorm(vec m, mat S) {
  int n = m.size();
  vec e = randn(n);
  return m + chol(S).t() * e;
}

double rinvGaussian(double m, double s) {
  double out;
  double v = randn();
  double y = v*v;
  double x = m + (m*m*y)/(2*s) - (m/(2*s)) * sqrt(4*m*s*y + m*m*y*y);

  if ( m/(m+x) >= randu() ) {
    out = x;
  } else {
    out = m*m/x;
  }

  return out;
}
