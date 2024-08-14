import java.util.Arrays;

public class Kruskal {

    public static void main(String[] args) {
        int vertices = 4; // Número de vértices en el grafo
        int edges = 5; // Número de aristas en el grafo
        Kruskal graph = new Kruskal(vertices, edges);

        // Añadir arista 0-1
        graph.arista[0].origen = 0;
        graph.arista[0].destino = 1;
        graph.arista[0].peso = 10;

        // Añadir arista 0-2
        graph.arista[1].origen = 0;
        graph.arista[1].destino = 2;
        graph.arista[1].peso = 6;

        // Añadir arista 0-3
        graph.arista[2].origen = 0;
        graph.arista[2].destino = 3;
        graph.arista[2].peso = 5;

        // Añadir arista 1-3
        graph.arista[3].origen = 1;
        graph.arista[3].destino = 3;
        graph.arista[3].peso = 15;

        // Añadir arista 2-3
        graph.arista[4].origen = 2;
        graph.arista[4].destino = 3;
        graph.arista[4].peso = 4;

        // Ejecutar el algoritmo de Kruskal
        graph.algoritmoKruskal();
    }

    // Clase interna para representar una arista
    class Arista implements Comparable<Arista> {

        int origen, destino, peso;

        // Comparar las aristas basadas en su peso
        public int compareTo(Arista compararArista) {
            return this.peso - compararArista.peso;
        }
    };

    // Clase interna para representar un conjunto para el algoritmo union-find
    class Subconjunto {

        int padre, rango;
    }

    int vertices, edges; // Número de vértices y aristas
    Arista[] arista; // Array de aristas

    // Constructor
    Kruskal(int v, int e) {
        vertices = v;
        edges = e;
        arista = new Arista[e];
        for (int i = 0; i < e; ++i) {
            arista[i] = new Arista();
        }
    }

    // Método para encontrar el conjunto del elemento i (con compresión de ruta)
    int encontrar(Subconjunto[] subconjuntos, int i) {
        if (subconjuntos[i].padre != i) {
            subconjuntos[i].padre = encontrar(subconjuntos, subconjuntos[i].padre);
        }
        return subconjuntos[i].padre;
    }

    // Método para unir dos subconjuntos en uno (con unión por rango)
    void unir(Subconjunto[] subconjuntos, int x, int y) {
        int raizX = encontrar(subconjuntos, x);
        int raizY = encontrar(subconjuntos, y);

        if (subconjuntos[raizX].rango < subconjuntos[raizY].rango) {
            subconjuntos[raizX].padre = raizY;
        } else if (subconjuntos[raizX].rango > subconjuntos[raizY].rango) {
            subconjuntos[raizY].padre = raizX;
        } else {
            subconjuntos[raizY].padre = raizX;
            subconjuntos[raizX].rango++;
        }
    }

    // Método principal para construir el MST usando el algoritmo de Kruskal
    void algoritmoKruskal() {
        Arista[] resultado = new Arista[vertices]; // Array para almacenar el MST
        int e = 0; // Contador de aristas en el MST
        int i = 0; // Índice para las aristas ordenadas
        for (i = 0; i < vertices; ++i) {
            resultado[i] = new Arista();
        }

        // Paso 1: Ordenar todas las aristas en orden no decreciente de su peso
        Arrays.sort(arista);

        // Crear conjuntos con un único elemento cada uno
        Subconjunto[] subconjuntos = new Subconjunto[vertices];
        for (i = 0; i < vertices; ++i) {
            subconjuntos[i] = new Subconjunto();
        }

        for (int v = 0; v < vertices; ++v) {
            subconjuntos[v].padre = v;
            subconjuntos[v].rango = 0;
        }

        i = 0; // Índice inicial de las aristas ordenadas

        // Número de aristas en el MST será vertices-1
        while (e < vertices - 1) {
            // Paso 2: Seleccionar la arista más corta y verificar si forma un ciclo
            Arista siguienteArista = arista[i++];

            int x = encontrar(subconjuntos, siguienteArista.origen);
            int y = encontrar(subconjuntos, siguienteArista.destino);

            // Si no forma un ciclo, incluirla en el resultado y unir los subconjuntos
            if (x != y) {
                resultado[e++] = siguienteArista;
                unir(subconjuntos, x, y);
            }
        }

        // Imprimir el MST resultante
        System.out.println("Las aristas en el MST son:");
        for (i = 0; i < e; ++i) {
            System.out.println(resultado[i].origen + " -- " + resultado[i].destino + " == " + resultado[i].peso);
        }
    }
}
