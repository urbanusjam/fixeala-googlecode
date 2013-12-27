package ar.com.urbanusjam.services.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.CharEncoding;
import org.springframework.core.io.ClassPathResource;
import org.springframework.ui.jasperreports.JasperReportsUtils;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;
import ar.com.urbanusjam.services.ExportService;
import ar.com.urbanusjam.services.dto.ReportDTO;

public class ExportServiceImpl implements ExportService {
	

	@Override
	public boolean exportToPDF(ReportDTO reportDTO) throws IOException, JRException {

		try {					
			
			final JasperPrint print = this.getPrint(reportDTO);			
//			JasperExportManager.exportReportToPdfFile(print, "C:\\desarrollo\\issue.pdf");				
//			JasperViewer.viewReport(print, false);
			
			final JRPdfExporter  pdfExporter = new JRPdfExporter();
			pdfExporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			pdfExporter.setParameter(JRExporterParameter.OUTPUT_FILE, new File("C:\\desarrollo\\issue.pdf"));
			pdfExporter.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, CharEncoding.UTF_8);
			pdfExporter.exportReport();
			
			return true;
			
		}catch(Exception e){
			  
			    return false;
		} 
		
		
	}
	
		
	@Override
    public boolean exportToXLS(ReportDTO report) throws IOException, JRException {
		
		try {
			
			JasperPrint print = this.getPrint(report);
	        
	        JRXlsExporter exporterXLS = new JRXlsExporter();     
	        exporterXLS.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporterXLS.setParameter(JRExporterParameter.OUTPUT_FILE, new File("C:\\desarrollo\\issue.xls"));
	        exporterXLS.setParameter(JRExporterParameter.CHARACTER_ENCODING, CharEncoding.UTF_8);
	        exporterXLS.setParameter(JRExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE);
	        exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
	        exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
	        exporterXLS.setParameter(JRXlsExporterParameter.IS_IGNORE_CELL_BACKGROUND, Boolean.TRUE);
	        exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
	        exporterXLS.setParameter(JRXlsExporterParameter.IS_IGNORE_CELL_BORDER, Boolean.FALSE);
	    	
	        exporterXLS.exportReport();
	        
	        return true;
			
		}catch(Exception e){
			  
		    return false;
		} 
	        	             
        
    }
	
	
	private JasperPrint getPrint(ReportDTO reportDTO) throws IOException, JRException{
		
		ClassPathResource resource = new ClassPathResource("/reports/" + reportDTO.getReportName() + ".jrxml");
		JasperReport report = JasperCompileManager.compileReport(resource.getInputStream());
		
		JRDataSource dataSource;
		
		if (reportDTO.getBeans().size() == 0) {
		    dataSource = new JREmptyDataSource();
		}
		else {
		   dataSource = JasperReportsUtils.convertReportData(reportDTO.getBeans());
		}
		
		JasperPrint print = JasperFillManager.fillReport(report, reportDTO.getParameters(), dataSource);
		return print;
	}
	

	
}
