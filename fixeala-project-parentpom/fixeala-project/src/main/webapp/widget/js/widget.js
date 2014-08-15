var loader = '<div class="widget-loader"><img src="http://localhost:8080/fixeala/widget/images/loader.gif"/></span>';	
var $widgetBody =  $('.widget-body');

function redirectIssueURL(issueID, issueTitle){
	var protocol = window.location.protocol;
	var host = window.location.host;
	var context = "fixeala";
	var subcontext = "issues/" + issueID;		
	var url = protocol + "//" + host + "/" + context + "/" + subcontext + ".html";
	window.open (url, issueTitle);
}
	
$('#refreshWidget').click(function() {	
	refreshWidget();
});	

function refreshWidget(){
	
	(function widgetTimer() {
		$.ajax({
		    url: "./refreshWidget.html",
	 		type: "GET",		 		
	 		dataType: "json",									 
	        success: function(data){	    
	        		
	          	$widgetBody.replaceWith(loader);
	        
	        	if(data.result){
	        		$widgetBody.load(location.href + " .widget-body > * ");	
	 				setTimeout(function(){	 				
	 					$('.widget-loader').replaceWith($widgetBody);					 					 						      
	 				}, 1000);
	        	}	        	
	        	else{
	        		setTimeout(function(){		
	        			$('.widget-loader').hide();
	        			$(".widget-error").text(data.message);
	 					$(".widget-error").show();	 					
	 				}, 1000);
	        	}
	        	
			}, // success 
			complete: function() {
			      // Schedule the next request when the current one's complete
			      setTimeout(widgetTimer, 900000); //15 min
			},
			error: function(jqXHR, exception) {
				
				$widgetBody.replaceWith(loader);
				
				setTimeout(function(){	 	
					$(".widget-error").text("Ha ocurrido un error al intentar cargar los reclamos. Intente de nuevo.");
					$('.widget-loader').hide();	
					$(".widget-error").show();	
				}, 1000);
				
	        } // error
		});		
	})();
}
