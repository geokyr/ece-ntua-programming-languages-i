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
    // int days = 6;
    // int hospitals = 3;
    // int arr[days] = {10, -4, -3 ,-3, 3, 8};

    // // int days = 11;
    // // int hospitals = 3;
    // // int arr[days] = {42, -10, 8, 1, 11, -6, -12, 16, -15, -11, 13};

    // // -avg = -sum/cnt >= hospitals
    // // -avg' = -sum'/cnt >= 0
    // // avg' = sum'/cnt <= 0
    
    int days, hospitals;

    ifstream myfile(argv[1]);

    if(myfile.is_open()) {
        myfile >> days;
        // cout << "days" << days << endl;
        myfile >> hospitals;
        // cout << "hospitals" << hospitals << endl;
    }

    int arr[days];
    
    if(myfile.is_open()) {
        for(int i = 0; i < days; i++) {
            myfile >> arr[i];
            //cout << "arr[" << i << "]" << arr[i] << endl;;
        }
    }

    myfile.close();

    for(int i = 0; i<days; i++) {
        arr[i] = -arr[i];
        arr[i] -= hospitals;
        // cout << arr[i] << ", ";
    }
    cout << longestSubarray(arr, days) << endl;
    return 0;

}


// A[-8,-5,10,2]

// S[-1,7,12,2,0]

// ans = 0

// searchspace[-1,7,12,]

// index[0,1,2,]

// j = 3

// idx = -1

// A{ 42, -10, 8, 1, 11, -6, -12, 16, -15, -11, 13 }

// 37,-5,5

// searchspace 37

// index 0

// ans 2

// https://www.geeksforgeeks.org/longest-subarray-with-sum-greater-than-equal-to-zero/
// https://leetcode.com/problems/longest-well-performing-interval/discuss/339791/c-on-solution-beats-9932-reduced-to-finding-longest-subarray-with-positive-sum
// https://stackoverflow.com/questions/28356453/longest-positive-sum-substring
// https://www.geeksforgeeks.org/largest-subarray-having-sum-greater-than-k/