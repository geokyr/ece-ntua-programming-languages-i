#include <iostream>
#include <fstream>

using namespace std;

int index(int i, int j, int m) {
    return m * i + j;
}

int search(int i, int j, int n, int m, char *paths, int *values) {
    int idx = index(i, j, m);

    if(values[idx] == 1 || values[idx] == -1) {
        return values[idx];
    }
    
    else if(values[idx] == 2) {
        return -1;
    }

    else switch (paths[idx]) {
        case 'U':
            if(i == 0) {
                return 1;
            }
            else {
                values[idx] = 2;
                return (values[index(i - 1, j, m)] = search(i - 1, j, n, m, paths, values));
            }
            break;

        case 'D':
            if(i == n - 1) {
                return 1;
            }
            else {
                values[idx] = 2;
                return (values[index(i + 1, j, m)] = search(i + 1, j, n, m, paths, values));
            }
            break;

        case 'L':
            if(j == 0) {
                return 1;
            }
            else {
                values[idx] = 2;
                return (values[index(i, j - 1, m)] = search(i, j - 1, n, m, paths, values));
            }
            break;

        case 'R':
            if(j == m - 1) {
                return 1;
            }
            else {
                values[idx] = 2;
                return (values[index(i, j + 1, m)] = search(i, j + 1, n, m, paths, values));
            }
            break;       
        
        default:
            return -2;
            break;
    } 
}

int main(int argc, char *argv[]) {
    int n, m;

    ifstream myfile(argv[1]);

    if(myfile.is_open()) {
        myfile >> n;
        myfile >> m;
    }

    char paths[n*m];

    if(myfile.is_open()) {
        for(int i = 0; i < n * m; i++) {
            myfile >> paths[i];
        }
    }

    myfile.close();

    int values[n*m] = {0};
    // 0 -> unvisited, -1 -> loop, 1 -> exit, 2 -> visited
    int counter = 0;

    for(int i = 0; i < n; i++) {
        for(int j = 0; j < m; j++) {
            if((values[index(i, j, m)] = search(i, j, n, m, paths, values)) == -1) {
                counter++;
            }

        }
    }

    cout << counter << endl;
}