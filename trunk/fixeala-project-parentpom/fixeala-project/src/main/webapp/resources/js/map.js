// Enable the visual refresh
google.maps.visualRefresh = true; 

var map;
var init_coord = new google.maps.LatLng(-34.599722, -58.381944);

var provinces = ["Buenos Aires", "Catamarca", "Chaco", "Chubut", "Córdoba","Corrientes",
                       "Entre Ríos", "Formosa", "Jujuy", "La Pampa", "La Rioja", "Mendoza",
                       "Misiones", "Neuquén", "Río Negro", "Salta", "San Juan", "San Luis",
                       "Santa Cruz", "Santa Fe", "Santiago del Estero", "Tierra del Fuego", "Tucumán" 
                       ];

var initMarker;
var markers = [];

var placeSearch, autocomplete;
var component_form = {

  'neighborhood': 'short_name',
  'locality': 'long_name',
  'administrative_area_level_1': 'long_name'
};

$(document).ready(function(){	
	
	 var geocoder;	 
		 
	 function initialize() {

        var mapOptions = {
          center: init_coord,
          zoom: 12,
          mapTypeId: google.maps.MapTypeId.ROADMAP,
          mapTypeControl: true,
          scrollwheel: false
        };
        
        map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
        
        // Layer
//        var kmlLayer = new google.maps.KmlLayer({
//            url: 'http://fixeala.googlecode.com/svn/trunk/fixeala-project-parentpom/fixeala-project/src/main/webapp/resources/data/barrios_caba.kml',
//            preserveViewport: true
//        });      
//          
//        kmlLayer.setMap(map);
//        
//        google.maps.event.addListener(kmlLayer, 'click', function(kmlEvent) {     
//        	showInContentWindow(kmlEvent.latLng, kmlEvent.featureData.description);
//        });
        
       
       

		//AUTOCOMPLETE
		var pac_input = document.getElementById('address');
		var options = {
				 		types: [ 'geocode' ],        		
				 		componentRestrictions: {country: "ar"}
				 	};
		
		// prevents enter key to submit form//	
		$('#address').keydown(function (e) {
		  if (e.which == 13 && $('.pac-container:visible').length) return false;
		});	
		// prevents enter key to submit form//

		// pick first item when list opens//	
		    if (!$('.pac-container').is(':visible')) {
		  $('#address').val($('.pac-container').find('.pac-item').eq(0).text());
		  
		  $('.pac-container').find('.pac-item').eq(0).addClass('.pac-item-selected');
		
		
		}      
		    
		    (function pacSelectFirst(input){
		        // store the original event binding function
		        var _addEventListener = (input.addEventListener) ? input.addEventListener : input.attachEvent;

		        function addEventListenerWrapper(type, listener) {
		        // Simulate a 'down arrow' keypress on hitting 'return' when no pac suggestion is selected,
		        // and then trigger the original listener.

		        if (type == "keydown") {
		          var orig_listener = listener;
		          listener = function (event) {
		            var suggestion_selected = $(".pac-item.pac-selected").length > 0;
		            if (event.which == 13 && !suggestion_selected) {
		              var simulated_downarrow = $.Event("keydown", {keyCode:40, which:40})
		              orig_listener.apply(input, [simulated_downarrow]);
		            }

		            orig_listener.apply(input, [event]);
		          };
		        }

		        // add the modified listener
		        _addEventListener.apply(input, [type, listener]);
		      }

		      if (input.addEventListener)
		        input.addEventListener = addEventListenerWrapper;
		      else if (input.attachEvent)
		        input.attachEvent = addEventListenerWrapper;

		    })(pac_input);
		    

	    autocomplete = new google.maps.places.Autocomplete(pac_input, options);
//	    $('#address').keypress(function(e) {
//	    	  if (e.which == 13) {
//	    		  $(".pac-container").show();
//	    	    return false;
//	    	  }
//	    	});
	 
	    
	    google.maps.event.addListener(autocomplete, 'place_changed', function(e) {	   
	    	fillInAddress();	
	    	var arr = [];
	    	arr = ($('#address').val()).split(",");
	    	setTimeout(function(){$('#address').val(arr[0]);},0);
	    });
	    
	   
		
        
            
        //SET MARKER COORDINATES ON MAP CLICK
        google.maps.event.addListener(map, 'click', function(e) {	 
        	
        	if( $("#btnIssue").hasClass('active') ){
        		getAddressOnMapClick(e.latLng);
        	}
        
        });     
	       
	    //DISPLAY MARKERS FROM DB
        loadMarkers(map);
      
	 }//initialize   
	 
	 
	 
	 
	 google.maps.event.addDomListener(window, 'load', initialize); 
	 
	 
	 
	
	 
      
 });//document.ready




