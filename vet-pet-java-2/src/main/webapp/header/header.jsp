<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <!-- Otros enlaces de CSS, favicon, título, etc. -->
</head>
<body>
    <%
        boolean isLoggedIn = false;
    %>
    
    
    <header class="header">
            <div class="logo">
                <img src="<%= request.getContextPath() %>/.imagenes/svg/logo.svg" alt="Logo">
            </div>
            <div class="navbar">
                <ul>
                    <a href="<%= request.getContextPath() %>/index.jsp"><li>Inicio</li></a>
                    <a href="<%= request.getContextPath() %>/busqueda/busqueda.jsp"><li>Productos</li></a>
                    
                    <% if (isLoggedIn==false) { %>
                    <a href="<%= request.getContextPath() %>/formulario/formulario.jsp"> <!-- Enlace a la página de la cuenta del usuario -->
                        <li>Mi Cuenta</li>
                    </a>
                    <% } else { %>
                    <a href="<%= request.getContextPath() %>/formulario/formulario.jsp"><li>Ingresar</li></a>
                    <% } %>
                </ul>
            </div>
        </header>
</body>
</html>
