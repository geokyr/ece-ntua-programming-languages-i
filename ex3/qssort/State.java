import java.util.*;

public class State {
    private List<Integer> queue;
    private List<Integer> stack;
    private String path;

    public State(List<Integer> initQ, List<Integer> initS, String initP) {
        queue = new ArrayList<>(initQ);
        stack = new ArrayList<>(initS);
        path = initP;
    }

    public State moveQ() {
        List<Integer> newQ = new ArrayList<>(queue);
        List<Integer> newS = new ArrayList<>(stack);
        newS.add(newQ.remove(0));
        State newState = new State (newQ, newS, path + "Q");
        return newState;
    }

     public State moveS() {
        List<Integer> newQ = new ArrayList<>(queue);
        List<Integer> newS = new ArrayList<>(stack);
        newQ.add(newS.remove(newS.size() - 1));
        State newState = new State (newQ, newS, path + "S");
        return newState;
    }

    public State[] next() {
        State[] states = new State[2];
        int i = 0;
        if(!queue.isEmpty()) {
            states[i] = this.moveQ();
            i++;
        }
        if(!stack.isEmpty()) {
            states[i] = this.moveS();
        }
        return states;
    }
     
    public boolean isSorted() {
        if(queue.isEmpty()) {
            return true;
        }
        
        Iterator<Integer> iterator = queue.iterator();
        Integer current, previous = iterator.next();
        while (iterator.hasNext()) {
            current = iterator.next();
            if (previous.compareTo(current) > 0) {
                return false;
            }
            previous = current;
        }
        return true;
    }

    public int getQueueSize() {
        return queue.size();
    }

    public int getStackSize() {
        return stack.size();
    }

    public String getPath() {
        return path;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("");
        sb.append(queue.toString());
        sb.append(stack.toString());
        return sb.toString();
    }

    @Override
    public int hashCode() {
        return (17 * queue.hashCode() + 42 * stack.hashCode());
    }
}