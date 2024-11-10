<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Sesión</title>
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

    <h1 style="margin-top: 50px">Editar Registro de Sesión</h1>
    
    <%
        int id_se = Integer.parseInt(request.getParameter("id_se"));
        String usuario = "";
        String contraseña = "";
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
                contraseña = rs.getString("contraseña");
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
        <label>Contraseña: <input type="text" name="contraseña" value="<%= contraseña %>"></label><br>
        <label>Tipo: <input type="number" name="tipo" value="<%= tipo %>"></label><br>
        <button type="submit">Guardar Cambios</button>
    </form>
</body>
</html>
