import java.util.Arrays;

public class SumRowRun implements Runnable{

    private final int[] row;
    private int sum;

    public SumRowRun(int[] row){

        this.row = row;

    }



    @Override
    public void run(){

        sum = Arrays.stream(row).sum();
        System.out.printf("%d generate by %s\n", sum, Thread.currentThread().getName());

    }

    public int getSum(){

        return sum;

    }
}
