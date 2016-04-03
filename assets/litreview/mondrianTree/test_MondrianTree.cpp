#include <iostream>
#include "mondrianTree.h"

using namespace std;

int main() {
  mondrianTree mt;
  mt.ext(1,2,3,4);
  mt.ext(2,1,4,5);
  mt.print();

  mt.testing(0);
}
