#pragma once
#include <iostream>
#include <vector>
#include <string>
#include "mondrianNode.h"

class mondrianTree {
    public:
        mondrianTree() : root(NULL) {}

        mondrianTree(const std::tuple<int,double,double>& dat, 
                     const mondrianTree& left_child  = mondrianTree(),
                     const mondrianTree& right_child = mondrianTree(),
                     const mondrianTree& parent  = mondrianTree()) :
          root(new mondrianNode(dat, left_child.root, right_child.root, parent.root)) {}

        virtual ~mondrianTree() {} // Simply a virtual destructor to avoid warnings.
        mondrianTree get_left_tree() const;
        mondrianTree get_right_tree() const;
        const std::tuple<int,double,double>& dat() const;
        bool is_null() const;
        bool is_leaf() const;
        //virtual std::string to_string() const; // draw the tree

    protected: // protected instead of private because "mondrianNode" is secret
        mondrianTree(mondrianNode* new_root) : root(new_root) {}
        mondrianNode *root;
};
