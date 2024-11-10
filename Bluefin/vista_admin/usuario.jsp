<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Administración de Usuarios</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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

    <h1 style="margin-top: 50px">Vista de Administrador - Tabla Usuario</h1>
    
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
            //<3 Vivirás en mi código Lau :3
            //PD ya estoy bien cansado :(
            //P.PD tqm :p
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");
                stmt = con.createStatement();
                
                String query = "SELECT * FROM usuario";
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
