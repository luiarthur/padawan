#pragma once
#include <iostream>
#include <cstddef>     // for mondrianTree::to_string()
#include <sstream>     // for mondrianTree::to_string()
#include <stdexcept>   // for mondrianTree::to_string()
#include <string>      // for mondrianTree::to_string()

#include "mondrianNode.h"

class mondrianTree {
    public:
        mondrianTree() : root(NULL) {}

        mondrianTree(const std::tuple<int,double,double>& dat, 
                     const mondrianTree& left_child  = mondrianTree(),
                     const mondrianTree& right_child = mondrianTree()) :
          root(new mondrianNode(dat, left_child.root, right_child.root)) {}

        virtual ~mondrianTree() {} // Simply a virtual destructor to avoid warnings.
        mondrianTree get_left_tree() const;
        mondrianTree get_right_tree() const;
        const std::tuple<int,double,double>& dat() const;
        bool is_null() const;
        bool is_leaf() const;
        virtual std::string to_string() const; // draw the tree


    protected:
        /* Unlike "private", now the following is visible to, mutable by, but 
           proteted from children. if "private" were used, root trees
           would not be immutable to children. 
           "protected" is good for extending classes. But "private"
           is usually preferred to restrict the editting of parent
           classes.  see p.192 */
        mondrianTree(mondrianNode* new_root) : root(new_root) {}
        mondrianNode *root;
};

std::ostream& operator<<(std::ostream& out, const mondrianTree& tree);
