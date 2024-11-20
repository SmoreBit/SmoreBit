document.addEventListener('DOMContentLoaded', function () {
    // Definir los elementos de las imágenes del juego y de educación
    const gameImageElement = document.getElementById('gameImage');
    const educImageElement = document.getElementById('educImage');
    
    // Listas de imágenes para cada uno
    const gameImages = ['images/JUEGO.png', 'images/JUEGO2.png', 'images/JUEGO3.png'];
    const educImages = ['images/EDUCACION.png', 'images/EDUCACION2.png'];
    
    let currentGameIndex = 0;
    let currentEducIndex = 0;
    
    // Funciones para cambiar las imágenes
    function changeGameImage() {
        currentGameIndex = (currentGameIndex + 1) % gameImages.length;
        gameImageElement.src = gameImages[currentGameIndex];
    }

    function changeEducImage() {
        currentEducIndex = (currentEducIndex + 1) % educImages.length;
        educImageElement.src = educImages[currentEducIndex];
    }

    // Intervalos para cambiar las imágenes
    setInterval(changeGameImage, 800);
    setInterval(changeEducImage, 1600);

    /*-------------------- Vars --------------------*/
    let progress = 50;
    let startX = 0;
    let active = 0;
    let isDown = false;

    /*-------------------- Constantes --------------------*/
    const speedWheel = 0.02;
    const speedDrag = -0.1;

    /*-------------------- Función para obtener Z-Index --------------------*/
    const getZindex = (array, index) => array.map((_, i) => (index === i) ? array.length : array.length - Math.abs(index - i));

    /*-------------------- Selección de los elementos del carrusel --------------------*/
    const $items = document.querySelectorAll('.carousel-item');
    const $cursors = document.querySelectorAll('.cursor');

    // Función para mostrar los elementos
    const displayItems = (item, index, active) => {
        const zIndex = getZindex([...$items], active)[index];
        item.style.setProperty('--zIndex', zIndex);
        item.style.setProperty('--active', (index - active) / $items.length);
    }

    /*-------------------- Animación --------------------*/
    const animate = () => {
        progress = Math.max(0, Math.min(progress, 100));
        active = Math.floor(progress / 100 * ($items.length - 1));

        $items.forEach((item, index) => displayItems(item, index, active));
    }
    animate();

    /*-------------------- Click en los elementos del carrusel --------------------*/
    $items.forEach((item, i) => {
        item.addEventListener('click', () => {
            progress = (i / $items.length) * 100 + 10;
            animate();
        });
    });

    /*-------------------- Funciones de interacción con el mouse --------------------*/
    const handleWheel = e => {
        const wheelProgress = e.deltaY * speedWheel;
        progress = progress + wheelProgress;
        animate();
    }

    const handleMouseMove = (e) => {
        if (e.type === 'mousemove') {
            $cursors.forEach(($cursor) => {
                $cursor.style.transform = `translate(${e.clientX}px, ${e.clientY}px)`;
            });
        }
        if (!isDown) return;
        const x = e.clientX || (e.touches && e.touches[0].clientX) || 0;
        const mouseProgress = (x - startX) * speedDrag;
        progress = progress + mouseProgress;
        startX = x;
        animate();
    }

    const handleMouseDown = e => {
        isDown = true;
        startX = e.clientX || (e.touches && e.touches[0].clientX) || 0;
    }

    const handleMouseUp = () => {
        isDown = false;
    }

    /*-------------------- Agregar los eventos a los listeners --------------------*/
    document.addEventListener('mousewheel', handleWheel);
    document.addEventListener('mousedown', handleMouseDown);
    document.addEventListener('mousemove', handleMouseMove);
    document.addEventListener('mouseup', handleMouseUp);
    document.addEventListener('touchstart', handleMouseDown);
    document.addEventListener('touchmove', handleMouseMove);
    document.addEventListener('touchend', handleMouseUp);
});
