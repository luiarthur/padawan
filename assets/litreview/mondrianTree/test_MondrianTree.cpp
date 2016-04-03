#include <iostream>
#include "mondrianTree.h"
#include "readMatrix.h" // readMatrix, printMatrix

using namespace std;

int main() {
  mondrianTree mt;
  //mt.ext(1,2,3,4);
  //mt.ext(2,1,4,5);
  //mt.print();

  vector< vector<double> > X = readMatrix("dat.txt");
  mt.sample(X,2);

}
