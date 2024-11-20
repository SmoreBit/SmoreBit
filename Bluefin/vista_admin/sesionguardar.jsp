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
    <title>Guardar Cambios</title>
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
        int id_se = Integer.parseInt(request.getParameter("id_se"));
        String usuario = request.getParameter("usuario");
        String contraseña = request.getParameter("contraseña");
        int tipo = Integer.parseInt(request.getParameter("tipo"));

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");

            String query = "UPDATE sesion SET usuario = ?, contraseña = ?, tipo = ? WHERE id_se = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, usuario);
            pstmt.setString(2, contraseña);
            pstmt.setInt(3, tipo);
            pstmt.setInt(4, id_se);

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
    <a href="sesion.jsp">Volver a la vista de administrador</a>
</body>
</html>
