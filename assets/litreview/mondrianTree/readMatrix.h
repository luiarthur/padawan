#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <vector>

std::vector<std::vector<double> > readMatrix(const char *name)
{
    std::vector<std::vector<double> > result;
    std::ifstream input (name);
    std::string lineData;

    while(getline(input, lineData))
    {
        double d;
        std::vector<double> row;
        std::stringstream lineStream(lineData);

        while (lineStream >> d)
            row.push_back(d);

        result.push_back(row);
    }

    return result;
}

void printMatrix(std::vector<std::vector<double> > M) {
    int r = M.size();
    int c = M[0].size();
    
    std::cout << std::endl;
    for (int i=0; i<r; i++) {
       for (int j=0; j<c; j++) {
          std::cout << M[i][j] << "\t";
     }
       std::cout << std::endl;
    }
}
