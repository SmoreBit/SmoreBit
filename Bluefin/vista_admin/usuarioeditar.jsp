<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
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
