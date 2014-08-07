package ar.com.urbanusjam.services.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.JRXmlExporter;
import net.sf.jasperreports.engine.export.JRXmlExporterParameter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;

import org.apache.commons.lang.CharEncoding;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.jasperreports.JasperReportsUtils;

import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
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
	public boolean generateDataset(ReportDTO report) throws Exception {	
		String fileFormat = "";
		boolean result = false;		
		
		try {
			
			fileFormat = report.getFileFormat();
			
			if(fileFormat.equals(FileFormat.PDF))					
				result = this.generatePDFReport(report);
			
			if(fileFormat.equals(FileFormat.XLS)){
				this.generateExcelReport(report);
				result = true;
			}					
				
			
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
		
		ClassPathResource resource = new ClassPathResource(pathJasperTemplate);
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
	
	private void generateExcelReport(ReportDTO report) throws Exception {

		try {	
			
		
			
			this.setCacheHeaders(report.getReponse());		
			
			
			FastReportBuilder dynamicReportBuilder = new FastReportBuilder();
			DynamicReport dynamicReport = dynamicReportBuilder.addColumn("ID"                   , "id"               , String.class.getName(), 30)
			        .addColumn("Titulo"             , "title"              , String.class.getName(), 30)
			        .addColumn("Direccion"       , "address" , String.class.getName(), 50)			    
			        .addColumn("Fecha y Hora"           , "fechaFormateada"    , String.class.getName()  , 60, true)
			        .addColumn("Estado"             , "status"              , String.class.getName() , 70, true)
			        .setPrintColumnNames(true)
			        .setIgnorePagination(true) //for Excel, we may dont want pagination, just a plain list
			        .setMargins(0, 0, 0, 0)
			        .setTitle("Listado de incidencias barriales de la República Argentina")
			        .setSubtitle("Este reporte fue generado el " + new Date())
			        .setUseFullPageWidth(true)
			        .setReportName("fixeala Excel")
	                //Esto sirve para cuando no hay registros a mostrar, que muestre los headers pero no verifique las propiedades de los beans
	                .setWhenNoDataShowNoDataSection() 
	                .build();
		
			
			  JRDataSource datasource = report.getBeans().isEmpty() ?  new JREmptyDataSource() : new JRBeanCollectionDataSource(report.getBeans());   
			  
			 JasperPrint jasperPrint = DynamicJasperHelper.generateJasperPrint(dynamicReport, new ClassicLayoutManager() , datasource, new HashMap<String, Object>());
			 
		        
		    exportToXLSX(jasperPrint);
			
		    
			
		}catch(Exception e){
			throw new Exception();
		} 
		
	}
	
	 private static void exportToXLSX(JasperPrint jasperPrint) throws JRException, FileNotFoundException {
	        JRXlsxExporter exporter = new JRXlsxExporter();

	        File outputFile = new File("/Users/cora/Downloads/fixeala_reporte.xls");
	        FileOutputStream fos = new FileOutputStream(outputFile);
	        
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, fos);
	        exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, CharEncoding.UTF_8);

	        //Excel specific parameter
	        exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, true);
	        exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
	        exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, false);
	        exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS, true);

//	        exporter.setParameter(JRXlsExporterParameter.SHEET_NAMES, ["Belka","Strelka"].toArray(new String[2]) );
	        exporter.exportReport();
	    }
	
	private String generateJaspeFilename(String fileFormat){		
		return "fixeala_dataset_" + DateUtils.generateTimestampDate() + "_" + DateUtils.generateTimestampTime() + "." + fileFormat;	 	
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
	
		
	public String generateOutputFilename(String fileFormat){			
		return pathJasperOutputFolder + "fixeala-dataset-" + DateUtils.generateTimestamp() + "." + fileFormat;
	}
	
	

	
	
}
