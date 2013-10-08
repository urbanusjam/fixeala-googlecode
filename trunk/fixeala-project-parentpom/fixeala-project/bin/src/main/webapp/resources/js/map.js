 var map;
 var init_coord = new google.maps.LatLng(-34.599722, -58.381944);

 var provinces = ["Buenos Aires", "Catamarca", "Chaco", "Chubut", "Córdoba","Corrientes",
                       "Entre Ríos", "Formosa", "Jujuy", "La Pampa", "La Rioja", "Mendoza",
                       "Misiones", "Neuquén", "Río Negro", "Salta", "San Juan", "San Luis",
                       "Santa Cruz", "Santa Fe", "Santiago del Estero", "Tierra del Fuego", "Tucumán" 
                       ];

var initMarker;

$(document).ready(function(){
	
	
	 var geocoder;	 
		 
	 function initialize() {

        var mapOptions = {
          center: init_coord,
          zoom: 12,
          mapTypeId: google.maps.MapTypeId.ROADMAP,
          mapTypeControl: true    
        };
        
        map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);	 
        
        google.maps.event.addListenerOnce(map, 'bounds_changed', function() { 
        	
        	// Getting the boundaries of the map 
        	var bounds = map.getBounds(); 
        	
        	// Getting the corners of the map 
        	var southWest = bounds.getSouthWest(); 
        	var northEast = bounds.getNorthEast(); 
        	
        	// Calculating the distance from the top to the bottom of the map 
        	var latSpan = northEast.lat() - southWest.lat(); 
        	
        	// Calculating the distance from side to side 
        	var lngSpan = northEast.lng() - southWest.lng();         	
        	
        	// Creating a new MarkerManager object 
        	var mgr = new MarkerManager(map);
        	
        	// Creating an array that will store the markers 
        	var markers = [];
        	
        	/*
        	// Creating a loop 
        	for (var i = 0; i < 1000; i++) { 
        		
	        	// Creating a random position 
	        	var lat = southWest.lat() + latSpan * Math.random(); 
	        	var lng = southWest.lng() + lngSpan * Math.random(); 
	        	var latlng = new google.maps.LatLng(lat, lng); 
	        	
	        	// Creating a marker. Note that we don't add it to the map 
	        	var marker = new google.maps.Marker({ 
	        		position: latlng 
	        	}); 
	        	
	        	// Adding the marker to the markers array 
	        	markers.push(marker); 
        	
        	}*/
        	// Creating a MarkerClusterer object and adding the markers array to it
        	
        	//var markerclusterer = new MarkerClusterer(map, markers);
        	
        	/*
        	// Making sure the MarkerManager is properly loaded before we use it 
        	google.maps.event.addListener(mgr, 'loaded', function() { 
        		
	        	// Adding the markers to the MarkerManager 
	        	mgr.addMarkers(markers, 1); 
	        	
	        	// Adding the markers to the map
	        	mgr.refresh(); 
	        	
        	});*/
        	
        }); 
	
        google.maps.event.addListener(map, 'click', function(e) {	 
        	
        	if( $("#btnIssue").hasClass('active') ){
        		getAddress(e.latLng);
        	}
        
        });     
        
       // loadMarkers(map);
             
      }//initialize
	 	 	 	 
      google.maps.event.addDomListener(window, 'load', initialize); 
      
 });//document.ready
 

