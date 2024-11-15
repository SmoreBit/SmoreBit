<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("../sesion.html");
        return;
    }
%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Guardar Cambios en Usuario</title>
    <link rel="stylesheet" href="css/index.css">
        <script>
        function cerrarSesion() {
            if (confirm("¿Estás seguro de que quieres cerrar la sesión?")) {
                window.location.href = "cerrarSesion.jsp";
            }
        }
    </script>
</head>
<body>
    <div class="navbar">
        <a href="index.html">Inicio</a>
        <a href="sesion.jsp">Sesión</a>
        <a href="usuario.jsp">Usuario</a>
        <a href="logros.jsp">Logros</a>
        <a href="faqs.jsp">FAQs</a>
        <a href="puzzle.jsp">Puzzle</a>
        <a href="quiz.jsp">Quiz</a>
        <a href="respuestas.jsp">Respuestas</a>
        <a href="#" onclick="cerrarSesion()">Salir</a>
    </div>
    <br><br><br>
    <%
        int id_us = Integer.parseInt(request.getParameter("id_us"));
        String correo = request.getParameter("correo");
        String genero = request.getParameter("genero");
        int icono = Integer.parseInt(request.getParameter("icono"));
        int edad = Integer.parseInt(request.getParameter("edad"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String fecha = request.getParameter("fecha");

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");

            String query = "UPDATE usuario SET correo = ?, genero = ?, icono = ?, edad = ?, nombre = ?, apellido = ?, fecha = ? WHERE id_us = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, correo);
            pstmt.setString(2, genero);
            pstmt.setInt(3, icono);
            pstmt.setInt(4, edad);
            pstmt.setString(5, nombre);
            pstmt.setString(6, apellido);
            pstmt.setString(7, fecha);
            pstmt.setInt(8, id_us);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("<p>Registro actualizado con éxito.</p>");
            } else {
                out.println("<p>Error al actualizar el registro.</p>");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    %>
    <a href="usuario.jsp">Volver a la vista de administrador</a>
</body>
</html>
