package ar.com.urbanusjam.web.validators;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.web.forms.RegistrationForm;

@Component("registrationValidator")
public class RegistrationValidator implements Validator{
	
	@Autowired
	private UserService userService;
		

	@Override
	public boolean supports(Class<?> c) {
		 return RegistrationForm.class.isAssignableFrom(c);
	}

	@Override
	public void validate(Object target, Errors errors) {
		 RegistrationForm form = (RegistrationForm) target;
		 
		 boolean usernameExists = userService.usernameExists(form.getUsername());
		 boolean emailExists = userService.emailExists(form.getEmail());
		 
		 if(usernameExists){
			 errors.rejectValue("username", "registration.username.exists");
		 }
		 
		 if(emailExists){
			 errors.rejectValue("email", "registration.email.exists");
		 }
		 
		 if (!(form.getPassword()).equals(form.getConfirmPassword())) {
			      errors.rejectValue("confirmPassword", "matchingPassword.registration.confirmPassword");
		 }
		
	}

}
