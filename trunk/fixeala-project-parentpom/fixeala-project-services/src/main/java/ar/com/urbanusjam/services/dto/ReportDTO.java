package ar.com.urbanusjam.services.dto;

import java.util.List;
import java.util.Map;

public class ReportDTO {

	private String reportName;
	private List<?> beans;
	private Map<String, Object> parameters;
	
	public ReportDTO(String reportName, List<?> beans) {
		super();
		this.reportName = reportName;
		this.beans = beans;
	}
	
	public ReportDTO(String reportName, Map<String, Object> parameters, List<?> beans) {
		this(reportName, beans);
		this.parameters = parameters;
	}
	
	public String getReportName() {
		return reportName;
	}
	
	public void setReportName(String reportName) {
		this.reportName = reportName;
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