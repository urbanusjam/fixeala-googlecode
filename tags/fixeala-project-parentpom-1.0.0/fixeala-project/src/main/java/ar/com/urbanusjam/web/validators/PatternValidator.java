package ar.com.urbanusjam.web.validators;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PatternValidator {
	
	  private Pattern pattern;
	  private Matcher matcher;
	  
	  /**  
	  *		^                     # Start of the line
	  *		  [a-z0-9_-]	      # Match characters and symbols in the list, a-z, 0-9, underscore, hyphen
	  *                  {3,15}   # Length at least 3 characters and maximum length of 15 
	  *     $                     # End of the line		
	  */
	  private static final String USERNAME_PATTERN = "^[a-z0-9_-]{3,15}$";
	  
	  /**  
		  *		^                     # Start of the line
		  *		  [a-z0-9_-]	      # Match characters and symbols in the list, a-z, 0-9, underscore, hyphen
		  *                  {8,18}   # Length at least 8 characters and maximum length of 18 
		  *     $                     # End of the line		
		  */
	  private static final String PASSWORD_PATTERN = "^[a-z0-9_-]{6,18}$";
	  
	  /**
	    Passwords will contain at least (1) upper case letter

	    Passwords will contain at least (1) lower case letter

	    Passwords will contain at least (1) number or special character

	    Passwords will contain at least (8) characters in length

	    Password maximum length is not limited
      **/		 
//	  private static final String STRONG_PASSWORD_PATTERN = "(?=^.{8,16}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$";

	  
	  
	  
		  
	  public PatternValidator(){
		  pattern = Pattern.compile(USERNAME_PATTERN);
		  pattern = Pattern.compile(PASSWORD_PATTERN);
	  }

	
	  public boolean validateUsername(final String username){
		  matcher = pattern.matcher(username);
		  return matcher.matches();
	  }
	  
	  
	  public boolean validatePassword(final String password){
		  matcher = pattern.matcher(password);
		  return matcher.matches();
	  }

}
