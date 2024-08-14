import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class App2 {

    public static void main(String[] args) throws Exception {

        try (Connection conn = DriverManager.getConnection("jdbc:h2:~/test", "sa", "");
             Statement stmt = conn.createStatement() )
        {
           /* String sqlCreateTable = """
                    CREATE TABLE IF NOT EXISTS REGISTRATION
                    (
                    ID INTEGER NOT NULL,
                    FIRST_NAME VARCHAR(255),
                    LAST_NAME VARCHAR(255),
                    AGE INTEGER,
                    CONSTRAINT REGISTRATION_pkey PRIMARY KEY (ID)
                    );
                    """;
            stmt.executeUpdate(sqlCreateTable);
            System.out.println("Tabla creada");
            String sqlInsert = """
                    INSERT INTO REGISTRATION VALUES (1, 'JORGE', 'LÓPEZ', 45);
                    INSERT INTO REGISTRATION VALUES (2, 'JUAN', 'MOROCHO', 47);
                    INSERT INTO REGISTRATION VALUES (3, 'RENÉ', 'ELIZALDE', 40);
                    INSERT INTO REGISTRATION VALUES (4, 'AUDREY', 'ROMERO', 44);
                    INSERT INTO REGISTRATION VALUES (5, 'ELIZABETH', 'CADME', 45);
                    """;

            stmt.executeUpdate(sqlInsert);
            System.out.println("Datos agregados");*/
            String sqlSelect = "SELECT ID, FIRST_NAME, LAST_NAME, AGE FROM REGISTRATION";
            ResultSet rs = stmt.executeQuery(sqlSelect);

            while (rs.next()) {
                System.out.printf("%d - %s %s (%d)\n",
                        rs.getInt("ID"),
                        rs.getString("FIRST_NAME"),
                        rs.getString("LAST_NAME"),
                        rs.getInt("AGE")
                );
            }

            rs.close();

            String sqlSelect1 = "SELECT AVG(AGE) AS Promedio, FROM REGISTRATION";
            ResultSet rs1 = stmt.executeQuery(sqlSelect1);

            System.out.println("\nPromedio de las edades: ");
            while (rs1.next()) {
                System.out.printf("%.2f \n",
                        rs1.getDouble("Promedio")
                );
            }

            rs1.close();

            String sqlSelect2 = "SELECT FIRST_NAME, FROM REGISTRATION WHERE FIRST_NAME LIKE 'J%' ";
            ResultSet rs2 = stmt.executeQuery(sqlSelect2);

            System.out.println("\nNombres empezados por J: ");
            while (rs2.next()) {
                System.out.printf("%s\n",
                        rs2.getString("FIRST_NAME")
                );
            }

            rs2.close();
        }
    }

    private static void searchById(String id, Connection conn) throws SQLException {
        var selectBase = """
                SELECT ID, FIRST_NAME, LAST_NAME, AGE
                FROM REGISTRATION
                WHERE id = %s;
                """;
        var select = String.format(selectBase, id);
        System.out.println(select);
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(select) ) {

            while (rs.next()) {
                System.out.printf("%d - %s %s (%d)\n",
                        rs.getInt("ID"),
                        rs.getString("LAST_NAME"),
                        rs.getString("FIRST_NAME"),
                        rs.getInt("AGE"));
            }
        }
    }
}
