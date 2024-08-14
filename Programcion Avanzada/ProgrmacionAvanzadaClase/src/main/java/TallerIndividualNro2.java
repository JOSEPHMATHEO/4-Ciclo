import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.IntStream;

public class TallerIndividualNro2 {

    public static void main(String[] args)throws InterruptedException {

        List<Integer> lista2 = IntStream.generate(() ->
                        ThreadLocalRandom.current().nextInt(1, 100_000))
                .limit(24)
                .boxed()
                .toList();

        var nums = List.of(1,6, 10561,13,28,100,496,1000,2000,17,101,202,1804,1928,31,63,10,12,12001,33333,8128);

        // Numeros Deficientes

        ThCountMain numsDeficiente = new ThCountDeficiente(nums);
        Thread threadDeficiente = new Thread(numsDeficiente,"Deficientes-Threads");
        threadDeficiente.start();

        // Numeros Perfectos

        ThCountMain numsPerfectos = new ThCountPerfecto(nums);
        Thread threadPerfectos = new Thread(numsPerfectos, "Perfectos-Threads");
        threadPerfectos.start();


        // Numeros Abundantes

        ThCountMain numsAbundantes = new ThCountAbundante(nums);
        Thread threadAbundantes = new Thread(numsAbundantes,"Abundantes-Threads");
        threadAbundantes.start();

        threadDeficiente.join();
        threadPerfectos.join();
        threadAbundantes.join();

        System.out.printf("Numeros Deficientes %s\n" +
                "Numeros Perfectos %s\n" +
                "Numeros Abundantes %s\n");

    }


}
