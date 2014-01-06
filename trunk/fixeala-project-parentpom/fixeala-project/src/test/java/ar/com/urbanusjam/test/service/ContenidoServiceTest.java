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
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:test-context.xml"}) 
public class ContenidoServiceTest {

	@Autowired
	private ContenidoService contenidoService;
	
	private List<InputStream> inputStreams;
	
	private static final String IMAGE_NAME = "image";
	
	private static final String SOURCE_DIRECTORY = "C:\\temp\\fixeala\\samples\\";	

	
	@Before
	public void init(){
		
		inputStreams = new ArrayList<InputStream>();
		
		for(int i = 0 ; i < 10 ; i++){
		
	        InputStream input;	      
	        
			try {
				String url = SOURCE_DIRECTORY + IMAGE_NAME + i + ".jpg";
				input = new BufferedInputStream(new FileInputStream(url));
				inputStreams.add(input);
					
			} catch (FileNotFoundException e) {
				System.out.println("Fallo el init()");
			}	     
	       
		}
		
	}
	
	
//	@Test(expected=FileNotFoundException.class)
	//@Test
	public void uploadFilesToFolderTest() throws FileNotFoundException{
			
		for(int i = 0; i < inputStreams.size() ; i++){			
			FileWrapperDTO file = contenidoService.subirContenido(inputStreams.get(i), "jpg");	
			System.out.println("Archivo " + i + ": " + file.getFile().getName() + " (" + getFileSize(file.getFile()) + " Kb)");				
		}		
		
	}
	
	@Test
	public void uploadFiles() throws FileNotFoundException{
			
		ContenidoDTO contenido = new ContenidoDTO();
		InputStream input = inputStreams.get(0);
		contenido.setInputStream(input);	
		contenido.setTipo("jpg");	
		contenido.setNroReclamo("18865");	
		FileWrapperDTO file = contenidoService.upload(contenido);	
		Assert.assertNotNull(file.getFile().length());
		
	}
	
	
	public void deleteFilesTest(){}
	
	
	//@Test
	public void listarContenidosTest() throws FileNotFoundException {
		
		Long idIssue = new Long(17324);		
		List<ContenidoDTO> contenidos = contenidoService.listarContenidos(idIssue);
		Assert.assertEquals(6, contenidos.size());
				
	}
	
	private int getFileSize(File file){
		double bytes = file.length();
		int kilobytes = (int) (bytes / 1024);
		return kilobytes;
	}
	
	
	
	public void valdiateFileTest(){}
	
}
