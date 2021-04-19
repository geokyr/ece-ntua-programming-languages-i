#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;

int search(int* searchspace, int s, int e, int key) {
        int ans = -1;

        while(s <= e) {
            int mid = (s + e) /2 ;

            if(searchspace[mid] - key >= 0) {
                ans = mid;
                e = mid - 1;
            }
            else {
                s = mid + 1;
            }
        }
        return ans;
}
    
int longestSubarray(int a[], int n) {
    int SuffixSum[n + 1];
    SuffixSum[n] = 0;

    for(int i = n - 1; i >= 0; --i) {
        SuffixSum[i] = SuffixSum[i + 1] + a[i];
    }

    int ans = 0;
    int searchspace[n];
    int index[n];

    int j = 0;
    
    for (int i = 0; i < n; ++i) { 

        if (j == 0 or SuffixSum[i] > searchspace[j - 1]) { 
            searchspace[j] = SuffixSum[i]; 
            index[j] = i; 
            j++; 
        } 

        int idx = search(searchspace, 0, j - 1, SuffixSum[i + 1]); 

        if (idx != -1) 
            ans = max(ans, i - index[idx] + 1); 
    } 

    return ans; 
}

int main(int argc, char *argv[]) {
    
    int days, hospitals;

    ifstream myfile(argv[1]);

    if(myfile.is_open()) {
        myfile >> days;
        myfile >> hospitals;
    }

    int arr[days];
    
    if(myfile.is_open()) {
        for(int i = 0; i < days; i++) {
            myfile >> arr[i];
        }
    }

    myfile.close();

    for(int i = 0; i<days; i++) {
        arr[i] = -arr[i];
        arr[i] -= hospitals;
    }
    cout << longestSubarray(arr, days) << endl;
    return 0;

}

/* Based on the following idea:
*
*  // -average = -sum/counter >= hospitals =>
*  // -average' = -sum'/counter >= 0 =>
*  // average' = sum'/counter <= 0
*
*  and with the help of:
*  https://www.geeksforgeeks.org/longest-subarray-with-sum-greater-than-equal-to-zero/
*/