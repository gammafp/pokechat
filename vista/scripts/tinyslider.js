var carrusel = document.querySelectorAll('#carrusel .imagen');
var imagenActual = 0;
var imagenIntervalo = setInterval(siguienteImagen, 5000);

function siguienteImagen() {
    carrusel[imagenActual].className = 'imagen';
    imagenActual = (imagenActual + 1) % carrusel.length;
    carrusel[imagenActual].className = 'imagen muestra';
}
