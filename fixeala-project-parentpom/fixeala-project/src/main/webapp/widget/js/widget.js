var loader = '<div class="widgetLoader"><img src="http://localhost:8080/fixeala/widget/images/loader.gif"/></span>';	
var $widgetBody =  $('.widgetIssues');

function redirectIssueURL(issueID, issueTitle){
	var protocol = window.location.protocol;
	var host = window.location.host;
	var context = "fixeala";
	var subcontext = "issues/" + issueID;		
	var url = protocol + "//" + host + "/" + context + "/" + subcontext + ".html";
	window.open (url, issueTitle);
}
	
	
$('#refreshWidget').click(function() {	
	$.ajax({
	    url: "./refreshWidget.html",
 		type: "GET",		 		
 		dataType: "json",									 
        success: function(data){	        	
        	        	
          	$widgetBody.replaceWith(loader);
        	
        	if(data.result){
        		$widgetBody.load(location.href + " .widgetIssues > * ");	
 				setTimeout(function(){	 				
 					$('.widgetLoader').replaceWith($widgetBody);					 					 						      
 				}, 1000);
        	}	        	
        	else{
        		setTimeout(function(){		
        			$('.widgetLoader').hide();
        			$(".widgetError").text(data.message);
 					$(".widgetError").show();	 					
 				}, 1000);
        	}
        	
		}, // success 
		
		error: function(jqXHR, exception) {
			
			$widgetBody.replaceWith(loader);
			
			setTimeout(function(){	 	
				$(".widgetError").text("Ha ocurrido un error al intentar cargar los reclamos. Intente de nuevo.");
				$('.widgetLoader').hide();	
				$(".widgetError").show();	
			}, 1000);
			
        } // error
	});			  
});	
