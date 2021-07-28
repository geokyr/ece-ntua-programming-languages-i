import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class RreadFile {
    private int[] carPositions;
    private int towns, cars;

    public RreadFile(String fileName) {
        try {
            File obj = new File(fileName);
            Scanner reader = new Scanner(obj);
            
            int t = reader.nextInt();
            int c = reader.nextInt();

            int[] arr = new int[c];
            int i = 0;
            while(reader.hasNext()) {
                int pos = reader.nextInt();
                arr[i] = pos;
                i++;
            }

            towns = t;
            cars = c;
            carPositions = arr;

            reader.close();
        } catch(FileNotFoundException exception) {
            exception.printStackTrace();
        }
    }

    public int[] getCarPositions(){
        return carPositions;
    }

    public int getTowns(){
        return towns;
    }

    public int getCars(){
        return cars;
    }    
}