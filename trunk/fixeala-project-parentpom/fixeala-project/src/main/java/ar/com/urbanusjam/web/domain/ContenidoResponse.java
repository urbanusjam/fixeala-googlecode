package ar.com.urbanusjam.web.domain;



public class ContenidoResponse {

	private boolean status;
	private String message;
	private int totalUploadedFiles;
	private String uploadedFiles; 


	public ContenidoResponse(){}

	public ContenidoResponse(boolean status, String message) {
		super();
		this.status = status;
		this.message = message;
	}
	
	public ContenidoResponse(boolean status, int totalUploadedFiles) {
		super();
		this.status = status;
		this.totalUploadedFiles = totalUploadedFiles;
	}
	
	public ContenidoResponse(boolean status, String message, int totalUploadedFiles) {
		super();
		this.status = status;
		this.message = message;
		this.totalUploadedFiles = totalUploadedFiles;
	}
	
	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getTotalUploadedFiles() {
		return totalUploadedFiles;
	}

	public void setTotalUploadedFiles(int totalUploadedFiles) {
		this.totalUploadedFiles = totalUploadedFiles;
	}

	public String getUploadedFiles() {
		return uploadedFiles;
	}

	public void setUploadedFiles(String uploadedFiles) {
		this.uploadedFiles = uploadedFiles;
	}
	
}