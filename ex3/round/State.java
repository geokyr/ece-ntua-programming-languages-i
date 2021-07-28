import java.util.*;

public class State {
    private int towns, cars, answer, answerIndex;
    private int[] carPositions, townsArr;

    public State(int[] initCarPositions, int initTowns, int initCars) {
        carPositions = initCarPositions;
        towns = initTowns;
        cars = initCars;
    }

    private static int calculateDistance(int h, int towns, int current) {
        if(h <= current) {
            return current - h;
        }
        else {
            return towns + current - h;
        }
    }

    private int[] calculateMaxAndSum() {
        int sum = 0, max = 0, distance = 0;

        for(int i = 0; i < cars; i++) {
            distance = calculateDistance(carPositions[i], towns, 0);
            sum += distance;
            max = Math.max(max, distance);
        }
        int[] ans = {sum, max};
        return ans;
    }

    private void createTownsArray() {
        int[] tempArr = new int[towns];
        
        for(int i = 0; i < cars; i++){
            tempArr[carPositions[i]]++;
        }
        townsArr = tempArr;
    }

    private int nextIndex(int current) {
        int next;
        if(current == towns - 1) {
            next = 0;
        }
        else {
            next = current + 1;
        }

        while(townsArr[next] == 0) {
            if(next == towns - 1) {
                next = 0;
            }
            else{
                next++;
            }
        }
        return next;
    }

    private static boolean isValid(int max, int sum) {
        return (max <= ((sum - max) + 1)) ? true : false;
    }

    private void setAnswer(int ans, int ansIndex) {
        answer = ans;
        answerIndex = ansIndex;
    }

    public void solve() {
        createTownsArray();
        
        int sum = calculateMaxAndSum()[0];
        int max = calculateMaxAndSum()[1];
        setAnswer(sum, 0);

        int next = nextIndex(0);
        
        for(int i = 1; i < towns; i++){
            if(i == next) {
                next = nextIndex(i);
            }
            
            sum += cars - (towns * townsArr[i]);
            max = calculateDistance(next, towns, i);
            
            if(isValid(max, sum) && sum < answer) {
                setAnswer(sum, i);
            }
        }
        System.out.println(answer + " " + answerIndex);
    }
}