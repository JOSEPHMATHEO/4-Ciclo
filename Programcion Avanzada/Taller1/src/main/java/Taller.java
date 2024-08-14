import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Taller {
    public static void main(String[] args) throws Exception {
        Connection conn = DriverManager.getConnection("jdbc:h2:~/test", "sa", "");

        // Crear las tablas si no existen
        String sqlCreateTableCategoria = """
                CREATE TABLE IF NOT EXISTS Categoria (
                    id_categoria INTEGER PRIMARY KEY,
                    nombre VARCHAR(255)
                )
                """;

        String sqlCreateTableGasto = """
                CREATE TABLE IF NOT EXISTS Gasto (
                    id_gasto INTEGER PRIMARY KEY,
                    valor DECIMAL(10, 2),
                    fecha DATE,
                    gravado_iva BOOLEAN,
                    id_categoria INTEGER,
                    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
                )
                """;

        String sqlCreateTableOtraCategoria = """
                CREATE TABLE IF NOT EXISTS OtraCategoria (
                    id_otra_categoria INTEGER PRIMARY KEY,
                    nombre VARCHAR(255),
                    fecha_creacion DATE
                )
                """;

        Statement stmt = conn.createStatement();
        stmt.executeUpdate(sqlCreateTableCategoria);
        stmt.executeUpdate(sqlCreateTableGasto);
        stmt.executeUpdate(sqlCreateTableOtraCategoria);
        System.out.println("Tablas creadas");

        // Insertar datos de ejemplo
        String sqlInsertCategoria = """
                INSERT INTO Categoria (id_categoria, nombre) VALUES
                (1, 'Vivienda'),
                (2, 'Educación, arte y cultura'),
                (3, 'Salud'),
                (4, 'Vestimenta'),
                (5, 'Alimentación'),
                (6, 'Turismo')
                """;

        String sqlInsertGasto = """
                INSERT INTO Gasto (id_gasto, valor, fecha, gravado_iva, id_categoria) VALUES
                (1, 100.00, '2024-04-20', true, 1),
                (2, 150.00, '2024-04-20', false, 1),
                (3, 200.00, '2024-04-20', true, 2),
                (4, 120.00, '2024-04-20', false, 3)
                """;

        String sqlInsertOtraCategoria = """
                INSERT INTO OtraCategoria (id_otra_categoria, nombre, fecha_creacion) VALUES
                (1, 'Otra categoría', '2024-04-19')
                """;

        stmt.executeUpdate(sqlInsertCategoria);
        stmt.executeUpdate(sqlInsertGasto);
        stmt.executeUpdate(sqlInsertOtraCategoria);
        System.out.println("Datos agregados");

        // 1. Categoría con más gastos
        String sqlMaxGastos = """
                SELECT c.nombre, COUNT(*) AS total_gastos
                FROM Gasto g
                INNER JOIN Categoria c ON g.id_categoria = c.id_categoria
                GROUP BY c.nombre
                ORDER BY total_gastos DESC
                LIMIT 1
                """;
        ResultSet rsMaxGastos = stmt.executeQuery(sqlMaxGastos);
        if (rsMaxGastos.next()) {
            String categoriaMaxGastos = rsMaxGastos.getString("nombre");
            int totalGastos = rsMaxGastos.getInt("total_gastos");
            System.out.printf("1. Categoría con más gastos: %s (%d gastos)\n", categoriaMaxGastos, totalGastos);
        }
        rsMaxGastos.close();

        // 2. Categoría con el gasto más elevado
        String sqlMaxValor = """
        SELECT c.nombre, MAX(g.valor) AS max_valor
        FROM Gasto g
        INNER JOIN Categoria c ON g.id_categoria = c.id_categoria
        GROUP BY c.nombre
        """;
        ResultSet rsMaxValor = stmt.executeQuery(sqlMaxValor);
        if (rsMaxValor.next()) {
            String categoriaMaxValor = rsMaxValor.getString("nombre");
            double maxValor = rsMaxValor.getDouble("max_valor");
            System.out.printf("2. Categoría con el gasto más elevado: %s ($%.2f)\n", categoriaMaxValor, maxValor);
        }
        rsMaxValor.close();

        // 3. Categoría con el mayor promedio de gastos
        String sqlPromedioGastos = """
                SELECT c.nombre, AVG(g.valor) AS promedio_gastos
                FROM Gasto g
                INNER JOIN Categoria c ON g.id_categoria = c.id_categoria
                GROUP BY c.nombre
                ORDER BY promedio_gastos DESC
                LIMIT 1
                """;
        ResultSet rsPromedioGastos = stmt.executeQuery(sqlPromedioGastos);
        if (rsPromedioGastos.next()) {
            String categoriaPromedioGastos = rsPromedioGastos.getString("nombre");
            double promedioGastos = rsPromedioGastos.getDouble("promedio_gastos");
            System.out.printf("3. Categoría con el mayor promedio de gastos: %s ($%.2f)\n", categoriaPromedioGastos, promedioGastos);
        }
        rsPromedioGastos.close();

        // 4. Categoría con el menor número de gastos gravados por IVA
        String sqlMinGastosIVA = """
                SELECT c.nombre, COUNT(*) AS total_gastos_iva
                FROM Gasto g
                INNER JOIN Categoria c ON g.id_categoria = c.id_categoria
                WHERE g.gravado_iva = true
                GROUP BY c.nombre
                ORDER BY total_gastos_iva ASC
                LIMIT 1
                """;
        ResultSet rsMinGastosIVA = stmt.executeQuery(sqlMinGastosIVA);
        if (rsMinGastosIVA.next()) {
            String categoriaMinGastosIVA = rsMinGastosIVA.getString("nombre");
            int totalGastosIVA = rsMinGastosIVA.getInt("total_gastos_iva");
            System.out.printf("4. Categoría con el menor número de gastos gravados por IVA: %s (%d gastos)\n", categoriaMinGastosIVA, totalGastosIVA);
        }
        rsMinGastosIVA.close();

        // 5. Categorías ordenadas por número de gastos en forma descendente
        String sqlCategoriasOrdenadas = """
                SELECT c.nombre, COUNT(*) AS total_gastos
                FROM Gasto g
                INNER JOIN Categoria c ON g.id_categoria = c.id_categoria
                GROUP BY c.nombre
                ORDER BY total_gastos DESC
                """;
        ResultSet rsCategoriasOrdenadas = stmt.executeQuery(sqlCategoriasOrdenadas);
        System.out.println("5. Categorías ordenadas por número de gastos en forma descendente:");
        while (rsCategoriasOrdenadas.next()) {
            String nombreCategoria = rsCategoriasOrdenadas.getString("nombre");
            int totalGastos = rsCategoriasOrdenadas.getInt("total_gastos");
            System.out.printf("%s: %d gastos\n", nombreCategoria, totalGastos);
        }
        stmt.close();
        conn.close();
    }
}
