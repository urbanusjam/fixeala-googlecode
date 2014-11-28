package ar.com.urbanusjam.web.domain.api;

import org.codehaus.jackson.map.DeserializationConfig.Feature;
import org.codehaus.jackson.map.ObjectMapper;

public class CustomObjectMapper extends ObjectMapper {

	public CustomObjectMapper() {
	    super();
	
	    this.configure(Feature.UNWRAP_ROOT_VALUE, true);
	}


}
