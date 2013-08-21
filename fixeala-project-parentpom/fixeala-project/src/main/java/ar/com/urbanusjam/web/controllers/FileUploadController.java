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
	
	@RequestMapping(value="/file", method=RequestMethod.POST)
	public @ResponseBody List<UploadedFile> upload(
	@RequestParam("file") MultipartFile file, HttpServletRequest request) {
	
		List<UploadedFile> uploadedFiles = new ArrayList<UploadedFile>();
		UploadedFile u = new UploadedFile(file.getOriginalFilename(),
		Long.valueOf(file.getSize()).intValue(),
		this.pathImagenesTemporales+file.getOriginalFilename());	
		   
		String fileName =this.pathImagenesTemporales+file.getOriginalFilename();

		File dir = new File(this.pathImagenesTemporales+file.getOriginalFilename());
        if(!dir.exists()) {
            dir.mkdirs();
        }
         File multipartFile = new File(fileName);
		 try {
			file.transferTo(multipartFile);
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			UserDTO userDTO = new UserDTO();
			userDTO.setUsername(user.getUsername());
			userDTO.setProfilePic(file.getOriginalFilename());			
			userDTO.setNeighborhood("Congreso");			
			userDTO.setEmail("guest@gmail.com");		
			
			userService.updateAccount(userDTO);
			
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		uploadedFiles.add(u);
		return uploadedFiles;
	}
	
	
	
    
}
