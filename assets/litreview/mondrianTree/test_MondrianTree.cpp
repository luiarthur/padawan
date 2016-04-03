#include <iostream>
#include "mondrianTree.h"

using namespace std;

int main() {

  tuple<int,double,double> dat(1,2,3);
  tuple<int,double,double> dat1(2,4,6);
  tuple<int,double,double> dat2(1,3,5);

  mondrianTree root(dat);
  mondrianTree lT(dat1);
  mondrianTree rT(dat2);
  mondrianTree big(dat,lT,rT);

  cout << get<0>(big.get_left_tree()->dxt) ;
}
