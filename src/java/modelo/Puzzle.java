package modelo;

import java.io.Serializable;

public class Puzzle implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idPu; // Corresponde a la columna `id_pu`
    private String nombre; // Corresponde a la columna `nombre`
    private String descripcion; // Corresponde a la columna `descripcion`
    private int estado; // Corresponde a la columna `estado`
    private int npiezas; // Corresponde a la columna `npiezas`
    private int idUs; // Corresponde a la columna `id_us` (clave foránea)

    // Constructor por defecto
    public Puzzle() {
    }

    // Constructor con parámetros
    public Puzzle(int idPu, String nombre, String descripcion, int estado, int npiezas, int idUs) {
        this.idPu = idPu;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.estado = estado;
        this.npiezas = npiezas;
        this.idUs = idUs;
    }

    // Getters
    public int getIdPu() {
        return idPu;
    }

    public String getNombre() {
        return nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public int getEstado() {
        return estado;
    }

    public int getNpiezas() {
        return npiezas;
    }

    public int getIdUs() {
        return idUs;
    }

    // Setters
    public void setIdPu(int idPu) {
        this.idPu = idPu;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public void setNpiezas(int npiezas) {
        this.npiezas = npiezas;
    }

    public void setIdUs(int idUs) {
        this.idUs = idUs;
    }
}
