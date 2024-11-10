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

    function loadContent(section) {
        const contentDiv = document.getElementById('content');
        
        if (section === 'noticias') {
            contentDiv.innerHTML = `
                <h2>Noticias</h2>
                <p>Aquí se muestran las noticias relacionadas.</p>
            `;
        } else if (section === 'mapa') {
            contentDiv.innerHTML = `
                <h2>Mapa</h2>
                <p>Aquí se muestra el mapa interactivo.</p>
            `;
        } else if (section === 'articulos') {
            contentDiv.innerHTML = `
                <h2>Artículos</h2>
                <p>Aquí se muestran artículos destacados.</p>
            `;
        }
    }
    

    setInterval(changeEducImage, 1600);
});



