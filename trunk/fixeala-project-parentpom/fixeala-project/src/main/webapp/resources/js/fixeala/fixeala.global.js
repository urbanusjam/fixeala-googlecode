var fxlGlobalController = {
		
	loggedUser : null,
	
	tagList : null,
		
	initNavTooltip : function(){
		
		$('.navbar .nav > li > a').tooltip({
				placement: 'bottom'
		});
		
	},

	showAlert : function(message, alertType) {
	    $('#alert_placeholder').html('<div id="alertdiv" style="text-align:center;height:auto;padding: 15px;border:2px solid" class="alert ' 
	    		+  alertType + '"><a class="close" data-dismiss="alert">&times;</a><span>'+message+'</span></div>');

	    setTimeout(function() { 
	    }, 6000);
	},	
		
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
			  	url : fxlGlobalController.getDomainUrl() + "getLocalities",
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
	
	initFeedback : function(){
		
		$("#feedbackLink").click(function(){				
			$('#cbxAsuntoFeedback option:first-child').attr("selected", "selected");
			$('#msgFeedback').val('');				
			$("#mdl-feedback").modal('show');					
		});
		
		$("#btnSendFeedback").click(function(){
			fxlGlobalController.sendFeedback();
		});
		
		$('#msgFeedback').keyup(function(){
		      if($(this).val().length > 0){
		         $('#btnSendFeedback').prop('disabled',false);
		      }else{
		         $('#btnSendFeedback').prop('disabled',true);
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
		    url: fxlGlobalController.getDomainUrl() + "sendFeedback",
	 		data: "asunto=" + asunto + "&mensaje=" + mensaje + "&email=" + email,		 		
	 		beforeSend: function(){
	 			fxlGlobalController.blockPage("html");	 		
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
    			fxlGlobalController.unBlockPage("html");    			
            }
           
		});
		
	},
	
	blockPage : function(containerID) {
	  	
  		var loader = fxlGlobalController.getDomainUrl() + 'resources/images/loader.gif';
  	  
		$(containerID).block({
								message : '<h4>Procesando...<br><br><img src='+loader+ '/></h4>',
								overlayCSS : {
									backgroundColor : '#000',
									opacity : 0.3,
									cursor : 'wait'
								},
								css : {
									'-webkit-border-radius' : '5px',
									'-moz-border-radius' : '5px',
									padding : 20,
									margin : 0,
									width : '250px',
									textAlign : 'center',
									color : '#000',
									border : '0px solid #aaa',
									cursor : 'wait'
								}
							});
	},

	unBlockPage : function(containerID) {
			$(containerID).unblock();
	},
	
	getDomainUrl : function (){
		
		var protocol = window.location.protocol;
		var host = window.location.host;
		var context = "fixeala";
		var domainUrl = protocol + "//" + host + "/" + context + "/";
	 	return domainUrl;
	 	
	},
	
	clearForm : function(form) {
    	console.log('--- limpiando form ---');
  	  	// iterate over all of the inputs for the form
  	  	// element that was passed in
  	  	$(':input', form).each(function() {
	  	    var type = this.type;
	  	    var tag = this.tagName.toLowerCase(); // normalize case
	  	    // it's ok to reset the value attr of text inputs,
	  	    // password inputs, and textareas
	  	    if (type == 'text' || type == 'password' || tag == 'textarea')
	  	      this.value = "";
	  	    // checkboxes and radios need to have their checked state cleared
	  	    // but should *not* have their 'value' changed
	  	    else if (type == 'checkbox' || type == 'radio')
	  	      this.checked = false;
	  	    // select elements need to have their 'selectedIndex' property set to -1
	  	    // (this works for both single and multiple select elements)
	  	    else if (tag == 'select')
	  	      this.selectedIndex = -1;
  	  	});
    },
    
    cropText : function(value, limit){
		var cropped = '';
		if(value.length > limit){
			cropped = value.substr(0, limit) + '...';	
		}
        else {
        	cropped = value;	
        }	
        return cropped;
	}
		
};