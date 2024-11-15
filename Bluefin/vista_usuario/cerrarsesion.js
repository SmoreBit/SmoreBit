        function cerrarSesion() {
            if (confirm("¿Estás seguro de que quieres cerrar la sesión?")) {
                window.location.href = "seguridad/cerrarSesion2.jsp";
            }
        }