import javax.swing.plaf.TableHeaderUI;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ExectSumRowRun {

    public static void main(String[] args) throws InterruptedException {
        int[][] mat = {

                {3,8,7,2},
                {5,6,9,1},
                {5,0,7,4}
        };

        List<SumRowRun> runs = new ArrayList<>();
        List<Thread> threads = new ArrayList<>();

        System.out.println("Creating Threads");
        for(var row: mat){

            SumRowRun run = new SumRowRun(row);
            runs.add(run);
            Thread thexect = new Thread(run);
            thexect.start();
            threads.add(thexect);

        }

        for(var thexect: threads){

            thexect.join(1*1000);

        }

        Thread.sleep(1 * 1000);
        System.out.println();
        System.out.println("\nPrinting results");

        for(var run: runs){

            System.out.printf("Sum calculated: %d\n", run.getSum());

        }

        var sumTotal = runs.stream()
                .mapToInt(SumRowRun::getSum)
                .sum();

        System.out.printf("End[Hilo:%s]\n", Thread.currentThread().getName());

    }
}
