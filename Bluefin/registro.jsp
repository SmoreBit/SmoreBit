<%@ page import="service.UsuarioService" %>
<%@ page import="service.SesionService" %>
<%
    String usuario = request.getParameter("usuario").trim();
    String correo = request.getParameter("correo").trim();
    String contra = request.getParameter("contraseña");
    String nombre = request.getParameter("nombre").trim();
    String apellido = request.getParameter("apellido").trim();
    String genero = request.getParameter("genero");
    int edad = Integer.parseInt(request.getParameter("edad"));
    int icono = Integer.parseInt(request.getParameter("icono"));

    // Obtener la fecha actual si no se proporciona
    String fecha = request.getParameter("fecha");
    if (fecha == null || fecha.isEmpty()) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        fecha = sdf.format(new java.util.Date());
    }

    UsuarioService usuarioService = new UsuarioService();
    SesionService sesionService = new SesionService();

    if (usuarioService.correoExiste(correo)) {
        out.println("<script>alert('Este correo electrónico ya está asociado a una cuenta.');</script>");
        out.println("<script>window.location='registro.html';</script>");
    } else if (sesionService.usuarioExiste(usuario)) {
        out.println("<script>alert('Este nombre de usuario ya existe. Por favor, elige otro.');</script>");
        out.println("<script>window.location='registro.html';</script>");
    } else {
        int idUs = usuarioService.registrarUsuario(correo, genero, icono, edad, nombre, apellido, fecha);
        if (idUs > 0) {
            boolean registrado = sesionService.registrarSesion(usuario, contra, idUs);
            if (registrado) {
                out.println("<script>alert('Usuario registrado exitosamente');</script>");
                out.println("<script>window.location='sesion.html';</script>");
            } else {
                out.println("<script>alert('Error al registrar la sesión.');</script>");
                out.println("<script>window.location='registro.html';</script>");
            }
        } else {
            out.println("<script>alert('Error al registrar el usuario.');</script>");
            out.println("<script>window.location='registro.html';</script>");
        }
    }
%>
