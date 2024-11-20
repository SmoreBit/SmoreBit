package service;

import conexion.DatabaseConnection;
import modelo.Sesion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SesionService {

    public SesionService() {
    }

    // Método para obtener la lista de sesiones
    public List<Sesion> getSesionList() {
        List<Sesion> sesionList = new ArrayList<>();
        String query = "SELECT * FROM sesion";

        try (Connection connection = DatabaseConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                Sesion sesion = new Sesion();
                sesion.setIdSe(resultSet.getInt("id_se")); // id_se
                sesion.setUsuario(resultSet.getString("usuario")); // usuario
                sesion.setContraseña(resultSet.getString("contraseña")); // contraseña
                sesion.setTipo(resultSet.getInt("tipo")); // tipo
                sesion.setIdUs(resultSet.getInt("id_us")); // id_us
                sesionList.add(sesion);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sesionList;
    }

    // Método para validar las credenciales de inicio de sesión
    public Sesion validarSesion(String usuario, String contraseña) {
        String query = "SELECT id_se, usuario, contraseña, tipo, id_us FROM sesion WHERE usuario = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, usuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("contraseña");
                    if (storedPassword.equals(contraseña)) {
                        Sesion sesion = new Sesion();
                        sesion.setIdSe(rs.getInt("id_se"));
                        sesion.setUsuario(rs.getString("usuario"));
                        sesion.setContraseña(rs.getString("contraseña"));
                        sesion.setTipo(rs.getInt("tipo"));
                        sesion.setIdUs(rs.getInt("id_us"));
                        return sesion;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Método para verificar si un nombre de usuario ya existe
    public boolean usuarioExiste(String usuario) {
        String query = "SELECT 1 FROM sesion WHERE usuario = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, usuario);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Retorna true si el usuario ya existe
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Método para registrar una nueva sesión
    public boolean registrarSesion(String usuario, String contraseña, int idUs) {
        String query = "INSERT INTO sesion (usuario, contraseña, tipo, id_us) VALUES (?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, usuario);
            ps.setString(2, contraseña);
            ps.setInt(3, 1); // Tipo de usuario estándar
            ps.setInt(4, idUs);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Retorna true si la sesión fue registrada
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
