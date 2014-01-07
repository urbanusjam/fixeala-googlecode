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

@Service("contenidoService")
public class ContenidoServiceImpl implements ContenidoService {
	
    private static final String DATE_FORMAT_NOW = "yyyyMMddHHmmss";
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
    

//	public void setContenidoDAO(ContenidoDAO contenidoDAO) {
//		this.contenidoDAO = contenidoDAO;
//	}
//	
//	public void setIssueDAO(IssueDAO issueDAO) {
//		this.issueDAO = issueDAO;
//	}
//
//	public void setPathImagenes(String pathImagenes) {
//		this.pathImagenes = pathImagenes;
//	}

	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor=Exception.class)
	public FileWrapperDTO subirContenido(ContenidoDTO contenido)
			throws BusinessException {
		
		FileWrapperDTO fileWrapper = new FileWrapperDTO();
		InputStream inputStream = contenido.getInputStream();
		
		if(inputStream == null)		
			throw new BusinessException("archivo no encontrado");	
			
		//file is created and saved in temp folder
		fileWrapper = this.uploadFile(inputStream, contenido.getExtension());
		 
		File file = fileWrapper.getFile();		
		contenido.setAlto(fileWrapper.getAlto());
		contenido.setAncho(fileWrapper.getAncho());				
		contenido.setNombre(this.getNombreArchivoSinExtension(file.getName()));
		contenido.setNombreConExtension(file.getName());
		contenido.setPathRelativo("/" + file.getName());
		
		//file reference is persisted in database
		this.grabarContenido(contenido);
				
		return fileWrapper;
	}
	    
	
	@Override
	public FileWrapperDTO uploadFile(InputStream inputStream, String extensionArchivo) throws BusinessException {		
		
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
        catch (BusinessException e) {
        	//completar
        } 
        catch (IOException e) {
        	//completar
        }
        return fileWrapper;
	}
	
	@Override
	public File abrirContenidoFile(ContenidoDTO contenidoDTO) throws BusinessException {
	 	if ( contenidoDTO == null )		
	 		throw new BusinessException("archivo no encontrado");	
        
        /** Existe el contenido, lo busco en la ruta de contenidos reales **/
        if ( contenidoDTO.getId() > 0 )
            return new File(this.pathImagenes + contenidoDTO.getNombreConExtension());
        
        /** No existe todavia, lo busco en los banners temporales **/
        else
            return new File(this.pathImagenes + getNombreArchivoSinExtension(contenidoDTO.getNombreConExtension()) + EXTENSION_BANNER);
	}

	@Override
	public InputStream abrirContenidoRaw(ContenidoDTO contenidoDTO) throws BusinessException {
		try {
	            if ( contenidoDTO == null )
	            	throw new BusinessException("archivo no encontrado");	
	            
	            /** Existe el contenido, lo busco en la ruta de contenidos reales **/
	            if ( contenidoDTO.getId() > 0 )
					
					return new FileInputStream(this.pathImagenes + contenidoDTO.getId() + EXTENSION_BANNER);
					
				else
	                return new FileInputStream(this.pathImagenes + getNombreArchivoSinExtension(contenidoDTO.getNombreConExtension()) + EXTENSION_BANNER);
		} catch (BusinessException e) {
			throw new BusinessException("archivo no encontrado");	
		} catch (FileNotFoundException e) {
			throw new BusinessException("archivo no encontrado");	
		}
		
	}

	
	//@Override
	private void grabarContenido(ContenidoDTO contenidoDTO) {	
        try {
        	 Contenido contenido = convertirAContenido(contenidoDTO);     
             contenidoDAO.save(contenido);
             contenidoDTO.setId(contenido.getId());   
		} catch (BusinessException e) {		
			e.printStackTrace();
		}        
	}
	

	@Override
	public ContenidoDTO obtenerContenido(Long idContenido) throws BusinessException {

	    Contenido contenido = contenidoDAO.findContenidoById(idContenido);
        if ( contenido == null ){		
        	throw new BusinessException("archivo no encontrado");	
		}        
        ContenidoDTO contenidoDTO = convertirAContenidoDTO(contenido);         
        return contenidoDTO;
	}
	
	@Override
	public List<ContenidoDTO> listarContenido(Long idIssue) throws BusinessException {
		List<Contenido> contenidos = contenidoDAO.findContenidosByIssue(idIssue);
		List<ContenidoDTO> contenidosDTO = new ArrayList<ContenidoDTO>();
		
		for(Contenido contenido : contenidos){
			ContenidoDTO contenidoDTO = convertirAContenidoDTO(contenido);
			contenidosDTO.add(contenidoDTO);
		}
		
		return contenidosDTO;
	}
	
	
	 private String getNombreArchivoSinExtension(String nombreArchivo) {
        String nombreArchivoSinExtension = "";        
        if (nombreArchivo.lastIndexOf(".") == -1){
            nombreArchivoSinExtension = nombreArchivo;
        } else {
            nombreArchivoSinExtension = nombreArchivo.substring(0, nombreArchivo.lastIndexOf("."));
        } 
        return nombreArchivoSinExtension;
	 }
	 
	 
	 private void grabarImagenDisco(Contenido contenido) throws BusinessException {
        try {
            /** Copio el archivo del temporal al directorio de las imagenes **/
            FileUtils.copyFile(new File(this.pathImagenes
                    + contenido.getNombreFileSystem()), new File(
                    this.pathImagenes + contenido.getId() + EXTENSION_BANNER));
        } catch (IOException e) {
        	throw new BusinessException("archivo no encontrado");	
        }
	 }
	 
	 
	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor=Exception.class)
	public void borrarContenido(ContenidoDTO contenido) throws BusinessException {		
		
		contenidoDAO.delete(convertirAContenido(contenido));
		deleteFile(this.pathImagenes + contenido.getNombreConExtension()); 
	
	}
	
	public boolean deleteFile(String filePath) throws BusinessException {
		boolean isDeleted = false;
		try {			
				File file = new File(filePath);
				if(file.delete()){
					isDeleted = true;
//	    			System.out.println(file.getName() + " is deleted!");    		
	    		}else{
	    			throw new BusinessException("archivo no encontrado");	
	    		}
			
		} catch (Exception  e) {
			throw new BusinessException("archivo no encontrado");	
		}
		return isDeleted;		
	}

	@Override
	public int deleteMultipleFiles(String[] paths) throws BusinessException {
		
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
	 public ContenidoDTO convertirAContenidoDTO(Contenido contenido) {        
        ContenidoDTO contenidoDTO = new ContenidoDTO();
        contenidoDTO.setId(contenido.getId());
        contenidoDTO.setPathRelativo(contenido.getPathRelativo());
        contenidoDTO.setAlto(contenido.getAlto());
        contenidoDTO.setAncho(contenido.getAncho());    
        contenidoDTO.setNombre(contenido.getNombre());
        contenidoDTO.setExtension(contenido.getTipo());
        contenidoDTO.setNombreConExtension(contenido.getNombreFileSystem());      
        contenidoDTO.setNroReclamo(String.valueOf(contenido.getIssue().getId()));
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
        contenido.setNombreFileSystem(contenidoDTO.getNombreConExtension());
        
        Issue issue = new Issue();
		issue.setId(Long.valueOf(contenidoDTO.getNroReclamo()));		
        contenido.setIssue(issue);
        
        return contenido;
    }
    
    private String generateTimestamp(){
    	  Calendar cal = Calendar.getInstance();
          SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);         
          String timestamp = StringUtils.EMPTY;
          timestamp = sdf.format(cal.getTime());  
          return timestamp;
    }

    private String getExtensionArchivo(String nombreArchivo) {
		return nombreArchivo.substring(nombreArchivo.lastIndexOf(".") + 1, nombreArchivo.length());
	}
	


}
