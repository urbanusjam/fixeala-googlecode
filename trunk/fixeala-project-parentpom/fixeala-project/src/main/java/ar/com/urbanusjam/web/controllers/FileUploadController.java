package ar.com.urbanusjam.web.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import ar.com.urbanusjam.services.UserService;

@Controller
//@RequestMapping(value="/file")
public class FileUploadController {
	
	@Autowired
	@Qualifier("userService")
	UserService userService;
	
	@Autowired
	@Qualifier(value = "fixealaAuthenticationManager")
	protected AuthenticationManager fixealaAuthenticationManager;
	
	String pathImagenesTemporales = "C:/temp/fixeala/uploads/";
	
//	@RequestMapping(method=RequestMethod.GET)
//	public String template(){
//		return "template";
//	}
	
//	@RequestMapping(value="/message", method=RequestMethod.POST)
//	public @ResponseBody StatusResponse message(@RequestBody Message message) {	
//		return new StatusResponse(true, "Message received");
//	}
	
	@RequestMapping(value="/fileupload", method=RequestMethod.GET)
	public String showFileUploadPage() {	
		return "fileupload";
	}
	
	
	@RequestMapping(value="upload", method = RequestMethod.POST)
	public @ResponseBody String doFileUpload(@RequestParam("file") MultipartFile file, 
			HttpServletRequest request){
		String s = file.getName();
		return "file";
	}
	
    
}