//end AUTOCOMPLETE

function fillInAddress() {
    var place = autocomplete.getPlace();
   
    for (var component in component_form) {
      document.getElementById(component).value = "";
      document.getElementById(component).disabled = false;
    }
 
    var result = place.address_components;
    
    if(result == null){
      	alert("No se encontraron resultados");
        return false;        
    }
  
    // hay resultados
    else{
    	for (var j = 0; j < result.length; j++) {
    	      var att = result[j].types[0];
    	      if (component_form[att]) {
    	        var val = result[j][component_form[att]];
    	        document.getElementById(att).value = val;
    	       
    	        
    	      }    	    
    	}   
    	
    
    }
	
    
    
}
    
  function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var geolocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
        autocomplete.setBounds(new google.maps.LatLngBounds(geolocation, geolocation));
        
       
      });
    }
  }

function initializeMiniMap(lat, lng, titulo) {
	  
    var latlng = new google.maps.LatLng(lat, lng);
    
    var mapOptions = {
      center: latlng,
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControl: true,
      scrollwheel: false
    };    
        
    var miniMap = new google.maps.Map(document.getElementById("mini_map"), mapOptions);    

    marker = new google.maps.Marker({ 
		map: miniMap,
    	position: latlng,
    	title: titulo
    }); 	
}

function refreshMap(newLatLng){	
	 google.maps.event.addDomListener(window, 'resize', function() {
	        map.setCenter(newLatLng);
	});
}
 

function getIssueURL(issueID, issueTitle, type){
	var protocol = window.location.protocol;
	var host = window.location.host;
	var context = "fixeala";
	var subcontext = "issues/" + issueID;		
	var parsedTitle = issueTitle.replace(/\s/g, '-').toLowerCase();	
	var url = protocol + "//" + host + "/" + context + "/" + subcontext + "-" + parsedTitle + ".html";	
	
	if(type == 'link')
		return '<a href="'+ url +'">' + issueTitle + '</a>';		
	
	if(type == 'plain')
		return url;
}

function getUserURL(userID){
	var protocol = window.location.protocol;
	var host = window.location.host;
	var context = "fixeala";
	var subcontext = "users/" + userID;	
	var url = protocol + "//" + host + "/" + context + "/" + subcontext + ".html";	
	var urlLink = '<a style="cursor:pointer" id="issue-user" href="'+ url +'">' + userID + '</a>';	
	return urlLink;
}



/*** -------------- CARGA DE MARKERS EN EL MAPA -------------- ***/
/*** --------------------------------------------------------- ***/

