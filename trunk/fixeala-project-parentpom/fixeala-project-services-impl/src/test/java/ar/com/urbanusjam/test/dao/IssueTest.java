package ar.com.urbanusjam.test.dao;

import java.util.Date;
import java.util.List;

import junit.framework.Assert;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.utils.CriteriaSearch;
import ar.com.urbanusjam.entity.annotations.Issue;

@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={"classpath*:ctx/fixeala-context.xml"}) 
@ContextConfiguration(locations={"classpath:test-context.xml"}) 
//@TransactionConfiguration(transactionManager="transactionManager", defaultRollback = true)
public class IssueTest /*extends AbstractTransactionalJUnit4SpringContextTests*/  {
			
	@Autowired
	private IssueDAO issueDAO;	

	@Before
	public void setUp(){
		
	}

	@Test
	public void sampleTest(){
		
//		Date demoDate = new Date();		
		DateTime minDate = new DateTime("2013-12-09");		
		DateTime maxDate = new DateTime(minDate.plusMonths(3));		
		
		String[] estado = new String[]{"RESUELTO"};
		String[] tags = new String[]{"bache", "vereda"};
		
		CriteriaSearch newSearch = new CriteriaSearch();
//		newSearch.setProvincia("Ciudad Autónoma de Buenos Aires");
//		newSearch.setCiudad("Buenos Aires");
//		newSearch.setBarrio("Palermo");
//		newSearch.setMinFecha(minDate.toDate());
//		newSearch.setMaxFecha(maxDate.toGregorianCalendar());
		newSearch.setEstado(estado);
//		newSearch.setTags(tags);
		
		
		List<Issue> issues = issueDAO.getIssuesByCriteria(newSearch);
	
		Assert.assertEquals(1, issues.size());
		
	
	}

	
	
  
}
