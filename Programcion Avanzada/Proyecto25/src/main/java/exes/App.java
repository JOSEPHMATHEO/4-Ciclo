package exes;

import org.openjdk.jmh.annotations.*;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;
import task.TaskCount;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.*;

public class App {

    public static void main(String[] args) throws RunnerException {
        Options opt = new OptionsBuilder()
                .include(App.class.getSimpleName())
                .forks(1)
                .build();

        new Runner(opt).run();

    }
    private static int numHilos = Runtime.getRuntime().availableProcessors();

    @Benchmark
    @BenchmarkMode(Mode.AverageTime)
    @Warmup(iterations = 5, time = 5, timeUnit = TimeUnit.MILLISECONDS)
    @Measurement(iterations = 5, time = 5, timeUnit = TimeUnit.MILLISECONDS)
    @OutputTimeUnit(TimeUnit.MILLISECONDS)

    public static void execWorkSeveralThreadsListNums() {

        ExecutorService executorService = severalThreads(numHilos);
        List<Future<double>> futures = new ArrayList<>();

        for (var num : data) {
            TaskCount taskCountPrime = new TaskCount(num);
            futures.add(executorService.submit(taskCount));
        }

        try {
            for(Future<double> future : futures) {
                future.get();
            }
        } catch (InterruptedException e) {}

        executorService.shutdown();
    }

    private static ExecutorService severalThreads(int numThreads) {
        return Executors.newFixedThreadPool(numThreads);
    }
}



}
