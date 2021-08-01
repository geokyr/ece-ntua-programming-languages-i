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
        State[] states = new State[4];
        int i = 0;
        if(!queue.isEmpty()) {
            State q = this.moveQ();
            if(q.getQueueSize() > 0) {
                states[i] = q.moveQ();
                i++;
            }
            if(q.getStackSize() > 0) {
                states[i] = q.moveS();
                i++;
            }
        }
        if(!stack.isEmpty()) {
            State s = this.moveS();
            if(s.getQueueSize() > 0) {
                states[i] = s.moveQ();
                i++;
            }
            if(s.getStackSize() > 0) {
                states[i] = s.moveS();
                i++;
            }
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
    public int hashCode() {
        return (17 * queue.hashCode() + 42 * stack.hashCode());
    }
}