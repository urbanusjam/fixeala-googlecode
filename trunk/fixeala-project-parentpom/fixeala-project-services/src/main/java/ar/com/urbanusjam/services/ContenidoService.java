package ar.com.urbanusjam.services;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.services.dto.MediaContentDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;
import ar.com.urbanusjam.services.exceptions.BusinessException;

public interface ContenidoService {
	   
  
    public MediaContentDTO subirContenido(MediaContentDTO contenido) throws BusinessException; 
    
    public MediaContentDTO obtenerAvatarUsuario(String username) throws BusinessException; 
    
    public MediaContentDTO uploadFile(InputStream inputStream, MediaContentDTO fileWrapper) throws BusinessException;
    
    public List<MediaContentDTO> listarContenidos(Long idIssue) throws BusinessException;
       
    public void borrarContenido(MediaContentDTO contenido) throws BusinessException;       
    
    public MediaContent convertirAContenido(MediaContentDTO contenidoDTO);
    
    public MediaContentDTO convertirAContenidoDTO(MediaContent contenido);
        
    public File abrirContenidoFile(MediaContentDTO contenidoDTO) throws BusinessException;
    
    public int obtenerUltimoOrden(String issueID) throws BusinessException;
//    
//    public InputStream abrirContenidoRaw(ContenidoDTO contenidoDTO) throws BusinessException;
//    
    public MediaContentDTO obtenerContenido(String filename, String idIssue) throws BusinessException;
//        
//    public boolean deleteFile(String filePath) throws BusinessException; 
//    
//    public int deleteMultipleFiles(String[] filePath) throws BusinessException; 
        
}
