function toggleInfo(element) {
    const info = element.querySelector('.team-info');
    info.classList.toggle('expanded');
};

document.addEventListener('DOMContentLoaded', function() {
    const links = document.querySelectorAll('nav a');

    links.forEach(link => {
        link.addEventListener('click', function(event) {
            event.preventDefault();
            const targetUrl = this.href;

            document.body.classList.add('fade-out');

            setTimeout(() => {
                window.location.href = targetUrl;
            }, 500); // Tiempo de la animación en milisegundos
        });
    });
});
