public class Round {
    public static void main(String args[]) {
        RreadFile inputRead = new RreadFile(args[0]);
        
        int[] carPositions = inputRead.getCarPositions();
        int towns = inputRead.getTowns();
        int cars = inputRead.getCars();

        State initial = new State(carPositions, towns, cars);
        initial.solve();
    }
}