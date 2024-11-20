document.addEventListener('DOMContentLoaded', function () {
    // Cambios de imágenes para elementos del menú
    const gameImageElement = document.getElementById('gameImage');
    const gameImages = ['images/JUEGO.png', 'images/JUEGO2.png', 'images/JUEGO3.png'];
    let currentGameIndex = 0;

    function changeGameImage() {
        currentGameIndex = (currentGameIndex + 1) % gameImages.length;
        gameImageElement.src = gameImages[currentGameIndex];
    }

    setInterval(changeGameImage, 800);

    const educImageElement = document.getElementById('educImage');
    const educImages = ['images/EDUCACION.png', 'images/EDUCACION2.png'];
    let currentEducIndex = 0;

    function changeEducImage() {
        currentEducIndex = (currentEducIndex + 1) % educImages.length;
        educImageElement.src = educImages[currentEducIndex];
    }

    setInterval(changeEducImage, 1600);

    const empImageElement = document.getElementById('empImage');
    const empImages = ['images/EMPRESA.png', 'images/EMPRESA2.png'];
    let currentEmpIndex = 0;

    function changeEmpImage() {
        currentEmpIndex = (currentEmpIndex + 1) % empImages.length;
        empImageElement.src = empImages[currentEmpIndex];
    }

    setInterval(changeEmpImage, 1600);

    // JavaScript para el funcionamiento del carrusel de noticias
    let currentIndex = 0;
    const items = document.querySelectorAll('.iframe-item');
    const totalItems = items.length;

    // Asegurarse de que los botones existen antes de añadir los eventos
    const nextButton = document.querySelector('.carousel-button-next');
    const prevButton = document.querySelector('.carousel-button-prev');

    if (nextButton && prevButton) {
        nextButton.addEventListener('click', () => {
            currentIndex = (currentIndex + 1) % totalItems;
            updateCarousel();
        });

        prevButton.addEventListener('click', () => {
            currentIndex = (currentIndex - 1 + totalItems) % totalItems;
            updateCarousel();
        });
    }

    function updateCarousel() {
        const container = document.querySelector('.iframe-container');
        container.style.transform = `translateX(-${currentIndex * 100}%)`;
    }
});
