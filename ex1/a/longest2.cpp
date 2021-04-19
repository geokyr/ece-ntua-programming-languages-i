#include <iostream>
#include <climits>
#include <algorithm>
using namespace std;

/*int* prefix(int arr[], int days) {
    int prefix[days + 1];
    prefix[0] = 0;
    
    for (int i = 1; i < days; i++) {
        prefix[i] = prefix[i - 1] + arr[i - 1];
    }

    return prefix;
}*/

int longestSubarray(int arr[], int len) {
    int lcnt = 1, left[len] = {0};
    
    for(int i = 1; i < len; i++) {
        if(arr[left[lcnt - 1]] > arr[i]) {
            left[lcnt++] = i;
        }
    }

    int rcnt = 1, right[len] = {len - 1};

    for(int i = len - 1; i > 0; i--) {
        if(arr[right[rcnt - 1]] < arr[i]) {
            right[rcnt++] = i;
        }
    }

    reverse(right, right + rcnt);

    for(int i = 0; i < lcnt; i++) {
        cout << left[i] << ", " << arr[left[i]] << endl;
    }

    for(int i = 0; i < rcnt; i++) {
        cout << right[i] << ", " << arr[right[i]] << endl;
    }

    int answer = -1, leftp = 0, rightp = 0;

    while(leftp < lcnt && rightp < rcnt) {
        if(arr[right[rightp]] >= arr[left[leftp]]) {
            while (rightp + 1 < rcnt && arr[right[rightp + 1]] >= arr[left[leftp]]) {
                rightp++;
            }
            answer = max(answer, right[rightp] - left[leftp]);
            leftp++;
            rightp++;
        } 
        else if(left[leftp] < right[rightp] - 1){
            leftp++;
        }
        else {
            rightp++; //leftp++ optimization
        }
    }
    return answer;
}

int main() {
    //int days = 11;
    int hospitals = 3;
    //int a[days] = {42, -10, 8, 1, 11, -6, -12, 16, -15, -11, 13};
    
    int days = 6;
    int a[6] = { 10, -4, -3 ,-2, 3, 8 };
    
    for(int i = 0; i<days; i++) {
        a[i] = -a[i];
        a[i] -= hospitals;
        cout << a[i] << ", ";
    } cout << endl;

    int prefix[days + 1];
    prefix[0] = 0;
    
    for (int i = 1; i < days + 1; i++) {
        prefix[i] = prefix[i - 1] + a[i - 1];
        cout << prefix[i] << ", ";
    } cout << endl;

    cout << longestSubarray(prefix, days + 1) << endl;
    return 0;
}

//https://cs.stackexchange.com/questions/129353/find-the-length-of-the-longest-subarray-having-sum-greater-than-k
//https://replit.com/@Apass_Jack/cs129353longestsubarray