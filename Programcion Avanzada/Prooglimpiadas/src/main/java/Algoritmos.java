import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class Algoritmos {

    public static void main(String[] args) {

        Random random = new Random();

        int[] arreglo = new int[random.nextInt(100)];
        System.out.println(arreglo.length);

        for (int i = 0; i < arreglo.length; i++) {
            arreglo[i] = random.nextInt(100) + 1;
        }

        int [] argss = {54,26,93,17,77,31,44,55,20};

        System.out.print("[");
        for (int i = 0; i < arreglo.length; i++) {
            if (i == arreglo.length - 1) {
                System.out.print(ordenarporfuncion(arreglo)[i] + "]");
            } else {
                System.out.print(ordenarporfuncion(arreglo)[i] + ", ");
            }
        }

        System.out.print("\n\n[");
        for (int i = 0; i < argss.length; i++) {
            if (i == argss.length - 1) {
                System.out.print(ordenarporfuncion(argss)[i] + "]");
            } else {
                System.out.print(ordenarporfuncion(argss)[i] + ", ");
            }
        }
    }

    public static int[] ordenarporfuncion(int [] T ){

        int n = T.length;

        if (n <= 1){
            return T;
        } else {
            int [] U = new int[n/2];
            int [] V = new int[n - n/2];

            for(int i = 0; i < n/2; i++){

                U[i] = T[i];

            }

            for(int i= n/2; i < n; i++){

                V[i - n/2] = T[i];

            }

            ordenarporfuncion(U);
            ordenarporfuncion(V);

            fusionar(U,V,T);
        }

        return T;
    }

    public static void fusionar(int[] U, int[] V, int[] T){

        int m = U.length;
        int n = V.length;

        int i = 0, j = 0;

        int[] U_aux = new int[m+1];
        int[] V_aux = new int[n+1];

        for(int k = 0; k < m; k++){

            U_aux[k] = U[k];

        }

        for(int k = 0; k < n; k++){

            V_aux[k] = V[k];

        }

        U_aux[m] = Integer.MAX_VALUE;
        V_aux[n] = Integer.MAX_VALUE;


        for(int k = 0; k < m+n; k++){

            if(U_aux[i] < V_aux[j]){
                T[k] = U_aux[i];
                i++;
            }else{
                T[k] = V_aux[j];
                j++;
            }
        }
    }
}
