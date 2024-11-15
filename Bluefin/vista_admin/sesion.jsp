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
    <title>Administración de Sesión</title>
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

    <h1 style="margin-top:20px">Vista de Administrador - Tabla Sesión</h1>
    <div class="search-bar" style="margin-top:20px;margin-bottom: 20px">
        <form method="get" action="sesion.jsp" style="display: flex;">
            <input type="text" name="search" placeholder="Buscar por ID o Usuario">
            <button type="submit">Buscar</button>
            <button type="button" onclick="window.location.href='sesion.jsp'">Reiniciar</button>
        </form>
    </div>
    <table>
        <tr>
            <th>ID</th>
            <th>Usuario</th>
            <th>Contraseña</th>
            <th>Tipo</th>
            <th>Acciones</th>
        </tr>
        
        <%
            // Conexión a la base de datos, no te robes mi contraseña >:(
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            String searchQuery = request.getParameter("search");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");
                stmt = con.createStatement();
                
                // Consultita para obtener los registros de la tabla sesion
                String query = "SELECT * FROM sesion";
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    query += " WHERE id_se LIKE '%" + searchQuery + "%' OR usuario LIKE '%" + searchQuery + "%'";
                }
                rs = stmt.executeQuery(query);
                
                // Generar filitas de las tablitas :3
                while (rs.next()) {
                    int id = rs.getInt("id_se");
                    String usuario = rs.getString("usuario");
                    String contraseña = rs.getString("contraseña");
                    int tipo = rs.getInt("tipo");
                    //<3 Lau
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= usuario %></td>
                        <td><%= contraseña %></td>
                        <td><%= tipo %></td>
                        <td class="action-buttons">
                            <form action="sesioneditar.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="id_se" value="<%= id %>">
                                <button type="submit">Editar</button>
                            </form>
                            <form action="sesioneliminar.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="id_se" value="<%= id %>">
                                <button type="submit" onclick="return confirm('¿Estás seguro de que deseas eliminar este registro?');">Eliminar</button>
                            </form>
                        </td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    out.println("Error al cerrar la conexión: " + e.getMessage());
                }
            }
        %>
    </table>
</body>
</html>