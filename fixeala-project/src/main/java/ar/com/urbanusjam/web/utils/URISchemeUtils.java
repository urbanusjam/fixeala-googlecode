package ar.com.urbanusjam.web.utils;

public class URISchemeUtils {
	
	public static final String CONN_PROTOCOL = "http";
	public static final String CONN_HOST = "localhost";
	public static final String CONN_PORT = "8080";
	public static final String CONN_CONTEXT = "fixeala";
	public static final String CONN_SUBCONTEXT_ISSUES = "issues";
	public static final String CONN_SUBCONTEXT_USERS = "users";
	public static final String CONN_RELATIVE_URL_ISSUES = CONN_PROTOCOL + "://" + CONN_HOST + ":" + CONN_PORT + "/" + CONN_CONTEXT + "/"+ CONN_SUBCONTEXT_ISSUES;
	public static final String CONN_RELATIVE_URL_USERS = CONN_PROTOCOL + "://" + CONN_HOST + ":" + CONN_PORT + "/" + CONN_CONTEXT + "/" + CONN_SUBCONTEXT_USERS;
	

}
