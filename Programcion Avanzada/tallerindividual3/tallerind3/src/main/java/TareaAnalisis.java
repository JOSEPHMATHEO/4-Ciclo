import java.util.Scanner;

public class TareaAnalisis {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        // Ejemplo de número para calcular su factorial

        System.out.print("Escriba un numero: ");
        int number = sc.nextInt();

        System.out.println("El factorial de " + number + " es " + factorial(number));

        /*boolean flag = true;

        while(flag) {

            System.out.print("Escriba una palabra: ");
            String palabra = sc.next();

            if (palindromo(palabra)) {

                System.out.println("La palabra " + palabra + " es un palindromo");
                flag = false;

            } else {

                System.out.println("La palabra " + palabra + " no es un palindromo");

            }

        }*/
    }
    public static boolean palindromo(String palabra) {

        if (palabra.length()==0 || palabra.length()==1) {

            return true;

        }if (palabra.charAt(0)== palabra.charAt((palabra.length()-1))) {

            return palindromo(palabra.substring(1,palabra.length()-1));

        }

        return false;

    }

    public static int factorial(int n) {

        // Caso base: el factorial de 0 es 1

        if (n == 1) {

            return 1;

        }

        // Llamada recursiva: n * factorial de (n-1)

        return n * factorial(n - 1);
    }


}