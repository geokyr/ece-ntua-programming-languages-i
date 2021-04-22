#include <iostream>
#include <fstream>

using namespace std;

int search(int i, int j, int n, int m, char **paths) {

    // If the room is already resolved return its value.
    if(paths[i][j] == 1 || paths[i][j] == -1) {
        return paths[i][j];
    }
    
    // If the room has been visited again in this iteration its a non-exiting loop.
    else if(paths[i][j]  == 2) {
        return -1;
    }

    /* If the room hasn't been resolved follow the path, and check if it exits.
    *  If it doesn't, mark this room as visited and update its value while
    *  calling recursively the function for the next room.
    */
    else switch (paths[i][j]) {
        case 'U':
            if(i == 0) {
                return 1;
            }
            else {
                paths[i][j] = 2;
                return (paths[i - 1][j] = search(i - 1, j, n, m, paths));
            }
            break;

        case 'D':
            if(i == n - 1) {
                return 1;
            }
            else {
                paths[i][j]  = 2;
                return (paths[i + 1][j] = search(i + 1, j, n, m, paths));
            }
            break;

        case 'L':
            if(j == 0) {
                return 1;
            }
            else {
                paths[i][j] = 2;
                return (paths[i][j - 1] = search(i, j - 1, n, m, paths));
            }
            break;

        case 'R':
            if(j == m - 1) {
                return 1;
            }
            else {
                paths[i][j] = 2;
                return (paths[i][j + 1] = search(i, j + 1, n, m, paths));
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

    // Dynamically allocate 2D array.
    char **paths = new char*[n];
    for(int i = 0; i < n; i++) {
        paths[i] = new char[m];
    }

    if(myfile.is_open()) {
        for(int i = 0; i < n; i++) {
            for(int j = 0; j < m; j++) {
                myfile >> paths[i][j];
            }
        }
    }

    myfile.close();
    
    
    int counter = 0;

    for(int i = 0; i < n; i++) {
        for(int j = 0; j < m; j++) {
            if((paths[i][j] = search(i, j, n, m, paths)) == -1) {
                counter++;
            }

        }
    }

    // Free the dynamically allocated memory.
    for(int i = 0; i < n; ++i) {
        delete [] paths[i];
    }
    delete [] paths;

    cout << counter << endl;
}        
