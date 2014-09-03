package ar.com.urbanusjam.web.controllers;

import java.util.List;

import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.entity.annotations.IssueRepair;
import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistoryDTO;
import ar.com.urbanusjam.web.utils.RestURIConstants;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("/api")
public class RestAPIController {
	
	private static final Logger logger = LoggerFactory.getLogger(RestAPIController.class);
	
	@Autowired
	private IssueService issueService;
	
	@RequestMapping(value = RestURIConstants.GET_ALL_RECLAMOS, headers="Accept=application/json", method = RequestMethod.GET)
	public @ResponseBody String getAllReclamos(Model model) throws JSONException {	

		JsonArray jsonArray = new JsonArray();
		JsonObject jsonObject;
		JsonObject errorObject;
		
		try{
			
			List<IssueDTO> issues = issueService.loadAllIssues();
//			issues =  new ArrayList<IssueDTO>();
			
			if(issues.size() > 0 && issues != null){
				for(IssueDTO issue : issues){
					jsonArray.add(this.convertReclamoToJson(issue));
				}
				
				jsonObject = new JsonObject();
			    jsonObject.addProperty("success", true);
			    jsonObject.addProperty("status", 200);
			    jsonObject.add("data", jsonArray);
			    
			}
			else{
				
				errorObject = new JsonObject();
				errorObject.addProperty("error", "El recurso solicitado no existe");
				errorObject.addProperty("request", "/reclamos.json");
				errorObject.addProperty("method", "GET");
				
				jsonObject = new JsonObject();
				jsonObject.addProperty("success", false);
			    jsonObject.addProperty("status", 404);			    
			    jsonObject.add("data", errorObject);
			}
			
		}
		
		catch(Exception e){
			
			errorObject = new JsonObject();
			errorObject.addProperty("error", "Se produjo un error inesperado");
			errorObject.addProperty("request", "/reclamos.json");
			errorObject.addProperty("method", "GET");
			
			jsonObject = new JsonObject();
		    jsonObject.addProperty("success", false);
		    jsonObject.addProperty("status", 500);
		    jsonObject.add("data", errorObject);
		}
		

		return jsonObject.toString();
		
	}
	
	@RequestMapping(value = RestURIConstants.GET_RECLAMO, headers="Accept=application/json",  method = RequestMethod.GET)
	public @ResponseBody String getReclamo(@PathVariable("id") String reclamoID, Model model) throws JSONException {
	
		JsonObject jsonObject;
		JsonObject errorObject;
		
		try{
			
			IssueDTO issue = issueService.getIssueById(reclamoID);
			
			if(issue != null){
				jsonObject = new JsonObject();
			    jsonObject.addProperty("success", true);
			    jsonObject.addProperty("status", 200);
			    jsonObject.add("data", this.convertReclamoToJson(issue));
			}
			else{
				errorObject = new JsonObject();
				errorObject.addProperty("error", "El recurso solicitado no existe");
				errorObject.addProperty("request", "/reclamos/"+reclamoID+".json");
				errorObject.addProperty("method", "GET");
				
				jsonObject = new JsonObject();
				jsonObject.addProperty("success", false);
			    jsonObject.addProperty("status", 404);			    
			    jsonObject.add("data", errorObject);
			}		
			
		}
		catch(Exception e){
			
			errorObject = new JsonObject();
			errorObject.addProperty("error", "Se produjo un error inesperado");
			errorObject.addProperty("request", "/reclamos/"+reclamoID+".json");
			errorObject.addProperty("method", "GET");
			
			jsonObject = new JsonObject();
		    jsonObject.addProperty("success", false);
		    jsonObject.addProperty("status", 500);
		    jsonObject.add("data", errorObject);
			
		}
		
		return jsonObject.toString();
		
	}
	
	@RequestMapping(value = RestURIConstants.GET_RECLAMO_HISTORY, headers="Accept=application/json",  method = RequestMethod.GET)
	public @ResponseBody String getReclamoUpdates(@PathVariable("id") String reclamoID, Model model) throws JSONException {
	
		JsonArray jsonArray = new JsonArray();
		JsonObject jsonObject;
		JsonObject errorObject;		
		
		try{
			
			List<IssueHistoryDTO> updates = issueService.getIssueById(reclamoID).getHistorial();
			
			if(updates.size() > 0 && updates != null){
				
				for(IssueHistoryDTO update : updates){
					jsonArray.add(this.convertActualizacionToJson(update));
				}
				
				jsonObject = new JsonObject();
			    jsonObject.addProperty("success", true);
			    jsonObject.addProperty("status", 200);
			    jsonObject.add("data", jsonArray);
			}
			else{
				errorObject = new JsonObject();
				errorObject.addProperty("error", "El recurso solicitado no existe");
				errorObject.addProperty("request", "/reclamos/"+reclamoID+"/actualizaciones.json");
				errorObject.addProperty("method", "GET");
				
				jsonObject = new JsonObject();
				jsonObject.addProperty("success", false);
			    jsonObject.addProperty("status", 404);			    
			    jsonObject.add("data", errorObject);
			}		
			
		}
		catch(Exception e){
			
			errorObject = new JsonObject();
			errorObject.addProperty("error", "Se produjo un error inesperado");
			errorObject.addProperty("request", "/reclamos/"+reclamoID+"/actualizaciones.json");
			errorObject.addProperty("method", "GET");
			
			jsonObject = new JsonObject();
		    jsonObject.addProperty("success", false);
		    jsonObject.addProperty("status", 500);
		    jsonObject.add("data", errorObject);
			
		}
		
		return jsonObject.toString();
		
	}
	
