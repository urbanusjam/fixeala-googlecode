package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ActivationDAO;
import ar.com.urbanusjam.dao.AuthorityDAO;
import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.User;



public class UserDAOImpl extends GenericDAOImpl<User, Serializable>  implements UserDAO, UserDetailsManager  {

	private AuthorityDAO authorityDAO;	
	private ActivationDAO activationDAO;
		
	public UserDAOImpl() {
		super(User.class);
	}
	
	public void setAuthorityDAO(AuthorityDAO authorityDAO) {
		this.authorityDAO = authorityDAO;
	}	
	
	public void setActivationDAO(ActivationDAO activationDAO) {
		this.activationDAO = activationDAO;
	}

	@Override
	public User loadUserByUsername(String username) throws UsernameNotFoundException {
		List<User> users = this.findWhere(" username = ? ",  new Object[]{username});		
		return users.size() > 0 ? users.get(0) : null;						
	}
	
	
	@Override
	public List<User> findAllActiveUsers() {
		List<User> users = new ArrayList<User>();		
		users = this.findWhere(" enabled = true ORDER BY username, neighborhood");			
		return users;
	}
	
	@Override	 	
	@Transactional
	public void createUser(User user) {
		
		Session session = getHibernateTemplate().getSessionFactory().openSession(); 
		Transaction trx = null;
		
		try{				
			trx = session.beginTransaction();
			this.save(user);				
			authorityDAO.saveAuthorities(user.getUsername(), user.getAuthorities());
			trx.commit();			
		}
		catch(Exception e){
			trx.rollback();		
		}
		finally{			
			session.close();
		}			
	}

	
	@Override
	public void updateUser(UserDetails user) {
		this.update((User) user);		
	}

	@Override
	public void deleteUser(String username) {
		List<User> users = this.findWhere("username = ?", username);
		if(users.size() == 1){
			this.delete(users.get(0));
		}		
	}

	@Override
	public void changePassword(String username, String newPassword) {
		List<User> users = this.findWhere("username = ?", username);
		if(users.size() > 0){
			User u = users.get(0);
			u.setPassword(newPassword);
			getHibernateTemplate().update(u);
		}		
	}

	@Override
	public boolean userExists(String username) {
		@SuppressWarnings("unchecked")
		List<User> users = (List<User>) this.loadUserByUsername(username);		
		return users.size() > 0 ? true : false;
	}

	@Override
	public User loadUserByName(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void createUser(UserDetails user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean usernameExists(String username) {
		return this.findWhere(" username = ? ", new Object[]{username}).size() > 0 ? true : false;
	}

	@Override
	public boolean emailExists(String email) {
		return this.findWhere(" email = ? ", new Object[]{email}).size() > 0 ? true : false;
	}
	
	@Override
	public String findUsernameByEmail(String email) {
		List<User> users = this.findWhere(" email = ? ", new Object[]{email});
		return users.size() > 0 ? users.get(0).getUsername() : null;
	}

	@Override
	public String findPassword(String username, String password) {					
		List<User> users = this.findWhere(" username = ? and password = ? ", new Object[]{username, password});		
		return users.size() > 0 ? users.get(0).getPassword() : null;
	}

	@Override
	public void updateAccount(User user) {
		User userDB = (User) this.loadUserByUsername(user.getUsername());
		userDB.setNeighborhood(user.getNeighborhood());
		userDB.setEmail(userDB.getEmail());
		this.update(userDB);		
	}
	
	@Override
	public void activateAccount(String username) {
		User user = (User) this.loadUserByUsername(username);
		user.setEnabled(true);
		this.update(user);
	}

	@Override
	public void closeAccount(String username) {
		List<User> users = this.findWhere(" username = ? ", new Object[]{username});
		User user = users.get(0);
		user.setEnabled(false);
		user.setClosedAccountDate(new Date());
		this.update(user);
	}

	@Override
	public void deleteUnabledUserAndToken(String username) {
		List<User> users = this.findWhere(" username = ? ", new Object[]{username});		
		if(users.size() > 0){
			User user = users.get(0);
			delete(user);		
			
		}		
		activationDAO.deleteTokenByUsername(username);	
	}

		

}
