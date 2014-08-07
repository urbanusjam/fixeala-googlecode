package ar.com.urbanusjam.web.controllers;

import javax.servlet.http.HttpServletResponse;

import ar.com.urbanusjam.services.utils.DateUtils;

public class MainController {
	
	/** 
	 * Es necesario llamar a este metodo en todos los exportar que no pasen el HttpResponse al
	 * ExportarService, dado que por un bug del ie  si no se setean estos headers en el response, 
	 * se va a producir un error 
	 **/
	protected static void setExportCacheHeaders(HttpServletResponse response) {
		response.setHeader("Pragma", "private");
		response.setHeader("Cache-Control", "private, must-revalidate");
	}
	
	/**
     * 
     * Setea parametros en el response para devolver archivos Excel
     * 
     * @param response Response al cual setearle los parametros
     * @param excelFileName El nombre del archivo excel a devolver
     */
    protected static void setResponseParametersForExcelExport(HttpServletResponse response, String excelFileName) {
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=" + excelFileName);
        setExportCacheHeaders(response);
    }
    
    protected static void setResponseParametersForCsvExport(HttpServletResponse response, String csvFileName) {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=" + csvFileName);
        setExportCacheHeaders(response);
    }
    
    protected static void setResponseParametersForPdfExport(HttpServletResponse response, String pdfFileName) {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
        setExportCacheHeaders(response);
    }
    
    protected static void setResponseParametersForXmlExport(HttpServletResponse response, String xmlFileName) {
        response.setContentType("text/xml");
        response.setHeader("Content-Disposition", "attachment; filename=" + xmlFileName);
        setExportCacheHeaders(response);
    }
		
    protected static String generateOutputFilename(String fileFormat){			
		return "fixeala_reclamos_" + DateUtils.generateTimestamp(DateUtils.FORMAT_TIMESTAMP_DATE) + "." + fileFormat;
	}

}
