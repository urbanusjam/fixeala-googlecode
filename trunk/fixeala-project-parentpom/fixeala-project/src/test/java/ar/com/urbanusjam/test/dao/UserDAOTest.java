package ar.com.urbanusjam.test.dao;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.dao.utils.UserCriteriaSearch;
import ar.com.urbanusjam.entity.annotations.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:test-context.xml"}) 
public class UserDAOTest {
	
	@Autowired
	private UserDAO userDAO;	
	
	@Test
	public void findUsersByCriteriaTest(){
		
		String[] usernames = new String[]{"helloworld"};
		String[] roles = new String[]{"ROLE_USER"};
		boolean enabled = true;
		
		UserCriteriaSearch criteria = new UserCriteriaSearch(); 
		criteria.setUsernames(usernames);
		criteria.setRoles(roles);
		criteria.setEnabled(enabled);
		
		List<User> users = userDAO.findUsersByCriteria(criteria);
		
		Assert.assertEquals(1, users.size());
		
	}
	
	@Test
	public void findAdminUsersByCriteriaTest(){
		
		String[] usernames = new String[]{"coripel", "mock"};
		String[] roles = new String[]{"ROLE_ADMIN", "ROLE_MANAGER"};
		boolean enabled = true;
		
		UserCriteriaSearch criteria = new UserCriteriaSearch(); 
		criteria.setUsernames(usernames);
		criteria.setRoles(roles);
		criteria.setEnabled(enabled);
		
		List<User> users = userDAO.findUsersByCriteria(criteria);
		
		Assert.assertEquals(2, users.size());
		
	}

}