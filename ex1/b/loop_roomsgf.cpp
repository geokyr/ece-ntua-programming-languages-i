#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char *argv[]) {
    // int N = 3, M = 3;
    // char a[3][3] = {'U', 'L', 'D', 'L', 'U', 'D', 'L', 'R', 'L'}; //if char a[N][M] -> wrong answer (4->7)
    // int ans = 0;

    int N, M;

    ifstream myfile(argv[1]);

    if(myfile.is_open()) {
        myfile >> N;
        myfile >> M;
    }

    char a[N][M];

    if(myfile.is_open()) {
        for(int i = 0; i < N; i++) {
            for(int j = 0; j < M; j++) {
                myfile >> a[i][j];
            }
        }
    }

    myfile.close();

    int checki, checkj, ans = 0;
    
    int b[3][3] = {0};
    // 0 = unvisited, 2 = visited, 1 = exit, -1 = loop

    for(int i = 0; i < N; i++){
        for(int j = 0; j < M; j++) {

            checki = i;
            checkj = j;
            
            while(!(checki > N - 1 || checki < 0 || checkj > M - 1 || checkj < 0)) {
                b[checki][checkj] = 2;

                switch (a[checki][checkj]) {
                    case 'U':
                        checki--;
                        break;

                    case 'D':
                        checki++;
                        break;
                    
                    case 'R':
                        checkj++;
                        break;
                    
                    case 'L':
                        checkj--;
                        break;
                    
                    default:
                        break;
                }

                if(b[checki][checkj] != 0) {
                    if(b[checki][checkj] == 2 or b[checki][checkj] == -1) {
                        ans++;
                        b[i][j] = -1;
                        break;
                    }
                    b[i][j] = 1;
                    break;
                }
            }
        }
    }
    cout << ans << endl;
}