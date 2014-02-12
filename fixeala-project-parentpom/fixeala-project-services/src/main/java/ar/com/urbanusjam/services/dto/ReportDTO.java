package ar.com.urbanusjam.services.dto;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public class ReportDTO {
	
	private String templateName;
	private String fileFormat;
	private List<?> beans;
	private Map<String, Object> parameters;
	private HttpServletResponse reponse;
	private OutputStream outputStream;	
	
	public ReportDTO(){}
	
	public ReportDTO(List<?> beans, Map<String, Object> parameters) {
		super();		
		this.beans = beans;
		this.parameters = parameters;
	}
	
	public ReportDTO(String templateName, List<?> beans) {
		super();
		this.templateName = templateName;
		this.beans = beans;
	}
	
	public ReportDTO(String templateName, Map<String, Object> parameters, List<?> beans) {
		this(templateName, beans);
		this.parameters = parameters;
	}
	
	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	
	public String getFileFormat() {
		return fileFormat;
	}

	public void setFileFormat(String fileFormat) {
		this.fileFormat = fileFormat;
	}

	public Map<String, Object> getParameters() {
		return parameters;
	}
	
	public void setParameters(Map<String, Object> parameters) {
		this.parameters = parameters;
	}
	
	public List<?> getBeans() {
		return beans;
	}
	
	public void setBeans(List<?> beans) {
		this.beans = beans;
	}

	public HttpServletResponse getReponse() {
		return reponse;
	}

	public void setReponse(HttpServletResponse reponse) {
		this.reponse = reponse;
	}

	public OutputStream getOutputStream() {
		return outputStream;
	}

	public void setOutputStream(OutputStream outputStream) {
		this.outputStream = outputStream;
	}

	
	
	
}