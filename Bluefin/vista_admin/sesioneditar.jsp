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
    <title>Editar Sesi�n</title>
    <link rel="stylesheet" href="css/index.css">
        <script>
        function cerrarSesion() {
            if (confirm("�Est�s seguro de que quieres cerrar la sesi�n?")) {
                // Redirigir a la p�gina de cierre de sesi�n segura
                window.location.href = "cerrarSesion.jsp";
            }
        }
    </script>
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
        <a href="#" onclick="cerrarSesion()">Salir</a>
    </div>

    <h1 style="margin-top: 50px">Editar Registro de Sesi�n</h1>
    
    <%
        int id_se = Integer.parseInt(request.getParameter("id_se"));
        String usuario = "";
        String contrase�a = "";
        int tipo = 0;
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");

            String query = "SELECT * FROM sesion WHERE id_se = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id_se);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                usuario = rs.getString("usuario");
                contrase�a = rs.getString("contrase�a");
                tipo = rs.getInt("tipo");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    %>
    
    <form action="sesionguardar.jsp" method="post">
        <input type="hidden" name="id_se" value="<%= id_se %>">
        <label>Usuario: <input type="text" name="usuario" value="<%= usuario %>"></label><br>
        <label>Contrase�a: <input type="text" name="contrase�a" value="<%= contrase�a %>"></label><br>
        <label>Tipo: <input type="number" name="tipo" value="<%= tipo %>"></label><br>
        <button type="submit">Guardar Cambios</button>
    </form>
</body>
</html>
