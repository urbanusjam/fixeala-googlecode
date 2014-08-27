package ar.com.urbanusjam.web.controllers;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.web.domain.api.ReclamoListaResponse;
import ar.com.urbanusjam.web.domain.api.ReclamoResponse;
import ar.com.urbanusjam.web.services.transformer.IssueDTOTransformer;
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
	
	@RequestMapping(value = RestURIConstants.GET_RECLAMO, headers="Accept=application/json",  method = RequestMethod.GET)
	public @ResponseBody String getReclamo(@PathVariable("id") String reclamoID, Model model) throws JSONException {

//		JSONArray jsonArray = new JSONArray();
//		jsonArray.put(this.convertReclamoToJson(issueService.getIssueById(reclamoID)));
//		return jsonArray.toString();
		
		
		IssueDTO issue = issueService.getIssueById(reclamoID);
		
		ReclamoResponse response = new ReclamoResponse();
		
		if(issue == null){
			response.setSuccess(false);
			response.setStatus(HttpStatus.NOT_FOUND.value());
		}
		
		else{
			response.setSuccess(true);
			response.setStatus(HttpStatus.OK.value());
//			response.setData(new IssueDTOTransformer().transform(issue));
		}
		model.addAttribute(response);

		return "api/reclamos/" + reclamoID;
		
		
	}
	
	private LinkedHashMap<String, Comparable> convertReclamoToJson(IssueDTO reclamo) throws JSONException {
		
		Map<String, Comparable> obj = new LinkedHashMap<String, Comparable>(); //LinkedHashMap mantiene el orden de los campos; JSONObject no
		
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
		obj.put("votos", reclamo.getTotalVotes());
		obj.put("seguidores", reclamo.getTotalFollowers());
		obj.put("comentarios", reclamo.getComentarios().size());
		
		return (LinkedHashMap<String, Comparable>) obj;
		
	}
	
	private JSONArray convertReclamoToJsonArray(List<IssueDTO> reclamos) throws JSONException {		
		JSONArray jsonArray = new JSONArray();
		for(IssueDTO reclamo : reclamos){
			jsonArray.put(this.convertReclamoToJson(reclamo));			
		}		
		return jsonArray;		
	}

}
