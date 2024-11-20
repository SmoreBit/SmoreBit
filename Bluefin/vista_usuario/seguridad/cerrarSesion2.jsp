<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Borrar caché, así como en el android xdxd
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session != null) {
        session.invalidate();
    }

    response.sendRedirect("../../sesion.html");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cerrar Sesión</title>
    <link rel="stylesheet" href="css/index.css">
    <script>
        function checkSession() {
            fetch('verificarSesion.jsp')
                .then(response => response.json())
                .then(data => {
                    if (!data.sesionActiva) {
                        alert("La sesión ha expirado. Serás redirigido a la página de inicio de sesión.");
                        window.location.href = '../sesion.html';
                    }
                })
                .catch(error => console.error('Error al verificar la sesión:', error));
        }

        setInterval(checkSession, 60000);
    </script>
</head>
<body>
    <h1>Has cerrado la sesión exitosamente.</h1>
    <p>Serás redirigido a la página de inicio de sesión en unos segundos...</p>
</body>
</html>
