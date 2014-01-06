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
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;

public class ContenidoServiceImpl implements ContenidoService {
	
    private static final String DATE_FORMAT_NOW = "yyyyMMddHHmmss";
 	private static final int BUFFER_SIZE = 6124; 
    private static final String EXTENSION_BANNER = ".data";	 
    private static final long MAX_SIZE = 1024*256;  
    private final int LONGITUD_MAXIMA_NOMBRE_ARCHIVO_HASH = 16;

    private String pathImagenes;
    private ContenidoDAO contenidoDAO;
    private IssueDAO issueDAO;
    

	public void setContenidoDAO(ContenidoDAO contenidoDAO) {
		this.contenidoDAO = contenidoDAO;
	}
	
	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
	}

	public void setPathImagenes(String pathImagenes) {
		this.pathImagenes = pathImagenes;
	}

	
	
	private String getExtensionArchivo(String nombreArchivo) {
		return nombreArchivo.substring(nombreArchivo.lastIndexOf(".") + 1, nombreArchivo.length());
	}
	
	@Override
	@Transactional
	public FileWrapperDTO upload(ContenidoDTO contenido)
			throws FileNotFoundException {
		
		FileWrapperDTO fileWrapper = new FileWrapperDTO();
		InputStream inputStream = contenido.getInputStream();
		
		if(inputStream == null)		
			throw new FileNotFoundException();	
		
		fileWrapper = this.subirContenido(inputStream, contenido.getTipo());
		 
		File file = fileWrapper.getFile();		
		contenido.setAlto(fileWrapper.getAlto());
		contenido.setAncho(fileWrapper.getAncho());				
		contenido.setNombre(this.getNombreArchivoSinExtension(file.getName()));
		contenido.setNombreFileSystem(file.getName());
		contenido.setPathRelativo("/" + file.getName());
		
		this.grabarContenido(contenido);
		
		return fileWrapper;
	}
	    
	
	@Override
	public FileWrapperDTO subirContenido(InputStream inputStream,
			String extensionArchivo) throws FileNotFoundException {		
		
		FileWrapperDTO fileWrapper = new FileWrapperDTO();
		
		if(inputStream == null)		
			throw new FileNotFoundException();			
	    
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
        	//completar
        } 
        catch (IOException e) {
        	//completar
        }
        return fileWrapper;
	}
	
	@Override
	public File abrirContenidoFile(ContenidoDTO contenidoDTO) throws FileNotFoundException {
	 	if ( contenidoDTO == null )		
			throw new FileNotFoundException();		
        
        /** Existe el contenido, lo busco en la ruta de contenidos reales **/
        if ( contenidoDTO.getId() > 0 )
            return new File(this.pathImagenes + contenidoDTO.getNombreFileSystem());
        
        /** No existe todavia, lo busco en los banners temporales **/
        else
            return new File(this.pathImagenes + getNombreArchivoSinExtension(contenidoDTO.getNombreFileSystem()) + EXTENSION_BANNER);
	}

	@Override
	public InputStream abrirContenidoRaw(ContenidoDTO contenidoDTO) throws FileNotFoundException {
		try {
	            if ( contenidoDTO == null )
	                throw new FileNotFoundException();
	            
	            /** Existe el contenido, lo busco en la ruta de contenidos reales **/
	            if ( contenidoDTO.getId() > 0 )
					
						return new FileInputStream(this.pathImagenes + contenidoDTO.getId() + EXTENSION_BANNER);
					
				else
	                return new FileInputStream(this.pathImagenes + getNombreArchivoSinExtension(contenidoDTO.getNombreFileSystem()) + EXTENSION_BANNER);
		} catch (FileNotFoundException e) {
			throw new FileNotFoundException();
		}
		
	}

	
	@Override
	public void grabarContenido(ContenidoDTO contenidoDTO) {	
        try {
        	 Contenido contenido = convertirAContenido(contenidoDTO);     
             contenidoDAO.save(contenido);
             contenidoDTO.setId(contenido.getId());   
			 this.grabarImagenDisco(contenido);
		} catch (FileNotFoundException e) {		
			e.printStackTrace();
		}        
	}
	

	@Override
	public ContenidoDTO obtenerContenido(Long idContenido) throws FileNotFoundException {

	    Contenido contenido = contenidoDAO.findContenidoById(idContenido);
        if ( contenido == null ){
		
				throw new FileNotFoundException();
			}        
        ContenidoDTO contenidoDTO = convertirAContenidoDTO(contenido);         
        return contenidoDTO;
	}
	
	@Override
	public List<ContenidoDTO> listarContenidos(Long idIssue) {
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
	 
	 
	 private void grabarImagenDisco(Contenido contenido) throws FileNotFoundException {
        try {
            /** Copio el archivo del temporal al directorio de las imagenes **/
            FileUtils.copyFile(new File(this.pathImagenes
                    + contenido.getNombreFileSystem()), new File(
                    this.pathImagenes + contenido.getId() + EXTENSION_BANNER));
        } catch (IOException e) {
            throw new FileNotFoundException();
        }
	 }
	 
	 
	@Override
    public ContenidoDTO convertirAContenidoDTO(Contenido contenido) {        
        ContenidoDTO contenidoDTO = new ContenidoDTO();
        contenidoDTO.setId(contenido.getId());
        contenidoDTO.setPathRelativo(contenido.getPathRelativo());
        contenidoDTO.setAlto(contenido.getAlto());
        contenidoDTO.setAncho(contenido.getAncho());
        contenidoDTO.setUrl(contenido.getUrl());    
        contenidoDTO.setNombre(contenido.getNombre());
        contenidoDTO.setTipo(contenido.getTipo());
        contenidoDTO.setNombreFileSystem(contenido.getNombreFileSystem());
        contenidoDTO.setNombreFileSystemExtension( (contenido.getNombreFileSystem() == null) ? 
        		"" : getExtensionArchivo(contenido.getNombreFileSystem()));
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
        contenido.setUrl(contenidoDTO.getUrl());
        contenido.setNombre(contenidoDTO.getNombre());
        contenido.setTipo(contenidoDTO.getTipo());
        contenido.setNombreFileSystem(contenidoDTO.getNombreFileSystem());
        
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

	@Override
	public void borrarContenido(List<ContenidoDTO> contenidos) {
		// TODO Auto-generated method stub
		
	}

	

	

	
	

}
