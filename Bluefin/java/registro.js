function validateForm() {
    const nombre = document.querySelector("input[name='nombre']").value.trim();
    const apellido = document.querySelector("input[name='apellido']").value.trim();
    const edad = document.querySelector("input[name='edad']").value;
    const correo = document.querySelector("input[name='correo']").value.trim();
    const usuario = document.querySelector("input[name='usuario']").value.trim();
    const password = document.querySelector("input[name='contraseña']").value;
    const confirmPassword = document.querySelector("input[name='confirmar_contraseña']").value;

    // Validación de nombre y apellido
    const nameRegex = /^[A-Za-z\s]+$/;
    if (!nameRegex.test(nombre) || !nameRegex.test(apellido)) {
        alert("El nombre y apellido solo deben contener letras y espacios.");
        return false;
    }

    // Validación de edad (entre 6 y 120 años)
    if (isNaN(edad) || edad < 6 || edad > 120) {
        alert("La edad debe estar entre 6 y 120 años.");
        return false;
    }

    // Validación del correo electrónico con extensiones específicas
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|org|net|edu|gov|mil|info)$/;
    if (!emailRegex.test(correo)) {
        alert("Ingrese un correo electrónico válido que termine en .com, .org, .net, .edu, .gov, .mil o .info.");
        return false;
    }

    // Validación de un solo punto en el dominio del correo
    const domainPart = correo.split('@')[1];
    if ((domainPart.match(/\./g) || []).length > 1) {
        alert("Ingrese un correo electrónico con un solo dominio (por ejemplo, usuario@dominio.com).");
        return false;
    }

    // Validación de nombre de usuario (entre 3 y 15 caracteres, solo alfanumérico)
    const usernameRegex = /^[a-zA-Z0-9]+$/;
    if (usuario.length < 3 || usuario.length > 15 || !usernameRegex.test(usuario)) {
        alert("El nombre de usuario debe tener entre 3 y 15 caracteres y solo contener letras y números.");
        return false;
    }

    // Confirmación de contraseña
    if (password !== confirmPassword) {
        alert("Las contraseñas no coinciden.");
        return false;
    }

    return true;
}

function selectIcon(iconId, event) {
    event.stopPropagation();
    document.getElementById("icono").value = iconId;
    const iconSrc = document.querySelector(`.icon-option[data-id="${iconId}"] img`).src;
    document.querySelector(".icon-button").innerHTML = `<img src="${iconSrc}" alt="Ícono ${iconId}" width="24" height="24">`;
    toggleDropdown(false);
}

function toggleDropdown(show) {
    const dropdown = document.querySelector(".dropdown-content");
    dropdown.classList.toggle("show", show);
}

document.addEventListener("click", function(event) {
    const iconButton = document.querySelector(".icon-button");
    const dropdown = document.querySelector(".dropdown-content");

    if (iconButton.contains(event.target)) {
        toggleDropdown(!dropdown.classList.contains("show"));
    } else if (!dropdown.contains(event.target)) {
        toggleDropdown(false);
    }
});
