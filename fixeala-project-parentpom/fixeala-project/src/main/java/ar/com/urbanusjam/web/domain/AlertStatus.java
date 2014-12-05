package ar.com.urbanusjam.web.domain;

public class AlertStatus {
	
	private boolean result;
	private String message;
	private String pageRedirect;
	private int records;
	
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
	
	public AlertStatus(boolean result, String message, int records) {
		super();
		this.result = result;
		this.message = message;	
		this.records = records;
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

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

}