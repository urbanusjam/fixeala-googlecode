package ar.com.urbanusjam.test.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import junit.framework.Assert;
import net.sf.jasperreports.engine.JRException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.services.ExportService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.ReportDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:test-context.xml"}) 
public class IssueServiceTest {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private ExportService exportService;
	
	List<IssueDTO> issues;	
	
	Map<String, Object> parametros;
	
	ReportDTO report;
	
	@Before
	public void init(){		
		parametros = new HashMap<String, Object>();	
		issues = issueService.loadAllIssues();		
		report = new ReportDTO("issue_ireport_eclipse", parametros, issues);			
	}
	
	
	@Test
	public void exportIssuesToPdfTest(){
			
		try {						
//			parametros.put("style", "C:\\desarrollo\\style.jrxml");  
			boolean success = exportService.exportToPDF(report);			
			Assert.assertEquals(true, success);
			
		} catch (IOException e) {		
			e.printStackTrace();
			
		} catch (JRException e) {
			e.printStackTrace();
		}
		
	}
	
	public void exportIssuesToXlsTest(){
		
		Map<String, Object> parametros = new HashMap<String, Object>();
	
		try {		
			
			List<IssueDTO> issues = issueService.loadAllIssues();		
			ReportDTO report = new ReportDTO("issue_ireport", parametros, issues);			
			boolean success = exportService.exportToXLS(report);
			
			Assert.assertEquals(true, success);
			
		} catch (IOException e) {		
			e.printStackTrace();
			
		} catch (JRException e) {
			e.printStackTrace();
		}
		
	}
	
	public void exportIssuesToCvsTest(){
		
	}

}
