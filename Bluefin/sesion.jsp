<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*" %>

<%
    String usuario = request.getParameter("usuario");
    String contra = request.getParameter("contrase�a");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Cargar el driver de MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Establecer la conexi�n
        con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");

        // Consultar la base de datos para verificar las credenciales
        String sql = "SELECT tipo, contrase�a FROM sesion WHERE usuario = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, usuario);
        rs = ps.executeQuery();

        // Verificar si las credenciales son v�lidas
        if (rs.next()) {
            String storedPassword = rs.getString("contrase�a");
            if (storedPassword.equals(contra)) {
            
                int tipoUsuario = rs.getInt("tipo");
                switch(tipoUsuario) {
                    case 0:
                        out.println("<script>alert('Inicio de sesi�n exitoso Administrador');</script>");
                        out.println("<script>window.location='vista_admin/index.html';</script>");
                        break;
                    case 1:
                        out.println("<script>alert('�Bienvenido!');</script>");
                        out.println("<script>window.location='vista_usuario/index.html';</script>");
                        break;
                    default:
                        out.println("<script>alert('Tipo de usuario desconocido');</script>");
                        out.println("<script>window.location='sesion.html';</script>");
                }
            } else {
                out.println("<script>alert('Contrase�a incorrecta');</script>");
                out.println("<script>window.location='sesion.html';</script>");
            }
        } else {
            out.println("<script>alert('Usuario no encontrado');</script>");
            out.println("<script>window.location='sesion.html';</script>");
        }
    } catch(SQLException | ClassNotFoundException e) {
        out.println("<script>alert('Error al conectar con la base de datos');</script>");
        e.printStackTrace(new PrintWriter(out)); // Aqu� se utiliza PrintWriter
    } finally {
        // Cerrar recursos
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<script>alert('Error al cerrar la conexi�n con la base de datos');</script>");
            e.printStackTrace(new PrintWriter(out)); // Aqu� se utiliza PrintWriter
        }
    }
%>
