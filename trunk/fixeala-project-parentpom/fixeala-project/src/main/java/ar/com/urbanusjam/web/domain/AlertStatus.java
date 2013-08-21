package ar.com.urbanusjam.web.domain;

public class AlertStatus {
	
	private boolean result;
	private String message;
			
	public AlertStatus(boolean result, String message) {
		super();
		this.result = result;
		this.message = message;
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
	
	
	

}
