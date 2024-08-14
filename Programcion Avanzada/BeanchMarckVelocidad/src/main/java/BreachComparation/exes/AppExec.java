package BreachComparation.exes;

import BreachComparation.util.DataGenerator;
import BreachComparation.tasks.TaskCountPrime;

import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class AppExec {

    public static void main( String[] args ) throws RunnerException {
        //org.openjdk.jmh.Main.main(args);
        Options opt = new OptionsBuilder()
                .include(AppExec.class.getSimpleName())
                .forks(1)
                .build();
        new Runner(opt).run();
    }


    private static void action(List<Integer> data, ExecutorService executorService) {
        execWorkSeveralThreadsListNums(data, executorService);
    }

    private static void execWorkSeveralThreadsListNums(List<Integer> nums, ExecutorService executorService) {

        List<Future<Boolean>> futures =  new ArrayList<>() ;

        for (var num : nums) {
            TaskCountPrime taskCountPrime = new TaskCountPrime(num);
            futures.add(executorService.submit(taskCountPrime));
        }

        try {
            for(Future<Boolean> future : futures) {
                future.get();
            }
        } catch (InterruptedException | ExecutionException e) {
        }
    }

    private static ExecutorService severalThreads(int numThreads) {
        return Executors.newFixedThreadPool(numThreads);
    }
}