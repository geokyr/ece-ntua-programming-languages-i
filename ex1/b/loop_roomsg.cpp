#include <iostream>
using namespace std;

int main() {
    int N = 3, M = 3;
    char a[3][3] = {'U', 'L', 'D', 'L', 'U', 'D', 'L', 'R', 'L'}; //if char a[N][M] -> wrong answer (4->7)
    int ans = 0;
    

    for(int i = 0; i < N; i++){
        for(int j = 0; j < M; j++) {

            bool b[3][3] = {false};

            int checki = i, checkj = j;
            
            while(!(checki > N || checki < 0 || checkj > M || checkj < 0)) {
                b[checki][checkj] = true;

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

                if(b[checki][checkj] == true) {
                    ans++;
                    break;
                }
            }
        }
    }
    cout << ans << endl;
}