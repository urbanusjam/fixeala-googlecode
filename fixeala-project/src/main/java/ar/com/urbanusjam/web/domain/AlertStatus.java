package ar.com.urbanusjam.web.domain;

public class AlertStatus {
	
	private boolean result;
	private String message;
	private String pageRedirect;
	
	public AlertStatus(boolean result, String message) {
		super();
		this.result = result;
		this.message = message;	
	}
			
	public AlertStatus(boolean result, String message, String pageRedirect) {
		super();
		this.result = result;
		this.message = message;
		this.pageRedirect = pageRedirect;
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

	public String getPageRedirect() {
		return pageRedirect;
	}

	public void setPageRedirect(String pageRedirect) {
		this.pageRedirect = pageRedirect;
	}

	

}