package ar.com.urbanusjam.test.dao;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import ar.com.urbanusjam.dao.impl.utils.CriteriaType;
import ar.com.urbanusjam.dao.utils.CriteriaSearch;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.services.ExportService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.ReportDTO;
import ar.com.urbanusjam.services.utils.FileFormat;

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
	public void exportIssuesToPdfTest(){
		
		Map<String, Object> parametros = new HashMap<String, Object>();
//		parametros.put("style", "C:\\desarrollo\\style.jrxml");  
						
		try {		
			
			List<IssueDTO> issues = issueService.loadAllIssues();		
			ReportDTO report = new ReportDTO("issue_ireport", parametros, issues);			
			boolean success = exportService.exportToPDF(report);
			
			success = exportService.exportToXLS(report);
			
			Assert.assertEquals(true, success);
			
		} catch (IOException e) {		
			e.printStackTrace();
			
		} catch (JRException e) {
			e.printStackTrace();
		}
		
	}
	
	public void exportIssuesToXlsTest(){
		
	}
	
	public void exportIssuesToCvsTest(){
		
	}
	
	
	//@Test
	public void findIssuesByDefaultCriteriaTest(){
		
		// BUSQUEDA PREDETERMINADA
			//-- provincias : TODAS
			//-- ciudades   : TODAS
			//-- tags       : TODAS
			//-- estado     : TODOS
			//-- fecha      : ULTIMO MES - ACTUALIDAD
			//-- orden      : FECHA MAS RECIENTE
		
		Calendar minDate = Calendar.getInstance(); 
		minDate.add(Calendar.MONTH, -1);		
		Calendar maxDate = Calendar.getInstance();
		
		CriteriaSearch newSearch = new CriteriaSearch();	
		newSearch.setSearchType(CriteriaType.DEFAULT_SEARCH);
		newSearch.setMinFecha(minDate);
		newSearch.setMaxFecha(maxDate);
		
   		List<Issue> issues = issueDAO.getIssuesByCriteria(newSearch);
			
		Assert.assertEquals(7, issues.size());		
	
	}
	
	
	@Test
	public void findIssuesByCustomCriteriaTest() throws ParseException{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d1 = sdf.parse("2013-11-01");
		Date d2 = sdf.parse("2013-11-10");		
		String[] estados = new String[]{"RESUELTO", "ABIERTO"};
		String[] tags = new String[]{"bache", "alumbrado"};
		
		CriteriaSearch newSearch = new CriteriaSearch();	
		newSearch.setProvincia("Buenos Aires");
		newSearch.setCiudad("Gerli");
		newSearch.setMinFecha(this.toCalendar(d1));
		newSearch.setMaxFecha(this.toCalendar(d2));
		newSearch.setEstado(estados);
		newSearch.setTags(tags);
		newSearch.setSearchType(CriteriaType.CUSTOM_SEARCH);
		
		List<Issue> issues = issueDAO.getIssuesByCriteria(newSearch);
		
		Assert.assertEquals(1, issues.size());	
		
	}
	
	private GregorianCalendar toCalendar(Date date){
		Calendar cal = new GregorianCalendar();
        cal.setTime(date);
        return (GregorianCalendar) cal;
	}
		
  
}
