package ar.com.urbanusjam.web.services.impl;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRCsvDataSource;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRCsvExporterParameter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.JRXmlExporter;
import net.sf.jasperreports.engine.export.JRXmlExporterParameter;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.CharEncoding;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.jasperreports.JasperReportsUtils;

import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.builders.ColumnBuilderException;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
import ar.com.urbanusjam.services.dto.ReportDTO;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.FileFormat;
import ar.com.urbanusjam.web.services.ExportService;
import ar.com.urbanusjam.web.services.export.dto.IssueExcelDTO;
import ar.com.urbanusjam.web.services.export.transformer.IssueDTOTransformer;

@Service
@Transactional
public class ExportServiceImpl implements ExportService {
	
	private static String REPORT_TITLE = "Listado de reclamos barriales de la República Argentina";
	private static String[] CAMPOS = { "Nro. de Reclamo", "Título", "Dirección", "Fecha y Hora", "Estado" };
		
	@Value("${path.jasper.template.pdf}") 	
	private String pathJasperTemplatePdf;
	
	@Value("${path.jasper.template.csv}") 	
	private String pathJasperTemplateCsv;
	
	
	public void setPathJasperTemplatePdf(String pathJasperTemplatePdf) {
		this.pathJasperTemplatePdf = pathJasperTemplatePdf;
	}

	public void setPathJasperTemplateCsv(String pathJasperTemplateCsv) {
		this.pathJasperTemplateCsv = pathJasperTemplateCsv;
	}


	@Override
	public void generateDataset(ReportDTO report) throws Exception {	
			
		@SuppressWarnings("unchecked")
		Collection<IssueExcelDTO> issuesDTO =  CollectionUtils.collect(report.getBeans(), new IssueDTOTransformer()); 
		
		String fileFormat = report.getFileFormat();
		
		//EXCEL
		if(fileFormat.equals(FileFormat.XLS)){		
			exportToExcel(report.getOutputStream(), issuesDTO);			
		}
				
		//PDF
		if(fileFormat.equals(FileFormat.PDF))
			exportToPDF(report.getOutputStream(), issuesDTO);
		
		//CSV
		if(fileFormat.equals(FileFormat.CSV)){		
			exportToCSV(report.getOutputStream(), issuesDTO);			
		}
				
		//XML
		if(fileFormat.equals(FileFormat.XML)){		
			exportToXML(report.getOutputStream(), issuesDTO);			
		}
				
	}
	

	private JasperPrint getPdfPrint(OutputStream outputStream, Collection<?> beans) throws IOException, JRException {	
		
		ClassPathResource resource = new ClassPathResource(pathJasperTemplatePdf);
		JasperReport report = JasperCompileManager.compileReport(resource.getInputStream());		
		JRDataSource dataSource;
		
		if (beans.size() == 0) {
		    dataSource = new JREmptyDataSource();
		}
		else {
		   dataSource = JasperReportsUtils.convertReportData(beans);
		}
		
		JasperPrint print = JasperFillManager.fillReport(report, new HashMap<String, Object>(), dataSource);
		return print;
	}

	 
	private JasperPrint getDynamicPrint(OutputStream outputStream, Collection<?> beans, String[] campos) throws IOException, JRException, ClassNotFoundException, ColumnBuilderException {
		
		FastReportBuilder drb = new FastReportBuilder();
		DynamicReport dr = null;	
		
		dr = drb.addColumn( "NRO. DE RECLAMO", "nroReclamo", String.class.getName(),  50)
				.addColumn(	"FECHA Y HORA"   , "fecha"     , String.class.getName(),  50  )
				.addColumn(	"RUBRO"          , "rubro"     , String.class.getName(),  50  )
				.addColumn(	"CATEGORIA"      , "categoria" , String.class.getName(),  100 )
				.addColumn(	"TITULO"         , "titulo"    , String.class.getName(),  100 )
				.addColumn(	"DIRECCION"      , "direccion" , String.class.getName(),  100 )		
				.addColumn(	"BARRIO"         , "barrio"    , String.class.getName(),  50  )		
				.addColumn(	"CIUDAD"         , "ciudad"    , String.class.getName(),  70  )		
				.addColumn(	"PROVINCIA"      , "provincia" , String.class.getName(),  70  )		
				.addColumn(	"LATITUD"        , "latitud"   , String.class.getName(),  50  )		
				.addColumn(	"LONGITUD"       , "longitud"  , String.class.getName(),  50  )		
				.addColumn(	"ESTADO"         , "estado"    , String.class.getName(),  50  )
		        .setPrintColumnNames(Boolean.TRUE)
		        .setIgnorePagination(Boolean.TRUE)
		        .setUseFullPageWidth(Boolean.TRUE)
		        .setMargins(0, 0, 0, 0)
//		        .setTitle(REPORT_TITLE)
		        .setSubtitle("Este reporte fue generado el día " + DateUtils.getFechaFormateada(new Date(), DateUtils.DATE_TIME_PATTERN_LONG))		        
		        .setReportName("Fixeala - Lista de reclamos barriales")
            //Esto sirve para cuando no hay registros a mostrar, que muestre los headers pero no verifique las propiedades de los beans
            .setWhenNoDataShowNoDataSection() 
            .build();
	        
		JRDataSource datasource = (beans.isEmpty() ?  new JREmptyDataSource() : new JRBeanCollectionDataSource(beans));   
		JasperPrint jasperPrint = DynamicJasperHelper.generateJasperPrint(dr, new ClassicLayoutManager(), datasource);			  
		
		return jasperPrint;
		
		/**
		for( String label : CAMPOS){			
					
			char[] propertyName = (label.toCharArray());
            propertyName[0] = Character.toUpperCase(propertyName[0]);
			
            try{
	            Object bean = beans.iterator().next();
	            String methodName = "get" + String.valueOf(propertyName);
	            Method method = bean.getClass().getMethod(methodName);
	            Class<?> clase = method.getReturnType();
	            	            
	        	Class<?> clazz = bean.getClass();

	 		   for(Field field : clazz.getDeclaredFields()) {
	 		       //you can also use .toGenericString() instead of .getName(). This will
	 		       //give you the type information as well.

	 			System.out.println(field.getName());
	 		   }			
	 		   
            } catch (SecurityException e) {
                Log.error("Error de seguridad al intengar usar reflection", e);
            } catch (NoSuchMethodException e) {
            	Log.error("No se encontro el metodo por reflection", e);
            }
            
		}
		**/
		
	}
	

