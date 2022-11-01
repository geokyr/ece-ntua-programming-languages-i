import java.io.*;

public class ReadFileName {
    private int[] input;

    public ReadFileName(String fileName) {
        BufferedReader objReader = null;
        try {
            objReader = new BufferedReader(new FileReader(fileName));
            
            int size = Integer.parseInt(objReader.readLine());

            String arrayString = objReader.readLine();
            String[] arrayChar = arrayString.split(" ", -1);

            int[] array = new int[size];
            int i = 0;

            for (String a : arrayChar){
                array[i] = Integer.parseInt(a);
                i++;
            }

            input = array;
        } catch (IOException e){
            e.printStackTrace();
        } finally {
            try {
                if(objReader != null)  {
                    objReader.close();
                }
            } catch(IOException exception){
                exception.printStackTrace();
            }
        }
    }

    public int[] getInputArray() {
        return input;
    }
}