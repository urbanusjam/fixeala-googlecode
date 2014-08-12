package ar.com.urbanusjam.web.controllers;

import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.web.services.export.dto.ReclamoResponse;
import ar.com.urbanusjam.web.services.export.dto.ReclamoListaResponse;
import ar.com.urbanusjam.web.services.export.transformer.IssueDTOTransformer;
import ar.com.urbanusjam.web.utils.RestURIConstants;

@Controller
@RequestMapping("/api")
public class RestAPIController {
	
	private static final Logger logger = LoggerFactory.getLogger(RestAPIController.class);
	
	@Autowired
	private IssueService issueService;
	
	@RequestMapping(value = RestURIConstants.GET_ALL_RECLAMOS, method = RequestMethod.GET)
	public String getAllReclamos(Model model) throws JSONException {	
		

//		return this.convertReclamoToJsonArray(issueService.loadAllIssues()).toString();
//		return issueService.loadAllIssues();
		Collection<ReclamoResponse> issuesDTO =  CollectionUtils.collect(issueService.loadAllIssues(), new IssueDTOTransformer()); 
		model.addAttribute(new ReclamoListaResponse(issuesDTO));
		return "api/reclamos";
		
	}
	
	@RequestMapping(value = RestURIConstants.GET_RECLAMO, method = RequestMethod.GET)
	public String getReclamo(@PathVariable("id") String reclamoID, Model model) throws JSONException {

//		JSONArray jsonArray = new JSONArray();
//		jsonArray.put(this.convertReclamoToJson(issueService.getIssueById(reclamoID)));
//		return jsonArray.toString();
		model.addAttribute(new IssueDTOTransformer().transform(issueService.getIssueById(reclamoID)));
		return "api/reclamos/" + reclamoID;
		
		
	}
	
	private LinkedHashMap convertReclamoToJson(IssueDTO reclamo) throws JSONException {
		
		Map obj = new LinkedHashMap(); //LinkedHashMap mantiene el orden de los campos; JSONObject no
		
		obj.put("id", reclamo.getId());
		obj.put("informante", reclamo.getUsername());
		obj.put("fecha", reclamo.getFechaFormateada());
		obj.put("direccion", reclamo.getAddress());
		obj.put("barrio", reclamo.getNeighborhood());
		obj.put("ciudad", reclamo.getCity());
		obj.put("provincia", reclamo.getProvince());
		obj.put("latitud", reclamo.getLatitude());
		obj.put("longitud", reclamo.getLongitude());
		obj.put("titulo", reclamo.getTitle());
		obj.put("descripcion", reclamo.getDescription());
		obj.put("estado", reclamo.getStatus());
		obj.put("votosTotales", reclamo.getTotalVotes());
		obj.put("seguidoresTotales", reclamo.getTotalFollowers());
		obj.put("comentariosTotales", reclamo.getComentarios().size());
		
		return (LinkedHashMap) obj;
		
	}
	
	private JSONArray convertReclamoToJsonArray(List<IssueDTO> reclamos) throws JSONException {		
		JSONArray jsonArray = new JSONArray();
		for(IssueDTO reclamo : reclamos){
			jsonArray.put(this.convertReclamoToJson(reclamo));			
		}		
		return jsonArray;		
	}

}
