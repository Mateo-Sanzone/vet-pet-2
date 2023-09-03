<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="formulario.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/fontawesome.min.css" integrity="sha384-QYIZto+st3yW+o8+5OHfT6S482Zsvz2WfOzpFSXMF9zqeLcFV0/wlZpMtyFcZALm" crossorigin="anonymous">
        <title>Login - VetPet</title>
    </head>
    <body>
        <%
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;

            String activeForm = (request.getParameter("form") != null && request.getParameter("form").equals("register")) ? "register" : "login";
            boolean isLoggedIn = (session.getAttribute("userLoggedIn") != null && (boolean) session.getAttribute("userLoggedIn")); // Variable que guarda si se inició sesión

            // Verificar si se envió el formulario de cierre de sesión
            if (request.getParameter("cerrar_sesion") != null) {
                session.removeAttribute("userLoggedIn");
                response.sendRedirect("formulario.jsp");
                return;
            }
        %>

        <jsp:include page="../header/header.jsp" />

        <div class="login-container">

            <% if (isLoggedIn) {%>
            <div class="user-info">
                <h2>Tu Cuenta</h2>
                <!-- <p>Correo Electrónico: </p> -->
                <form action="formulario.jsp" method="post">
                    <input type="hidden" name="cerrar_sesion" value="true">
                    <button type="submit">Cerrar Sesión</button>
                    
                    <%
                        if (request.getParameter("cerrar_sesion") != null && request.getParameter("cerrar_sesion").equals("true")) {
                            session.setAttribute("isLoggedIn", false);
                        }
                    %>
                </form>
            </div>
            <% } else { %>

                <% if (activeForm.equals("register")) { %>
                <!-- Formulario de registro -->
                <h2>Registrate</h2>
                <form action="formulario.jsp" method="post" class="login-form">
                    <label for="correo">Correo Electrónico:</label>
                    <input type="email" id="correo" name="correo" required>
                    <label for="contraseña">Contraseña:</label>
                    <input type="password" id="contraseña" name="contraseña" required>
                    <button type="submit" name="registrarse">Registrarse</button>
                    <p>¿Ya tienes una cuenta? <a href="?form=login">Iniciar Sesión</a></p>
                </form>
                <% } else { %>
                <!-- Formulario de inicio de sesión -->
                <h2>Inicia Sesión</h2>
                <form action="formulario.jsp" method="post" class="login-form">
                    <label for="correo">Correo Electrónico:</label>
                    <input type="email" id="correo" name="correo" required>
                    <label for="contraseña">Contraseña:</label>
                    <input type="password" id="contraseña" name="contraseña" required>
                    <button type="submit" name="ingresar">Iniciar Sesión</button>
                    <p>¿No tenes una cuenta? <a href="?form=register">Registrate</a></p>
                </form>
                <% } %>

            <% } %>
        </div>



        <%  /* --------- CHECKEA que el usuario esté registrado ------------- */
            if (request.getParameter("ingresar") != null) {
                String correo = request.getParameter("correo");
                String contraseña = request.getParameter("contraseña");

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                    st = con.createStatement();

                    // Verificar si el correo está registrado
                    rs = st.executeQuery("SELECT COUNT(*) FROM usuarios WHERE correo = '" + correo + "'");
                    rs.next();
                    int count = rs.getInt(1);

                    if (count == 0) {
                    // El usuario no está registrado, muestra un mensaje de error
        %>
        <div class="error-message">
            <p>El correo electrónico ingresado no está registrado. Por favor, registrate antes de iniciar sesión.</p>
        </div>
        <%
        } else {
            // El usuario está registrado e inició sesión correctamente
        %>
        <div class="error-message">
            <p>Inicio de sesión exitoso.</p>
        </div>
        <%
                        session.setAttribute("userLoggedIn", true);
                        response.sendRedirect("../index.jsp");
                    }
                } catch (Exception e) {
                    out.print(e);
                }
            }

            /* ----------------- Registro ---------------- */
            if (request.getParameter("registrarse") != null) {
                String correo = request.getParameter("correo");
                String contraseña = request.getParameter("contraseña");

                try {
                    con = null;
                    st = null;

                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                    st = con.createStatement();

                    // Verificar si el correo ya está registrado
                    rs = st.executeQuery("SELECT COUNT(*) FROM usuarios WHERE correo = '" + correo + "'");
                    rs.next();
                    int count = rs.getInt(1);

                    if (count == 0) {
                        // El correo no está registrado, realizar el registro
                        st.executeUpdate("INSERT INTO usuarios (correo, contraseña) VALUES ('" + correo + "', '" + contraseña + "')");
                        // Puedes mostrar un mensaje de éxito aquí si lo deseas
        %>
        <div class="error-message">
            <p>El usuario se registró con éxito.</p>
        </div>

        <%
        } else {
            // El correo ya está registrado, muestra un mensaje de error
        %>
        <div class="error-message">
            <p>El correo electrónico ya está registrado. Por favor, inicia sesión.</p>
        </div>
        <%
                    }
                } catch (Exception e) {
                    out.print(e);
                }
            }

            // ------------------- ... (Código de cierre de sesión)
            // ------------------- session.setAttribute("userLoggedIn", false);
        %>




        <div class="lista-usuarios">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Correo</th>
                        <th scope="col">Contraseña</th>
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% /* LEE los registros desde la base de datos  */
                        try {

                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                            st = con.createStatement();
                            rs = st.executeQuery("SELECT * FROM `usuarios`;");

                            while (rs.next()) {
                    %>

                    <tr>
                        <th scope="row"><%= rs.getString(1)%></th>
                        <td><%= rs.getString(2)%></td>
                        <td><%= rs.getString(3)%></td>
                        <td>
                            <form action="formulario.jsp" method="post">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id_edit" value="<%= rs.getInt(1)%>">
                                <button type="submit" name="editar_<%= rs.getInt(1)%>">Editar</button>
                            </form>
                        </td>
                        <td>
                            <form action="formulario.jsp" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id_delete" value="<%= rs.getInt(1)%>">
                                <button type="submit" name="eliminar_<%= rs.getInt(1)%>">Eliminar</button>
                            </form>
                        </td>
                    </tr>

                    <%
                            }

                        } catch (Exception e) {
                            out.print("ERROR en mysql " + e);
                        }
                    %>


                </tbody>
            </table>

            <% /* ------------ EDITAR y ELIMINAR registros de la base de datos ---------------------------- */
                String action = request.getParameter("action");
                if (action != null) {
                    if (action.equals("edit")) {
                        int idEdit = Integer.parseInt(request.getParameter("id_edit"));
                        // Aquí puedes definir cómo deseas mostrar el formulario de edición
                        // Puedes usar un formulario emergente (modal) o incrustar el formulario en la página actual
            %>
            <div class="edit-form">
                <h3>Editar Usuario</h3>
                <form action="formulario.jsp" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id_update" value="<%= idEdit%>">
                    <label for="correo_edit">Correo Electrónico:</label>
                    <input type="email" id="correo_edit" name="correo_edit" required>
                    <label for="contraseña_edit">Contraseña:</label>
                    <input type="password" id="contraseña_edit" name="contraseña_edit" required>
                    <button type="submit" name="actualizar">Actualizar</button>
                </form>
            </div>
            <%
                    } else if (action.equals("delete")) {
                        int idDelete = Integer.parseInt(request.getParameter("id_delete"));
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                            st = con.createStatement();
                            st.executeUpdate("DELETE FROM usuarios WHERE id = " + idDelete);
                        } catch (Exception e) {
                            out.print("ERROR en mysql " + e);
                        }
                        // Redirige a la página después de la eliminación
                        response.sendRedirect("formulario.jsp");
                    } else if (action.equals("update")) {
                        int idUpdate = Integer.parseInt(request.getParameter("id_update"));
                        String nuevoCorreo = request.getParameter("correo_edit");
                        String nuevaContraseña = request.getParameter("contraseña_edit");
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                            st = con.createStatement();
                            st.executeUpdate("UPDATE usuarios SET correo = '" + nuevoCorreo + "', contraseña = '" + nuevaContraseña + "' WHERE id = " + idUpdate);
                        } catch (Exception e) {
                            out.print("ERROR en mysql " + e);
                        }
                        // Redirige a la página después de la actualización
                        response.sendRedirect("formulario.jsp");
                    }
                }
            %>



        </div>



        <footer class="footer">
            <div class="footer-content">
                <div class="footer-links">
                    <div class="column">
                        <img src="../.imagenes/svg/icono.svg" alt="Icono del Footer">
                    </div>
                    <div class="column">
                        <h3>Enlaces Útiles</h3>
                        <ul>
                            <li><a href="#">Inicio</a></li>
                            <li><a href="#">Servicios</a></li>
                            <li><a href="#">Productos</a></li>
                            <li><a href="#">Ingresar</a></li>
                        </ul>
                    </div>
                    <div class="column">
                        <h3>Otros enlaces</h3>
                        <ul>
                            <li><a href="#">Términos de Uso</a></li>
                            <li><a href="#">Polí­tica de Privacidad</a></li>
                            <li><a href="#">Aviso Legal</a></li>
                            <li><a href="#">+54 9 11 1234-5678</a></li>
                        </ul>
                    </div>
                </div>
                <p class="rights">© 2023 Todos los derechos reservados.</p>
            </div>
        </footer>




    </body>
</html>

