window.onscroll = function() {
    var navbar = document.querySelector('.blur-nav');
    if (window.pageYOffset > 0) {
        navbar.classList.add('visible');
    } else {
        navbar.classList.remove('visible');
    }
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
document.querySelectorAll('.card-container').forEach(card => {
    card.addEventListener('mouseover', () => {
        card.style.transform = 'rotateY(8deg) rotateX(4deg) scale(1.08)';
        card.style.boxShadow = '0px 15px 30px rgba(0, 0, 0, 0.3), 0 0 20px 8px rgba(74, 163, 255, 0.5)';
    });

    card.addEventListener('mouseout', () => {
        card.style.transform = 'rotateY(0deg) rotateX(0deg) scale(1)';
        card.style.boxShadow = '0px 4px 8px rgba(0, 0, 0, 0.2)';
    });
});