package logica;

import java.io.Serializable;
import java.util.List;
import service.SesionService;
import modelo.Sesion;

public class SesionLogica  implements Serializable
{

    public SesionLogica() 
    {
    }
    
    public List<Sesion>getSesionList( )
    {
        return new SesionService( ).getSesionList( );
    }
     
}