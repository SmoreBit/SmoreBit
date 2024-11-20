package modelo;

import java.io.Serializable;

public class Sesion implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idSe; // Corresponde a la columna `id_se`
    private String usuario; // Corresponde a la columna `usuario`
    private String contraseña; // Corresponde a la columna `contraseña`
    private int tipo; // Corresponde a la columna `tipo`
    private int idUs; // Corresponde a la columna `id_us` (clave foránea)

    // Constructor por defecto
    public Sesion() {
    }

    // Constructor con parámetros
    public Sesion(int idSe, String usuario, String contraseña, int tipo, int idUs) {
        this.idSe = idSe;
        this.usuario = usuario;
        this.contraseña = contraseña;
        this.tipo = tipo;
        this.idUs = idUs;
    }

    // Getters
    public int getIdSe() {
        return idSe;
    }

    public String getUsuario() {
        return usuario;
    }

    public String getContraseña() {
        return contraseña;
    }

    public int getTipo() {
        return tipo;
    }

    public int getIdUs() {
        return idUs;
    }

    // Setters
    public void setIdSe(int idSe) {
        this.idSe = idSe;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public void setIdUs(int idUs) {
        this.idUs = idUs;
    }
}
