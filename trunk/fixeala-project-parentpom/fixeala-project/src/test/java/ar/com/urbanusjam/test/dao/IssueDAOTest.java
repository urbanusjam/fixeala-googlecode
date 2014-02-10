package ar.com.urbanusjam.test.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import junit.framework.Assert;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.IssueVoteDAO;
import ar.com.urbanusjam.dao.impl.utils.CriteriaType;
import ar.com.urbanusjam.dao.utils.IssueCriteriaSearchRaw;
import ar.com.urbanusjam.entity.annotations.Issue;

@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={"classpath*:ctx/fixeala-context.xml"}) 
@ContextConfiguration(locations={"classpath:test-context.xml"}) 
//@TransactionConfiguration(transactionManager="transactionManager", defaultRollback = true)
public class IssueDAOTest  {
			
	@Autowired
	private IssueDAO issueDAO;	
	
	@Autowired
	private IssueVoteDAO issueVoteDAO;	
		
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
		
		IssueCriteriaSearchRaw newSearch = new IssueCriteriaSearchRaw();			
		newSearch.setMinFechaFormateada(minDate);
		newSearch.setMaxFechaFormateada(maxDate);
		
   		List<Issue> issues = issueDAO.getIssuesByCriteria(newSearch);
			
		Assert.assertEquals(7, issues.size());		
	
	}	
	
	@Test
	public void findIssuesByCustomCriteriaTest() throws ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date1 = sdf.parse("2013-01-01");
		Date date2 = sdf.parse("2014-01-10");		
		String[] estados = new String[]{"RESUELTO", "ABIERTO"};
		String[] tags = new String[]{"bache", "alumbrado"};
		
		IssueCriteriaSearchRaw newSearch = new IssueCriteriaSearchRaw();	
		newSearch.setProvincia("Buenos Aires");
		newSearch.setCiudad("Buenos Aires");
		newSearch.setMinFechaFormateada(this.toCalendar(date1));
		newSearch.setMaxFechaFormateada(this.toCalendar(date2));
		newSearch.setEstadosArray(estados);
		newSearch.setTagsArray(tags);
		newSearch.setSortField("date");
	
		List<Issue> issues = issueDAO.getIssuesByCriteria(newSearch);
		
		Assert.assertEquals(1, issues.size());	
		
	}
	
	//@Test
	public void sumarizeVotesByIssue() {
		Assert.assertEquals(new Long(2), issueVoteDAO.getTotalVotesCount(Long.valueOf("1011")));
	}
	
	private GregorianCalendar toCalendar(Date date){
		Calendar cal = new GregorianCalendar();
        cal.setTime(date);
        return (GregorianCalendar) cal;
	}	
  
}
