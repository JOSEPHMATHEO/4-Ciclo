package ec.edu.utpl.computacion.pa.planproc.s5.pe.tasks;

import java.util.List;
import java.util.concurrent.Callable;
import java.util.stream.IntStream;

public class TaskCountPrime implements Callable<Boolean>  {

    private int num;

    public TaskCountPrime(int num){

        this.num = num;
    }

    /*//  Primer Algoritmo

    @Override
    public Boolean call() throws Exception {

        return !IntStream.
                range(2, num).
                anyMatch(div -> num % div == 0);

    }*/

    //  Segundo Algoritmo

    /*@Override
    public Boolean call() throws Exception {

        return !IntStream.
                rangeClosed(2, num/2).
                anyMatch(div -> num % div == 0);

    }*/

    //  Tercero Algoritmo

    @Override
    public Boolean call() throws Exception {

        return num > 1 && IntStream.
                rangeClosed(2, (int) Math.sqrt(num)).
                noneMatch(divisor -> num % divisor == 0);

    }















    /*private boolean primoUno(int num){

        return !IntStream.
                range(2, num).
                anyMatch(div -> num % div == 0);

    }

    private boolean primoDos(int num){

        return !IntStream.
                rangeClosed(2, num/2).
                anyMatch(div -> num % div == 0);

    }

    private boolean primoTres(int num){

        return num > 1 && IntStream.
                rangeClosed(2, (int) Math.sqrt(num)).
                noneMatch(divisor -> num % divisor == 0);

    }*/

}