window.onscroll = function() {
    var navbar = document.querySelector('.navbar');
    if (window.pageYOffset > 0) {
        navbar.classList.add('visible');
    } else {
        navbar.classList.remove('visible');
    }
};
// Mostrar la ventana modal al cargar la página
window.onload = function() {
    document.getElementById('warningModal').style.display = 'block';
};

// Función para cerrar la ventana modal
function closeModal() {
    document.getElementById('warningModal').style.display = 'none';
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
            }, 200); 
        });
    });
});
