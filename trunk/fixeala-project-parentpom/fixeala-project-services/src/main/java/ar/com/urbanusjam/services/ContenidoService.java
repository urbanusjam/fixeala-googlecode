package ar.com.urbanusjam.services;

import java.io.InputStream;
import java.util.List;

import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;
import ar.com.urbanusjam.services.exceptions.BusinessException;

public interface ContenidoService {
	   
  
    public FileWrapperDTO subirContenido(ContenidoDTO contenido) throws BusinessException; 
    
    public FileWrapperDTO uploadFile(InputStream inputStream, String extensionArchivo) throws BusinessException; 
    
    public ContenidoDTO uploadFile2(InputStream inputStream, String extensionArchivo) throws BusinessException;
    
    public List<ContenidoDTO> listarContenido(Long idIssue) throws BusinessException;
       
    public void borrarContenido(ContenidoDTO contenido) throws BusinessException;       
    
    public Contenido convertirAContenido(ContenidoDTO contenidoDTO);
    
    public ContenidoDTO convertirAContenidoDTO(Contenido contenido);
    
//    
//    public File abrirContenidoFile(ContenidoDTO contenidoDTO) throws BusinessException;
//    
//    public InputStream abrirContenidoRaw(ContenidoDTO contenidoDTO) throws BusinessException;
//    
//    public ContenidoDTO obtenerContenido(Long idContenido) throws BusinessException;
//        
//    public boolean deleteFile(String filePath) throws BusinessException; 
//    
//    public int deleteMultipleFiles(String[] filePath) throws BusinessException; 
        
}
