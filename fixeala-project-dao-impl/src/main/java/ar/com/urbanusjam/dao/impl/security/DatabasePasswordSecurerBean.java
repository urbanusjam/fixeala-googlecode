package ar.com.urbanusjam.dao.impl.security;

import java.sql.ResultSet;
import java.sql.SQLException;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.security.authentication.dao.SaltSource;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;


public class DatabasePasswordSecurerBean extends JdbcDaoSupport {
	
	@Autowired
	private ShaPasswordEncoder passwordEncoder;

	@Autowired
	private SaltSource saltSource;
	
	@Autowired
	private UserDetailsService userService;
	
	public void secureDatabase() {
//		getJdbcTemplate().query("SELECT USERNAME, PASSWORD FROM USERS", new RowCallbackHandler(){
//			@Override
//			public void processRow(ResultSet rs) throws SQLException {
//				String username = rs.getString(1);
//				String password = rs.getString(2);
//				// Ch 4 Salt Exercise
//				UserDetails user = userService.loadUserByUsername(username);
//				String encodedPassword = passwordEncoder.encodePassword(password, saltSource.getSalt(user));
//				getJdbcTemplate().update(
//						"UPDATE USERS SET PASSWORD = ? WHERE USERNAME = ?", 
//						encodedPassword, username);
//				logger.debug("Updating password for username: "+username+" to: "+encodedPassword);
//			}			
//		});
	}
}
