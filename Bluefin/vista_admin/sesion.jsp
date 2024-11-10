<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Administración de Sesión</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            background-color: #f5f5f5;
            padding-top: 60px;
        }
        .navbar {
            width: 100%;
            background-color: #333;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            justify-content: center;
            padding: 15px 0;
            z-index: 1000;
        }
        .navbar a {
            color: #fff;
            padding: 12px 20px;
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
            transition: background-color 0.3s ease;
            margin: 0 10px;
        }

        .navbar a:hover {
            background-color: #555;
            border-radius: 5px;
        }
        @media (max-width: 600px) {
            .navbar {
                flex-wrap: wrap;
            }
            .navbar a {
                font-size: 16px;
                padding: 10px;
            }
        }
        main {
            padding: 20px;
        }

        section {
            margin: 20px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .action-buttons button {
            padding: 5px 10px;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
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
        <a href="../sesion.html">Salir</a>
    </div>
    <h1 style="margin-top:50px">Vista de Administrador - Tabla Sesión</h1>
    
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
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");
                stmt = con.createStatement();
                
                // Consultita para obtener los registros de la tabla sesion
                String query = "SELECT * FROM sesion";
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

