package ar.com.urbanusjam.web.controllers;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.web.utils.RestURIConstants;

@Controller
@RequestMapping("/api")
public class RestAPIController {
	
	private static final Logger logger = LoggerFactory.getLogger(RestAPIController.class);
	
	@Autowired
	private IssueService issueService;
	
	@RequestMapping(value = "/reclamos", produces = "application/json", method = RequestMethod.GET)
	public @ResponseBody String getAllReclamos() throws JSONException {	
		logger.info("Llamando al servicio getAllReclamos()...");
		return this.convertReclamoToJsonArray(issueService.loadAllIssues()).toString();
	}
	
	@RequestMapping(value = RestURIConstants.GET_RECLAMO, produces = "application/json", method = RequestMethod.GET)
	public @ResponseBody String getReclamo(@PathVariable("id") String reclamoID) throws JSONException {
		logger.info("Llamando al servicio getReclamo("+reclamoID+")...");
		JSONArray jsonArray = new JSONArray();
		jsonArray.put(this.convertReclamoToJson(issueService.getIssueById(reclamoID)));
		return jsonArray.toString();
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
