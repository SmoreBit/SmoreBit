<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
    </head>
    <script>
        function mensaje(){
            alert("Usuario registrado exitosamente");
        }
        
        function mensajeUsuarioExistente(){
            alert("Este nombre de usuario ya existe. Por favor, elige otro.");
        }

        function mensajeCorreoExistente(){
            alert("Este correo electrónico ya está asociado a una cuenta.");
        }
    </script>
    
    <body>
        <%
            String usuario = request.getParameter("usuario").trim();
            String correo = request.getParameter("correo").trim();
            String contra = request.getParameter("contraseña");
            String nombre = request.getParameter("nombre").trim();
            String apellido = request.getParameter("apellido").trim();
            String genero = request.getParameter("genero");
            int edad = Integer.parseInt(request.getParameter("edad"));
            int icono = Integer.parseInt(request.getParameter("icono"));

            // Obtener la fecha del formulario o asignar la fecha actual si no se proporciona
            String fecha = request.getParameter("fecha");
            if (fecha == null || fecha.isEmpty()) {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                fecha = sdf.format(new java.util.Date());
            }

            Connection con = null;
            Statement sta = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                con = DriverManager.getConnection("jdbc:mysql://localhost/bluefin", "root", "1234");
                sta = con.createStatement();

                // Verificar si el correo ya existe
                rs = sta.executeQuery("SELECT * FROM usuario WHERE correo='" + correo + "';");
                if (rs.next()) {
                    out.println("<script> mensajeCorreoExistente();</script>");
                    out.println("<script>window.location='registro.html';</script>");
                } else {
                    // Verificar si el nombre de usuario ya existe
                    rs = sta.executeQuery("SELECT * FROM sesion WHERE usuario='" + usuario + "';");
                    if (rs.next()) {
                        out.println("<script> mensajeUsuarioExistente();</script>");
                        out.println("<script>window.location='registro.html';</script>");
                    } else {
                        // Insertar el usuario en la tabla 'usuario' con la fecha asignada
                        int resultadoUsuario = sta.executeUpdate("INSERT INTO usuario (correo, genero, icono, edad, nombre, apellido, fecha) VALUES ('" 
                            + correo + "', '" + genero + "', " + icono + ", " + edad + ", '" + nombre + "', '" + apellido + "', '" + fecha + "');");

                        if (resultadoUsuario > 0) {
                            // Obtener el último ID de usuario registrado para asociarlo con la sesión
                            ResultSet generatedKeys = sta.executeQuery("SELECT LAST_INSERT_ID();");
                            int idUs = 0;
                            if (generatedKeys.next()) {
                                idUs = generatedKeys.getInt(1);
                            }

                            // Insertar en la tabla 'sesion'
                            sta.executeUpdate("INSERT INTO sesion (usuario, contraseña, tipo) VALUES ('" + usuario + "', '" + contra + "', 1);");
                            out.println("<script> mensaje();</script>");
                            out.println("<script>window.location='sesion.html';</script>");
                        }
                    }
                }
            } catch (Exception e) {
                out.print("Error en la base de datos: " + e.toString());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (sta != null) sta.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    out.print(e.toString());
                }
            }
        %>
    </body>
</html>
