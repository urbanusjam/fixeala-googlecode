package ar.com.urbanusjam.test.service;

import java.io.IOException;
import java.util.Date;
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

import ar.com.urbanusjam.services.ExportService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
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
	
	//@Before
	public void init(){		
		parametros = new HashMap<String, Object>();	
		issues = issueService.loadAllIssues();		
		report = new ReportDTO("issue_ireport_eclipse", parametros, issues);			
	}
	
	//@Test
	public void addFollower(){
		IssueFollowDTO following = new IssueFollowDTO();
		following.setIdIssue("1925");
		following.setUsername("helloworld");
		following.setDate(new Date());
		
		IssueFollowDTO following2 = new IssueFollowDTO();
		following2.setIdIssue("22085");
		following2.setUsername("mock");
		following2.setDate(new Date());
		
		IssueFollowDTO following3 = new IssueFollowDTO();
		following3.setIdIssue("22085");
		following3.setUsername("coripel");
		following3.setDate(new Date());
		
		issueService.followIssue(following);
		issueService.followIssue(following2);
		issueService.followIssue(following3);
		
		boolean isFollowing = issueService.isUserFollowingIssue(following);
	
		Assert.assertTrue("Follower added to issue #" + following.getIdIssue(), isFollowing);		
		
	}
	
	//@Test
	public void removeFollower(){
		IssueFollowDTO following = new IssueFollowDTO();
		following.setIdIssue("1011");
		following.setUsername("helloworld");
		following.setDate(new Date());
		
		issueService.unFollowIssue(following);
		boolean isFollowing = issueService.isUserFollowingIssue(following);
		
		Assert.assertFalse("Follower removed from issue #" + following.getIdIssue() , isFollowing);		
		
	}
	
	//@Test
	public void isUserFollowing(){
		IssueFollowDTO following = new IssueFollowDTO();
		following.setIdIssue("1011");
		following.setUsername("helloworld");
		following.setDate(new Date());
		
		boolean isFollowing = issueService.isUserFollowingIssue(following);
		
		Assert.assertTrue("User @" + following.getUsername().toUpperCase() , isFollowing);	
	}
	
	@Test
	public void getIssueFollowers(){
		String issueID = "67059";
		List<String> followers = issueService.getIssueFollowers(issueID);
		
		Assert.assertNotNull(followers);
		
		System.out.println("Usuarios observando el reclamo #" + issueID + ":" );
		for(String s : followers)			
			System.out.println("-" + s);
	}
	
	@Test
	public void getUserFollowings(){
		String userID = "helloworld";
		List<String> followings = issueService.getUserFollowings(userID);
		
		Assert.assertNotNull(followings);
		
		System.out.println("El usuario @" + userID + " está observando los siguientes reclamos:" );
		for(String s : followings)			
			System.out.println("#" + s);
	}
	
	
	//@Test
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
