#include <Rcpp.h>
using namespace Rcpp;

// Creates matrix with indices for building contrasts
// just like the R command t(combn(1:x, 2)) does, but
// in a straightforward fashion (=faster).

// [[Rcpp::export]]
IntegerMatrix combSimple(int x) {
  int m = (x*x - x) / 2;
  IntegerMatrix ans(m, 2);
  int i, j, r;
  i = 1;
  r = 0;
  while(i < x){
    j = i + 1;
    while(j <= x){
       ans(r, 0) = i;
       ans(r, 1) = j;
       j++;
       r++;
     }
    i++;
  }
  return ans;
}
