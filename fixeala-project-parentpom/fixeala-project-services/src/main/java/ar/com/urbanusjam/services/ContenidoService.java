package ar.com.urbanusjam.services;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;

import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;

public interface ContenidoService {

	public FileWrapperDTO subirContenido(InputStream inputStream, String nombreArchivo) throws FileNotFoundException;
	
	 /**
     * Guarda los contenidos en algún directorio temporal, antes de persistirlos en la BD.
     * 
     * @param entidad, contenido     
     * @return 
     * @throws BusinessException
     */
    public File subirContenidoFile(InputStream inputStream, String extensionArchivo) throws FileNotFoundException;
    
    /**
     * Obtiene un puntero al archivo del banner
     * 
     * @param contenidoDTO
     * @return
     */
    public InputStream abrirContenidoRaw(ContenidoDTO contenidoDTO) throws Exception;
    
    /**
     * Obtiene un File al archivo del banner
     * 
     * @param contenidoDTO
     * @return
     */
	public File abrirContenidoFile(ContenidoDTO contenidoDTO) throws Exception;

    public void grabarContenido(String issueID, ContenidoDTO contenido);
  
    public ContenidoDTO obtenerContenido (Long contenidoID) throws FileNotFoundException;
   

}
