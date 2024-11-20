<%@page import="service.SesionService"%>
<%@page import="modelo.Sesion"%>
<%
    String usuario = request.getParameter("usuario");
    String contra = request.getParameter("contraseña");

    SesionService sesionService = new SesionService();
    Sesion sesion = sesionService.validarSesion(usuario, contra);

    if (sesion != null) {
        session.setAttribute("userId", sesion.getIdUs());
        session.setAttribute("usuario", sesion.getUsuario());
        int tipoUsuario = sesion.getTipo();

        switch (tipoUsuario) {
            case 0:
                out.println("<script>alert('Inicio de sesión exitoso Administrador');</script>");
                out.println("<script>window.location='vista_admin/vistaAdmin.jsp';</script>");
                break;
            case 1:
                out.println("<script>alert('¡Bienvenido!');</script>");
                out.println("<script>window.location='vista_usuario/vistaUser.jsp';</script>");
                break;
            default:
                out.println("<script>alert('Tipo de usuario desconocido');</script>");
                out.println("<script>window.location='sesion.html';</script>");
        }
    } else {
        out.println("<script>alert('Usuario o contraseña incorrectos');</script>");
        out.println("<script>window.location='sesion.html';</script>");
    }
%>
