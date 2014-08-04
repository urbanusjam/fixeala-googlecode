package ar.com.urbanusjam.services.impl;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.JRXmlExporter;
import net.sf.jasperreports.engine.export.JRXmlExporterParameter;

import org.apache.commons.lang.CharEncoding;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.jasperreports.JasperReportsUtils;

import ar.com.urbanusjam.services.ExportService;
import ar.com.urbanusjam.services.dto.ReportDTO;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.FileFormat;

@Service
@Transactional
public class ExportServiceImpl implements ExportService {
	
	@Value("${path.jasper.template}") 	
	private String pathJasperTemplate;
	
	@Value("${path.jasper.output.folder}") 	
	private String pathJasperOutputFolder;
	
	
	
	
	public void setPathJasperTemplate(String pathJasperTemplate) {
		this.pathJasperTemplate = pathJasperTemplate;
	}


	public void setPathJasperOutputFolder(String pathJasperOutputFolder) {
		this.pathJasperOutputFolder = pathJasperOutputFolder;
	}


	@Override
	public boolean generateDataset(ReportDTO report) {	
		String fileFormat = "";
		boolean result = false;		
		
		try {
			
			fileFormat = report.getFileFormat();
			
			if(fileFormat.equals(FileFormat.PDF))					
				result = this.generatePDFReport(report);
			
			if(fileFormat.equals(FileFormat.XLS))					
				result = this.generateXLSReport(report);
			
			if(fileFormat.equals(FileFormat.CSV))					
				result = this.generateCSVReport(report);
			
			if(fileFormat.equals(FileFormat.XML))					
				result = this.generateXMLReport(report);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
				
	}
	
	
	private JasperPrint generateJasperPrint(ReportDTO reportDTO) throws IOException, JRException {	
		
		ClassPathResource resource = new ClassPathResource(this.pathJasperTemplate);
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
	
	
	
	
	private boolean generatePDFReport(ReportDTO report) throws IOException, JRException {

		try {	
			
			this.setCacheHeaders(report.getReponse());			
			final JasperPrint print = this.generateJasperPrint(report);	
			final JRPdfExporter pdfExporter = new JRPdfExporter();
			pdfExporter.setParameter(JRExporterParameter.JASPER_PRINT, print);	
			pdfExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, report.getOutputStream());
			pdfExporter.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, CharEncoding.UTF_8);
			pdfExporter.exportReport();	
			return true;
			
		}catch(Exception e){
			return false;
		} 
		
	}
	
	private boolean generateXLSReport(ReportDTO report) throws IOException, JRException {

		try {	
			
			this.setCacheHeaders(report.getReponse());			
			JasperPrint print = this.generateJasperPrint(report);	        
	        JRXlsExporter exporterXLS = new JRXlsExporter();     
	        
	        exporterXLS.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporterXLS.setParameter(JRExporterParameter.OUTPUT_STREAM, report.getOutputStream());
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
	
	private boolean generateCSVReport(ReportDTO report) throws IOException, JRException {
		try {	
			
			this.setCacheHeaders(report.getReponse());			
			JasperPrint print = this.generateJasperPrint(report);	        
	        JRCsvExporter exporterCSV = new JRCsvExporter();     
	        
	        exporterCSV.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporterCSV.setParameter(JRExporterParameter.OUTPUT_STREAM, report.getOutputStream());
	        exporterCSV.setParameter(JRExporterParameter.CHARACTER_ENCODING, CharEncoding.UTF_8);
	        exporterCSV.setParameter(JRExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE);
	        exporterCSV.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
	        exporterCSV.exportReport();	
			return true;
			
		}catch(Exception e){
			return false;
		} 
		
	}
	
	private boolean generateXMLReport(ReportDTO report) throws IOException, JRException {
		try {	
			
			this.setCacheHeaders(report.getReponse());			
			JasperPrint print = this.generateJasperPrint(report);	        
	        JRXmlExporter exporterXML = new JRXmlExporter();     
	        
	        exporterXML.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporterXML.setParameter(JRExporterParameter.OUTPUT_STREAM, report.getOutputStream());
	        exporterXML.setParameter(JRExporterParameter.CHARACTER_ENCODING, CharEncoding.UTF_8);
	        exporterXML.setParameter(JRXmlExporterParameter.IS_EMBEDDING_IMAGES, Boolean.FALSE);
	        exporterXML.exportReport();	
			return true;
			
		}catch(Exception e){
			return false;
		} 
		
	}
	
	
	
	 /** Es necesario llamar a este metodo en todos los exportar, dado que por un bug del ie
		 * si no se setean estos headers en el response, se va a producir un error */
		public void setCacheHeaders(HttpServletResponse response) {
			response.setHeader("Pragma", "private");
			response.setHeader("Cache-Control", "private, must-revalidate");
		}
	
		
	private File generateJaspeFile(String fileFormat){
		File file = new File(this.pathJasperOutputFolder + "fixeala-dataset-" + DateUtils.generateTimestamp() + "." + fileFormat);	
		return file; 	
	}
	
	

	
	
}
