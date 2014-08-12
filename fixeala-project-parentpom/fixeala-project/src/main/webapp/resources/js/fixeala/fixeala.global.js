var fxlGlobalController = {
		
	populateProvinceCombobox : function(provinces, pageType) {
			  
		  var $cbxProvince = $("#provincia");
		  var provinceList = $.parseJSON(provinces);
		
	      if(pageType != 'dataset'){
	    	  $cbxProvince.append($("<option />").val("none").text("SELECCIONE  PROVINCIA"));
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
	}
		
}