package logica;

import java.io.Serializable;
import java.util.List;
import service.UsuarioService;
import modelo.Usuario;

public class UsuarioLogica  implements Serializable
{

    public UsuarioLogica() 
    {
    }
    
    public List<Usuario>getUsuarioList( )
    {
        return new UsuarioService( ).getUsuarioList( );
    }
     
}