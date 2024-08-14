import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class TareaEnClase {

    public static void main(String[] args) {
    try (Connection conn = DriverManager.getConnection("jdbc:h2:~/test", "Roberto", "Peluza78")) {
        Statement delete = conn.createStatement();
        delete.executeUpdate("DROP ALL OBJECTS DELETE FILES;");
        System.out.println("Base de datos eliminada");

        Scanner scanner = new Scanner(System.in);
        boolean continuar = true;
        Statement stmt = conn.createStatement();

        String sqlCreateTable = """
                    CREATE TABLE IF NOT EXISTS Categoria (
                            id_categoria INTEGER PRIMARY KEY AUTO_INCREMENT,
                            nombre VARCHAR(50) NOT NULL,
                            fecha_creacion DATE NOT NULL
                    );
                    CREATE TABLE IF NOT EXISTS Gasto (
                        id_gasto INTEGER PRIMARY KEY AUTO_INCREMENT,
                        valor DECIMAL(10, 2) NOT NULL,
                        fecha DATETIME NOT NULL,
                        gravado_iva BOOLEAN NOT NULL,
                        id_categoria INTEGER NOT NULL,
                        FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
                    );
                    """;
        stmt.executeUpdate(sqlCreateTable);
        System.out.println("Tabla creada");



        String sqlInsert = """
                    INSERT INTO Categoria (nombre, fecha_creacion) VALUES
                        ('Vivienda', '2024-04-01'),
                        ('Educación, arte y cultura', '2024-04-01'),
                        ('Salud', '2024-04-01'),
                        ('Vestimenta', '2024-04-01'),
                        ('Alimentación', '2024-04-01'),
                        ('Turismo', '2024-04-01'),
                        ('Otros', '2024-04-01');
                    INSERT INTO Gasto (valor, fecha, gravado_iva, id_categoria) VALUES
                        (100.50, '2024-04-02 10:30:00', TRUE, 1),
                        (50.00, '2024-04-03 14:45:00', FALSE, 2),
                        (75.25, '2024-04-04 09:15:00', TRUE, 3),
                        (30.00, '2024-04-05 16:20:00', FALSE, 4),
                        (20.75, '2024-04-06 12:00:00', TRUE, 5),
                        (150.00, '2024-04-07 18:30:00', FALSE, 6),
                        (25.00, '2024-04-08 11:15:00', TRUE, 7);
                    """;
        while (continuar) {
            System.out.print("¿Desea agregar una nueva categoría? (s/n): ");
            String respuesta = scanner.nextLine();
            if (respuesta.equalsIgnoreCase("s")) {
                System.out.print("Ingrese el nombre de la nueva categoría: ");
                String nombreCategoria = scanner.nextLine();
                System.out.print("Ingrese la fecha de creación de la categoría (YYYY-MM-DD): ");
                String fechaCreacion = scanner.nextLine();

                String sqlInsertCategoria = "INSERT INTO Categoria (nombre, fecha_creacion) VALUES ('" +
                        nombreCategoria + "', '" + fechaCreacion + "')";
                stmt.executeUpdate(sqlInsertCategoria);
                System.out.println("Categoría agregada correctamente.");

                System.out.print("¿Desea agregar un gasto a la nueva categoría? (s/n): ");
                respuesta = scanner.nextLine();
                if (respuesta.equalsIgnoreCase("s")) {
                    System.out.print("Ingrese el valor del gasto: ");
                    double valor = scanner.nextDouble();
                    scanner.nextLine(); // Consumir el salto de línea después de ingresar el valor
                    System.out.print("Ingrese la fecha del gasto (YYYY-MM-DD HH:MM:SS): ");
                    String fechaGasto = scanner.nextLine();
                    System.out.print("¿El gasto está gravado por IVA? (s/n): ");
                    respuesta = scanner.nextLine();
                    boolean gravadoIva = respuesta.equalsIgnoreCase("s");

                    int idCategoria = obtenerIdCategoria(stmt, nombreCategoria);

                    String sqlInsertGasto = "INSERT INTO Gasto (valor, fecha, gravado_iva, id_categoria) VALUES ("
                            + valor + ", '" + fechaGasto + "', " + gravadoIva + ", " + idCategoria + ")";
                    stmt.executeUpdate(sqlInsertGasto);
                    System.out.println("Gasto agregado correctamente.");
                }
            } else {
                continuar = false;
            }
        }

        stmt.executeUpdate(sqlInsert);
        System.out.println("Datos agregados");

        // 1. ¿Cuál es la categoría en la que más gastos se han registrado?
        String sql1 = """
                    SELECT c.nombre, COUNT(*) AS cantidad_gastos
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY cantidad_gastos DESC
                    LIMIT 1;
                    """;
        ResultSet rs1 = stmt.executeQuery(sql1);
        if (rs1.next()) {
            System.out.println("1. La categoría con más gastos registrados es: " + rs1.getString("nombre"));
        }

        // 2. ¿Cuál es la categoría en dónde está el gasto más elevado?
        String sql2 = """
                    SELECT c.nombre, MAX(g.valor) AS gasto_maximo
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY gasto_maximo DESC
                    LIMIT 1;
                    """;
        ResultSet rs2 = stmt.executeQuery(sql2);
        if (rs2.next()) {
            System.out.println("2. La categoría con el gasto más elevado es: " + rs2.getString("nombre"));
        }

        // 3. ¿Cuál es la categoría que tiene el mayor promedio de gastos?
        String sql3 = """
                    SELECT c.nombre, AVG(g.valor) AS promedio_gastos
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY promedio_gastos DESC
                    LIMIT 1;
                    """;
        ResultSet rs3 = stmt.executeQuery(sql3);
        if (rs3.next()) {
            System.out.println("3. La categoría con el mayor promedio de gastos es: " + rs3.getString("nombre"));
        }

        // 4. ¿Cuál es la categoría que tiene el menor número de gastos gravados por IVA?
        String sql4 = """
                    SELECT c.nombre, COUNT(CASE WHEN g.gravado_iva THEN 1 END) AS gastos_gravados_iva
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY gastos_gravados_iva ASC
                    LIMIT 1;
                    """;
        ResultSet rs4 = stmt.executeQuery(sql4);
        if (rs4.next()) {
            System.out.println("4. La categoría con el menor número de gastos gravados por IVA es: " + rs4.getString("nombre"));
        }

        // 5. Presente las categorías ordenadas por el número de gastos en forma descendente
        String sql5 = """
                    SELECT c.nombre, COUNT(*) AS cantidad_gastos
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY cantidad_gastos DESC;
                    """;
        ResultSet rs5 = stmt.executeQuery(sql5);
        System.out.println("5. Categorías ordenadas por el número de gastos en forma descendente:");
        while (rs5.next()) {
            System.out.println(rs5.getString("nombre") + " - " + rs5.getInt("cantidad_gastos"));
        }
        // Imprimir tabla Categoria
        System.out.println("\nTabla Categoria:");
        String sqlSelectCategoria = "SELECT * FROM Categoria";
        ResultSet rsCategoria = stmt.executeQuery(sqlSelectCategoria);
        while (rsCategoria.next()) {
            System.out.println(rsCategoria.getInt("id_categoria") + " | " +
                    rsCategoria.getString("nombre") + " | " +
                    rsCategoria.getString("fecha_creacion"));
        }

// Imprimir tabla Gasto
        System.out.println("\nTabla Gasto:");
        String sqlSelectGasto = "SELECT * FROM Gasto";
        ResultSet rsGasto = stmt.executeQuery(sqlSelectGasto);
        while (rsGasto.next()) {
            System.out.println(rsGasto.getInt("id_gasto") + " | " +
                    rsGasto.getDouble("valor") + " | " +
                    rsGasto.getString("fecha") + " | " +
                    rsGasto.getBoolean("gravado_iva") + " | " +
                    rsGasto.getInt("id_categoria"));
        }

        conn.close();
    } catch (SQLException e) {
        e.printStackTrace();

    }
}

    private static int obtenerIdCategoria(Statement stmt, String nombreCategoria) throws SQLException {
        String sql = "SELECT id_categoria FROM Categoria WHERE nombre = '" + nombreCategoria + "'";
        ResultSet rs = stmt.executeQuery(sql);
        if (rs.next()) {
            return rs.getInt("id_categoria");
        } else {
            throw new SQLException("No se encontró la categoría con nombre: " + nombreCategoria);
        }
    }
}