package ar.com.urbanusjam.services;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;

public interface ExportService {
	
	public void generatePDFReport(String reportName, 
			Map<String, ? extends Object> parametros, Object dataSource) throws IOException, JRException;

}
