import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
public class App3 {
    public static void main( String[] args ) throws Exception {
        Connection conn = DriverManager.getConnection(
                "jdbc:h2:~/test",
                "sa",
                "");
// Crear la tabla si no existe
        String sqlCreateTable = """
                CREATE TABLE IF NOT EXISTS REGISTRATION
                (
                ID INTEGER NOT NULL,
                FIRST_NAME VARCHAR(255),
                LAST_NAME VARCHAR(255),
                AGE INTEGER,
                CONSTRAINT REGISTRATION_pkey PRIMARY KEY (ID)
                );
                """;
        Statement stmt = conn.createStatement();
        stmt.executeUpdate(sqlCreateTable);
        System.out.println("Tabla creada");

        // Insertar datos
        String sqlInsert = """
                INSERT INTO REGISTRATION VALUES (1, 'JORGE', 'LÓPEZ', 45);
                INSERT INTO REGISTRATION VALUES (2, 'JUAN', 'MOROCHO', 47);
                INSERT INTO REGISTRATION VALUES (3, 'RENÉ', 'ELIZALDE', 40);
                INSERT INTO REGISTRATION VALUES (4, 'AUDREY', 'ROMERO', 44);
                INSERT INTO REGISTRATION VALUES (5, 'ELIZABETH', 'CADME', 45);
                """;
        stmt.executeUpdate(sqlInsert);
        System.out.println("Datos agregados");

        // Consulta para obtener el promedio de edad
        String sqlPromedioEdad = "SELECT AVG(AGE) AS PROMEDIO_EDAD FROM REGISTRATION";
        ResultSet rsPromedio = stmt.executeQuery(sqlPromedioEdad);
        if (rsPromedio.next()) {
            double promedioEdad = rsPromedio.getDouble("PROMEDIO_EDAD");
            System.out.printf("Promedio de Edad: %.2f\n", promedioEdad);
        }
        rsPromedio.close();

        // Consulta para obtener nombres que comienzan con 'J'
        String sqlNombresConJ = "SELECT FIRST_NAME, LAST_NAME FROM REGISTRATION WHERE FIRST_NAME LIKE 'J%'";
        ResultSet rsNombresConJ = stmt.executeQuery(sqlNombresConJ);
        System.out.println("Nombres que comienzan con 'J':");
        while (rsNombresConJ.next()) {
            String firstName = rsNombresConJ.getString("FIRST_NAME");
            String lastName = rsNombresConJ.getString("LAST_NAME");
            System.out.printf("%s %s\n", firstName, lastName);
        }
        rsNombresConJ.close();

        stmt.close();
        conn.close();
    }

}
