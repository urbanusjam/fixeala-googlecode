package ar.com.urbanusjam.test.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import ar.com.urbanusjam.dao.IssueDAO;

@ContextConfiguration
public class IssueTest extends AbstractTransactionalJUnit4SpringContextTests {
	
	@Autowired	
	protected IssueDAO issueDAO;
	
	@Test
	public void sampleTest(){
	
		System.out.println("Probando test...");
	
	}

	
	
  
}
