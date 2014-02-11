package ar.com.urbanusjam.services.dto;

import java.util.List;
import java.util.Map;

public class ReportDTO {
	
	private String templateName;
	private List<?> beans;
	private Map<String, Object> parameters;
	
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
	
}