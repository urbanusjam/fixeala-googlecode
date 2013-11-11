package ar.com.urbanusjam.services;

import java.io.FileNotFoundException;
import java.io.InputStream;

import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;

public interface ContenidoService {
	
    public FileWrapperDTO subirContenido(InputStream inputStream, String extensionArchivo) throws FileNotFoundException;
 
    public void grabarContenido(ContenidoDTO contenido);
  
    public ContenidoDTO obtenerContenido (Long contenidoID) throws FileNotFoundException;
   
    public Contenido convertirAContenido(ContenidoDTO contenidoDTO);
    
    public ContenidoDTO convertirAContenidoDTO(Contenido contenido);

}
