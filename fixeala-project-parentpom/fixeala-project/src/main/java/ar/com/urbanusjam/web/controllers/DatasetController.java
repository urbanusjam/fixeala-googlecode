package ar.com.urbanusjam.web.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.ExportService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueCriteriaSearch;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.ReportDTO;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.FileFormat;
import ar.com.urbanusjam.web.domain.AlertStatus;

@Controller
public class DatasetController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private ExportService exportService;
	
	@RequestMapping(value="/dataset", method = RequestMethod.GET)
	public String showDatasetPage(Model model, HttpServletRequest request, HttpServletResponse response) { 	
				
		try {				
				String allTags = StringUtils.EMPTY;				
				JSONArray array = new JSONArray();
				
				List<String> dbTags = issueService.getTagList();
				
				for(String s : dbTags){
					JSONObject obj = new JSONObject();					
					obj.put("id", dbTags.indexOf(s));
					obj.put("text", s);
					array.put(obj);
				}
		
				allTags = array.toString();						
				model.addAttribute("allTags", allTags.length() == 0 ? "[{}]" : allTags);
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "dataset";	 
	}
	
	
	@RequestMapping(value="/exportDataset", method = RequestMethod.GET)
	public @ResponseBody AlertStatus exportDataset(@RequestParam("fileFormat") String fileFormat, 
			HttpServletRequest request, HttpServletResponse response) throws IOException, JRException { 
			
		boolean result = false;
		
		try{
			
			List<IssueDTO> issues = new ArrayList<IssueDTO>();		
			issues = issueService.loadAllIssues();
			
			if(issues.isEmpty()){
				return new AlertStatus(false, "No se encontraron resultados.");
			}
			
			else{
				result = generateDataset(issues, fileFormat, response);
				
//				if(!result)
//					return new AlertStatus(false, "Hubo un error al exportar el dataset.");
//				
//				else
//					return new AlertStatus(true, "Archivo generado correctamente.");
				
				return new AlertStatus(result, "Dataset");
			}
			
		}catch(Exception e){
			return new AlertStatus(false, "Hubo un error al exportar el dataset.");
		}	
		
	}
	
	@RequestMapping(value="/exportCustomDataset", method = RequestMethod.GET)
	public @ResponseBody AlertStatus exportCustomDataset(@ModelAttribute("datasetForm") IssueCriteriaSearch search, 
			HttpServletRequest request, HttpServletResponse response) throws IOException, JRException { 
		
		boolean result = false;
		
		try{
			
			List<IssueDTO> issues = new ArrayList<IssueDTO>();		
			issues = issueService.findIssuesByCriteria(search);	
			
			if(issues.isEmpty()){
				return new AlertStatus(false, "No se encontraron resultados.");
			}
					
			else{			
//				fileFormat = search.getFormatoArchivo();
//				fileName = generateJaspeFilename(fileFormat);
//				
//				if(fileFormat.equals(FileFormat.PDF))
//					response.setContentType("application/pdf");
//					
//				else if(fileFormat.equals(FileFormat.XLS))
//					response.setContentType("application/vnd.ms-excel");
//				
//				else if(fileFormat.equals(FileFormat.CSV))
//					response.setContentType("text/csv");
//				
//				else if(fileFormat.equals(FileFormat.XML))
//					response.setContentType("text/xml");
//				
//				response.setHeader("Content-Disposition", "attachment; filename=" + fileName);    
//	     					 
//				ReportDTO report = new ReportDTO();
//				report.setBeans(issues);
//				report.setFileFormat(fileFormat);
//				report.setParameters(new HashMap<String, Object>());
//				report.setReponse(response);
//				report.setOutputStream(response.getOutputStream());
//			
//				result = exportService.generateDataset(report);
				result = generateDataset(issues, search.getFormatoArchivo(), response);
				
//				if(!result)
//					return new AlertStatus(false, "Hubo un error al exportar el dataset.");
//				
//				else
					return new AlertStatus(result, "Dataset");
			}
			
		}catch(Exception e){
			return new AlertStatus(false, "Hubo un error al exportar el dataset.");
		}
	
	}
	
	private String generateJaspeFilename(String fileFormat){		
		return "fixeala_dataset_" + DateUtils.generateTimestampDate() + "_" + DateUtils.generateTimestampTime() + "." + fileFormat;	 	
	}
	
	private boolean generateDataset(List<IssueDTO> issues, String fileFormat,  HttpServletResponse response) throws IOException, JRException {
		
		String fileName = generateJaspeFilename(fileFormat);
		boolean result = false;
		
		if(fileFormat.equals(FileFormat.PDF))
			response.setContentType("application/pdf");
			
		else if(fileFormat.equals(FileFormat.XLS))
			response.setContentType("application/vnd.ms-excel");
		
		else if(fileFormat.equals(FileFormat.CSV))
			response.setContentType("text/csv");
		
		else if(fileFormat.equals(FileFormat.XML))
			response.setContentType("text/xml");
		
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName);    
 					 
		ReportDTO report = new ReportDTO();
		report.setBeans(issues);
		report.setFileFormat(fileFormat);
		report.setParameters(new HashMap<String, Object>());
		report.setReponse(response);	
	
		report.setOutputStream(response.getOutputStream());
		try {
			result = exportService.generateDataset(report);
		} catch (Exception e) {
			result = false;
		}			
		
		return result;
		
	}

}
