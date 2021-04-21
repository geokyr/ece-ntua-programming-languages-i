#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;
 
int maxIndexDiff(int arr[], int n){    
    int maxDiff = -1;
    int i, j;
 
    int* LMin = new int[(sizeof(int) * n)];
    int* RMax = new int[(sizeof(int) * n)];
 
    LMin[0] = arr[0];
    for(i = 1; i < n; ++i){
        LMin[i] = min(arr[i], LMin[i - 1]);
    }
 
    RMax[n - 1] = arr[n - 1];
    for(j = n - 2; j >= 0; --j){
        RMax[j] = max(arr[j], RMax[j + 1]);
    }
 
    i = 0, j = 0;
    while (j < n && i < n) {
        if (LMin[i] <= RMax[j]) {
            while(j + 1 < n && RMax[j + 1] >= LMin[i] ) {
                j++;
            }
            maxDiff = max(maxDiff, j - i);
            i++;
            j++;
        }
        else if(j - 1 > i){
            i++;
        }
        else {
            i++;
            j++;
        }
    }

    return maxDiff;
    delete[] LMin;
    delete[] RMax;
}
 
int main(int argc, char *argv[]){
    
    int days,hospitals;
 
    ifstream inputfile(argv[1]);
 
    if(inputfile.is_open()) {
        inputfile >> days;
        inputfile >> hospitals;
    }
 
    int arr[days];
    int prefix[days + 1];
 
    for(int i = 0; i < days; i++){
        inputfile >> arr[i];
    }
    inputfile.close();
 
    for(int k = 0; k < days; k++){
        arr[k] = -arr[k];
        arr[k] -= hospitals;
    }
 
    prefix[0] = 0;
    for (int i = 1; i < days + 1; i++) {
        prefix[i] = prefix[i - 1] + arr[i - 1];
    }
 
    cout << maxIndexDiff(prefix, days + 1) << endl;
    return 0;
}

/* Based on the following idea:
*
*  -average/hospitals >= 1 =>
*  (-sum/days)/hospitals >= 1 =>
*  (-sum/days) >= hospitals => (subtract hospitals from both sides)
*  (-sum'/days) >= 0 =>
*  (-average') >= 0
* 
*  and with an algorithm similar to this following logic:
*  https://geeksforgeeks.org/longest-subarray-having-average-greater-than-or-equal-to-x-set-2/?fbclid=IwAR0H2CBTKkr0SzIUXKIKUODf__OIGSspz3ABqEXODU4J-cVbqNT-T6DVVls
*/