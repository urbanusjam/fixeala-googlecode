package ar.com.urbanusjam.web.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DatasetAndWidgetController {
	
	@RequestMapping(value="/dataset", method = RequestMethod.GET)
	public String showDatasetPage() { 						
		return "dataset";	 
	}
	
	@RequestMapping(value="/widget", method = RequestMethod.GET)
	public String showWidgetPage() { 						
		return "widget";	 
	}

}
