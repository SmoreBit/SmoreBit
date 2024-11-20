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
    <title>Editar Usuario</title>
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

    <h1 style="margin-top: 50px">Editar Registro de Usuario</h1>
    
    <%
        int id_us = Integer.parseInt(request.getParameter("id_us"));
        String correo = "";
        String genero = "";
        int icono = 0;
        int edad = 0;
        String nombre = "";
        String apellido = "";
        Date fecha = null;
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");

            String query = "SELECT * FROM usuario WHERE id_us = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id_us);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                correo = rs.getString("correo");
                genero = rs.getString("genero");
                icono = rs.getInt("icono");
                edad = rs.getInt("edad");
                nombre = rs.getString("nombre");
                apellido = rs.getString("apellido");
                fecha = rs.getDate("fecha");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    %>
    
    <form action="usuarioguardar.jsp" method="post">
        <input type="hidden" name="id_us" value="<%= id_us %>">
        <label>Correo: <input type="email" name="correo" value="<%= correo %>"></label><br>
        <label>Género: <input type="text" name="genero" value="<%= genero %>"></label><br>
        <label>Ícono: <input type="number" name="icono" value="<%= icono %>"></label><br>
        <label>Edad: <input type="number" name="edad" value="<%= edad %>"></label><br>
        <label>Nombre: <input type="text" name="nombre" value="<%= nombre %>"></label><br>
        <label>Apellido: <input type="text" name="apellido" value="<%= apellido %>"></label><br>
        <label>Fecha: <input type="date" name="fecha" value="<%= fecha %>"></label><br>
        <button type="submit">Guardar Cambios</button>
    </form>
</body>
</html>
