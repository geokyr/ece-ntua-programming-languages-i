import java.util.*;

public class QSsort {
    public static void main(String args[]) {
        ReadFileName inputRead = new ReadFileName(args[0]);

        int[] inputArray = inputRead.getInputArray();
        int length = inputArray.length;
        
        List<Integer> initialQ = new ArrayList<Integer>();
        List<Integer> initialS = new ArrayList<Integer>();
        String path = "";

        for(int i = 0; i < length; i++) {
            initialQ.add(inputArray[i]);
        }

        State initial = new State(initialQ, initialS, path);
        String answer = "";

        Set<String> visited = new HashSet<String>();
        visited.add(initial.toString());
        
        Deque<State> Q = new ArrayDeque<State>();
        Q.add(initial);

        while(!Q.isEmpty()) {
            State s = Q.pop();
            if(s.isSorted() && s.getQueueSize() == length) {
                answer = s.getPath();
                if(answer.isEmpty()) {
                    System.out.println("empty");
                }
                else{
                    System.out.println(answer);
                }
                break;
            }
            else {
                State[] next = s.next();
                for(int i = 0; i < 2; i++) {
                    if(next[i] != null) {
                        String hash = next[i].toString();
                        if(!visited.contains(hash)){
                            Q.add(next[i]);
                            visited.add(hash);
                        }
                    }
                }
            }
        }
    }
}
