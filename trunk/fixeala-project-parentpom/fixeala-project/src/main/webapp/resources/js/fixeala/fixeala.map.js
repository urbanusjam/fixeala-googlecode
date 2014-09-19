var mapController = {
		
	mapMarkers: [],
	
	loadGoogleMap : function(){
		google.maps.event.addDomListener(window, 'load', mapController.initMap);  	 
	},
		
	initMap : function(){		
	   
	    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	    		 
	    mapController.displayMarkers(map);	  
	    mapController.initAutocomplete();
	    
	    google.maps.event.addListener(map, 'click', function(e) {	
	    	  mapController.setMarkerOnClick(map, e);
	    });
	    
	    $('#address').focusout(function(e) {
			 if(autocompleteCalls == 1){
				  if( $('#address').val() != "" ){
					   google.maps.event.trigger(autocomplete, 'place_changed');
				   }
			 }				 
		});
		
	},

	initMiniMap : function(lat, lng, titulo){
		
		var latlng = new google.maps.LatLng(lat, lng);
		var miniMap = new google.maps.Map(document.getElementById("mini_map"), mapOptions); 
		miniMap.setCenter(latlng);
		
	    var marker = new google.maps.Marker({ 
			map: miniMap,
	    	position: latlng,
	    	title: titulo
	    }); 	
	    	    
	    var infowindow = new google.maps.InfoWindow();	
	    var html = '<p>'+titulo+'</p>';
	    infowindow.setContent(html);
	    
	    google.maps.event.addListener(marker, 'click', function () {	    
			infowindow.open(miniMap, marker);			    			
		});
	    
	},
	
	refreshMap : function(map, newLocation){	
		google.maps.event.addDomListener(window, 'resize', function() {
			map.setCenter(newLocation);
		});
	},
	
	addListenerToMarker : function  (marker, infowindow){
		google.maps.event.addListener(marker, 'click', function() {         
	    	infowindow.open(map, marker);          
	    });
	},
	
	displayMarkers : function(map){
		
		var markers = [];
		
		$.ajax({
		        type: "GET",
		        url: "./loadMapMarkers.html",
		        dataType: "json",  	        
		        success: function(data){     
		        	
		        	var markerArray = data;
		        	
		        	var tempMarker;
		        	var infowindow;
		        	var textLimit = 500;	
		        	
		        	for (var i = 0; i < markerArray.length; i++) {         		
		        			        		
		        		var latlng = new google.maps.LatLng(markerArray[i].latitude, markerArray[i].longitude);
		        		var description = markerArray[i].description;
		        		var shortDescription = description.substr(0, textLimit);
		       
		        		var markerInfo = '<table border="0" cellpadding="0" cellspacing="0" width="380px" height="90px" style="background-color:white;font-family:Arial;">'
							 +'   <tr>'
							 +'	 	<td style="text-align:left;"><b><div style="color:#000;display:inline">'+mapController.getIssueURL(markerArray[i].id, markerArray[i].title, 'link')+'</div>' 
							 +'                                     <div style="color:#ccc;display:inline;"> &nbsp;&nbsp; <i class="icon-chevron-right"></i> &nbsp;&nbsp; </div>'  
							 +'										<span style="background:'+markerArray[i].statusCss+'" class="label">'+ markerArray[i].status +'</span></b></td>'				           
							 +'	 </tr>'	
							 +'  <tr style="font-size:11px">'
							 +'	 	<td style="text-align:left;color:grey">'+markerArray[i].address+'</td>'				
							 +'	 </tr><tr><td>&nbsp;</td></tr>'	
							 +'   <tr style="font-size:12px">'
							 +'	 	<td style="text-align:justify;color:black">'+shortDescription+' ...</td>'				
							 +'	 </tr>'	
							 +'   <tr style="height:3px">'
							 +'	 	<td>&nbsp;</td>'				
							 +'	 </tr>'			
							 +'	 <tr style="font-size:11px;padding-top:1px">'
							 +'		<td style="text-align:left;color:grey;border-top:1px solid grey">Reportado por: '+mapController.getUserURL(markerArray[i].user)+' &nbsp; <div style="margin:0;padding:0;float:right;clear:both;display:inline">'+ markerArray[i].date +'</div></td>'
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
		        		this.mapMarkers = markers;
		        	}	        
		        	
		    		for (var i = 0; i < markers.length; i++) {
		    			 
		    			var marker = markers[i];
		    			 
		    			google.maps.event.addListener(marker, 'click', function () {
		    				infowindow.setContent(this.html);
		    				infowindow.open(map, this);			    			
		    			});
		    			 
		    		}
		    		
		    		var clusterOptions = { gridSize:10, maxZoom: 15 };
		        	var markerclusterer = new MarkerClusterer(map, markers, clusterOptions);
		        }      
		  });
		
	},
	
	setMarkerOnClick : function(map, e){
	
		//open form
    	if(isFormOpen){	    		
    		mapTimesClicked++;

 		   if ( mapTimesClicked >= 2 ) {
 			   e.stopPropagation();
 			   e.preventDefault();			
 		   }
 		   else{
 			   mapTimesClicked = 0;	
 	    		if(!isAnimating){ 	       	   	 
 	            	if($("#tab1").hasClass("active")){
 	            		mapController.blockIssueForm(); 	            	
 	            		if( $("#btnIssue").hasClass('active') ){ 	
 	            			setTimeout(function(){   
 	            				mapController.geocodeAddressOnClick(e.latLng); 	            				
 	            				mapController.enableNexButton();		
 	            				mapController.unBlockIssueForm();
 	            			}, 1500);		
 	            		}    
 	            	}
 	            	else{
 	            		bootbox.alert("Para cambiar las coordenadas debe volver al Paso 1 (UBICACI&Oacute;N).");
 	            	}
 	    		}
 		   }//else    		
    	}	
	},
	
	initAutocomplete : function(){
		
		var pac_input = document.getElementById('address');
		var options = {
			types: [ 'geocode' ],        		
			componentRestrictions: {country: "ar"}
		};
			
		// prevents enter key to submit form//	
		$('#address').keydown(function (e) {
		  if (e.which == 13 && $('.pac-container:visible').length) return false;
		});		
		
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
		        			var simulated_downarrow = $.Event("blur", {keyCode:40, which:40})
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
	      
	    google.maps.event.addListener(autocomplete, 'place_changed', function(e) {	
	    	autocompleteCalls++;
	   		var addressArray = [];	   		
	   		addressArray = ($('#address').val()).split(",");   	   	
	   		setTimeout(function(){ 
	   			$('#address').val(addressArray[0]); 
	   		}, 0);
	   		mapController.fillInAddress();	   		
	    });
	    
	   autocompleteCalls = 0;
		
	},	
	
	fillInAddress : function(){

		this.blockIssueForm();
		
	    var place = autocomplete.getPlace();
	    
	    if (!place || !place.geometry || !mapController.hasAddressTypes(place)) {  
	    	alert("aca");
	    	setTimeout(function(){    	
	    		mapController.unBlockIssueForm();	    	
	    		bootbox.alert("La direcci&oacute;n proporcionada no es v&aacute;lida o carece de precisi&oacute;n.", function() {    		
	    			mapController.disableNexButton();
	    		});    		
	    	}, 1500);  
	    }   
		
		else{
			
			var result = place.address_components;
		    
		    $("#latitude").val(place.geometry.location.lat());
			$("#longitude").val(place.geometry.location.lng());
			
			if(place.geometry.viewport) {
				map.fitBounds(place.geometry.viewport);
			} 
			else{
				map.setCenter(place.geometry.location);
			    map.setZoom(17);  
			}
			 
			var infowindow = new google.maps.InfoWindow();
			 
			if(initMarker){
				initMarker.setMap(null);
			}      	
			 
			//global var
			initMarker = new google.maps.Marker({
				map: map,
			    icon: "resources/images/markers/blue_MarkerA.png",
			    draggable: true
			});
			
			initMarker.setPosition(place.geometry.location);
			initMarker.setVisible(true);
		
			//split components to fill form inputs
	    	for (var i = 0; i < place.address_components.length; i++) {    		
	    		var addressType = place.address_components[i].types[0];    	   
	    	    
	    		if(componentForm[addressType]) {
	    			var val = place.address_components[i][componentForm[addressType]];
	    	    	
	    	    	if(addressType == 'administrative_area_level_1' && val == 'Ciudad Autónoma de Buenos Aires')
	    	    		  val = 'Buenos Aires';
	    	    	else if(addressType == 'locality' && val == 'Buenos Aires')
	    	    		  val = 'Ciudad Autónoma de Buenos Aires';
	    	        
	    	    	$("#" + addressType).val(val);      	    
	    	    }    	    
	    	}  
	    	 	 
	    	//info window content
	    	var addressInfo = '';
	    	
	        if (place.address_components) {
	        	addressInfo = [
	              (place.address_components[0] && place.address_components[2].short_name || ''),
	              (place.address_components[1] && place.address_components[3].short_name || ''),
	              (place.address_components[2] && place.address_components[4].short_name || '')
	            ].join(', ');
	        }    	
	    	
	        infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + addressInfo);
	        infowindow.open(map, initMarker);
	        
	        mapController.addListenerToMarker(initMarker, infowindow);
	    	 
	    	setTimeout(function(){    	
	    		mapController.unBlockIssueForm();	    	
	    		mapController.enableNexButton();		  		
	     	}, 800);				
		}
	    
	},

	hasAddressTypes : function(result) {	
		
		var types = 0;
		var sameField = 0;
			
		for (var i = 0; i < result.address_components.length; i++) {				
			
			var addr = result.address_components[i];	
								
			 //calle
			 if (addr.types[0] == ['route'])		                
				 types++;      
	         
			 //altura
	         else if (addr.types[0] == ['street_number']){
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
		
		if(types == 4) 
			return true;
		
		else 
			return false;
	},
	
	geocodeAddress : function(callback){
		
		var geocoder;
		var address = $("#address").val();
		var neighborhood = $("#neighborhood").val();	 
		var city = $("#locality").val();
		var province = $("#administrative_area_level_1").val();	 
		var title = $("#title").val();
		var desc = $("#description").val();
		var searchAddress = address + "," + neighborhood + "," + city + "," + province;		
				 
		if(!geocoder) { 
			geocoder = new google.maps.Geocoder(); 
		}
		 
		var geocoderRequest = { 
			address: searchAddress,
			country: "AR"			
		} 
		 
		geocoder.geocode(geocoderRequest, function(results, status) { 
		
			//OK
			if (status == google.maps.GeocoderStatus.OK) {
				        	
				var locationType = results[0].geometry.location_type;
				var latLng = results[0].geometry.location;		
				
		       	address = results[0].geometry;
			            	
			    $("#latitude").val(latLng.lat());
				$("#longitude").val(latLng.lng());
	
			}
			
		});	
		
	},
	
	geocodeAddressOnClick : function(location){
		
		var geocoder;
		var infoWindow;

		if (!geocoder) {
			geocoder = new google.maps.Geocoder();
		}	

		var geocoderRequest = { 
				latLng: location
		} 
			
		geocoder.geocode(geocoderRequest, function(results, status) { 
			
			if (status == google.maps.GeocoderStatus.OK) {		
					
				var streetName = "";
				var streetNumber = "";
				var neighborhood = "";
				var city = "";
				var province = "";
								
				var fullAddress = results[0].formatted_address;
				
				if(!mapController.isArgentina(fullAddress)){
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
		                 
		                 else if (addr.types[0] == 'administrative_area_level_1'){
		                	 province = addr.long_name;		
		                	
		                 }	 
					} 						
				}
						
						
				if(province == "Ciudad Autónoma de Buenos Aires" && city == "Buenos Aires"){
					province = "Buenos Aires";
					city = "Ciudad Autónoma de Buenos Aires";
				}

				$("#neighborhood").val(neighborhood);
				$("#locality").val(city);
				$("#administrative_area_level_1").val(province);
				
				$("#latitude").val(location.lat());
				$("#longitude").val(location.lng());
					
				var formattedAddress;
				
               if (results[0].formatted_address != null) {
                     formattedAddress = results[0].formatted_address;
                     $("#address").val(streetName + " " + streetNumber);
               }
	                   
	           map.setCenter(results[0].geometry.location);
	           map.setZoom(17); 
	                                       
               if(initMarker)
            	   initMarker.setMap(null);
       		
           		initMarker = new google.maps.Marker({ 
           			 map: map,     
           			 icon: "resources/images/markers/blue_MarkerA.png",
           			 draggable: true,            			
           			 position: results[0].geometry.location
           		}); 
	           		
	           	var address = '';
	           	
	            if (results[0].address_components) {
	                address = [
	                  (results[0].address_components[0] && results[0].address_components[2].short_name || ''),
	                  (results[0].address_components[1] && results[0].address_components[3].short_name || ''),
	                  (results[0].address_components[2] && results[0].address_components[4].short_name || '')
	                ].join(', ');
	            }    
	            
	            var infowindow = new google.maps.InfoWindow();
	        	
	            infowindow.setContent('<div><strong>' + streetName + " " + streetNumber + '</strong><br>' + address);
	        	infowindow.open(map, initMarker);   
	        	
	        	mapController.addListenerToMarker(initMarker, infowindow);
	        	
	       		google.maps.event.addListener(initMarker, 'dragend', function(e) {
	       			mapController.blockIssueForm();	       			
	       			setTimeout(function(){    			
	       				mapController.getAddressOnMapClick(e.latLng); 
	       				mapController.enableNexButton();		
	       				mapController.unBlockIssueForm();
	       			 }, 1500);		
	       		}); 	           		  
				
			}else {
				bootbox.alert("Geocode was not successful for the following reason: " + status);
			}		
		}); 
		
	},
	
	getClosestMarkersByIssue : function(location){
		
		var markers, closestMarkers = [] ; 
		var maxDistance = 3.00; //km

		 $.ajax({
		        type: "GET",
		        url: "./loadMapMarkers",
		        dataType: "json",  	        
		        success: function(data){  
		        	
				    markers = data;
				    var centerPosition = new google.maps.LatLng(location.latitude, location.longitude);

					$.each(markers, function(i, marker) {
				    	
				       marker.position = new google.maps.LatLng(marker.latitude, marker.longitude);	
				       marker.distance = mapController.calculateDistanceKM(marker.position, centerPosition); 
				       
				       //chequeo que no se incluya el reclamo que se esta comparando
				       if(marker.position.lat() != centerPosition.lat()
				    		   && marker.position.lng() != centerPosition.lng()
				    		   && marker.distance <= maxDistance){
		            	   closestMarkers.push(marker);
		               }   
				       
				    });

				    closestMarkers.sort(function(a,b){
				    	return a.distance - b.distance
				    }); //ordeno distancias de menor a mayor
				    				 
				    var $table = $("#tblNearbyIssues tbody");	
				    
				    if(closestMarkers.length == 0){
				    	$table.append('No se encontraron resultados.');
				    }
				    else{
				    
				    	if(closestMarkers.length > 5){
				    		closestMarkers.splice(4, 4); //obtengo los 5 markers más cercanos al punto   
				    	}			    	
				    	
				    	$.each(closestMarkers, function(i, marker){				    	
					    	var tr = "";				    
				    		var imageSrc = '';
				    					    		
					    	if(marker.images.length > 0)
					    		imageSrc = marker.images[0].url;	
					    	else
					    		imageSrc = fxlGlobalController.getDomainUrl()+'resources/images/nopic.png';				    
					    
					    	tr += '<tr><td style="border-top:none">';
					    	tr += '<div class="media">';
					    	tr += '<img class="media-object pull-left thumbnail" style="width:64px; height:64px" src="'+imageSrc+'">';
					    	tr += '<div class="media-body">';
					    	tr += '<a href="'+mapController.getIssuePlainURL(marker.id, marker.title)+'"><h5 class="media-heading">'+marker.title+'</h5></a>';
					    	tr += '<p style="font-size:11px">Reportado por: '+mapController.getUserURL(marker.user)+'</p>';
					    	tr += '<a class=\"taglink\" href=\"./search.html?type=status&value='+marker.status+'\"><span style="background:'+marker.statusCss+'" class="label">'+marker.status+'</a></span>';
					    	tr += '</div>';	
					    	tr += '</div>';
					    	tr += '</td></tr>';					
							
					    	$table.append(tr);		
					    
					    });			    	
				    }		    
				
			  }		  
		});	
		
	},
	
	isArgentina : function (fullAddress){
		
		var addressArray = fullAddress.split(",");
		var validCountry = false;
		
		for(var i = 0; i < addressArray.length; i++){			
			if($.trim(addressArray[i]) == "Argentina"){
				validCountry = true;					
			}		
		}
		
		return validCountry;	
	},
	
	findProvince : function(value){
		
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
		
	},
	
	calculateDistanceKM : function (pointA, pointB){
		return (google.maps.geometry.spherical.computeDistanceBetween(pointA, pointB) / 1000).toFixed(2);
	},
	
	getIssuePlainURL : function (issueID){
		var protocol = window.location.protocol;
		var host = window.location.host;
		var context = "fixeala";
		var subcontext = "issues/" + issueID;		
		var url = protocol + "//" + host + "/" + context + "/" + subcontext;			
		return url;
	},

	getIssueURL : function(issueID, issueTitle, type){
		var protocol = window.location.protocol;
		var host = window.location.host;
		var context = "fixeala";
		var subcontext = "issues/" + issueID;		
		var url = subcontext;	
		
		if(type == 'link')
			return '<a href="'+ url +'">#' + issueID + " " + issueTitle + '</a>';		
		
		if(type == 'plain')
			return url;
	},

	getUserURL : function (userID){
		var protocol = window.location.protocol;
		var host = window.location.host;
		var context = "fixeala";
		var subcontext = "users/" + userID;	
		var url = protocol + "//" + host + "/" + context + "/" + subcontext;	
		var urlLink = '<a id="issue-user" style="cursor:pointer" class="user-link" href="'+ url +'">' + userID + '</a>';	
		return urlLink;
	},

	getUserPlainURL : function (userID){
		var protocol = window.location.protocol;
		var host = window.location.host;
		var context = "fixeala";
		var subcontext = "users/" + userID;	
		var url = protocol + "//" + host + "/" + context + "/" + subcontext;	
		return url;
	},
	
	enableNexButton : function(){
		 $(".pager li.next").removeClass('disabled');
	},
	
	disableNexButton : function(){
		$(".pager li.next").addClass('disabled');
	},

	blockIssueForm : function(){
		
		var $container = $("#mapFormContainer");
		
		$container.block({ 
     		message: "<h4>Procesando ubicaci&oacute;n...<br><br><img src=\"./resources/images/loader.gif\"/></h4>",
         	overlayCSS:  { 
                backgroundColor : '#000', 
                opacity         : 0.2, 
                cursor          : 'wait' 
            },
        	css: { 
        	   '-webkit-border-radius' : '5px', 
               '-moz-border-radius'    : '5px', 
               padding                 : 20, 
               margin                  : 0, 
               width				   : '250px', 		  	            
               textAlign			   : 'center', 
               color				   : '#000', 
               border				   : '0px solid #aaa', 
               cursor				   : 'wait' 
    		}
	    });
		
	},

	unBlockIssueForm : function(){
		var $container = $("#mapFormContainer");
		$container.unblock();	
	}
		
};


/**********************************************/
// GLOBAL VARIABLES					
/**********************************************/

google.maps.visualRefresh = true; 

var map;
var initMarker;
var init_coord = new google.maps.LatLng(-34.599722, -58.381944);

var mapOptions = {
		center: init_coord,
		zoom: 12,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		mapTypeControl: true,
		scrollwheel: false
};
var placeSearch, autocomplete;
var componentForm = {
//		  street_number: 'short_name',
//		  route: 'long_name',
		  neighborhood: 'long_name',
		  locality: 'long_name',
		  administrative_area_level_1: 'long_name'
		};
var isFormOpen;
var isAnimating = false; 
var mapTimesClicked = 0;
var autocompleteCalls = 0;

var geocoder;	