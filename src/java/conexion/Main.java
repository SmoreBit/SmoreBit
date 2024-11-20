package conexion;
import java.sql.Connection;
import java.sql.SQLException;
import conexion.DatabaseConnection;

public class Main {
    public static void main(String[] args) {
        String rutaSQL = "src/sql/bluefin_init.sql";
        try {
            DatabaseConnection.inicializarBaseDeDatos(rutaSQL);
            System.out.println("Base de datos inicializada correctamente.");
        } catch (Exception e) {
            System.err.println("Error al inicializar la base de datos: " + e.getMessage());
            e.printStackTrace();
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn != null) {
                System.out.println("Conexión exitosa a la base de datos: " + DatabaseConnection.getDbName());
            }
        } catch (SQLException e) {
            System.err.println("Error al conectar con la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
