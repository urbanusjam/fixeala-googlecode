package ar.com.urbanusjam.services.impl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.dto.MediaContentDTO;
import ar.com.urbanusjam.services.exceptions.BusinessException;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.FileUploadUtils;

@Service
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor=Exception.class)
public class ContenidoServiceImpl implements ContenidoService {
	 
 	private static final int BUFFER_SIZE = 6124; 
    private static final String EXTENSION_BANNER = ".data";	 
    private final int LONGITUD_MAXIMA_NOMBRE_ARCHIVO_HASH = 16;


    @Value("${path.imagenes}") 
    private String pathImagenes;
 
    private ContenidoDAO contenidoDAO;

    private IssueDAO issueDAO;
    
  

	public void setPathImagenes(String pathImagenes) {
		this.pathImagenes = pathImagenes;
	}


	public void setContenidoDAO(ContenidoDAO contenidoDAO) {
		this.contenidoDAO = contenidoDAO;
	}


	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
	}


	@Override
	public MediaContentDTO obtenerAvatarUsuario(String username)
			throws BusinessException {
		return null;
	}

	
	@Override	
	public MediaContentDTO subirContenido(MediaContentDTO fileWrapper) throws BusinessException {
			
		InputStream inputStream = fileWrapper.getInputStream();
		
		if(inputStream == null)		
			throw new BusinessException("archivo no encontrado");	
			
		//file is CREATED and saved in external folder
		fileWrapper = this.uploadFile(inputStream, fileWrapper);
		
		//file reference is PERSISTED in database
		this.grabarContenido(fileWrapper);
				
		return fileWrapper;
	}
	
	
	@Override
	public List<MediaContentDTO> listarContenidos(Long idIssue) throws BusinessException {
		List<MediaContent> contenidos = contenidoDAO.findContenidosByIssue(idIssue);
		List<MediaContentDTO> contenidosDTO = new ArrayList<MediaContentDTO>();
		
		for(MediaContent contenido : contenidos){
			MediaContentDTO contenidoDTO = convertirAContenidoDTO(contenido);
			File file = this.abrirContenidoFile(contenidoDTO);
			contenidoDTO.setFile(file);
			contenidosDTO.add(contenidoDTO);			
		}
		
		return contenidosDTO;
	}	
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor=Exception.class)
	public void borrarContenido(MediaContentDTO contenido) throws BusinessException {			
		contenidoDAO.deleteContenido(convertirAContenido(contenido));
//		contenidoDAO.delete(convertirAContenido(contenido));
		this.deleteFile(this.pathImagenes + contenido.getNombreConExtension());  // si no encuentra el archivo en la PC, lanza excepcion y no borra los registros de la BD.
	}	
	
	@Override
	 public MediaContentDTO convertirAContenidoDTO(MediaContent contenido) {        
       MediaContentDTO contenidoDTO = new MediaContentDTO();
       contenidoDTO.setId(contenido.getId());
       contenidoDTO.setPathRelativo(contenido.getPathRelativo());
       contenidoDTO.setAlto(contenido.getAlto());
       contenidoDTO.setAncho(contenido.getAncho());    
       contenidoDTO.setNombre(contenido.getNombre());
       contenidoDTO.setExtension(contenido.getTipo());
       contenidoDTO.setNombreConExtension(contenido.getNombreConExtension());      
       contenidoDTO.setNroReclamo(String.valueOf(contenido.getIssue().getId()));
       contenidoDTO.setOrden(String.valueOf(contenido.getOrden()));
       contenidoDTO.setProfilePic(contenido.isProfilePic());
       return contenidoDTO;
   }
      
   @Override
   public MediaContent convertirAContenido(MediaContentDTO contenidoDTO) {        
       MediaContent contenido = new MediaContent();
       contenido.setId(contenidoDTO.getId());
       contenido.setPathRelativo(contenidoDTO.getPathRelativo());
       contenido.setAlto(contenidoDTO.getAlto());
       contenido.setAncho(contenidoDTO.getAncho());
       contenido.setNombre(contenidoDTO.getNombre());
       contenido.setTipo(contenidoDTO.getExtension());
       contenido.setNombreConExtension(contenidoDTO.getNombreConExtension());
       contenido.setOrden(Integer.valueOf(contenidoDTO.getOrden()));
       contenido.setProfilePic(contenidoDTO.isProfilePic()); 
//       contenido.setFecha(getCurrentCalendar(new Date()));          
       return contenido;
   }   
     
   
   @Override
   public MediaContentDTO uploadFile(InputStream inputStream, MediaContentDTO fileWrapper) {		
		
		if(inputStream == null)		
			throw new BusinessException("archivo no encontrado");			
	    
       /** Archivo random a generar **/
       String nombreArchivoHash = UUID.randomUUID().toString();
       
       int inicioCadena = nombreArchivoHash.length() - LONGITUD_MAXIMA_NOMBRE_ARCHIVO_HASH;
      
       File file = new File( this.pathImagenes + "IMG-" + DateUtils.generateTimestamp() + "-FXL-" +  nombreArchivoHash.substring(inicioCadena) + "." + fileWrapper.getExtension().toLowerCase());
       
       try {
           FileOutputStream fileOutputStream;
           fileOutputStream = new FileOutputStream(file);
           byte[] buffer = new byte[BUFFER_SIZE];
           int bulk;
           while (true) {
               bulk = inputStream.read(buffer);
               if (bulk < 0) {
                   break;
               }
               fileOutputStream.write(buffer, 0, bulk);
               fileOutputStream.flush();
           }
           
           BufferedImage readImage = null;           
           readImage = ImageIO.read(file);   
           
           fileWrapper.setInputStream(inputStream);
           fileWrapper.setFile(file);
           fileWrapper.setNombre(FileUploadUtils.getNombreArchivoSinExtension(file.getName()));
           fileWrapper.setNombreConExtension(file.getName());
           fileWrapper.setExtension(FileUploadUtils.getExtensionArchivo(file.getName()));	
           fileWrapper.setPathRelativo("/" + file.getName());
           fileWrapper.setAlto(readImage.getHeight());
           fileWrapper.setAncho(readImage.getWidth());

           fileOutputStream.close();
           inputStream.close();
         
       }
       catch (FileNotFoundException e) {
    	   throw new BusinessException("archivo no encontrado");
       } 
       catch (IOException e) {
    	   throw new BusinessException("archivo no encontrado");       		
       }
     
       return fileWrapper;
   }   
   
   private void grabarContenido(MediaContentDTO contenidoDTO) {	
       try {
       	 	MediaContent contenido = convertirAContenido(contenidoDTO);      
       	 	contenido.setIssue(issueDAO.findIssueById(contenidoDTO.getNroReclamo()));
            contenidoDAO.save(contenido);
            contenidoDTO.setId(contenido.getId());   
		} catch (BusinessException e) {		
			e.printStackTrace();
		}        
   }	   
   
   private boolean deleteFile(String filePath) throws BusinessException {
		boolean isDeleted = false;
		try {			
				File file = new File(filePath);
				if(file.delete()){
					isDeleted = true;  		
	    		}else{
	    			throw new BusinessException("archivo no encontrado");	
	    		}
			
		} catch (Exception  e) {
			throw new BusinessException("archivo no encontrado");	
		}
		return isDeleted;		
   }	
   
   
	

   /**************************************/
   
   @Override
   public MediaContentDTO obtenerContenido(String idContenido, String idIssue) throws BusinessException {

	    MediaContent contenido = contenidoDAO.findContenidoByContenidoAndIssue(Long.valueOf(idContenido), Long.valueOf(idIssue));
        if ( contenido == null ){		
        	throw new BusinessException("archivo no encontrado");	
		}        
        MediaContentDTO contenidoDTO = convertirAContenidoDTO(contenido);         
        return contenidoDTO;
   }
	
   @Override
   public File abrirContenidoFile(MediaContentDTO contenidoDTO) throws BusinessException {
	   
	    File file = null;
	    
	 	if ( contenidoDTO == null )		
	 		throw new BusinessException("archivo no encontrado");	
        
        /** Existe el contenido, lo busco en la ruta de contenidos reales **/
        if ( contenidoDTO.getId() > 0 )
        	file = new File(this.pathImagenes + contenidoDTO.getNombreConExtension());
        
        return file;
      
   }
	
   private InputStream abrirContenidoRaw(MediaContentDTO contenidoDTO) throws BusinessException {
		try {
	            if ( contenidoDTO == null )
	            	throw new BusinessException("archivo no encontrado");	
	            
	            /** Existe el contenido, lo busco en la ruta de contenidos reales **/
	            if ( contenidoDTO.getId() > 0 )
					
					return new FileInputStream(this.pathImagenes + contenidoDTO.getId() + EXTENSION_BANNER);
					
				else
	                return new FileInputStream(this.pathImagenes + FileUploadUtils.getNombreArchivoSinExtension(contenidoDTO.getNombreConExtension()) + EXTENSION_BANNER);
		} catch (BusinessException e) {
			throw new BusinessException("archivo no encontrado");	
		} catch (FileNotFoundException e) {
			throw new BusinessException("archivo no encontrado");	
		}
		
   }

	
   private void grabarImagenDisco(MediaContent contenido) throws BusinessException {
        try {
            /** Copio el archivo del temporal al directorio de las imagenes **/
            FileUtils.copyFile(new File(this.pathImagenes
                    + contenido.getNombreConExtension()), new File(
                    this.pathImagenes + contenido.getId() + EXTENSION_BANNER));
        } catch (IOException e) {
        	throw new BusinessException("archivo no encontrado");	
        }
   }
	 

   private int deleteMultipleFiles(String[] paths) throws BusinessException {
		
		int deletedFilesCounter = 0;
		
		try {
			for(String path : paths){
				File file = new File(path);
				if(file.delete()){
	    			deletedFilesCounter++;
//	    			System.out.println(file.getName() + " is deleted!");    		
	    		}else{
	    			System.out.println("Delete operation is failed.");	    		
	    		}
			}
			
		} catch (Exception  e) {
		    System.err.format("%s: no such" + " file or directory%n");
		}
		
		return deletedFilesCounter++;
   }


	@Override
	public int obtenerUltimoOrden(String issueID)
			throws BusinessException {
		List<MediaContent> contenidos = contenidoDAO.findContenidosByIssue(Long.valueOf(issueID));		
		int cantidadContenidos = contenidos.size();
		return cantidadContenidos;		
	}
	
	private GregorianCalendar getCurrentCalendar(Date date){		
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		return (GregorianCalendar) calendar;	
	} 

}