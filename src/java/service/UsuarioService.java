package service;

import conexion.DatabaseConnection;
import modelo.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioService {

    public UsuarioService() {
    }

    // Método para obtener la lista de usuarios
    public List<Usuario> getUsuarioList() {
        List<Usuario> usuarioList = new ArrayList<>();
        String query = "SELECT * FROM usuario";

        try (Connection connection = DatabaseConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUs(resultSet.getInt("id_us"));
                usuario.setCorreo(resultSet.getString("correo"));
                usuario.setGenero(resultSet.getString("genero"));
                usuario.setIcono(resultSet.getInt("icono"));
                usuario.setEdad(resultSet.getInt("edad"));
                usuario.setNombre(resultSet.getString("nombre"));
                usuario.setApellido(resultSet.getString("apellido"));
                usuario.setFecha(resultSet.getDate("fecha"));
                usuarioList.add(usuario);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarioList;
    }

    // Método para verificar si un correo ya existe
    public boolean correoExiste(String correo) {
        String query = "SELECT 1 FROM usuario WHERE correo = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, correo);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Retorna true si el correo ya existe
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Método para registrar un nuevo usuario
    public int registrarUsuario(String correo, String genero, int icono, int edad, String nombre, String apellido, String fecha) {
        String query = "INSERT INTO usuario (correo, genero, icono, edad, nombre, apellido, fecha) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, correo);
            ps.setString(2, genero);
            ps.setInt(3, icono);
            ps.setInt(4, edad);
            ps.setString(5, nombre);
            ps.setString(6, apellido);
            ps.setString(7, fecha);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Retorna el ID generado
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
