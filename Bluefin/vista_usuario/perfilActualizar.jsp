<%@ page import="java.sql.*" %>
<%@ page import="utils.DatabaseConnection" %>

<%
    String userId = (String) session.getAttribute("userId");

    if (userId == null) {
        out.println("<script>alert('Por favor, inicia sesión primero.'); window.location='sesion.html';</script>");
    } else {
        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");
        String genero = request.getParameter("genero");
        int edad = Integer.parseInt(request.getParameter("edad"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        int iconoId = Integer.parseInt(request.getParameter("icono"));

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = DatabaseConnection.getConnection();
            String sql = "UPDATE usuario INNER JOIN sesion ON usuario.id_us = sesion.id_us " +
                         "SET sesion.usuario = ?, usuario.correo = ?, usuario.genero = ?, usuario.edad = ?, usuario.nombre = ?, usuario.apellido = ?, usuario.icono = ? " +
                         "WHERE usuario.id_us = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, usuario);
            pstmt.setString(2, correo);
            pstmt.setString(3, genero);
            pstmt.setInt(4, edad);
            pstmt.setString(5, nombre);
            pstmt.setString(6, apellido);
            pstmt.setInt(7, iconoId);
            pstmt.setString(8, userId);

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                out.println("<script>alert('Perfil actualizado correctamente');</script>");
                out.println("<script>window.location='perfil.jsp';</script>");
            } else {
                out.println("<script>alert('Error al actualizar el perfil');</script>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
    }
%>
