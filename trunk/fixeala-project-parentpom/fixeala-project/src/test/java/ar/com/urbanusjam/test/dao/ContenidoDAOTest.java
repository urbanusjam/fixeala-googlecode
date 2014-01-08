package ar.com.urbanusjam.test.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.entity.annotations.Issue;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:test-context.xml"}) 
public class ContenidoDAOTest {
	
	@Autowired
	private ContenidoDAO contenidoDAO;
	
	private Long idIssue;
	private Issue issue;
	private Contenido contenidoA;
	private Contenido contenidoB;
	private Contenido contenidoC;
	private List<Contenido> contenidos;
	private List<Contenido> contenidosDB;
	
	@Before
	public void init(){	
		
		idIssue = new Long(17324);
		 
		issue = new Issue();
		issue.setId(idIssue);
			
		contenidoA = new Contenido();	
		contenidoA.setId(new Long(4));
		contenidoA.setAlto(1024);
		contenidoA.setAncho(758);			
		contenidoA.setNombre("archivo01");
		contenidoA.setNombreConExtension("archivo01.png");
		contenidoA.setPathRelativo("/archivo01.png");
		contenidoA.setTipo("png");
		contenidoA.setIssue(issue);
		
		contenidoB = new Contenido();	
		contenidoA.setId(new Long(5));
		contenidoB.setAlto(640);
		contenidoB.setAncho(480);			
		contenidoB.setNombre("archivo02");
		contenidoB.setNombreConExtension("archivo02.gif");
		contenidoB.setPathRelativo("/archivo02.gif");
		contenidoB.setTipo("gif");
		contenidoB.setIssue(issue);
		
		contenidoC = new Contenido();	
		contenidoA.setId(new Long(6));
		contenidoC.setAlto(800);
		contenidoC.setAncho(600);			
		contenidoC.setNombre("archivo02");
		contenidoC.setNombreConExtension("archivo03.png");
		contenidoC.setPathRelativo("/archivo03.jpeg");
		contenidoC.setTipo("jpeg");
		contenidoC.setIssue(issue);
		
		contenidos = new ArrayList<Contenido>();
		contenidos.add(contenidoA);
		contenidos.add(contenidoB);
		contenidos.add(contenidoC);
		
		contenidosDB = new ArrayList<Contenido>();
		contenidosDB = contenidoDAO.findContenidosByIssue(idIssue);
		
	}
	
	//@Test
	public void findContenidosByIssue(){ 

		List<Contenido> contenidos = new ArrayList<Contenido>();
		Long idIssue = new Long(17324);
		
		contenidos = contenidoDAO.findContenidosByIssue(idIssue);
		
		Assert.assertTrue(contenidos.size() > 0);
		
	}
	
	@Test
	public void saveContenidosTest(){		
		
		contenidoDAO.saveAll(contenidos);
		
		Assert.assertEquals(contenidos.size(), contenidoDAO.findContenidosByIssue(idIssue).size());
		
	}
	
	//@Test
	//@Rollback
	public void deleteOneContenidoTest(){
		
		contenidos.remove(2);
		contenidos.remove(1);
		
		int sizeBefore = contenidoDAO.findContenidosByIssue(idIssue).size();			
		contenidoDAO.deleteContenidosByIssue(contenidos, idIssue);		
		int sizeAfter = contenidoDAO.findContenidosByIssue(idIssue).size();
		
		Assert.assertNotSame(sizeBefore, sizeAfter);
	}
	
	//@Test
	public void deleteMultipleContenidosTest(){
		
		contenidos.remove(0);
		
		int sizeBefore = contenidoDAO.findContenidosByIssue(idIssue).size();			
		contenidoDAO.deleteContenidosByIssue(contenidos, idIssue);
		int sizeAfter = contenidoDAO.findContenidosByIssue(idIssue).size();
		
		Assert.assertNotSame(sizeBefore, sizeAfter);
		
	}
	
	//@Test
	public void deleteAllContenidosTest(){
		
		int sizeBefore = contenidoDAO.findContenidosByIssue(idIssue).size();	
		contenidoDAO.deleteContenidosByIssue(contenidosDB, idIssue);		
		int sizeAfter = contenidoDAO.findContenidosByIssue(idIssue).size();
		
		Assert.assertNotSame(sizeBefore, sizeAfter);
		
	}
	
	
	private Long generateRandomID(){
		Random generator = new Random(); 
		int id = generator.nextInt(100000) + 1000;		
		return Long.valueOf(id);
	}
	
	
	

}
