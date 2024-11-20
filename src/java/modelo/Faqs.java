package modelo;

import java.io.Serializable;
import java.util.Date;

public class Faqs implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idFa; // Corresponde a la columna `id_fa`
    private String preguntas; // Corresponde a la columna `preguntas`
    private String respuestas; // Corresponde a la columna `respuestas`
    private Date fecha; // Corresponde a la columna `fecha`
    private int idUs; // Corresponde a la columna `id_us` (clave foránea)

    // Constructor por defecto
    public Faqs() {
    }

    // Constructor con parámetros
    public Faqs(int idFa, String preguntas, String respuestas, Date fecha, int idUs) {
        this.idFa = idFa;
        this.preguntas = preguntas;
        this.respuestas = respuestas;
        this.fecha = fecha;
        this.idUs = idUs;
    }

    // Getters
    public int getIdFa() {
        return idFa;
    }

    public String getPreguntas() {
        return preguntas;
    }

    public String getRespuestas() {
        return respuestas;
    }

    public Date getFecha() {
        return fecha;
    }

    public int getIdUs() {
        return idUs;
    }

    // Setters
    public void setIdFa(int idFa) {
        this.idFa = idFa;
    }

    public void setPreguntas(String preguntas) {
        this.preguntas = preguntas;
    }

    public void setRespuestas(String respuestas) {
        this.respuestas = respuestas;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public void setIdUs(int idUs) {
        this.idUs = idUs;
    }
}
