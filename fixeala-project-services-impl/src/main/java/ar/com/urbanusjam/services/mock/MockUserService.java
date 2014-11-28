package ar.com.urbanusjam.services.mock;

import ar.com.urbanusjam.entity.annotations.Authority;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.impl.UserServiceImpl;

public class MockUserService {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		UserService usersrv = new UserServiceImpl();
		
		//USER
	
		
		//ADMIN
		User user2 = new User();
		user2.setUsername("coripel");
		user2.setPassword("c7589745dd1841655ac79a8f6fbb8e63b01b1e00");
		user2.setApellido("Reyes Calens");
		user2.setNombre("Cora");
		
		
		
		
		//EDITOR

	}

}
