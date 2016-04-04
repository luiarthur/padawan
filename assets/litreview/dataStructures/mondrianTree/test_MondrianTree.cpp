#include <iostream>
#include "mondrianTree.h"

using namespace std;

//std::ostream& operator<<(std::ostream& out, const mondrianTree& tree) {
//  return out << tree.to_string();
//}


int main() {

  tuple<int,double,double> dat(1,2,3);
  tuple<int,double,double> dat1(2,4,6);
  tuple<int,double,double> dat2(1,3,5);

  mondrianTree lT(dat1);
  mondrianTree rT(dat2);
  mondrianTree big(dat,lT,rT);
  mondrianTree rbig(dat,big,rT);
  mondrianTree rrbig(dat,lT,rbig);

  //cout << get<0>(big.get_left_tree().dxt) ;
  cout << rrbig;
 
}

// How do I better draw a tree?
//    - D3.js?
//    - R?
//    - text: http://stackoverflow.com/questions/801740/c-how-to-draw-a-binary-tree-to-the-console
