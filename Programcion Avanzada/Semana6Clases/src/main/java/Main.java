import java.awt.*;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Main {

    public static void main(String[] args) {

        Tuple2[] rowDemo = {new Tuple2(120,284), new Tuple2(3,4)};

        ClassNumAmigos task = new ClassNumAmigos(rowDemo);

        ExecutorService executor = Executors.newSingleThreadExecutor();

        Future<Integer> future = executor.submit(task);

        try {
            System.out.printf("Existen %d numeros amigos\n",
                    future.get());
        }catch (InterruptedException | ExecutionException e){


            throw new RuntimeException(e);


        }

        executor.shutdown();

    }
}
