#include <cstddef>     // for mondrianTree::to_string()
#include <sstream>     // for mondrianTree::to_string()
#include <stdexcept>   // for mondrianTree::to_string()
#include <string>      // for mondrianTree::to_string()
#include "mondrianTree.h"

mondrianTree mondrianTree::get_left_tree() const {
  if (root == NULL) {
    throw std::invalid_argument("Cannot get left subtree of Empty Tree.");
  }
  return mondrianTree(root->left);
}

mondrianTree mondrianTree::get_right_tree() const{
  if (root == NULL) {
    throw std::invalid_argument("Cannot get right subtree of Empty Tree.");
  }
  return mondrianTree(root->right);
}

bool mondrianTree::is_leaf() const {
  if (root != NULL) {
    return root->left == NULL && root->right == NULL;
  } else {
    return true;
  }
}

bool mondrianTree::is_null() const {
  return root == NULL;
}

std::string mondrianTree::to_string() const {
  std::ostringstream os;

  if (is_null()) {
    os << "NULL\n";
  } else {
    //os << (*root).to_string() << " ";
    os << (*root).to_string() << "\n";
    os << get_left_tree().to_string();
    os << get_right_tree().to_string();
  }
  return os.str();
}

//void mondrianTree::sample(std::vector< std::vector<double> > X, double lambda) {
//  cout << "HI" << endl;
//}