	@RequestMapping(value = RestURIConstants.GET_RECLAMO_REPAIR, headers="Accept=application/json",  method = RequestMethod.GET)
	public @ResponseBody String getReclamoReparacion(@PathVariable("id") String reclamoID, Model model) throws JSONException {
	
		JsonObject jsonObject;
		JsonObject errorObject;
		
		try{
			
			IssueRepair repair = issueService.getIssueById(reclamoID).getReparacion();
			
			if(repair != null){
				jsonObject = new JsonObject();
			    jsonObject.addProperty("success", true);
			    jsonObject.addProperty("status", 200);
			    jsonObject.add("data", this.convertReparacionToJson(repair));
			}
			else{
				errorObject = new JsonObject();
				errorObject.addProperty("error", "El recurso solicitado no existe");
				errorObject.addProperty("request", "/reclamos/"+reclamoID+"/reparaciones.json");
				errorObject.addProperty("method", "GET");
				
				jsonObject = new JsonObject();
				jsonObject.addProperty("success", false);
			    jsonObject.addProperty("status", 404);			    
			    jsonObject.add("data", errorObject);
			}		
			
		}
		catch(Exception e){
			
			errorObject = new JsonObject();
			errorObject.addProperty("error", "Se produjo un error inesperado");
			errorObject.addProperty("request", "/reclamos/"+reclamoID+"/reparaciones.json");
			errorObject.addProperty("method", "GET");
			
			jsonObject = new JsonObject();
		    jsonObject.addProperty("success", false);
		    jsonObject.addProperty("status", 500);
		    jsonObject.add("data", errorObject);
			
		}
		
		return jsonObject.toString();
		
	}
	
	@RequestMapping(value = RestURIConstants.GET_RECLAMO_IMAGE, headers="Accept=application/json",  method = RequestMethod.GET)
	public @ResponseBody String getReclamoImagenes(@PathVariable("id") String reclamoID, Model model) throws JSONException {
	
		JsonArray jsonArray = new JsonArray();
		JsonObject jsonObject;
		JsonObject errorObject;		
		
		try{
			
			List<MediaContent> files = issueService.getIssueById(reclamoID).getContenidos();
			
			if(files.size() > 0 && files != null){
				
				for(MediaContent file : files){
					jsonArray.add(this.convertImagenToJson(file));
				}
				
				jsonObject = new JsonObject();
			    jsonObject.addProperty("success", true);
			    jsonObject.addProperty("status", 200);
			    jsonObject.add("data", jsonArray);
			}
			else{
				errorObject = new JsonObject();
				errorObject.addProperty("error", "El recurso solicitado no existe");
				errorObject.addProperty("request", "/reclamos/"+reclamoID+"/imagenes.json");
				errorObject.addProperty("method", "GET");
				
				jsonObject = new JsonObject();
				jsonObject.addProperty("success", false);
			    jsonObject.addProperty("status", 404);			    
			    jsonObject.add("data", errorObject);
			}		
			
		}
		catch(Exception e){
			
			errorObject = new JsonObject();
			errorObject.addProperty("error", "Se produjo un error inesperado");
			errorObject.addProperty("request", "/reclamos/"+reclamoID+"/imagenes.json");
			errorObject.addProperty("method", "GET");
			
			jsonObject = new JsonObject();
		    jsonObject.addProperty("success", false);
		    jsonObject.addProperty("status", 500);
		    jsonObject.add("data", errorObject);
			
		}
		
		return jsonObject.toString();
		
	}
	
	

	//////////////////////////////////////////////////////////////////////
	
	
	
