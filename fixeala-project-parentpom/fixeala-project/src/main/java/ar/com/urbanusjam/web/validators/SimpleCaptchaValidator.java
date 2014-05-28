package ar.com.urbanusjam.web.validators;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.captcha.Captcha;

public class SimpleCaptchaValidator {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public boolean isCaptchaValido (HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
		//request.setCharacterEncoding("UTF-8");
		String answer = request.getParameter("captcha_answer");
		logger.debug("hay answer: "+answer);
		
		if (answer == null || answer.isEmpty()) 
			return false;
	
		else
			return (captcha.isCorrect(answer));
		
	}

}