function loadMarkers(map){
	
	 $.ajax({
	        type: "GET",
	        url: "http://localhost:8080/fixeala/loadMapMarkers.html",
	        dataType: "json",  	        
	        success: function(data){        			 	    	        	
	        	
	        	var markerArray = data;
	        	var markers = [];
	        	var infowindow = null;
	        	
//	        	var iconDefault = 'resources/images/markers/blue_MarkerR.png';
//        		var iconHover = 'resources/images/markers/yellow_MarkerR.png';
	        	
	        	for (var i = 0; i < markerArray.length; i++) { 
	        		
	        		var latlng = new google.maps.LatLng(markerArray[i].latitude, markerArray[i].longitude);
	        			 
	        		var markerInfo = '<table border="0" cellpadding="0" cellspacing="0" width="380px" height="90px" style="background-color:white;font-family:Arial;font-size:12px">'
						 +'   <tr>'
						 +'	 	<td style="text-align:left; font:16px Arial;"><b><div style="color:BlueViolet;display:inline">'+markerArray[i].title+'</div><div style="color:#ccc;display:inline;"> &nbsp;&nbsp; <i class="icon-chevron-right"></i> &nbsp;&nbsp; </div><div style="color:orange;display:inline;">En tratamiento</div></b></td>'				
						 +'	 </tr>'	
						 +'  <tr style="font-size:11px">'
						 +'	 	<td style="text-align:left;color:grey">'+markerArray[i].formattedAddress+'</td>'				
						 +'	 </tr><tr><td>&nbsp;</td></tr>'	
						 +'   <tr style="font-size:12px">'
						 +'	 	<td style="text-align:justify;color:black">'+markerArray[i].description+'<a href="#" class="readMore"> (leer más)</a></td>'				
						 +'	 </tr>'	
						 +'   <tr style="height:3px">'
						 +'	 	<td>&nbsp;</td>'				
						 +'	 </tr>'			
						 +'	 <tr style="font-size:11px;padding-top:1px">'
						 +'		<td style="text-align:left;color:grey;border-top:1px solid grey">Posteado por: <a href="#" class="user">'+markerArray[i].user.username+'</a> &nbsp; | &nbsp; <a href="#" class="user">7 reclamos</a> <div style="margin:0;padding:0;float:right;clear;both;display:inline">'+ markerArray[i].date +'</div></td>'
						 +'	 </tr>'				
						 +'	 </table>';	
				 
	        	
	        		var marker = new google.maps.Marker({ 
	    	        	position: latlng,
	    	        	html: markerInfo,
	    	        	title: markerArray[i].title
	    	        }); 
	        		
	        		
	        		infowindow = new google.maps.InfoWindow();
	        	 
	        		 for (var i = 0; i < markers.length; i++) {
	        			 
	        			 var marker = markers[i];
	        			 
	        			 google.maps.event.addListener(marker, 'click', function () {
	        				 infowindow.setContent(this.html);
	        				 infowindow.open(map, this);
	        			
	        			 });
	        			 
//	        			 google.maps.event.addListener(marker, 'mouseover', function() { 
//	        				 marker.setIcon(iconHover);
//	        		      });
//	        			 
//	        			 google.maps.event.addListener(marker, 'mouseout', function() { 
//	        				 marker.setIcon(iconDefault);
//	        		      });
	        			 
	        		 }
			         
			       
			         
			         var markerclusterer = new MarkerClusterer(map, markers);
	        	}
	        	
	        	
	         }
	       
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

 
 function getCoordinates(address){	 
	
	 var city = $("#city").val();
	 var province = $("#province").val();				
	 var searchAddress = address + ", " + city + ", " + province;		
	 var fullAddress;
	
	 var neighborhood = $("#neighborhood").val();	 
	 var title = $("#title").val();
	 var desc = $("#description").val();
	 
	 var geocoder;
	 
	 if(!geocoder) { 
		 geocoder = new google.maps.Geocoder(); 
	}
	 
	 var geocoderRequest = { 
			 address: searchAddress,
			 country: "AR"
			
	 } 
	
	 geocoder.geocode(geocoderRequest, function(results, status) { 
		 		 
		 switch(status) {
	        case google.maps.GeocoderStatus.OK:
	        	
	        	var location_type = results[0].geometry.location_type;
	        	
	        	//check if it's a precise aproximation
	        	if(location_type == "RANGE_INTERPOLATED" || location_type == "APPROXIMATE"){
	        		   			 
					 var addr_street = "",
					 addr_number = "",
					 addr_neighborhood = "";
		             addr_city = "",
		             addr_province = "";
				 
		
					for (var i = 0; i < results[0].address_components.length; i++) {				
						
						var addr = results[0].address_components[i];	
											
						 if (addr.types[0] == ['route'])		                
							addr_street = addr.long_name;	                 
		                 
		                 else if (addr.types[0] == ['street_number']){
		                	 addr_number = addr.long_name;
		                 }
						
		                 else if (addr.types[0] == ['neighborhood']){										
								addr_neighborhood = neighborhood;
						 }
						
						 else if (addr.types[0] == ['locality']){						
								 addr_city = addr.long_name;
						 }
							                 
		                 else if (addr.types[0] == ['administrative_area_level_1']){	                	
		                		 addr_province = addr.long_name;	
		                 }
						 
					}    	
					
					if( (addr_neighborhood.length > 0) && (addr_city.length > 0) ) {			
						fullAddress = addr_street + " " + addr_number + ", " + addr_neighborhood + ", " + addr_city + ", " + addr_province;	
					}
					
					else if( (addr_neighborhood.length <= 0) && (addr_city.length <= 0) ) {
						fullAddress = addr_street + " " + addr_number + ", " + addr_province;	
					}	
					
					else if ( (addr_neighborhood.length <= 0) && (addr_city.length > 0) ) {		
						fullAddress = addr_street + " " + addr_number + ", " + addr_city + ", " + addr_province;
					}
					
				
				 	
				map.setCenter(results[0].geometry.location); 	
				
				 if(initMarker)
         			initMarker.setMap(null);
         		
         		initMarker = new google.maps.Marker({ 
         			 map: map,
         			 icon: "resources/images/markers/blue_MarkerI.png",
         			 draggable: false,
         			 position: results[0].geometry.location
         		}); 
				
				 
				 var html = '<table border="0" cellpadding="0" cellspacing="0" width="380px" height="90px" style="background-color:white;font-family:Arial;font-size:12px">'
					 +'   <tr>'
					 +'	 	<td style="text-align:left; font:16px Arial;"><b><div style="color:BlueViolet;display:inline">'+title+'</div><div style="color:#ccc;display:inline;"> &nbsp;&nbsp; <i class="icon-chevron-right"></i> &nbsp;&nbsp; </div><div style="color:orange;display:inline;">En tratamiento</div></b></td>'				
					 +'	 </tr>'	
					 +'  <tr style="font-size:11px">'
					 +'	 	<td style="text-align:left;color:grey">'+fullAddress+'</td>'				
					 +'	 </tr><tr><td>&nbsp;</td></tr>'	
					 +'   <tr style="font-size:12px">'
					 +'	 	<td style="text-align:justify;color:black">'+desc+'<a href="#" class="readMore"> (leer más)</a></td>'				
					 +'	 </tr>'	
					 +'   <tr style="height:3px">'
					 +'	 	<td>&nbsp;</td>'				
					 +'	 </tr>'			
					 +'	 <tr style="font-size:11px;padding-top:1px">'
					 +'		<td style="text-align:left;color:grey;border-top:1px solid grey">Posteado por: <a href="#" class="user">fulanito88</a> &nbsp; | &nbsp; <a href="#" class="user">7 reclamos</a> <div style="margin:0;padding:0;float:right;clear;both;display:inline">12/12/2011</div></td>'
					 +'	 </tr>'				
					 +'	 </table>';	

				 var infowindow;
		         google.maps.event.addListener(initMarker, 'click', function() {   
		      
		        	if (!infowindow) {
		        		infowindow = new google.maps.InfoWindow();    
		        		
		    		}
		        	        	
		        	infowindow.setContent(html);
		        	infowindow.open(map, initMarker); 
		        });
	        		
	        		
	        	}
	        	
	        	else{
	        		alert ("Not precise");
	        	}
	        					 
			
	        	
	        break;
	        case google.maps.GeocoderStatus.ZERO_RESULTS:
	        		 alert("No se encontraron resultados.");			
	        break;
	        default:
	          alert("Ocurrió un error al validar la dirección. Intente más tarde.");
	          
	     }//switch
		 
			 
	
		 
		
		 
		 
	
	 });
	
	 
 }
 
 function getAddress(latLng) {
	 
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
					
				
					$("#neighborhood").val(neighborhood);
					$("#city").val(city);
					$("#province").val(province);
					
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
            			 icon: "resources/images/markers/blue_MarkerI.png",
            			 draggable: true,
            			 position: results[0].geometry.location
            		}); 
            		
            		 google.maps.event.addListener(initMarker, 'click', function() {   
            		      
            	        	if (!infowindow) {
            	        		infowindow = new google.maps.InfoWindow();   
            	    		}	        
            	        	map.setCenter(results[0].geometry.location); 	
            	     });
            		 
            		
            		 
            		 google.maps.event.addListener(initMarker, 'dragend', function(e) {
            			
             	  		 getAddress(e.latLng);
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
 
 
 
 

