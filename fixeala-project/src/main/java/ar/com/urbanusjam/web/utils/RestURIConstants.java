package ar.com.urbanusjam.web.utils;

public class RestURIConstants {
	
	public static final String GET_ALL_RECLAMOS = "/reclamos";
	public static final String GET_RECLAMO = "/reclamos/{id}";
	public static final String GET_RECLAMO_HISTORY = "/reclamos/{id}/actualizaciones";
	public static final String GET_RECLAMO_REPAIR = "/reclamos/{id}/reparaciones";
	public static final String GET_RECLAMO_IMAGE = "/reclamos/{id}/imagenes";
	public static final String GET_RECLAMOS_BY_LOCATION = "/reclamos/?latitud={latitud}&longitud={longitud}&nroResultados={nroResultados}";

}
