package QuickSort;

public class QuickSort {

    public static void main(String[] args) {

        // TODO code application logic here

        int arreglo[] = {8,40,15,10,32,5,7};

        quickSort(arreglo,0, arreglo.length - 1);

        // Salida de Datos

        System.out.print("[");

        for(int i = 0; i <= arreglo.length - 1 ; i++){

            System.out.print(arreglo[i] + " ");

        }

        System.out.print("]");

    }

    public static void quickSort(int arr[], int izq1, int der1){


        if(izq1 < der1){

            int indexQuickSort = ordenamiento(arr,izq1,der1);
            quickSort(arr,izq1,indexQuickSort);
            quickSort(arr,indexQuickSort + 1, der1);

        }

    }


    public static int ordenamiento(int A[], int izq, int der) {

        // Elejimos el elemento que sera nuestro pivote

        int pivote = A[izq];

        // Cilco de comparacion

        while (true){

            // Mientras que el elemento que viene desde la izquiera
            // sea menor al pivote, continuara avanzando el indice

            while(A[izq] < pivote ){

                izq++;

            }

            // Mientras cada elemento que viene desde la derecha
            // sea mayor al pivote, continuara disminuyendo el indice

            while(A[der] > pivote ){

                der--;

            }

            // Si el elemento de la izquiera es mayor o igual que el elemento de la derecha
            // significa que los elementos estan en orden, por lo que no es necesaro hacer
            // un cambio de los elementos

            if (izq >= der){

                // Se empieza a dividir el arreglo desde el indice donde se detuvo
                // y se comienza a ordenar los elementos

                return der;

            }else{

                // Si el elemento de la izquiera no supera o es igual a elemento de la derecha
                // significa que los elementos no estan en orden, por lo tanto se los
                // intercambiaran

                int aux = A[izq];
                A[izq] = A[der];
                A[der] = aux;

                // Se intercambiaron los elementos, y los indices avanzan y disminuyen una vez mas

                izq++;
                der--;

            }

            // El cilo while se repite hasta que izquiera >= derecha

        }

    }

}