package ar.com.urbanusjam.services.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.CharEncoding;
import org.springframework.core.io.ClassPathResource;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.view.JasperViewer;
import ar.com.urbanusjam.services.ExportService;

public class ExportServiceImpl implements ExportService {

	@Override
	public void generatePDFReport(String reportName,
			Map<String, ? extends Object> parametros, Object dataSource)
			throws IOException, JRException {
		
		InputStream inputStream = null;
	
		try {
			
			
//			final String reportFile = String.format("C:\\desarrollo\\%s.jrxml", reportName);
//			inputStream = new ClassPathResource(reportFile).getInputStream();
			
			final JasperReport report = JasperCompileManager.compileReport("C:\\desarrollo\\issue.jrxml");
			
//			final JasperReport report = JasperCompileManager.compileReport(inputStream);
			
			final JRDataSource datasource = (JRDataSource) dataSource;

			final JasperPrint print = JasperFillManager.fillReport(report, parametros, datasource);
			
			 JasperExportManager.exportReportToPdfFile(print,
			          "C:\\desarrollo\\issue.pdf");
	
			
			JasperViewer.viewReport(print, false);
			
		}catch(Exception e){
			    int i = 0;
		} 
		
		
	}
	
	

	
}
