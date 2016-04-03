#pragma once

#include <iostream>
#include <tuple>
#include <sstream>

// p.254 (List), p.459 (Tree)
struct mondrianNode {

  // Data Fields
  std::tuple<int,double,double> dxt; // split dimension, location, time
  mondrianNode *left;
  mondrianNode *right;
  mondrianNode *parent;

  // Constructor
  mondrianNode(const std::tuple<int,double,double>& dat, 
               mondrianNode* left_val=NULL,
               mondrianNode* right_val=NULL,
               mondrianNode* parent_val=NULL) :
    dxt(dat), left(left_val), right(right_val), parent(parent_val) {}
  
  // Destructor (to avoid warning message). Does nothing.
  //virtual ~mondrianNode() {}

  virtual std::string to_string() const {
    std::ostringstream os;
    os << std::get<0>(dxt) << "," << std::get<1>(dxt) << "," << std::get<2>(dxt);
    return os.str();
  }
};
