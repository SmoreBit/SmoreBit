<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("../sesion.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página con Barra de Navegación</title>
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
        <a href="vistaAdmin.jsp">Inicio</a>
        <a href="sesion.jsp">Sesión</a>
        <a href="usuario.jsp">Usuario</a>
        <a href="logros.jsp">Logros</a>
        <a href="faqs.jsp">FAQs</a>
        <a href="puzzle.jsp">Puzzle</a>
        <a href="quiz.jsp">Quiz</a>
        <a href="respuestas.jsp">Respuestas</a>
        <a href="#" onclick="cerrarSesion()">Salir</a>
    </div>
    <h1 style="text-align: center;margin-top: 50px">Bienvenido Administrador :3</h1>
    <p>Esta es la vista de administrador de Bluefin, eso significa que tienes 
       CONTROL TOTAL sobre las tablas de la base de datos, llamese altas bajas y
       cambios, puedes hacer todo eso, practicamente tienes todo el poder >:) arriba
       verás las tablas que están dadas de alta en la base de datos de bluefin 
       para acceder a ellas debes dar clic sobre la tabla que quieras editar
       seguido de eso verás una tablota con todos los datos en la plataforma. Para editarla
       simplemente presiona en el botón editar y abrirá otra página con los datos para 
       que puedas editar TODOS los campos y para eliminarla debes dar en el botón de eliminar
       SENCILLO no? :3 disfruta del poder y no borres cosas importantes chi? :3</p>
</body>
</html>