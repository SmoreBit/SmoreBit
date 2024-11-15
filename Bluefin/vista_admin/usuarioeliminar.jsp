<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Eliminar Usuario</title>
</head>
<body>
    <div class="navbar">
        <a href="index.html">Inicio</a>
        <a href="sesion.jsp">Sesi�n</a>
        <a href="usuario.jsp">Usuario</a>
        <a href="logros.jsp">Logros</a>
        <a href="faqs.jsp">FAQs</a>
        <a href="puzzle.jsp">Puzzle</a>
        <a href="quiz.jsp">Quiz</a>
        <a href="respuestas.jsp">Respuestas</a>
        <a href="../sesion.html">Salir</a>
    </div>

    <%
        int id_us = Integer.parseInt(request.getParameter("id_us"));
        
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");

            String query = "DELETE FROM usuario WHERE id_us = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id_us);

            int rowsDeleted = pstmt.executeUpdate();
            if (rowsDeleted > 0) {
                out.println("<p>Registro eliminado con �xito.</p>");
            } else {
                out.println("<p>Error al eliminar el registro.</p>");
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