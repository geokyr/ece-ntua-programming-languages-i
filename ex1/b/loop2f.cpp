#include <iostream>
#include <fstream>
using namespace std;

int pos(int i, int j, int N) {
    return N*i + j;
}

int check(int i, int j, int N, int M, char *a, int *b) {
    int position = pos(i, j, N);

    if(b[position] == 1 || b[position] == -1) {
                return b[position];
    }

    else if(b[position] == 2) {
        return -1;
    }

    else switch (a[position]) {
        case 'U':
            if(i == 0) {
                return 1;
            }
            else {
                b[pos(i, j, N)] = 2;
                b[pos(i - 1, j, N)] = check(i - 1, j, N, M, a, b);
                return b[pos(i - 1, j, N)];
            }
            break;

        case 'D':
            if(i == N - 1) {
                return 1;
            }
            else {
                b[pos(i, j, N)] = 2;
                b[pos(i + 1, j, N)] = check(i + 1, j, N, M, a, b);
                return b[pos(i + 1, j, N)];
            }
            break;

        case 'L':
            if(j == 0) {
                return 1;
            }
            else {
                b[pos(i, j, N)] = 2;
                b[pos(i, j - 1, N)] = check(i, j - 1, N, M, a, b);
                return b[pos(i, j - 1, N)];
            }
            break;

        case 'R':
            if(j == M - 1) {
                return 1;
            }
            else {
                b[pos(i, j, N)] = 2;
                b[pos(i, j + 1, N)] = check(i, j + 1, N, M, a, b);
                return b[pos(i, j + 1, N)];
            }
            break;       
        
        default:
            return 1000;
            break;
    }
}

int main(int argc, char *argv[]) {
    // int N = 3, M = 3;
    // char a[N*M] = {'U', 'L', 'D', 'L', 'U', 'D', 'L', 'R', 'L'}; //if char a[N][M] -> wrong answer (4->7)

    // 0 -> unvisited, 1 -> success, -1 -> failure, 2 -> visited
    // int b[N*M] = {0};
    // int ans = 0;

    int N, M;

    ifstream myfile(argv[1]);

    if(myfile.is_open()) {
        myfile >> N;
        myfile >> M;
    }

    char a[N*M];

    if(myfile.is_open()) {
        for(int i = 0; i < N*M; i++) {
            myfile >> a[i];
        }
    }

    myfile.close();

    int b[N*M] = {0};
    int ans = 0;

    for(int i = 0; i < N; i++){
        for(int j = 0; j < M; j++) {
            b[pos(i, j, N)] = check(i, j, N, M, a, b);
            if(b[pos(i, j, N)] == -1) {
                ans++;
            }
        }
    }

    cout << ans << endl;
}