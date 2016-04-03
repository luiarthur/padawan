#include <iostream>
#include "mondrianNode.h"

using namespace std;

int main() {

  tuple<int,double,double> dat(1,2,3);
  tuple<int,double,double> dat_1(2,4,6);
  tuple<int,double,double> dat_2(1,3,5);

  mondrianNode *root = new mondrianNode(dat);
  mondrianNode *node_1 = new mondrianNode(dat_1);
  mondrianNode *node_2 = new mondrianNode(dat_2);
  
  root->left = node_1;
  root->right = node_2;
  node_1->parent = root;
  node_2->parent = root;

  cout << get<0>(root->left->parent->dxt) << endl;

  //

  mondrianTree();
}
