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
            boolean isLoggedIn = (session.getAttribute("userLoggedIn") != null && (boolean) session.getAttribute("userLoggedIn")); // Variable que guarda si se inici� sesi�n

            // Verificar si se envi� el formulario de cierre de sesi�n
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
                <!-- <p>Correo Electr�nico: </p> -->
                <form action="formulario.jsp" method="post">
                    <input type="hidden" name="cerrar_sesion" value="true">
                    <button type="submit">Cerrar Sesi�n</button>
                    
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
                    <label for="correo">Correo Electr�nico:</label>
                    <input type="email" id="correo" name="correo" required>
                    <label for="contrase�a">Contrase�a:</label>
                    <input type="password" id="contrase�a" name="contrase�a" required>
                    <button type="submit" name="registrarse">Registrarse</button>
                    <p>�Ya tienes una cuenta? <a href="?form=login">Iniciar Sesi�n</a></p>
                </form>
                <% } else { %>
                <!-- Formulario de inicio de sesi�n -->
                <h2>Inicia Sesi�n</h2>
                <form action="formulario.jsp" method="post" class="login-form">
                    <label for="correo">Correo Electr�nico:</label>
                    <input type="email" id="correo" name="correo" required>
                    <label for="contrase�a">Contrase�a:</label>
                    <input type="password" id="contrase�a" name="contrase�a" required>
                    <button type="submit" name="ingresar">Iniciar Sesi�n</button>
                    <p>�No tenes una cuenta? <a href="?form=register">Registrate</a></p>
                </form>
                <% } %>

            <% } %>
        </div>



        <%  /* --------- CHECKEA que el usuario est� registrado ------------- */
            if (request.getParameter("ingresar") != null) {
                String correo = request.getParameter("correo");
                String contrase�a = request.getParameter("contrase�a");

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                    st = con.createStatement();

                    // Verificar si el correo est� registrado
                    rs = st.executeQuery("SELECT COUNT(*) FROM usuarios WHERE correo = '" + correo + "'");
                    rs.next();
                    int count = rs.getInt(1);

                    if (count == 0) {
                    // El usuario no est� registrado, muestra un mensaje de error
        %>
        <div class="error-message">
            <p>El correo electr�nico ingresado no est� registrado. Por favor, registrate antes de iniciar sesi�n.</p>
        </div>
        <%
        } else {
            // El usuario est� registrado e inici� sesi�n correctamente
        %>
        <div class="error-message">
            <p>Inicio de sesi�n exitoso.</p>
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
                String contrase�a = request.getParameter("contrase�a");

                try {
                    con = null;
                    st = null;

                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                    st = con.createStatement();

                    // Verificar si el correo ya est� registrado
                    rs = st.executeQuery("SELECT COUNT(*) FROM usuarios WHERE correo = '" + correo + "'");
                    rs.next();
                    int count = rs.getInt(1);

                    if (count == 0) {
                        // El correo no est� registrado, realizar el registro
                        st.executeUpdate("INSERT INTO usuarios (correo, contrase�a) VALUES ('" + correo + "', '" + contrase�a + "')");
                        // Puedes mostrar un mensaje de �xito aqu� si lo deseas
        %>
        <div class="error-message">
            <p>El usuario se registr� con �xito.</p>
        </div>

        <%
        } else {
            // El correo ya est� registrado, muestra un mensaje de error
        %>
        <div class="error-message">
            <p>El correo electr�nico ya est� registrado. Por favor, inicia sesi�n.</p>
        </div>
        <%
                    }
                } catch (Exception e) {
                    out.print(e);
                }
            }

            // ------------------- ... (C�digo de cierre de sesi�n)
            // ------------------- session.setAttribute("userLoggedIn", false);
        %>




        <div class="lista-usuarios">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Correo</th>
                        <th scope="col">Contrase�a</th>
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
                        // Aqu� puedes definir c�mo deseas mostrar el formulario de edici�n
                        // Puedes usar un formulario emergente (modal) o incrustar el formulario en la p�gina actual
            %>
            <div class="edit-form">
                <h3>Editar Usuario</h3>
                <form action="formulario.jsp" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id_update" value="<%= idEdit%>">
                    <label for="correo_edit">Correo Electr�nico:</label>
                    <input type="email" id="correo_edit" name="correo_edit" required>
                    <label for="contrase�a_edit">Contrase�a:</label>
                    <input type="password" id="contrase�a_edit" name="contrase�a_edit" required>
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
                        // Redirige a la p�gina despu�s de la eliminaci�n
                        response.sendRedirect("formulario.jsp");
                    } else if (action.equals("update")) {
                        int idUpdate = Integer.parseInt(request.getParameter("id_update"));
                        String nuevoCorreo = request.getParameter("correo_edit");
                        String nuevaContrase�a = request.getParameter("contrase�a_edit");
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/usuarios?user=root&password=");
                            st = con.createStatement();
                            st.executeUpdate("UPDATE usuarios SET correo = '" + nuevoCorreo + "', contrase�a = '" + nuevaContrase�a + "' WHERE id = " + idUpdate);
                        } catch (Exception e) {
                            out.print("ERROR en mysql " + e);
                        }
                        // Redirige a la p�gina despu�s de la actualizaci�n
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
                        <h3>Enlaces �tiles</h3>
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
                            <li><a href="#">T�rminos de Uso</a></li>
                            <li><a href="#">Pol�tica de Privacidad</a></li>
                            <li><a href="#">Aviso Legal</a></li>
                            <li><a href="#">+54 9 11 1234-5678</a></li>
                        </ul>
                    </div>
                </div>
                <p class="rights">� 2023 Todos los derechos reservados.</p>
            </div>
        </footer>




    </body>
</html>

