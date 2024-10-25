document.addEventListener('DOMContentLoaded', function () {
    const waves = document.querySelector('.waves');
    waves.classList.add('waves-enter');
    
    waves.addEventListener('animationend', function () {
        waves.classList.remove('waves-enter');
    });
    
    document.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            const url = this.href;
            
            // Añadir la animación de salida a las olas
            waves.classList.add('waves-exit');
            document.body.style.transition = 'opacity 1.5s';
            document.body.style.opacity = 0;
            
            // Esperar a que la animación termine antes de cambiar la página
            setTimeout(() => {
                window.location.href = url;
            }, 1500);
        });
    });
});