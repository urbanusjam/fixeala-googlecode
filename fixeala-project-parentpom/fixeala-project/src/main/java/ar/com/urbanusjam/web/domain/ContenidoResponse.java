package ar.com.urbanusjam.web.domain;


public class ContenidoResponse {

	private boolean result;
	private String message;
	private int totalFiles;
	private Object files;


	public ContenidoResponse(){}

	public ContenidoResponse(boolean result, String message) {
		super();
		this.result = result;
		this.message = message;
	}

	public ContenidoResponse(boolean result, String message, int totalFiles) {
		super();
		this.result = result;
		this.message = message;
		this.totalFiles = totalFiles;
	}
	
	public ContenidoResponse(boolean result, String message, int totalFiles, Object files) {
		super();
		this.result = result;
		this.message = message;
		this.totalFiles = totalFiles; 
		this.files = files;
	}
	
	public boolean isResult() {
		return result;
	}


	public void setResult(boolean result) {
		this.result = result;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}
	
	

	public int getTotalFiles() {
		return totalFiles;
	}

	public void setTotalFiles(int totalFiles) {
		this.totalFiles = totalFiles;
	}

	public Object getFiles() {
		return files;
	}

	public void setFiles(Object files) {
		this.files = files;
	}



	
	

}
