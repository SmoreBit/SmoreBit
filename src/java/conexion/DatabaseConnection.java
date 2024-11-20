package conexion;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection {
    public static String getDbName() {
    return DB_NAME;
}
    // URL, usuario y contraseña para la base de datos
    private static final String URL = "jdbc:mysql://localhost:3306/";
    private static final String DB_NAME = "bluefin";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";

    // Método para obtener la conexión a la base de datos específica
    public static Connection getConnection() throws SQLException {
        try {
            // Registrar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("No se pudo cargar el controlador de MySQL");
        }
        return DriverManager.getConnection(URL + DB_NAME, USER, PASSWORD);
    }

    // Método para ejecutar un archivo SQL
    public static void ejecutarScriptSQL(String rutaSQL) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             BufferedReader br = new BufferedReader(new FileReader(rutaSQL))) {

            StringBuilder script = new StringBuilder();
            String linea;
            while ((linea = br.readLine()) != null) {
                script.append(linea).append("\n");
            }

            String[] comandos = script.toString().split(";");
            for (String comando : comandos) {
                if (!comando.trim().isEmpty()) {
                    stmt.execute(comando.trim());
                    System.out.println("Ejecutado: " + comando.trim());
                }
            }
            System.out.println("Script ejecutado correctamente desde: " + rutaSQL);

        } catch (Exception e) {
            System.err.println("Error al ejecutar el script SQL: " + e.getMessage());
        }
    }

    // Método para inicializar la base de datos si no existe
    public static void inicializarBaseDeDatos(String rutaSQL) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement()) {

            // Verifica si la base de datos existe
            String checkDBQuery = "CREATE DATABASE IF NOT EXISTS " + DB_NAME;
            stmt.execute(checkDBQuery);
            System.out.println("Base de datos '" + DB_NAME + "' verificada/creada.");

            // Usa la base de datos y ejecuta el script
            stmt.execute("USE " + DB_NAME);
            ejecutarScriptSQL(rutaSQL);

        } catch (Exception e) {
            System.err.println("Error al inicializar la base de datos: " + e.getMessage());
        }
    }
}
