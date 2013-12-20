package ar.com.urbanusjam.test.dao;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import junit.framework.Assert;

import net.sf.jasperreports.engine.JRException;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.utils.CriteriaSearch;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.services.ExportService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;

@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={"classpath*:ctx/fixeala-context.xml"}) 
@ContextConfiguration(locations={"classpath:test-context.xml"}) 
//@TransactionConfiguration(transactionManager="transactionManager", defaultRollback = true)
public class IssueTest /*extends AbstractTransactionalJUnit4SpringContextTests*/  {
			
	@Autowired
	private IssueDAO issueDAO;	
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private ExportService exportService;

	@Before
	public void setUp(){
		
	}

	//@Test
	public void findIssuesForExportByCriteriaTest(){

		DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyy/MM/dd");
		DateTime minDate = new DateTime("2013-12-10");		
		DateTime maxDate = new DateTime("2013-12-19");		
				
		String[] estado = new String[]{"RESUELTO"};
		String[] tags = new String[]{"bache", "vereda"};
		
	
		CriteriaSearch newSearch = new CriteriaSearch();
		newSearch.setProvincia("Ciudad Autónoma de Buenos Aires");
		newSearch.setCiudad("Buenos Aires");
//		newSearch.setBarrio("Palermo");
		newSearch.setMinFecha(minDate.toDate());
		newSearch.setMaxFecha(maxDate.toDate());
//		newSearch.setEstado(estado);
//		newSearch.setTags(tags);
		
		
		List<Issue> issues = issueDAO.getIssuesByCriteria(newSearch);
	
		Assert.assertEquals(1, issues.size());
		
	
	}
	
	@Test
	public void searchIssuesByCriteriaTest(){
		
	}
	
	@Test
	public void exportIssuesToPdfTest(){
		
		List<IssueDTO> issues = issueService.loadAllIssues();
		
		Map<String, Object> parametros = new HashMap<String, Object>();
//		parametros.put("imagen", imagen);  
				
		try {
			exportService.generatePDFReport("issue", parametros, issues);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
		
  
}
