document.addEventListener('DOMContentLoaded', function () {
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
        // Corregido: Usar currentEmpIndex en lugar de currentEducIndex
        currentEmpIndex = (currentEmpIndex + 1) % empImages.length;
        empImageElement.src = empImages[currentEmpIndex];
    }

    setInterval(changeEmpImage, 1600);
});
