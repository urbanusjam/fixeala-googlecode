package ar.com.urbanusjam.web.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;

import org.apache.commons.lang.StringUtils;
import org.jfree.util.Log;
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

import ar.com.urbanusjam.entity.utils.FileFormat;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueCriteriaSearch;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.ReportDTO;
import ar.com.urbanusjam.web.domain.api.ReclamoResponse;
import ar.com.urbanusjam.web.services.ExportService;


@Controller
@RequestMapping(value="/dataset")
public class DatasetController extends MainController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private ExportService exportService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String showDatasetPage(Model model, HttpServletRequest request, HttpServletResponse response) { 	
				
		try {				
			
				//provinces
				List<String> provinces = issueService.loadProvinces();
				JSONArray provArray = new JSONArray();
				String allProvinces = StringUtils.EMPTY;					
				
				for(String s : provinces){
					JSONObject obj = new JSONObject();					
					obj.put("text", s);
					provArray.put(obj);
				}		
				
				allProvinces = provArray.toString();
				model.addAttribute("provinceList", allProvinces.length() == 0 ? "[{}]" : allProvinces);
				
				//tags
				List<String> dbTags = issueService.getTagList();				
				JSONArray tagsArray = new JSONArray();
				String allTags = StringUtils.EMPTY;	
								
				for(String s : dbTags){
					JSONObject obj = new JSONObject();					
					obj.put("id", dbTags.indexOf(s));
					obj.put("text", s);
					tagsArray.put(obj);
				}				
				
				allTags = tagsArray.toString();		
				model.addAttribute("allTags", allTags.length() == 0 ? "[{}]" : allTags);
				
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "dataset";	 
	}
				
	@RequestMapping(value="/download", method = RequestMethod.GET)
	public @ResponseBody List<ReclamoResponse> exportDataset(@RequestParam("format") String fileFormat, 
			HttpServletRequest request, HttpServletResponse response) throws Exception { 
			
		List<IssueDTO> issues = new ArrayList<IssueDTO>();		
		
		try{
			issues = issueService.loadAllIssues();						
			buildReport(issues, fileFormat, response, request);	
			
		}catch (Exception e) {
	      	Log.error(e.getMessage());	       
	    }
		return null;
		
	}
	
	@RequestMapping(value="/export", method = RequestMethod.GET)
	public @ResponseBody void exportCustomDataset(@ModelAttribute("datasetForm") IssueCriteriaSearch search, 
			HttpServletRequest request, HttpServletResponse response) throws IOException, JRException { 
		
		List<IssueDTO> issues = new ArrayList<IssueDTO>();	
		
		try{			
			issues = issueService.findIssuesByCriteria(search);		
			buildReport(issues, search.getFormatoArchivo(), response, request);		
		
		}catch(Exception e){
			Log.error(e.getMessage());	    
		}
		
	}
	
	
	private void buildReport(List<IssueDTO> issues, String fileFormat,  HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		ReportDTO report = new ReportDTO();
		
		report.setBeans(issues);
		report.setFileFormat(fileFormat);	
		report.setParameters(new HashMap<String, Object>());
		report.setReponse(response);	
		report.setOutputStream(response.getOutputStream());		
		report.setInputStream(request.getInputStream());
		
		if(fileFormat.equals(FileFormat.XLS))
			setResponseParametersForExcelExport(response, generateOutputFilename(fileFormat));
		
		if(fileFormat.equals(FileFormat.CSV))
			setResponseParametersForCsvExport(response, generateOutputFilename(fileFormat));
		
		if(fileFormat.equals(FileFormat.XML))
			setResponseParametersForXmlExport(response, generateOutputFilename(fileFormat));
		
		if(fileFormat.equals(FileFormat.JSON))
			setResponseParametersForJsonExport(response, generateOutputFilename(fileFormat));
				
		exportService.exportDataset(report);
		
	}
	
}
