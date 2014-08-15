var fxlGlobalController = {
		
	populateProvinceCombobox : function(provinces, pageType) {
			  
		  var $cbxProvince = $("#provincia");
		  var provinceList = $.parseJSON(provinces);
		
	      if(pageType != 'dataset'){
	    	  $cbxProvince.append($("<option />").val("none").text("SELECCIONE PROVINCIA"));
	      }
		  
		  $.each(provinceList, function(index, item) {
			  $cbxProvince.append($("<option />").val(item.text).text(item.text));
		  });
	},
		  
	populateLocalityOnChange : function(pageType) {			

		  var $cbxProvince = $("#provincia");
		  var $cbxLocality = $("#ciudad");
	      var selectedProv = $cbxProvince.find('option:selected').val();
	      
	      $cbxLocality.attr("disabled", true);
	      $cbxLocality.empty();	      
	      
	      if(pageType == 'dataset'){
	    	  $cbxLocality.append($("<option />").val("todas").text("TODAS"));
	      }	     
	     	      
	      if(selectedProv == 'BUENOS AIRES'){
	    	  $cbxLocality.append($("<option />").val("caba").text("CAPITAL FEDERAL"));
	      }     
		      
		  $.ajax({			
			  	url : getDomainUrl() + "getLocalities",
			  	data: "province=" + selectedProv,
			  	success: function(result) { 

        		  $.each(result, function(index, item) {
	        		  $cbxLocality.append($("<option />").val(item.text).text(item.text));
	        	  });	        	
	        	  	          	
			    },
			    complete: function(){
			        $cbxLocality.attr("disabled", false);
			    }
		  });			  
	},
	
	sendFeedback : function() {
		var asunto = $("#cbxAsuntoFeedback").find('option:selected').text();
		var email = $("#emailFeedback").val(); 
		var mensaje = $("#msgFeedback").val(); 
		
		$("#mdl-feedback").modal('hide');
		
		$.ajax({
			type: "POST",
		    url: getDomainUrl() + "sendFeedback",
	 		data: "asunto=" + asunto + "&mensaje=" + mensaje + "&email=" + email,		 		
	 		beforeSend: function(){
	 			blockPage("html");	 		
	 		},
	        success: function(result){		
	        	 
	        	if(result)
	        		bootbox.alert("El mensaje se ha enviado correctamente.");
		    	
		    	else
		    		bootbox.alert("No se ha podido enviar el mensaje. Intente m&aacute;s tarde.");
	        	
    		},
    		error: function(){
             	bootbox.alert("No se ha podido enviar el mensaje. Intente m&aacute;s tarde.");
            },
    		complete: function() {
    			unBlockPage("html");    			
            }
           
		});
		
	}
		
}