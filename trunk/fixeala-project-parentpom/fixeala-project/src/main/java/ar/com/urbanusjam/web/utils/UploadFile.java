package ar.com.urbanusjam.web.utils;

import java.io.Serializable;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class UploadFile implements Serializable {

	private static final long serialVersionUID = -38331060124340967L;
	private CommonsMultipartFile fileData;
	
	public UploadFile() {
	
	}

	public CommonsMultipartFile getFileData() {
		return fileData;
	}

	public void setFileData(CommonsMultipartFile fileData) {
		this.fileData = fileData;
	}
	
	
	

}