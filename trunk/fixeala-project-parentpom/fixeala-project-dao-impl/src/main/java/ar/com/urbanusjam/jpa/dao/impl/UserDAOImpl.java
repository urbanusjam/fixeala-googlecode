package ar.com.urbanusjam.jpa.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ActivationDAO;
import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.dao.utils.UserCriteriaSearch;
import ar.com.urbanusjam.entity.annotations.User;

@Repository
@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class UserDAOImpl implements UserDAO, UserDetailsManager  {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager;   

	@Autowired
	private ActivationDAO activationDAO;
		
	public UserDAOImpl() {}

//	public void setActivationDAO(ActivationDAO activationDAO) {
//		this.activationDAO = activationDAO;
//	}
	
	@Override
	public User loadUserByUsername(String username) throws UsernameNotFoundException {		
		User user = new User();		
		try{
			user = entityManager.createQuery("SELECT u FROM User u WHERE u.username = :username", User.class)
					  .setParameter("username", username)			
 					  .getSingleResult();	
		} catch(NoResultException e){
			user = null;
		}
		
		return user;			
	}	
	
	@Override
	public List<User> findAllActiveUsers() {		
		List<User> users = entityManager.createQuery("SELECT u FROM User u WHERE u.enabled = :enabled", User.class)
										.setParameter("enabled", true)
									    .getResultList();
		return users;
	}
	
	/**
	@Override
	public List<User> findUsersByArea(String areaID) {
		List<User> users = new ArrayList<User>();			
		users = this.findWhere(" enabled = true AND area.id = ? AND verifiedOfficial = true AND isArea = false ORDER BY username ASC", new Object[]{Long.valueOf(areaID)});			
		return users;
	}
	**/
	
	@Override	 	
	public void createUser(User user) {	
		entityManager.persist(user);				
	}
	
	@Override
	public void updateUser(UserDetails user) {		
		entityManager.merge(user);
		((Transaction) entityManager).commit();//implicitly flushes if flush mode is COMMIT or AUTO.
	}

	@Override
	public void deleteUser(String username) {
		User user = (User) this.loadUserByUsername(username);				
		entityManager.remove(user);		
	}

	@Override
	public void changePassword(String username, String newPassword) {
		User user = (User) this.loadUserByUsername(username);			
		user.setPassword(newPassword);
		entityManager.merge(user);
	}

	@Override
	public boolean userExists(String username) {
		User user =  this.loadUserByUsername(username);		
		return user != null ? true : false;
	}

	@Override
	public boolean emailExists(String email) {
		User user = new User();		
		try{
			user = entityManager.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
					 			.setParameter("email", email)			
					 			.getSingleResult();
		} catch(NoResultException e){
			user = null;
		}		
		return user != null ? true : false;
	}
	
	@Override
	public String findUsernameByEmail(String email) throws NoResultException {
		try{
			User user = entityManager.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
					 .setParameter("email", email)			
					 .getSingleResult();	
			return user.getUsername();
		} catch(NoResultException e){
			return null;
		}	
	}

	@Override
	public String findPassword(String username, String password) {	
		User user = entityManager.createNamedQuery("User.findPassword", User.class)
				 .setParameter("username", username)			
				 .setParameter("password", password)			
				 .getSingleResult();					
		return user.getPassword();
	}

	@Override
	public void updateAccount(User user) {
		User userDB = (User) this.loadUserByUsername(user.getUsername());
		userDB.setNeighborhood(user.getNeighborhood());
		userDB.setEmail(user.getEmail());
		entityManager.merge(userDB);
		((Transaction) entityManager).commit();
	}
	
	@Override
	public void activateAccount(String username) {
		User user = (User) this.loadUserByUsername(username);
		user.setEnabled(true);
		entityManager.merge(user);
	}

	@Override
	public void closeAccount(String username) {
		User user = (User) this.loadUserByUsername(username);	
		user.setEnabled(false);
		user.setClosedAccountDate(new Date());
		entityManager.merge(user);
		((Transaction) entityManager).commit();
	}

	@Override
	public void deleteUnabledUserAndToken(String username) {
		User user = (User) this.loadUserByUsername(username);	
		//PONER EN UNA TRANSACCION!!!
		entityManager.remove(user);			
		activationDAO.deleteTokenByUsername(username);	
	}

	@Override
	public List<User> findUsersByCriteria(UserCriteriaSearch searchParam) {
		
		List<User> result = new ArrayList<User>();
		
//		Criteria criteria = sessionFactory.getCurrentSession()
//			                .createCriteria(User.class)
//							.createAlias("roles", "r")
//							.add( Restrictions.in("r.authority", searchParam.getRoles()) )	
//							.add( Restrictions.eq("enabled", searchParam.isEnabled()) )	
//					        .addOrder(Order.asc("username") )
//					        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
//		
//		if( searchParam.getUsernames() != null && searchParam.getUsernames().length > 0){
//			criteria.add(Restrictions.in("username", searchParam.getUsernames()));	
//		}			
//				
//		result = criteria.list();	
		
		return result;
	}

	@Override
	public Long findUserIDbyUsername(String username) {
		User user = (User) this.loadUserByUsername(username);		
		return user.getId();	
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

}
