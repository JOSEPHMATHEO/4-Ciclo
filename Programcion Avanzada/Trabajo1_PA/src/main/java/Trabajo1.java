import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Trabajo1 {

    public static void main(String[] args)  {

        // Control de excepciones

        try (Connection conn =

                // Conexion a la base de datos

                     DriverManager.getConnection(
                             "jdbc:h2:~/test",
                             "root",
                             "#23@luis2002")) {

            Statement delete = conn.createStatement();

            // Declaracion de variables

            Scanner scanner = new Scanner(System.in);
            boolean flag = true;
            Statement stmt = conn.createStatement();

            // Creacion de las tablas

            String sqlCreateTable = """
                    
                    -- Tabla Categoria
                    
                    CREATE TABLE IF NOT EXISTS Categoria (
                        id_categoria INTEGER PRIMARY KEY AUTO_INCREMENT,
                        nombre VARCHAR(60) NOT NULL,
                        fecha_crn DATE NOT NULL
                    );
                    
                    -- Tabla Gasto
                    
                    CREATE TABLE IF NOT EXISTS Gasto (
                        id_gasto INTEGER PRIMARY KEY AUTO_INCREMENT,
                        valor DECIMAL(15, 2) NOT NULL,
                        fecha_h DATETIME NOT NULL,
                        gravado_iva BOOLEAN NOT NULL,
                        id_categoria INTEGER NOT NULL,
                        FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
                    );
                    """;
            stmt.executeUpdate(sqlCreateTable);
            System.err.println("La tabla a sido creada con exito...");

            // Insersion de los Datos

            String sqlInsert = """
                    INSERT INTO Categoria (nombre, fecha_crn) VALUES
                    
                        ('Vivienda', '2024-04-01'),
                        ('Educación, arte y cultura', '2024-04-01'),
                        ('Salud', '2024-04-01'),
                        ('Vestimenta', '2024-04-01'),
                        ('Alimentación', '2024-04-01'),
                        ('Turismo', '2024-04-01'),
                        ('Otros', '2024-04-01');
                        
                    INSERT INTO Gasto (valor, fecha_h, gravado_iva, id_categoria) VALUES
                    
                        (100.00, '2018-01-05 10:30:00', TRUE, 1),
                        (200.25, '2019-02-10 14:45:00', TRUE, 2),
                        (300.50, '2020-03-15 09:15:00', TRUE, 3),
                        (400.75, '2021-04-20 16:20:00', FALSE, 4),
                        (500.00, '2022-05-25 12:00:00', FALSE, 5),
                        (600.25, '2023-06-30 18:30:00', FALSE, 6),
                        (700.50, '2024-07-05 11:15:00', TRUE, 7);
                    """;

            // Ciclo repetitivo que me permite agregar nuevas categorias y gastos

            while (flag) {

                // Ingreso de datos

                System.out.print("Ingrese s para agregar una nueva categoria o n para no (s/n): ");
                String seleccion1 = scanner.nextLine().toLowerCase();

                if (seleccion1.equals("s")) {

                    System.out.print("Ingrese la nueva categoría: ");
                    String nomCategoria = scanner.nextLine();

                    System.out.print("Ingrese la fecha de creación en formato (YYYY-MM-DD): ");
                    String fechaCrea = scanner.nextLine();

                    // Creacion de una nueva categoria

                    String sqlInsertCategoria =
                            "INSERT INTO Categoria (nombre, fecha_crn) VALUES ('" +
                            nomCategoria + "', '" + fechaCrea + "')";

                    stmt.executeUpdate(sqlInsertCategoria);

                    System.err.println("la categoría a sigo agregada con exito...");



                    System.out.print("Ingrese s para agregar un gasto a la categoria o n para no (s/n): ");
                    String seleccion2 = scanner.nextLine().toLowerCase();

                    if (seleccion2.equals("s")) {

                        System.out.print("Ingrese el valor: ");
                        double valor = scanner.nextDouble();

                        scanner.nextLine(); // Limpieza de Buffer

                        System.out.print("Ingrese la fecha del gasto en el formato (YYYY-MM-DD HH:MM:SS): ");
                        String fechaGst = scanner.nextLine();

                        System.out.print("Ingrese s si el gasto está gravado con  IVA o n si no (s/n): ");

                        String seleccion3 = scanner.nextLine().toLowerCase();
                        boolean gravadoIva = seleccion3.equals("s");

                        int idCategoria = obtenerIdCategoria(stmt, nomCategoria);

                        //Inserccion de datos

                        String sqlInsertGasto = "INSERT INTO Gasto (valor, fecha_h, gravado_iva, id_categoria) VALUES ("
                                + valor + ", '" + fechaGst + "', " + gravadoIva + ", " + idCategoria + ")";
                        stmt.executeUpdate(sqlInsertGasto);

                        System.err.println("Los gastod han sido agregado con exito...");
                    }

                } else {

                    flag = false;

                }

            }

            stmt.executeUpdate(sqlInsert);
            System.err.println("Datos agregados");

            // Consultas Sql

            // 1. ¿Cuál es la categoría en la que más gastos se han registrado?

            String sql1 = """
                    SELECT c.nombre, COUNT(*) AS cantidadG
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY cantidadG DESC
                    LIMIT 1;
                    """;
            ResultSet rs1 = stmt.executeQuery(sql1);

            if (rs1.next()) {
                System.out.println("1. La categoría con más gastos registrados es: " + rs1.getString("nombre"));
            }

            // 2. ¿Cuál es la categoría en dónde está el gasto más elevado?

            String sql2 = """
                    SELECT c.nombre, MAX(g.valor) AS gastomax
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY gastomax DESC
                    LIMIT 1;
                    """;
            ResultSet rs2 = stmt.executeQuery(sql2);

            if (rs2.next()) {
                System.out.println("2. La categoría con el gasto más elevado es: " + rs2.getString("nombre"));
            }

            // 3. ¿Cuál es la categoría que tiene el mayor promedio de gastos?

            String sql3 = """
                    SELECT c.nombre, AVG(g.valor) AS promedio_
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY promedio_ DESC
                    LIMIT 1;
                    """;
            ResultSet rs3 = stmt.executeQuery(sql3);

            if (rs3.next()) {
                System.out.println("3. La categoría con el mayor promedio de gastos es: " + rs3.getString("nombre"));
            }

            // 4. ¿Cuál es la categoría que tiene el menor número de gastos gravados por IVA?

            String sql4 = """
                    SELECT c.nombre, COUNT(CASE WHEN g.gravado_iva THEN 1 END) AS gastos_gravado
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY gastos_gravado ASC
                    LIMIT 1;
                    """;
            ResultSet rs4 = stmt.executeQuery(sql4);

            if (rs4.next()) {
                System.out.println("4. La categoría con el menor número de gastos gravados por IVA es: " + rs4.getString("nombre"));
            }

            // 5. Presente las categorías ordenadas por el número de gastos en forma descendente

            String sql5 = """
                    SELECT c.nombre, COUNT(*) AS cantidadG
                    FROM Gasto g
                    JOIN Categoria c ON g.id_categoria = c.id_categoria
                    GROUP BY c.nombre
                    ORDER BY cantidadG DESC;
                    """;
            ResultSet rs5 = stmt.executeQuery(sql5);

            System.out.println("5. Categorías ordenadas por el número de gastos en forma descendente:");
            while (rs5.next()) {
                System.out.println(rs5.getString("nombre") + " - " + rs5.getInt("cantidad_gastos"));
            }

            // Impresion de las tablas

            // Tabla de Categorias

            System.out.println("\n --Categorias-- \n");

            String sqlSelectCategoria = "SELECT * FROM Categoria";
            ResultSet rsCategoria = stmt.executeQuery(sqlSelectCategoria);

            // Ciclo para la impresion de la tabla

            while (rsCategoria.next()) {
                System.out.println(
                        rsCategoria.getInt("id_categoria") + " | " +
                        rsCategoria.getString("nombre") + " | " +
                        rsCategoria.getString("fecha_crn"));
            }
            // Imprimir tabla Gastos

            System.out.println("\n --Gasto-- \n");

            String sqlSelectGasto = "SELECT * FROM Gasto";
            ResultSet rsGasto = stmt.executeQuery(sqlSelectGasto);

            // Ciclo para la impresion de la tabla

            while (rsGasto.next()) {
                System.out.println(
                        rsGasto.getInt("id_gasto") + " | " +
                        rsGasto.getDouble("valor") + " | " +
                        rsGasto.getString("fecha_h") + " | " +
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