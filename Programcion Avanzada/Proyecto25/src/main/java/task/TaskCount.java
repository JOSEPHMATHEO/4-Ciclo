package task;

import java.util.Random;
import java.util.concurrent.*;

public class TaskCount implements Callable<double> {

    private static final int NUM_POINTS = 1000000;

    private double num;

    public TaskCount(Future<double> num) {
        this.num = num;
    }


    /*ExecutorService executorService = Executors.newFixedThreadPool(12);
        List<Future<Double>> futures = new ArrayList<>();*/
    @Override
    public double call() throws Exception {

        /*ExecutorService executorService = Executors.newFixedThreadPool(12);
        List<Future<Double>> futures = new ArrayList<>();*/

        long nroPointsIn = 0L;
        Random r = new Random();

        for (int i = 0; i < NUM_POINTS; i++) {
            double x = r.nextDouble() * 2 - 1;
            double y = r.nextDouble() * 2 - 1;

            if (x * x + y * y <= 1) {
                nroPointsIn++;
            }

            //futures.add(executorService.submit(new Suma))
        }

        // Calcula el valor estimado de π
        double piEstimate = 4.0 * nroPointsIn / NUM_POINTS;
        System.out.println("Estimated value of Pi: " + piEstimate);
        return piEstimate;
    }
}


