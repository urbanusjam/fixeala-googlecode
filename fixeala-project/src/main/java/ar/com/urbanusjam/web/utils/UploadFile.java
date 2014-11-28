package ar.com.urbanusjam.web.utils;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class UploadFile implements Serializable {

	private static final long serialVersionUID = -38331060124340967L;
	private MultipartFile file;
	
	public UploadFile() {
	
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	
	

}