function loadMarkers(map){
	
	 $.ajax({
	        type: "GET",
	        url: "./loadMapMarkers.html",
	        dataType: "json",  	        
	        success: function(data){        			 	    	        	
	        	
	        	var markerArray = data;	        
	        	var tempMarker;
	        	var infowindow;
	        	
//	        	var iconDefault = 'resources/images/markers/blue_MarkerR.png';
//        		var iconHover = 'resources/images/markers/yellow_MarkerR.png';
	        
	        	for (var i = 0; i < markerArray.length; i++) {         		
	        			        		
	        		var latlng = new google.maps.LatLng(markerArray[i].latitude, markerArray[i].longitude);
	        	
	        		var markerInfo = '<table border="0" cellpadding="0" cellspacing="0" width="380px" height="90px" style="background-color:white;font-family:Arial;">'
						 +'   <tr>'
						 +'	 	<td style="text-align:left; font-size:18px;"><b><div style="color:BlueViolet;display:inline">'+getIssueURL(markerArray[i].id, markerArray[i].title, 'link')+'</div><div style="color:#ccc;display:inline;"> &nbsp;&nbsp; <i class="icon-chevron-right"></i> &nbsp;&nbsp; </div><div style="color:orange;display:inline;">'+ markerArray[i].status +'</div></b></td>'				
						 +'	 </tr>'	
						 +'  <tr style="font-size:11px">'
						 +'	 	<td style="text-align:left;color:grey">'+markerArray[i].formattedAddress+'</td>'				
						 +'	 </tr><tr><td>&nbsp;</td></tr>'	
						 +'   <tr style="font-size:12px">'
						 +'	 	<td style="text-align:justify;color:black">'+markerArray[i].description+'<a href="#" class="readMore"> (leer m&aacute;s)</a></td>'				
						 +'	 </tr>'	
						 +'   <tr style="height:3px">'
						 +'	 	<td>&nbsp;</td>'				
						 +'	 </tr>'			
						 +'	 <tr style="font-size:11px;padding-top:1px">'
						 +'		<td style="text-align:left;color:grey;border-top:1px solid grey">Posteado por:'+getUserURL(markerArray[i].user.username)+' &nbsp; | &nbsp; <a href="#" class="user">7 reclamos</a> <div style="margin:0;padding:0;float:right;clear;both;display:inline">'+ markerArray[i].formattedDate +'</div></td>'
						 +'	 </tr>'				
						 +'	 </table>';					 
	        	
	        		tempMarker = new google.maps.Marker({ 
	        			map: map,
	    	        	position: latlng,	        	
	    	        	html: markerInfo,
	    	        	title: markerArray[i].title	    	        	
	    	        }); 	        		
	        		
	        		infowindow = new google.maps.InfoWindow();	        		
	        		markers.push(tempMarker);	        		
	        	}	        
	        	
	    		 for (var i = 0; i < markers.length; i++) {
	    			 
	    			 var marker = markers[i];
	    			 
	    			 google.maps.event.addListener(marker, 'click', function () {
	    				 infowindow.setContent(this.html);
	    				 infowindow.open(map, this);
	    			
	    			 });
	    			 
//        			 google.maps.event.addListener(marker, 'mouseover', function() { 
//        				 marker.setIcon(iconHover);
//        		      });
//        			 
//        			 google.maps.event.addListener(marker, 'mouseout', function() { 
//        				 marker.setIcon(iconDefault);
//        		      });
	    			 
	    		 }       
	    		 var clusterOptions = {gridSize:10, maxZoom: 15};
	        	 var markerclusterer = new MarkerClusterer(map, markers, clusterOptions);
	        }//success
	       
	    });
	
}
 


