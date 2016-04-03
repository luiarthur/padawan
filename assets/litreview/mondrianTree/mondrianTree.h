#pragma once
#include <iostream>
#include <vector>
#include "mondrianNode.h"

class mondrianTree {
    public:
        mondrianTree() {root = new mondrianNode( std::make_tuple(0,0,0) );}
        void sample(std::vector< std::vector<double> > X, double lambda);
    //private:
        mondrianNode *root;
};
