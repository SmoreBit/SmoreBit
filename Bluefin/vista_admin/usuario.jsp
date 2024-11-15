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
    <title>Administración de Usuarios</title>
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

    <h1 style="margin-top: 20px">Vista de Administrador - Tabla Usuario</h1>
    <div class="search-bar" style="margin-top:20px;margin-bottom: 20px">
        <form method="get" action="usuario.jsp" style="display: flex;">
            <input type="text" name="search" placeholder="Buscar por Nombre, Correo o Fecha">
            <button type="submit">Buscar</button>
            <button type="button" onclick="window.location.href='usuario.jsp'">Reiniciar</button>
        </form>
    </div>
    <table>
        <tr>
            <th>ID</th>
            <th>Correo</th>
            <th>Género</th>
            <th>Ícono</th>
            <th>Edad</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Fecha</th>
            <th>Acciones</th>
        </tr>
        
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            String searchQuery = request.getParameter("search");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");
                stmt = con.createStatement();
                
                String query = "SELECT * FROM usuario";
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    query += " WHERE nombre LIKE '%" + searchQuery + "%' OR correo LIKE '%" + searchQuery + "%' OR fecha LIKE '%" + searchQuery + "%'";
                }
                rs = stmt.executeQuery(query);
                
                while (rs.next()) {
                    int id = rs.getInt("id_us");
                    String correo = rs.getString("correo");
                    String genero = rs.getString("genero");
                    int icono = rs.getInt("icono");
                    int edad = rs.getInt("edad");
                    String nombre = rs.getString("nombre");
                    String apellido = rs.getString("apellido");
                    Date fecha = rs.getDate("fecha");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= correo %></td>
                        <td><%= genero %></td>
                        <td><%= icono %></td>
                        <td><%= edad %></td>
                        <td><%= nombre %></td>
                        <td><%= apellido %></td>
                        <td><%= fecha %></td>
                        <td class="action-buttons">
                            <form action="usuarioeditar.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="id_us" value="<%= id %>">
                                <button type="submit">Editar</button>
                            </form>
                            <form action="usuarioeliminar.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="id_us" value="<%= id %>">
                                <button type="submit" onclick="return confirm('¿Estás seguro de que deseas eliminar este registro?');">Eliminar</button>
                            </form>
                        </td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            }
        %>
    </table>
</body>
</html>
