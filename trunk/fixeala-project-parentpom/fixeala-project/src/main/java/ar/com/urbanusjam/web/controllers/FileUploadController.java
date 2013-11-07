package ar.com.urbanusjam.web.controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.web.utils.Message;
import ar.com.urbanusjam.web.utils.StatusResponse;
import ar.com.urbanusjam.web.utils.UploadFile;

@Controller
@RequestMapping(value="/template")
public class FileUploadController {
	
	@Autowired
	@Qualifier("userService")
	UserService userService;
	
	@Autowired
	@Qualifier(value = "fixealaAuthenticationManager")
	protected AuthenticationManager fixealaAuthenticationManager;
	
	String pathImagenesTemporales = "C:/temp/fixeala/uploads/";
	
	@RequestMapping(method=RequestMethod.GET)
	public String template(){
		return "template";
	}
	
	@RequestMapping(value="/message", method=RequestMethod.POST)
	public @ResponseBody StatusResponse message(@RequestBody Message message) {	
		return new StatusResponse(true, "Message received");
	}
	
	
    
}
