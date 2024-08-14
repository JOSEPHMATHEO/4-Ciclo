import java.util.List;

public class ThSumList implements Runnable{
    private List<Integer>  lista;
    private int deficientes =0;
    private int perfectos = 0;
    private int abundantes = 0;

    public ThSumList(List<Integer>  lista){

        this.lista = lista;

    }

    @Override
    public void run(){

        int deficientes = 0;
        int perfectos = 0;
        int abundantes = 0;

        for (int num : lista) {
            int suma = 0;
            for (int i = 1; i < num; i++) {
                if (num % i == 0) {
                    Thread t = Thread.currentThread();
                    suma += i;
                }
            }
            if (suma < num) {
                Thread t = Thread.currentThread();
                deficientes++;
            } else if (suma == num) {
                Thread t = Thread.currentThread();
                perfectos++;
            } else {
                abundantes++;
            }
        }

        System.out.printf(
                        "Deficientes: %d generate by %s\n "+
                        "Perfectos: %d generate by %s\n"+
                        "Abundantes: %d generate by %s\n",
                        deficientes, Thread.currentThread().getName(),
                        perfectos, Thread.currentThread().getName(),
                        abundantes, Thread.currentThread().getName()
        );

    }


}