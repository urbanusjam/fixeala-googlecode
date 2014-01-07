package ar.com.urbanusjam.services.exceptions;

public class BusinessException extends RuntimeException {
	
	private static final long serialVersionUID = 1L;
	
	private final String codError;
	private Object[] arguments;
	
	public BusinessException(String errorCode) {
		super(errorCode);
		this.codError = errorCode;	
	}
	
	public BusinessException(String errorCode, Object[] arguments) {
		this(errorCode);
		this.arguments=arguments;
	}
	
	public String getCodError() {
		return codError;
	}
	
	public Object[] getArguments() {
		return arguments;
	}
	
	public String getErrorCode() {
		return codError;
	}
	
	public void setArguments(Object[] arguments){
	    this.arguments=arguments;
	}
	
}