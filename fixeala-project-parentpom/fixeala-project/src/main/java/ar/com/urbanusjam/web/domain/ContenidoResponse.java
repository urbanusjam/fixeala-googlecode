package ar.com.urbanusjam.web.domain;

import java.util.List;

public class ContenidoResponse {

	private boolean result;
	private String message;
	private Object files;


	public ContenidoResponse(){}

	public ContenidoResponse(boolean result, String message) {
		super();
		this.result = result;
		this.message = message;
	}

	public ContenidoResponse(boolean result, String message, Object files) {
		super();
		this.result = result;
		this.message = message;
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

	public Object getFiles() {
		return files;
	}

	public void setFiles(Object files) {
		this.files = files;
	}



	
	

}
