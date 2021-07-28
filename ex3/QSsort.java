import java.util.*;

public class QSsort {
    public static void main(String args[]) {
        QSsortReadFileName inputRead = new QSsortReadFileName(args[0]);

        int[] inputArray = inputRead.getInputArray();
        
        String path = "";
        List<Integer> initialQ = new ArrayList<Integer>();
        List<Integer> initialS = new ArrayList<Integer>();

        for(int i = 0; i < inputArray.length; i++) {
            initialQ.add(inputArray[i]);
        }
        
    }
    
}
