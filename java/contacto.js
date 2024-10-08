window.onscroll = function() {
    var navbar = document.querySelector('.navbar');
    if (window.pageYOffset > 0) {
        navbar.classList.add('visible');
    } else {
        navbar.classList.remove('visible');
    }
}
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