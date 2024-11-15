<%@ page import="java.sql.*" %>
<%@ page import="utils.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil del Usuario</title>
    <link rel="stylesheet" href="css/perfil.css">
    <script src="cerrarsesion.js"></script>
    <style>
        .profile-container {
            width: 60%;
            margin: 0 auto;
            padding: 20px;
            background-color: #f0f0f0;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .profile-icon {
            display: block;
            margin: 0 auto;
            border-radius: 50%;
            width: 150px;
            height: 150px;
            object-fit: cover;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .profile-detail {
            margin: 15px 0;
            font-size: 1.2em;
        }
        .profile-detail strong {
            color: #333;
        }
        .edit-button {
            margin: 20px;
            padding: 10px 20px;
            font-size: 1em;
            cursor: pointer;
        }
        .hidden {
            display: none;
        }
        .icon-option {
            margin: 5px;
            width: 50px;
            height: 50px;
            border: 2px solid transparent;
            cursor: pointer;
            transition: border 0.3s;
        }
        .icon-option.selected {
            border-color: blue;
        }
    </style>
    <script>
        function toggleEdit() {
            document.getElementById("view-mode").classList.toggle("hidden");
            document.getElementById("edit-mode").classList.toggle("hidden");
        }

        // Función para seleccionar el icono
        function selectIcon(iconId) {
            document.getElementById("iconoIdInput").value = iconId;
            document.querySelectorAll(".icon-option").forEach(el => el.classList.remove("selected"));
            document.getElementById("icon-option-" + iconId).classList.add("selected");
        }
    </script>
</head>
<body>
    <div class="navbar">
        <a href="vistaUser.jsp">Inicio</a>
        <a href="#">Logros</a>
        <a href="#">FAQs</a>
        <a href="rompecabezas.html">Puzzle</a>
        <a href="#">Quiz</a>
        <a href="pintadito.html">Dibujo</a>
        <a href="perfil.jsp">Perfil</a>
        <a href="#" onclick="cerrarSesion()">Salir</a>
    </div>

    <main>
        <div class="profile-container">
            <h2>Perfil del Usuario</h2>
            <%
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                String userId = (String) session.getAttribute("userId");

                if (userId == null) {
                    out.println("<script>alert('Por favor, inicia sesión primero.'); window.location='sesion.html';</script>");
                } else {
                    try {
                        con = DatabaseConnection.getConnection();
                        
                        String query = "SELECT sesion.usuario, usuario.correo, usuario.genero, usuario.icono, usuario.edad, usuario.nombre, usuario.apellido " +
                                       "FROM sesion INNER JOIN usuario ON sesion.id_us = usuario.id_us WHERE usuario.id_us = ?";
                        pstmt = con.prepareStatement(query);
                        pstmt.setString(1, userId);
                        rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            String nombreUsuario = rs.getString("usuario");
                            String correo = rs.getString("correo");
                            String genero = rs.getString("genero");
                            int edad = rs.getInt("edad");
                            String nombre = rs.getString("nombre");
                            String apellido = rs.getString("apellido");
                            int iconoId = rs.getInt("icono");

                            // Determinar la imagen del ícono según el valor de "icono"
                            String iconoUrl = "images/default.png";
                            switch (iconoId) {
                                case 1:
                                    iconoUrl = "images/capibara.png";
                                    break;
                                case 2:
                                    iconoUrl = "images/foca.png";
                                    break;
                                case 3:
                                    iconoUrl = "images/nutria.png";
                                    break;
                                default:
                                    iconoUrl = "images/default.png";
                                    break;
                            }
            %>

                            <!-- Modo de visualización -->
                            <div id="view-mode">
                                <img src="<%= iconoUrl %>" alt="Ícono de perfil" class="profile-icon">
                                <div class="profile-detail"><strong>Nombre de usuario:</strong> <%= nombreUsuario %></div>
                                <div class="profile-detail"><strong>Correo:</strong> <%= correo %></div>
                                <div class="profile-detail"><strong>Género:</strong> <%= genero %></div>
                                <div class="profile-detail"><strong>Edad:</strong> <%= edad %> años</div>
                                <div class="profile-detail"><strong>Nombre:</strong> <%= nombre %> <%= apellido %></div>
                                <button class="edit-button" onclick="toggleEdit()">Editar Perfil</button>
                            </div>

                            <!-- Modo de edición (oculto al inicio) -->
                            <div id="edit-mode" class="hidden">
                                <form action="perfilActualizar.jsp" method="post">
                                    <div class="profile-detail">
                                        <strong>Nombre de usuario:</strong>
                                        <input type="text" name="usuario" value="<%= nombreUsuario %>" required>
                                    </div>
                                    <div class="profile-detail">
                                        <strong>Correo:</strong>
                                        <input type="email" name="correo" value="<%= correo %>" required>
                                    </div>
                                    <div class="profile-detail">
                                        <strong>Género:</strong>
                                        <select name="genero" required>
                                            <option value="Masculino" <%= genero.equals("Masculino") ? "selected" : "" %>>Masculino</option>
                                            <option value="Femenino" <%= genero.equals("Femenino") ? "selected" : "" %>>Femenino</option>
                                        </select>
                                    </div>
                                    <div class="profile-detail">
                                        <strong>Edad:</strong>
                                        <input type="number" name="edad" value="<%= edad %>" required>
                                    </div>
                                    <div class="profile-detail">
                                        <strong>Nombre:</strong>
                                        <input type="text" name="nombre" value="<%= nombre %>" required>
                                        <input type="text" name="apellido" value="<%= apellido %>" required>
                                    </div>

                                    <!-- Selección de ícono -->
                                    <div class="profile-detail">
                                        <strong>Selecciona un nuevo ícono:</strong><br>
                                        <img src="images/capibara.png" id="icon-option-1" class="icon-option <%= (iconoId == 1) ? "selected" : "" %>" onclick="selectIcon(1)">
                                        <img src="images/foca.png" id="icon-option-2" class="icon-option <%= (iconoId == 2) ? "selected" : "" %>" onclick="selectIcon(2)">
                                        <img src="images/nutria.png" id="icon-option-3" class="icon-option <%= (iconoId == 3) ? "selected" : "" %>" onclick="selectIcon(3)">
                                        <input type="hidden" name="icono" id="iconoIdInput" value="<%= iconoId %>">
                                    </div>

                                    <button type="submit" class="edit-button">Guardar Cambios</button>
                                    <button type="button" class="edit-button" onclick="toggleEdit()">Cancelar</button>
                                </form>
                            </div>
            <%
                        } else {
                            out.println("<p>No se pudo encontrar el perfil del usuario.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception e) {}
                        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                        if (con != null) try { con.close(); } catch (Exception e) {}
                    }
                }
            %>
        </div>
    </main>
</body>
</html>
