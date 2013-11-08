package ar.com.urbanusjam.services.impl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import javax.imageio.ImageIO;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;

public class ContenidoServiceImpl implements ContenidoService {
	
 	private static final int BUFFER_SIZE = 6124; 
    private static final String EXTENSION_BANNER = ".data";	 
    private static final long MAX_SIZE = 1024*256;  
    private final int LONGITUD_MAXIMA_NOMBRE_ARCHIVO_HASH = 16;
    private String pathImagenesTemporales;
    private String pathImagenes;
    private ContenidoDAO contenidoDAO;
    private IssueDAO issueDAO;
    

	public void setContenidoDAO(ContenidoDAO contenidoDAO) {
		this.contenidoDAO = contenidoDAO;
	}
	
	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
	}

	public void setPathImagenesTemporales(String pathImagenesTemporales) {
		this.pathImagenesTemporales = pathImagenesTemporales;
	}

	public void setPathImagenes(String pathImagenes) {
		this.pathImagenes = pathImagenes;
	}

	
	@Override
	public FileWrapperDTO subirContenido(InputStream inputStream,
			String nombreArchivo) throws FileNotFoundException {
		
		FileWrapperDTO banner = new FileWrapperDTO();	        
        String extensionArchivo = this.getExtensionArchivo(nombreArchivo);        
        banner.setFile(this.subirContenidoFile(inputStream, extensionArchivo));
        
        if ( banner.getFile().length() > MAX_SIZE ){
            throw new FileNotFoundException();
        }
     
        banner.setTipoContenido(extensionArchivo);
      
        BufferedImage readImage = null;
        try {
            readImage = ImageIO.read(banner.getFile());
        } catch (Exception e) {
            throw new FileNotFoundException();
        }
        
        banner.setAlto(readImage.getHeight());
        banner.setAncho(readImage.getWidth());      

        return banner;
	}
	
	 private String getExtensionArchivo(String nombreArchivo) {
	        return nombreArchivo.substring(nombreArchivo.lastIndexOf(".") + 1, nombreArchivo.length());
	    }
	    
	
	@Override
	public File subirContenidoFile(InputStream inputStream,
			String extensionArchivo) throws FileNotFoundException {
	
		if(inputStream == null)
			throw new FileNotFoundException();
	    
        /** Archivo random a generar **/
        String nombreArchivoHash = UUID.randomUUID().toString();
        int inicioCadena = nombreArchivoHash.length() - LONGITUD_MAXIMA_NOMBRE_ARCHIVO_HASH;
        File file = new File( this.pathImagenesTemporales + nombreArchivoHash.substring(inicioCadena) + "." + extensionArchivo.toLowerCase());
        
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

            fileOutputStream.close();
            inputStream.close();
          
        }
        catch (FileNotFoundException e) {
        } 
        catch (IOException e) {
        }
        return file;
	}

	@Override
	public InputStream abrirContenidoRaw(ContenidoDTO contenidoDTO) throws Exception {
		 try {
	            if ( contenidoDTO == null )
	                throw new FileNotFoundException();
	            
	            /** Existe el contenido, lo busco en la ruta de contenidos reales **/
	            if ( contenidoDTO.getId() > 0 )
	                return new FileInputStream(this.pathImagenes + contenidoDTO.getId() + EXTENSION_BANNER);
	            /** No existe todavia, lo busco en los banners temporales **/
	            else
	                return new FileInputStream(this.pathImagenesTemporales 
	                		+ this.getNombreArchivoSinExtension(contenidoDTO.getNombreFileSystem()) + EXTENSION_BANNER);
	        } catch (FileNotFoundException e) {
	            throw new Exception("No se encontro el archivo: " + e.getMessage());
	        }
	}
	
	@Override
	public File abrirContenidoFile(ContenidoDTO contenidoDTO) throws Exception {
		  if ( contenidoDTO == null )
	            throw new FileNotFoundException();
	        
	        /** Existe el contenido, lo busco en la ruta de contenidos reales **/
	        if ( contenidoDTO.getId() > 0 )
	            return new File(this.pathImagenesTemporales + contenidoDTO.getNombreFileSystem());
	        /** No existe todavia, lo busco en los banners temporales **/
	        else
	            return new File(this.pathImagenesTemporales 
	            		+ this.getNombreArchivoSinExtension(contenidoDTO.getNombreFileSystem()) + EXTENSION_BANNER);
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
        if ( contenido == null )
            throw new FileNotFoundException();        
        ContenidoDTO contenidoDTO = convertirAContenidoDTO(contenido);         
        return contenidoDTO;
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
            FileUtils.copyFile(new File(this.pathImagenesTemporales
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
	

}
