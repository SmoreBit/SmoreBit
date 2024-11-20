package modelo;

import java.io.Serializable;

public class Logros implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idLo; // Corresponde a la columna `id_lo`
    private String descripcion; // Corresponde a la columna `descripcion`
    private String titulo; // Corresponde a la columna `titulo`
    private int progreso; // Corresponde a la columna `progreso`
    private int idUs; // Corresponde a la columna `id_us` (clave foránea)

    // Constructor por defecto
    public Logros() {
    }

    // Constructor con parámetros
    public Logros(int idLo, String descripcion, String titulo, int progreso, int idUs) {
        this.idLo = idLo;
        this.descripcion = descripcion;
        this.titulo = titulo;
        this.progreso = progreso;
        this.idUs = idUs;
    }

    // Getters
    public int getIdLo() {
        return idLo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getTitulo() {
        return titulo;
    }

    public int getProgreso() {
        return progreso;
    }

    public int getIdUs() {
        return idUs;
    }

    // Setters
    public void setIdLo(int idLo) {
        this.idLo = idLo;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setProgreso(int progreso) {
        this.progreso = progreso;
    }

    public void setIdUs(int idUs) {
        this.idUs = idUs;
    }
}