function findProvincia (value) {
	
	if (value=="BA") {
		map.setCenter(new google.maps.LatLng(-34.599722, -58.381944)); 
		map.setZoom(9);
	}
	
	else{
		
		if (value=="CF") {map.setCenter(new google.maps.LatLng(-34.599722, -58.381944))}	
		if (value=="CT") {map.setCenter(new google.maps.LatLng(-28.466667, -65.783333))}
		if (value=="CC") {map.setCenter(new google.maps.LatLng(-27.451389, -58.986667))}	
		if (value=="CH") {map.setCenter(new google.maps.LatLng(-43.3, -65.1))}
		if (value=="CD") {map.setCenter(new google.maps.LatLng(-31.428333, -64.193333))}
		if (value=="CR") {map.setCenter(new google.maps.LatLng(-27.483333333333, -58.816666666667))}
		if (value=="ER") {map.setCenter(new google.maps.LatLng(-31.744444, -60.5175))}
		if (value=="FO") {map.setCenter(new google.maps.LatLng(-26.183333, -58.175))}
		if (value=="FO") {map.setCenter(new google.maps.LatLng(-26.183333, -58.175))}	
		if (value=="JY") {map.setCenter(new google.maps.LatLng(-24.185556, -65.299444))}
		if (value=="LP") {map.setCenter(new google.maps.LatLng(-36.616667, -64.283333))}
		if (value=="LR") {map.setCenter(new google.maps.LatLng(-29.433333, -66.85))}	
		if (value=="MZ") {map.setCenter(new google.maps.LatLng(-32.890278, -68.847222))}
		if (value=="MN") {map.setCenter(new google.maps.LatLng(-27.366667, -55.896944))}	
		if (value=="NQ") {map.setCenter(new google.maps.LatLng(-38.951667, -68.074444))}
		if (value=="RN") {map.setCenter(new google.maps.LatLng(-40.8, -63))}	
		if (value=="SA") {map.setCenter(new google.maps.LatLng(-24.783333, -65.416667))}
		if (value=="SJ") {map.setCenter(new google.maps.LatLng(-31.5375, -68.536389))}
		if (value=="SL") {map.setCenter(new google.maps.LatLng(-33.3, -66.35))}	
		if (value=="SC") {map.setCenter(new google.maps.LatLng(-51.623056, -69.216111))}
		if (value=="SF") {map.setCenter(new google.maps.LatLng(-32.95, -60.65))}
		if (value=="SE") {map.setCenter(new google.maps.LatLng(-27.783333, -64.266667))}
		if (value=="TF") {map.setCenter(new google.maps.LatLng(-54.807222, -68.304444))}
		if (value=="TM") {map.setCenter(new google.maps.LatLng(-26.816667, -65.216667))}
			
		map.setZoom(12);
		
	}	
		
}



function validateAddress(){
	
	 var address = $("#address").val();
	 var neighborhood = $("#neighborhood").val();	 
	 var city = $("#locality").val();
	 var province = $("#administrative_area_level_1").val();	 
	 var title = $("#title").val();
	 var desc = $("#description").val();

	 var searchAddress = address + ", " + neighborhood + ", " + city + ", " + province;			
	 var geocoder;
	 
	 if(!geocoder) { 
		 geocoder = new google.maps.Geocoder(); 
	 }
	 
	 var geocoderRequest = { 
			 address: searchAddress,
			 country: "AR"			
	 } 
	
	 var isValid = false;
	 
	 geocoder.geocode(geocoderRequest, function(results, status) { 
		 
//		 alert(results[0].geometry.location_type);
		 
		 //OK
		 if (status == google.maps.GeocoderStatus.OK) {
		        	
		        	var location_type = results[0].geometry.location_type;
		        	
		        	if(location_type == "RANGE_INTERPOLATED" || location_type == "ROOFTOP"){
		        	
		        		 isValid = true;			        	
		        	}			        	
				        	
		        	if(location_type == "APPROXIMATE"){		        		
		        		bootbox.alert("No se hall&oacute; un resultado exacto. Espeficique mo&aacute;s datos, por favor.");	
		        		
		        	
		        	}
		        	
//		        	if(location_type == "GEOMETRIC_CENTER"){
//		        		if(hasAddressTypes(results))	
//		        			return true;	        		
//		        	}
		        		
		 }
		//ZERO RESULTS
		 if (status == google.maps.GeocoderStatus.ZERO_RESULTS) { 
		        		bootbox.alert("No se encontraron resultados para la direcci&oacute;n sumninistrada.");	

		   
		 }       
		 if ( (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) 
				 || (status == google.maps.GeocoderStatus.REQUEST_DENIED)
				 || (status == google.maps.GeocoderStatus.INVALID_REQUEST)
				 || (status == google.maps.GeocoderStatus.UNKNOWN_ERROR ) ){    		 

	        	bootbox.alert("Ocurri&oacute; un error al validar la direcci&oacute;n. Intente de nuevo.");
	        
	     
		 }
		
	 });//geocoder

	
} 

