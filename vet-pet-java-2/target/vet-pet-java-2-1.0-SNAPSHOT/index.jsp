<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/x-icon" href=".imagenes/icono/icono.ico">
    <!-- NO anda el ico -->
    <title>Home - VetPet</title>
</head>
<body>

    <jsp:include page="header/header.jsp" />
    
    <main>

        <section class="hero-section">
            <div class="texto">
                <span class="titulo">VetPet</span>
                <span class="desc">Tu <span class="subrayado">veterinaria online</span> de confianza.</span>
            </div>
            <div class="imagenes">
                <img src=".imagenes/perro2.png" alt="perro2">
            </div>
        </section>
        
        <section class="que-es-vetpet">
            <span class="titulo">Que es VetPet?</span>
            <div class="info">
                <p class="texto">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                <p class="texto">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
                <p class="texto">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
            </div>
        </section>

        <section class="preguntas-frecuentes">
            <span class="titulo">FAQ</span>
            <div class="container">
                <div class="faq">
                    <span class="pregunta">Lorem ipsum dolor?</span>
                    <span class="respuesta">Sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</span>
                </div>
                <div class="faq">
                    <span class="pregunta">Lorem ipsum dolor?</span>
                    <span class="respuesta">Sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</span>
                </div>
                <div class="faq">
                    <span class="pregunta">Lorem ipsum dolor?</span>
                    <span class="respuesta">Sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</span>
                </div>
            </div>
        </section>
        
    </main>



    <footer class="footer">
        <div class="footer-content">
            <div class="footer-links">
                <div class="column">
                    <img src=".imagenes/svg/icono.svg" alt="Icono del Footer">
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
                        <li><a href="#">Pol��tica de Privacidad</a></li>
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