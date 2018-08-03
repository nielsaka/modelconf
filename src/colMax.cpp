# include <Rcpp.h>

using namespace Rcpp;

// [[Rcpp::export]]
NumericVector colMax(NumericMatrix X){
	int n = X.ncol();
	NumericVector V(n);
	for (int i=0; i<n; i++) {
		NumericVector W = X.column(i);
		V[i] = *std::max_element(W.begin(), W.end()); 
	}
	return V; 
}

/*** R
A <- matrix(1:100, 10, 10)
colMax(A)
*/