	private void exportToPDF(OutputStream outputStream, Collection<?> beans) {
		
		try{
			
			JasperPrint print = this.getPdfPrint(outputStream, beans);	
			
			JRPdfExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);	
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
			exporter.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, CharEncoding.ISO_8859_1);
			exporter.exportReport();
			
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			
		
	}
	
	private void exportToExcel(OutputStream outputStream, Collection<?> beans) {

		try{
			
//			JasperPrint jasperPrint = this.getDynamicPrint(outputStream, beans, CAMPOS);
			
			
			ClassPathResource resource = new ClassPathResource(pathJasperTemplateCsv);
			JasperReport report = JasperCompileManager.compileReport(resource.getInputStream());	
			JasperPrint jasperPrint = JasperFillManager.fillReport(report,
					new HashMap<String, Object>(), new JRBeanCollectionDataSource(beans));
						
			JRXlsExporter exporter = new JRXlsExporter();	        
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
			exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, CharEncoding.ISO_8859_1);

			exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
			exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
//         	exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, true);
         	exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
         	exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS, true);
			
			exporter.exportReport();
        
//	    } catch (ColumnBuilderException e) {
//            e.printStackTrace();
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
        } catch (JRException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
        e.printStackTrace();
        }
    
	}
	
	private void exportToXML(OutputStream outputStream, Collection<?> beans) {
		
		try{
			
//			JasperPrint print = this.getPdfPrint(outputStream, beans);	
			ClassPathResource resource = new ClassPathResource(pathJasperTemplateCsv);
			JasperReport report = JasperCompileManager.compileReport(resource.getInputStream());	
			JasperPrint jasperPrint = JasperFillManager.fillReport(report,
					new HashMap<String, Object>(), new JRBeanCollectionDataSource(beans));
			
			JRXmlExporter exporter = new JRXmlExporter();
			exporter.setParameter(JRXmlExporterParameter.JASPER_PRINT, jasperPrint);	
			exporter.setParameter(JRXmlExporterParameter.OUTPUT_STREAM, outputStream);
			exporter.setParameter(JRXmlExporterParameter.CHARACTER_ENCODING, CharEncoding.ISO_8859_1);
			exporter.exportReport();
			
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			
		
	}
	
	private void exportToCSV(OutputStream outputStream, Collection<?> beans) {
		
		try{
		
			ClassPathResource resource = new ClassPathResource(pathJasperTemplateCsv);
			JasperReport report = JasperCompileManager.compileReport(resource.getInputStream());	
			JasperPrint jasperPrint = JasperFillManager.fillReport(report,
					new HashMap<String, Object>(), new JRBeanCollectionDataSource(beans));
			
//			JRCsvMetadataExporter csvExporter = JRCsvMetadataExporter();
			JRCsvExporter csvExporter = new JRCsvExporter();
			csvExporter.setParameter(JRCsvExporterParameter.FIELD_DELIMITER, ";");
			csvExporter.setParameter(JRCsvExporterParameter.JASPER_PRINT, jasperPrint);	
			csvExporter.setParameter(JRCsvExporterParameter.OUTPUT_STREAM, outputStream);
			csvExporter.setParameter(JRCsvExporterParameter.CHARACTER_ENCODING, CharEncoding.ISO_8859_1);
			csvExporter.exportReport();
			
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			
		
	}
	
	
}
