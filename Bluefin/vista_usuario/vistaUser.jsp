<%@ page import="java.sql.*" %>
<%@ page import="utils.DatabaseConnection" %>

<%
    // Verificación de la sesión y del usuario autenticado
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("../sesion.html");
        return;
    }

    // Obtén el nombre de usuario desde la sesión
    String usuario = (String) session.getAttribute("usuario");

    // Consulta para obtener el valor del campo "icono" del usuario
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    int icono = 0;

    try {
        // Usa la clase DatabaseConnection para obtener la conexión
        conn = DatabaseConnection.getConnection();
        String sql = "SELECT icono FROM usuario u JOIN sesion s ON u.id_us = s.id_us WHERE s.usuario = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, usuario);
        rs = stmt.executeQuery();

        if (rs.next()) {
            icono = rs.getInt("icono");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Vista de Usuario - Vida Marina</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/vistaUser.css">
    <script src="cerrarsesion.js"></script>
    <style>
        .imagencita {
    border-radius: 50%;
    width: 300px;
    height: 300px;
    object-fit: cover;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
}

    </style>
</head>
<body>
    <div class="navbar">
        <a href="vistaUser.jsp">Inicio</a>
        <a href="#">Logros</a>
        <a href="#">FAQs</a>
        <a href="rompecabezas.html">Puzzle</a>
        <a href="#">Quiz</a>
        <a href="pintadito.html">Dibujo</a>
        <a href="perfil.jsp">Perfil</a>
        <a href="#" onclick="cerrarSesion()">Salir</a>
    </div>
    <br><br>
    <main>
        <div class="content">
            <h1>Bienvenido a tu perfil de usuario</h1>
            <p>Aquí podrás ver tu progreso y acceder a diferentes secciones del sitio, explora el mundo marino mientras aprendes y te diviertes.</p>
        </div>

        <div class="perfil-imagen">
            <%
                String imagenRuta = "";
                switch (icono) {
                    case 1:
                        imagenRuta = "images/capibarainicio.jpg";
                        break;
                    case 2:
                        imagenRuta = "images/focainicio.jpg";
                        break;
                    case 3:
                        imagenRuta = "images/nutriainicio.jpg";
                        break;
                    default:
                        imagenRuta = "images/icono_default.png";
                        break;
                }
            %>
            <img src="<%= imagenRuta %>" alt="Icono de Usuario" class="imagencita">
        </div>
    </main>
</body>
</html>