	private JsonElement convertReclamoToJson(IssueDTO reclamo) throws JSONException {
		
		JsonObject obj = new JsonObject(); //LinkedHashMap mantiene el orden de los campos; JSONObject no
		obj.addProperty("id", Integer.parseInt(reclamo.getId()));	
		obj.addProperty("fecha", reclamo.getFechaFormateada());
		obj.addProperty("informante", reclamo.getUsername());
		obj.addProperty("direccion", reclamo.getAddress());
		obj.addProperty("descripcion", reclamo.getDescription());
		obj.addProperty("barrio", reclamo.getNeighborhood());
		obj.addProperty("ciudad", reclamo.getCity());
		obj.addProperty("provincia", reclamo.getProvince());
		obj.addProperty("latitud", reclamo.getLatitude());
		obj.addProperty("longitud", reclamo.getLongitude());
		obj.addProperty("titulo", reclamo.getTitle());	
		obj.addProperty("estado", reclamo.getStatus());
		obj.addProperty("comentarios", reclamo.getComentarios().size());
		obj.addProperty("votos", reclamo.getTotalVotes());
		obj.addProperty("seguidores", reclamo.getTotalFollowers());
		obj.addProperty("link", "http://localhost:8081/fixeala/issues/" + reclamo.getId());

		return (JsonElement) obj;
		
	}
	
	private JsonElement convertActualizacionToJson(IssueHistoryDTO update) throws JSONException {
		
		JsonObject obj = new JsonObject(); //LinkedHashMap mantiene el orden de los campos; JSONObject no
		obj.addProperty("reclamo", update.getNroReclamo());	
		obj.addProperty("usuario", update.getUsername());	
		obj.addProperty("fecha", update.getFechaFormateada());	
		obj.addProperty("motivo", update.getMotivo());			
		obj.addProperty("estado", update.getEstado());	
		obj.addProperty("resolucion", update.getResolucion());	
		obj.addProperty("observaciones", update.getObservaciones());	

		return (JsonElement) obj;
		
	}
	
	private JsonElement convertReparacionToJson(IssueRepair reparacion) throws JSONException {
		
		JsonObject obj = new JsonObject(); //LinkedHashMap mantiene el orden de los campos; JSONObject no
		obj.addProperty("reclamo", reparacion.getId());	
		obj.addProperty("obra", reparacion.getObra());	
		obj.addProperty("nro_licitacion", reparacion.getNroLicitacion());	
		obj.addProperty("nro_expediente", reparacion.getNroExpediente());	
		obj.addProperty("plazo", reparacion.getPlazo());	
		obj.addProperty("unidad_ejecutora", reparacion.getUnidadEjecutora());	
		obj.addProperty("unidad_financiamiento", reparacion.getUnidadFinanciamiento());	
		obj.addProperty("contratista_nombre", reparacion.getContratistaNombre());	
		obj.addProperty("contratista_cuit", reparacion.getContratistaCuit());	
		obj.addProperty("tecnico_nombre", reparacion.getRepresentanteTecnicoNombre());	
		obj.addProperty("tecnico_matricula", reparacion.getRepresentanteTecnicoMatricula());	
		obj.addProperty("presupuesto_adjudicacion", reparacion.getPresupuestoAdjudicacion());	
		obj.addProperty("presupuesto_final", reparacion.getPresupuestoFinal());	
		obj.addProperty("fecha_estimada_inicio", reparacion.getFechaEstimadaInicio() != null ? reparacion.getFechaEstimadaInicio().toString() : null);	
		obj.addProperty("fecha_estimada_fin", reparacion.getFechaEstimadaFin() != null ? reparacion.getFechaEstimadaFin().toString() : null);	
		obj.addProperty("fecha_real_inicio", reparacion.getFechaRealInicio() != null ? reparacion.getFechaRealInicio().toString() : null);	
		obj.addProperty("fecha_real_inicio", reparacion.getFechaRealFin() != null ? reparacion.getFechaRealFin().toString() : null);	
		obj.addProperty("estado", reparacion.getEstadoObra());	
		obj.addProperty("observaciones", reparacion.getObservaciones());	

		return (JsonElement) obj;
		
	}
	
	private JsonElement convertImagenToJson(MediaContent archivo) throws JSONException {
		
		JsonObject obj = new JsonObject(); //LinkedHashMap mantiene el orden de los campos; JSONObject no
		obj.addProperty("id", archivo.getFileID());	
		obj.addProperty("reclamo", archivo.getIssueID());	
		obj.addProperty("tipo", archivo.getFileType());	
		obj.addProperty("nombre", archivo.getFilename());	
		obj.addProperty("orden", archivo.getFileID());	
		obj.addProperty("fecha", archivo.getUploadDate());	
		obj.addProperty("ancho", archivo.getWidth());	
		obj.addProperty("alto", archivo.getHeight());	
		obj.addProperty("tamano", archivo.getSize());	
		obj.addProperty("link", archivo.getLink());	
		
		return (JsonElement) obj;
		
	}
	
}
