package ar.com.urbanusjam.test.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.dto.MediaContentDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:test-context.xml"}) 
public class ContenidoServiceTest {

	@Autowired
	private ContenidoService contenidoService;
	
	private List<InputStream> inputStreams;
	
	private static final String FILE_NAME = "image";
	
	private static final String SOURCE_DIRECTORY = "C:\\temp\\fixeala\\samples\\";	
	
	private static final String UPLOAD_DIRECTORY = "C:\\temp\\fixeala\\uploads\\";	

	
	@Before
	public void init(){
		
		inputStreams = new ArrayList<InputStream>();
		
		for(int i = 0 ; i < 10 ; i++){
		
	        InputStream input;	      
	        
			try {
				String url = SOURCE_DIRECTORY + FILE_NAME + i + ".jpg";
				input = new BufferedInputStream(new FileInputStream(url));
				inputStreams.add(input);
					
			} catch (FileNotFoundException e) {
				System.out.println("Fallo en la inicialización de contenidos.");
			}	     
	       
		}
		
	}	
	
	@Test
	public void uploadContenido() throws FileNotFoundException{
		
		System.out.println("\n");
		System.out.println(" ----------------------------------------------------------------------- ");
        System.out.println("          T E S T ( 1 )  :    U P L O A D     C O N T E N I D O          ");
        System.out.println(" ----------------------------------------------------------------------- ");
        System.out.println("\n");
        
		MediaContentDTO contenido = new MediaContentDTO();
		List<MediaContentDTO> filesToUpload = new ArrayList<MediaContentDTO>();
		int uploadedFiles = 0;
		
		for(InputStream input : inputStreams){
			contenido.setInputStream(input);	
			contenido.setExtension("jpg");	
			contenido.setNroReclamo("18865");	
			contenido.setOrden(String.valueOf(inputStreams.indexOf(input)));	
			filesToUpload.add(contenidoService.subirContenido(contenido));	
			uploadedFiles++;
		}		
		
		for(MediaContentDTO file : filesToUpload){
			System.out.println("Uploaded file " + (filesToUpload.indexOf(file) + 1) + ": " + file.getFile().getName() + " (" + getFileSize(file.getFile()) + " Kb)");		
			Assert.assertNotNull(file.getFile().length());
		}	
		
		System.out.println("\n");
		System.out.println(uploadedFiles + " ARCHIVOS SUBIDOS.");
			
	}
	
	
	//@Test
	public void displayContenidoTest() throws FileNotFoundException {
		
		System.out.println("\n");
		System.out.println(" ----------------------------------------------------------------------- ");
        System.out.println("         T E S T ( 2 )  :    D I S P L A Y     C O N T E N I D O         ");
        System.out.println(" ----------------------------------------------------------------------- ");
        System.out.println("\n");
        
		Long idIssue = new Long(18865);		
		
		List<MediaContentDTO> contenidos = contenidoService.listarContenidos(idIssue);
		
		Assert.assertNotSame(0, contenidos.size());
				
		for(MediaContentDTO contenido : contenidos){
			System.out.println("Contenido " + (contenidos.indexOf(contenido) + 1) + ": " + contenido.getNombreConExtension());				
		}
		
		System.out.println("\n");
		System.out.println(contenidos.size() + " ARCHIVOS LISTADOS.");	
		
	}
	
	
	//@Test
	public void deleteContenidoTest() throws FileNotFoundException {
		
		System.out.println("\n");
		System.out.println(" ----------------------------------------------------------------------- ");
        System.out.println("           T E S T ( 3 )  :   D E L E T E     C O N T E N I D O          ");
        System.out.println(" ----------------------------------------------------------------------- ");
        System.out.println("\n");
        
        Long idIssue = new Long(18865);		
		List<MediaContentDTO> contenidos = contenidoService.listarContenidos(idIssue);
        
		int deletedFiles = 0;
		
		for(MediaContentDTO contenido : contenidos){
			System.out.println("Deleting file " + (contenidos.indexOf(contenido) + 1) + ": " + contenido.getNombreConExtension());
			contenidoService.borrarContenido(contenido);
			deletedFiles++;
		}
		
		Assert.assertEquals(deletedFiles, contenidos.size());
		
		System.out.println("\n");
		System.out.println(deletedFiles + " ARCHIVOS BORRADOS.");		
		        
	}
	
	
	/**
	@Test(expected=BusinessException.class)
	public void uploadFileTest() throws FileNotFoundException {			
		
		FileWrapperDTO file = contenidoService.uploadFile(null, "png");	
		System.out.println("Archivo :" + file.getFile().getName() + " (" + getFileSize(file.getFile()) + " Kb)");	
		
	}
		
	
	@Test
	public void deleteFileTest() throws FileNotFoundException{		
		
		String[] filenames = { UPLOAD_DIRECTORY + "IMG-20140107104045-FXL-7f8628eb-2fb3-4c6e-88f5-2df370c7f7ff.jpg"};		
		int deletedFiles = contenidoService.deleteMultipleFiles(filenames);				
		Assert.assertEquals(1, deletedFiles);
		
	}
	
	
	@Test
	public void deleteMultipleFilesTest() throws FileNotFoundException{
		
		Long idIssue = new Long(18865);		
		List<ContenidoDTO> contenidos = new ArrayList<ContenidoDTO>(); 
		int deletedFiles = 0;
		
		contenidos = contenidoService.listarContenido(idIssue);	
		String[] filenames = new String[contenidos.size()];
		
		for(ContenidoDTO c : contenidos){
			filenames[contenidos.indexOf(c)] = UPLOAD_DIRECTORY + c.getNombreConExtension();
		}		
		
		deletedFiles = contenidoService.deleteMultipleFiles(filenames);		
		
		Assert.assertEquals(deletedFiles, contenidos.size());
		
	}
	**/
			
	
	private int getFileSize(File file){
		double bytes = file.length();
		int kilobytes = (int) (bytes / 1024);
		return kilobytes;
	}	
	
}