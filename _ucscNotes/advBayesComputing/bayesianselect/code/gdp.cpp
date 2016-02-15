//[[Rcpp::depends(RcppArmadillo)]]
#include <func.cpp> // wsample, ldnorm, mvrnorm

double alpha_update(vec beta, double eta) {
  int p = beta.size();
  vec a = linspace<vec>(.1,1,10);
  vec logprobs = p * log(1/a - 1) -1/a * sum(log(1+abs(beta)/eta));
  vec probs = exp(logprobs - max(logprobs));
  
  double out_a = wsample(a,probs);
  return 1/out_a - 1;
}

double eta_update(vec beta, double alpha) {
  int p = beta.size();
  vec e = linspace<vec>(.1,1,10);
  vec logprobs = zeros<vec>(10);
  for (int j=0; j<p; j++) {
    logprobs[j] = -p * log(1/e[j]-1) -(alpha+1) * sum(log(1+e[j]*abs(beta)/(1-e[j]) ));
  }
  vec probs = exp(logprobs - max(logprobs));
  
  double out_e = wsample(e,probs);
  return 1/out_e - 1;
}


//[[Rcpp::export]]
List gdp(vec y, mat x, int B, int burn, bool printProg, bool returnHyper) {
  int n = y.size();
  int J = x.n_cols;
  mat beta = ones<mat>(B,J);
  mat lam = ones<mat>(B,J);
  mat tau = ones<mat>(B,J);
  vec alpha = ones<vec>(B);
  vec eta = ones<vec>(B);
  mat xx = x.t() * x;
  mat xy = x.t() * y;
  mat D = eye<mat>(J,J);
  mat S = eye<mat>(J,J);
  vec a = ones<vec>(10);
  vec e = ones<vec>(10);
  vec prob = ones<vec>(10);
  double m, sc;
  List ret;

  for (int b=1; b<B; b++) {
    // Update beta
    S = (xx + D.i()).i();
    beta.row(b) = reshape(mvrnorm(S*xy, S), 1, J);

    // Update lambda_j, tau_j
    for (int j=0; j<J; j++) {
      // Update lambda
      sc = 1 / ( abs(beta(b,j)) + eta[b-1] );
      lam(b,j) = rgamma(1,alpha[b-1]+1, sc)[0]; // shape, scale

      // Update tau
      m = lam(b,j) / abs(beta(b,j));
      tau(b,j) = 1 /  rinvGaussian(m, lam(b,j) * lam(b,j));
    }

    // Update alpha. Greedy Gibbs.
    alpha[b] = alpha_update(vectorise(beta.row(b)),eta[b-1]);

    // Update eta. Greedy Gibbs.
    eta[b] = alpha_update(vectorise(beta.row(b)),alpha[b]);


    if (printProg) Rcout << "\rProgress: " << b << "/" << B;
  }

  ret["beta"] = beta.tail_rows(B-burn);

  if (returnHyper) {
    ret["lambda"] = lam.tail_rows(B-burn);
    ret["tau"] = tau.tail_rows(B-burn);
    ret["alpha"] = alpha;
    ret["eta"] = eta;
  }

  return ret;
}