function hasAddressTypes(results) {	
	
	var types = 0;
	var sameField = 0;
	
//	var address = $("#address").val();
//	var neighborhood = $("#neighborhood").val();	 
//	var city = $("#locality").val();
//	var province = $("#administrative_area_level_1").val();	 
	
	for (var i = 0; i < results[0].address_components.length; i++) {				
		
		var addr = results[0].address_components[i];	
							
		 //calle
		 if (addr.types[0] == ['route'])		                
			 types++;      
         
		 //altura
         else if (addr.types[0] == ['street_number']){
        	 types++;    
         }
		
		 //barrio (opcional)
         else if (addr.types[0] == ['neighborhood']){										
        	 types++;   
        	
		 }
		
		 //ciudad - localidad
		 else if (addr.types[0] == ['locality']){						
			 types++;    
		 }
		
		 //provincia
         else if (addr.types[0] == ['administrative_area_level_1']){	                	
        	 types++;    
         }
		 
	}    
	
	if(types == 4 || types == 5){alert("campos completos!"); return true;}
	else{alert("faltan datos!"); return false;}
	//return false;	
}
 
 function listenMarker (marker, infowindow){
	  google.maps.event.addListener(marker, 'click', function() {         
           infowindow.open(map, marker);          
     });
}
 
 function getAddressOnMapClick(latLng) {
	 
	 var geocoder;
	 var infoWindow;

	if (!geocoder) {
		geocoder = new google.maps.Geocoder();
	}	

	var geocoderRequest = { 
			latLng: latLng
	} 
		
	geocoder.geocode(geocoderRequest, function(results, status) { 
		
		if (status == google.maps.GeocoderStatus.OK) {		
				
				var streetName = "";
				var streetNumber = "";
				var neighborhood = "";
				var city = "";
				var province = "";
								
				var fullAddress = results[0].formatted_address;
				
				if(!isArgentina(fullAddress)){
					alert("Se encuentra fuera de los límites de la República Argentina.");	  
				}	
				
				else{
					
					for (var i = 0; i < results[0].address_components.length; i++) { 

						var addr = results[0].address_components[i];							
						
		                 if (addr.types[0] == 'route')	                
		                	 streetName = addr.long_name;		               
		                 
		                 else if (addr.types[0] == 'street_number')
		                	 streetNumber = addr.long_name;		                 
		                 
		                 else if (addr.types[0] == 'neighborhood')
		                	 neighborhood = addr.long_name;
		                 
		                 else if (addr.types[0] == 'locality')
		                	 city = addr.long_name;
		                 
		                 else if (addr.types[0] == 'administrative_area_level_1')
		                     province = addr.long_name;		                 
		                  
					} 

					$("#route").val(streetName);
					$("#street_number").val(streetNumber);
					$("#neighborhood").val(neighborhood);
					$("#locality").val(city);
					$("#administrative_area_level_1").val(province);
					
					$("#latitude").val(latLng.lat());
					$("#longitude").val(latLng.lng());
			
					var formattedAddress;
					
                    if (results[0].formatted_address != null) {
                          formattedAddress = results[0].formatted_address;
                          $("#address").val(streetName + " " + streetNumber);
                    }
                                        
                    if(initMarker)
            			initMarker.setMap(null);
            		
            		initMarker = new google.maps.Marker({ 
            			 map: map,     
            			 icon: "resources/images/markers/blue_MarkerA.png",
            			 draggable: true,            			
            			 position: results[0].geometry.location
            		}); 
        		 
            		 google.maps.event.addListener(initMarker, 'dragend', function(e) {  
            			 getAddressOnMapClick(e.latLng);             	  	 
             	  	});  
				}
				
			
		} 
		else { 
			content += '<p>No address could be found. Status = ' + status + '</p>'; 
		} 


	}); 
	
	
	
	function isArgentina(fullAddress){
		
		var addressArray = fullAddress.split(",");
		var validCountry = false;
		
		for(var i = 0; i < addressArray.length; i++){			
			if($.trim(addressArray[i]) == "Argentina"){
				validCountry = true;					
			}		
		}
		
		return validCountry;	
	}
	
	
	
} 
 
