import java.util.stream.IntStream;

public abstract class NumerosPrimos implements Runnable {

    private final int [] row;
    public int sumaPrimos;

    public NumerosPrimos(int [] row){

        this.row = row;

    }

    private static IntStream getPrimos(Integer num){

        IntStream intStream = IntStream.range(1, num).filter(div -> (num % div == 0 && num / num == 0));
        return intStream;

    }

    public static void getSumaPrimos(Integer num){

         getPrimos(num).filter(x -> {
            boolean b = ((num * 2) + 1) == getPrimos(num);
            return b;
        }).sum;

    }


    public int[] getRow(){

        return row;

    }

    public int getSumaPrimos(){

        return sumaPrimos;

    }



}
