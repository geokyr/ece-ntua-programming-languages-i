#include <iostream>
#include <climits>
#include <algorithm>
#include <fstream>
using namespace std;

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
            rightp++;
            //leftp++ optimization
        }
    }
    return answer;
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

    for(int i = 0; i < days; i++) {
        arr[i] = -arr[i];
        arr[i] -= hospitals;
    }

    int prefix[days + 1];
    prefix[0] = 0;
    
    for (int i = 1; i < days + 1; i++) {
        prefix[i] = prefix[i - 1] + arr[i - 1];
    }

    cout << longestSubarray(prefix, days + 1) << endl;
    return 0;
}

/* Based on the following idea:
*
*  -average = -sum/counter >= hospitals =>
*  -average' = -sum'/counter >= 0 =>
*  average' = sum'/counter <= 0
*
*  and with the help of:
*  https://cs.stackexchange.com/questions/129353/find-the-length-of-the-longest-subarray-having-sum-greater-than-k
*  https://replit.com/@Apass_Jack/cs129353longestsubarray
*/

