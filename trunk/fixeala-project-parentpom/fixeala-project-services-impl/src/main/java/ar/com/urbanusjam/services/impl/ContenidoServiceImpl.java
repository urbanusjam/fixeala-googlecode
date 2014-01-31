package ar.com.urbanusjam.services.impl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;
import ar.com.urbanusjam.services.exceptions.BusinessException;
import ar.com.urbanusjam.services.utils.FileUploadUtils;

@Service("contenidoService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor=Exception.class)
public class ContenidoServiceImpl implements ContenidoService {
	
    private static final String DATE_FORMAT_NOW = "yyyyMMddHHmmssSSS";
 	private static final int BUFFER_SIZE = 6124; 
    private static final String EXTENSION_BANNER = ".data";	 
    private static final long MAX_SIZE = 1024*256;  
    private final int LONGITUD_MAXIMA_NOMBRE_ARCHIVO_HASH = 16;


    @Value("${path.imagenes}") 
    private String pathImagenes;
    
    @Autowired
    private ContenidoDAO contenidoDAO;
    
    @Autowired
    private IssueDAO issueDAO;
    
    
	@Override
	public ContenidoDTO obtenerAvatarUsuario(String username)
			throws BusinessException {
		return null;
	}

	
	@Override	
	public ContenidoDTO subirContenido(ContenidoDTO fileWrapper) throws BusinessException {
			
		InputStream inputStream = fileWrapper.getInputStream();
		
		if(inputStream == null)		
			throw new BusinessException("archivo no encontrado");	
			
		//file is CREATED and saved in external folder
		fileWrapper = this.uploadFile2(inputStream, fileWrapper);
		
		//file reference is PERSISTED in database
		this.grabarContenido(fileWrapper);
				
		return fileWrapper;
	}
	
	
	@Override
	public List<ContenidoDTO> listarContenidos(Long idIssue) throws BusinessException {
		List<Contenido> contenidos = contenidoDAO.findContenidosByIssue(idIssue);
		List<ContenidoDTO> contenidosDTO = new ArrayList<ContenidoDTO>();
		
		for(Contenido contenido : contenidos){
			ContenidoDTO contenidoDTO = convertirAContenidoDTO(contenido);
			File file = this.abrirContenidoFile(contenidoDTO);
			contenidoDTO.setFile(file);
			contenidosDTO.add(contenidoDTO);			
		}
		
		return contenidosDTO;
	}	
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor=Exception.class)
	public void borrarContenido(ContenidoDTO contenido) throws BusinessException {				
		contenidoDAO.delete(convertirAContenido(contenido));
		this.deleteFile(this.pathImagenes + contenido.getNombreConExtension()); 	
	}	
	
	@Override
	 public ContenidoDTO convertirAContenidoDTO(Contenido contenido) {        
       ContenidoDTO contenidoDTO = new ContenidoDTO();
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
   public Contenido convertirAContenido(ContenidoDTO contenidoDTO) {        
       Contenido contenido = new Contenido();
       contenido.setId(contenidoDTO.getId());
       contenido.setPathRelativo(contenidoDTO.getPathRelativo());
       contenido.setAlto(contenidoDTO.getAlto());
       contenido.setAncho(contenidoDTO.getAncho());
       contenido.setNombre(contenidoDTO.getNombre());
       contenido.setTipo(contenidoDTO.getExtension());
       contenido.setNombreConExtension(contenidoDTO.getNombreConExtension());
       contenido.setOrden(Integer.valueOf(contenidoDTO.getOrden()));
       contenido.setProfilePic(contenidoDTO.isProfilePic());
       
       Issue issue = new Issue();
	   issue.setId(contenidoDTO.getNroReclamo() == null ? null : Long.valueOf(contenidoDTO.getNroReclamo()));		
       contenido.setIssue(issue);
       
       return contenido;
   }   
     
   @Override
   public FileWrapperDTO uploadFile(InputStream inputStream, String extensionArchivo) {		
		
		FileWrapperDTO fileWrapper = new FileWrapperDTO();
		
		if(inputStream == null)		
			throw new BusinessException("archivo no encontrado");			
	    
       /** Archivo random a generar **/
       String nombreArchivoHash = UUID.randomUUID().toString();
      
       File file = new File( this.pathImagenes + "IMG-" + this.generateTimestamp() + "-FXL-" +  nombreArchivoHash + "." + extensionArchivo.toLowerCase());
       
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
           
           fileWrapper.setFile(file);
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
   
   @Override
   public ContenidoDTO uploadFile2(InputStream inputStream, ContenidoDTO fileWrapper) {		
		
		if(inputStream == null)		
			throw new BusinessException("archivo no encontrado");			
	    
       /** Archivo random a generar **/
       String nombreArchivoHash = UUID.randomUUID().toString();
       
       int inicioCadena = nombreArchivoHash.length() - LONGITUD_MAXIMA_NOMBRE_ARCHIVO_HASH;
      
       File file = new File( this.pathImagenes + "IMG-" + this.generateTimestamp() + "-FXL-" +  nombreArchivoHash.substring(inicioCadena) + "." + fileWrapper.getExtension().toLowerCase());
       
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
   
   private void grabarContenido(ContenidoDTO contenidoDTO) {	
       try {
       	 	Contenido contenido = convertirAContenido(contenidoDTO);     
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
   
   
   
   private String generateTimestamp(){
   	  Calendar cal = Calendar.getInstance();
         SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);         
         String timestamp = StringUtils.EMPTY;
         timestamp = sdf.format(cal.getTime());  
         return timestamp;
   }
	

   /**************************************/
   
   @Override
   public ContenidoDTO obtenerContenido(String idContenido, String idIssue) throws BusinessException {

	    Contenido contenido = contenidoDAO.findContenidoByContenidoAndIssue(Long.valueOf(idContenido), Long.valueOf(idIssue));
        if ( contenido == null ){		
        	throw new BusinessException("archivo no encontrado");	
		}        
        ContenidoDTO contenidoDTO = convertirAContenidoDTO(contenido);         
        return contenidoDTO;
   }
	
   @Override
   public File abrirContenidoFile(ContenidoDTO contenidoDTO) throws BusinessException {
	   
	    File file = null;
	    
	 	if ( contenidoDTO == null )		
	 		throw new BusinessException("archivo no encontrado");	
        
        /** Existe el contenido, lo busco en la ruta de contenidos reales **/
        if ( contenidoDTO.getId() > 0 )
        	file = new File(this.pathImagenes + contenidoDTO.getNombreConExtension());
        
        return file;
      
   }
	
   private InputStream abrirContenidoRaw(ContenidoDTO contenidoDTO) throws BusinessException {
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

	
   private void grabarImagenDisco(Contenido contenido) throws BusinessException {
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
		List<Contenido> contenidos = contenidoDAO.findContenidosByIssue(Long.valueOf(issueID));		
		int cantidadContenidos = contenidos.size();
		return cantidadContenidos;		
	}

}