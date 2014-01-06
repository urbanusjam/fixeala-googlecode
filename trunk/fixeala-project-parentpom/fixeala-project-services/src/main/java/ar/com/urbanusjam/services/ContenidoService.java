package ar.com.urbanusjam.services;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.List;

import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;

public interface ContenidoService {
	   
    
    public void grabarContenido(ContenidoDTO contenido);
  
    public ContenidoDTO obtenerContenido(Long idContenido) throws FileNotFoundException;
    
    public List<ContenidoDTO> listarContenidos(Long idIssue);
    
    public void borrarContenido(List<ContenidoDTO> contenidos);
    
    
    public FileWrapperDTO upload(ContenidoDTO contenido) throws FileNotFoundException; 
    
    public FileWrapperDTO subirContenido(InputStream inputStream, String extensionArchivo) throws FileNotFoundException; 
    
    public File abrirContenidoFile(ContenidoDTO contenidoDTO) throws FileNotFoundException;
    
    public InputStream abrirContenidoRaw(ContenidoDTO contenidoDTO) throws FileNotFoundException;
    
    
   
    //quitar
    public Contenido convertirAContenido(ContenidoDTO contenidoDTO);
    
    public ContenidoDTO convertirAContenidoDTO(Contenido contenido);

}
