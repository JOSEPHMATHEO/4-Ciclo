import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
public class App3 {
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