#include <iostream>
using namespace std;

int main() {
    int days = 11;
    int hospitals = 3;
    int arr[days] = {42, -10, 8, 1, 11, -6, -12, 16, -15, -11, 13};
    int max = 0;
    
    for(int i = 0; i < days; i++) {
        int sum = 0;
        int cnt = 0;
        if(days - i - 1 < max) {
            break;
        }
        for(int j = i; j < days; j++) {
            sum += arr[j];
            cnt++;
            if(-sum/(cnt * hospitals) >= 1) {
                if(cnt >= max) {
                    max = cnt;
                }
            }
        }
    }
    cout << max << endl;
}