package modelo;

import java.io.Serializable;
import java.util.Date;

public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idUs; // Corresponde a la columna `id_us`
    private String correo; // Corresponde a la columna `correo`
    private String genero; // Corresponde a la columna `genero`
    private int icono; // Corresponde a la columna `icono`
    private int edad; // Corresponde a la columna `edad`
    private String nombre; // Corresponde a la columna `nombre`
    private String apellido; // Corresponde a la columna `apellido`
    private Date fecha; // Corresponde a la columna `fecha`

    // Constructor por defecto
    public Usuario() {
    }

    // Constructor con parámetros
    public Usuario(int idUs, String correo, String genero, int icono, int edad, String nombre, String apellido, Date fecha) {
        this.idUs = idUs;
        this.correo = correo;
        this.genero = genero;
        this.icono = icono;
        this.edad = edad;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fecha = fecha;
    }

    // Getters
    public int getIdUs() {
        return idUs;
    }

    public String getCorreo() {
        return correo;
    }

    public String getGenero() {
        return genero;
    }

    public int getIcono() {
        return icono;
    }

    public int getEdad() {
        return edad;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public Date getFecha() {
        return fecha;
    }

    // Setters
    public void setIdUs(int idUs) {
        this.idUs = idUs;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public void setIcono(int icono) {
        this.icono = icono;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
}
