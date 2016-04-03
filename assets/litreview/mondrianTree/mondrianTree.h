#pragma once
#include <iostream>
#include <vector>

class mondrianTree {

  public:
    mondrianTree() {J=0;}

    std::vector<int> T() {return nodes;}
    std::vector<int> delta() {return split_dims;}
    std::vector<double> xi() {return split_locs;}
    std::vector<double> tau() {return split_times;}
    int size() {return J;}

    void ext(int j, int d, double x, double t) {
      nodes.push_back(j);
      split_dims.push_back(d);
      split_locs.push_back(x);
      split_times.push_back(t);
      J++;
    }

    void print() {
      std::cout << std::endl;
      std::cout << "nodes" << "\t" << "split_dims" << "\t"
                << "split_locs" << "\t"<< "split_times" << "\t" << std::endl;
      if (J > 0) {
        for (int i=0; i<J; i++) {
          std::cout << nodes[i] << "\t" << split_dims[i] << "\t\t"
               << split_locs[i] << "\t\t"<< split_times[i] << "\t\t" << std::endl;
        }
      }
      std::cout << std::endl;
    }

    void sample(std::vector< std::vector<double> > X, double lambda);

  private:
    std::vector<int> nodes;
    std::vector<int> split_dims;
    std::vector<double> split_locs;
    std::vector<double> split_times;
    int J;
};
