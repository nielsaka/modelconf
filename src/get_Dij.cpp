# include <Rcpp.h>
# include <math.h>

using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix get_Dij(NumericMatrix bdta, NumericMatrix index){
	int B = bdta.ncol();
	int R = index.nrow(); // R = (m^2 - m) / 2; m = # models
	
	NumericMatrix bdta_Dij(R, B); 
	
	for (int b = 0; b < B; ++b) {
		for (int r = 0; r < R; ++r) {
			bdta_Dij(r, b) =  bdta(index(r, 0), b)  -  bdta(index(r, 1), b);
		}
	}
	return bdta_Dij;
}
// [[Rcpp::export]]
NumericMatrix get_Dij_abs(NumericMatrix bdta, NumericMatrix index){
	int B = bdta.ncol();
	int R = index.nrow(); // R = (m^2 - m) / 2; m = # models
	
	NumericMatrix bdta_Dij(R, B); 
	
	for (int b = 0; b < B; ++b) {
		for (int r = 0; r < R; ++r) {
			bdta_Dij(r, b) =  fabs(bdta(index(r, 0), b)  -  bdta(index(r, 1), b));
		}
	}
	return bdta_Dij;
}

/*** R
library(microbenchmark)

index <- t(combn(1:5,2))
A <- matrix(1:25, 5, 5)

(B <- get_Dij(A, index - 1))
(C <- get_Dij_abs(A, index - 1))

D <- matrix(1:1e4, 100, 100)
index <- t(combn(1:100, 2))
microbenchmark(abs(get_Dij(D, index - 1)), get_Dij_abs(D, index - 1))
*/