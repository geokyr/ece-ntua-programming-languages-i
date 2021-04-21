#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;
 
int maxIndexDiff(int arr[], int n){    
    int maxDiff;
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
 
    i = 0, j = 0, maxDiff = -1;
    while (j < n && i < n) {
        if (LMin[i] <= RMax[j]) {
            while(j + 1 < n && RMax[j+1] >= LMin[i] ) j++;
            maxDiff = max(maxDiff, j - i);
            j += 1;
            i += 1;
        }
        else if( j > i ){
            i += 1;
        }
        else {
            j += 1;
            i += 1;
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
 
    for( int i = 0; i < days; i++){
        inputfile >> arr[i];
    }
    inputfile.close();
 
    for(int k = 0; k < days; k++){
        arr[k] = -arr[k];
        arr[k] = arr[k] - hospitals;
    }
 
    prefix[0] = arr[0];
    for (int i = 1; i < days + 1; i++) {
        prefix[i] = prefix[i - 1] + arr[i - 1];
    }
 
    int maxDiff = maxIndexDiff(prefix, days + 1);
    cout << maxDiff <<endl;
    return 0;
}