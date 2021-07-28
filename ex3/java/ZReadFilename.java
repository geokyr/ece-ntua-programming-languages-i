import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class ZReadFilename {
    private int[] input;
    private int Num;

    public ZReadFilename(String filename) {        
            BufferedReader objReader = null;
            try {
        
                objReader = new BufferedReader(new FileReader(filename));
            
                int number = Integer.parseInt(objReader.readLine());

                String arrayString = objReader.readLine();
                String[] arrayChar = arrayString.split( " ", -1 );

                int[] array = new int[number];
                int i = 0;

                for (String a : arrayChar){
                    array[i] = Integer.parseInt(a);
                    i++;
                }

                Num = number;
                input = array;
            
            } catch (IOException e) {
        
                e.printStackTrace();
        
            } finally {
        
                try {
                    if (objReader != null)
                        objReader.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        }
        
        public int[] getInputArray(){
            return input;
        }

        public int getN(){
            return Num;
        }

}