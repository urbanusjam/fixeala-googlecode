//var coord_ba = new google.maps.LatLng(-34.599722, -58.381944);
//var coord_center = new google.maps.LatLng(-35,-65); 
var map;
var svg; 
var coords = [ -40.446947 , -65.529327	]; 
var AMBA_IDS = ["D02003", "D02004", "D02011", "D02017", "D02035", "D02036", "D02132", "D02038", 
                "D02051", "D02052", "D02134", "D02133", "D02129", "D02061", "D02063", "D02062", 
                "D02070", "D02130", "D02075", "D02077", "D02079", "D02080", "D02089", "D02128", 
                "D02092", "D02105", "D02106", "D02053", "D02109", "D02113", "D02118", "D02122", "CAPFED"];

$(document).ready(function(){
	
	var myData = [];
	var width =  500;	
	
	var $menu_item = $( ".floating-tab-menu li" );

	$menu_item.hover(function() {
		$(this).animate({
			marginRight : parseInt($(this).css('margin-right')) == 0 ?  100  : 0 
		}, 400);
		return false;
	});

	
//	d3.text("resources/data/lanacion-censo.csv", function(datasetText) {
//		myData = d3.csv.parseRows(datasetText);
//	});

	//generateMap('map-svg-canvas', width, myData);
	
	init_leaflet();

});


function init_leaflet(){

	//http://ta.wq.io/leaflet_d3
	
	// VARIABLES	 
	var provinciasPath;
	var departamentosPath =  new L.geoJson();
	var departamentoPathByProvincia;
	var currentDepartamento;
	var currentProvincia;
	var info;
	var currentZoom;
		
	// TILES	
	var cloudmadeUrl = 'http://{s}.tile.cloudmade.com/API-key/{styleId}/256/{z}/{x}/{y}.png',
		cludmadeKey = 'BC9A493B41014CAABB98F0471D759707',
	    cloudmadeAttribution = 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2011 CloudMade';
	 
	var defaultLayer = L.tileLayer('http://{s}.tile.cloudmade.com/{key}/{styleId}/256/{z}/{x}/{y}.png', {
			attribution: 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2011 CloudMade',
			key: 'BC9A493B41014CAABB98F0471D759707',
			styleId: 22677
	});
	
	var minimal   = L.tileLayer(cloudmadeUrl, {styleId: 22677, key: cludmadeKey, attribution: cloudmadeAttribution});
	
	// DATA LOADING		
//	loadReclamos();
	loadProvincias();
//	loadDepartamentos();	
	
//	loadNewProvincias();

	
	// LAYERS			
	var rec = L.layerGroup();
	var rec2 = L.layerGroup();
	var rec3 = L.layerGroup();
	var rec4 = L.layerGroup();

	var map = L.map('map_leaflet', {
	    center: new L.LatLng(-33.578015,-63.658218),
	    zoom: 5,
	    minZoom: 4,
	    maxZoom: 18,
	    layers: [defaultLayer, rec]
	});
		
	var baseLayers = {		
		"Mapa": defaultLayer	   
	};
	
	var groupedOverlays = {		    
      "Reclamos" : {
    	  "Abiertos"     : rec,		     
    	  "En progreso"  : rec2,
    	  "Resueltos"    : rec3,
    	  "Reabiertos"   : rec4
      }
	};
	
	var layerControl = L.control.groupedLayers(baseLayers, groupedOverlays);
	map.addControl(layerControl);
	
	// BOUNDARIES [ long - lat ]
		
	//	var north = L.latLng(-66.216667, -21.766667),
	//    	east = L.latLng(53.633333, -26.25),
	//    	south = L.latLng(-66.516667, -55.05),
	//    	west = L.latLng(-73.566667, -50.016667),
	//    	bounds = L.latLngBounds(south, west, north, east);

	//	map.fitBounds(bounds);	
	
	// EVENTS	
	map.on('viewreset', function(){
		currentZoom = map.getZoom();
		displayLayersOnZoom(currentZoom);
		console.log("zoom level: "+ map.getZoom());
	});	

	
	
	function displayLayersOnZoom(zoom){		
		if(zoom <= 6){
			if(departamentoPathByProvincia != null){
				map.removeLayer(departamentoPathByProvincia);
			}
			provinciasPath.addTo(map);
		
		}
//		if(zoom >= 7){
//			if(departamentoPathByProvincia == null){
//
//				map.removeLayer(provinciasPath);
//				departamentosPath.addTo(map);
//			}
//		
//		}
		
		
	}

	// STYLES
	var popupStyle = {
		color: "#000"			
    };
	
	var myStyle = {
		color       : "#ff7800",
		weight      : 2,
		opacity     : 0.5,
		display     : "none"
	 };
	 
	var provinciaStyle = {
		color       : "#1FBBA6",
        opacity	    : 1,  
		fillColor   : "#2BFCE0",
		fillOpacity : 0.4,
		weight      : 2		
	}
	
	
	var provinciaUnselectedStyle = {
			color       : "#1FBBA6",
	        opacity	    : 1,  
			fillColor   : "#2BFCE0",
			fillOpacity : 0.1,
			weight      : 2		
		}
	
	var provinciaHoverStyle = {
		weight: 2,
		color: '#1FBBA6',
		dashArray: '',
		fillColor: '#1FBBA6',
		fillOpacity: 0.6
	}	
	
	var departamentoStyle = {
		color		: "#1FBBA6",
		opacity     : 1,
		fillColor   : "#2BFCE0",
		fillOpacity : 0.4,
		weight      : 2		
	}	
	
	
		
	//RECLAMOS 		
	function loadReclamos(){	
		
		d3.json("resources/data/reclamos.json", function(error, markers) {
			 
			//console.log(markers);
			
			markersCluster = L.markerClusterGroup({maxClusterRadius: 100, showCoverageOnHover: false});
			
			var reclamosOverlay  = new L.geoJson(markers, {
				style: popupStyle,
				onEachFeature: function (feature, layer) {
					
					var marker = feature.properties;
					//console.log(marker);
					var textLimit = 400;
					var shortDescription = marker.description.substr(0, textLimit);
					
					var markerInfo = '<table border="0" cellpadding="0" cellspacing="0" style="width:380px">'
						 +'   <tr>'
						 +'	 	<td style="text-align:left; padding-bottom:10px"><strong><h4 style="display:inline">'+getIssueURL(marker.id, marker.title, 'link')
						 +'																	&nbsp;&nbsp;<i class="fa fa-chevron-right"></i>&nbsp;&nbsp;' 
						 +'															       <span class="'+marker.statusCss+'">'+ marker.status +'</span></h4></strong></td>'				           
					
						 +'	 </tr>'	
						 +'  <tr>'
						 +'	 	<td style="text-align:left;color:grey">'+marker.address+'</td>'				
						 +'	 </tr><tr><td>&nbsp;</td></tr>'	
						 +'   <tr style="font-size:12px;">'
						 +'	 	<td style="text-align:justify;color:black;padding-bottom:10px">'+shortDescription+' ...</td>'				
						 +'	 </tr>'	
						 +'	 <tr>'
						 +'		<td style="text-align:left;color:grey;padding-top:5px;border-top:1px solid grey">Nro. #'+marker.id+'&nbsp;&nbsp;<i class="fa fa-caret-right"></i>&nbsp;&nbsp;Reportado por: '+getUserURL(marker.user)+' &nbsp;   <div style="margin:0;padding:0;float:right;clear:both;display:inline">'+ marker.date +'</div></td>'
						 +'	 </tr>'				
						 +'	 </table>';		
					
			    	layer.bindPopup(markerInfo, {minWidth: 390, maxWidth: 390});
			    	markersCluster.addLayer(layer);
			    	
			    	/*
			    	var iconHover = L.icon({
			    	    iconUrl: 'my-icon.png',
			    	    iconSize: [38, 95],
			    	    iconAnchor: [22, 94],
			    	    popupAnchor: [-3, -76],
			    	    shadowUrl: 'my-icon-shadow.png',
			    	    shadowRetinaUrl: 'my-icon-shadow@2x.png',
			    	    shadowSize: [68, 95],
			    	    shadowAnchor: [22, 94]
			    	});			    	
			    	
			    	layer.on('mouseover', function(){		
							layer.setIcon(iconHover);
			    	});*/
			    	
			    }
			});
						
			map.addLayer(markersCluster);
				 
		});
		
	}	
	
	function loadNewProvincias(){
			
		d3.json('resources/data/provincias.json', function(error, dataProv) {
			console.log(dataProv);
			/**
//			var provincias = dataProv.features;		
			
			var options = [{ style: provinciaStyle , onEachFeature : onEachFeature }];
		
			var data = [];
			
			//loop provincias
			for(var i=0 ; i < provincias.length; i++){
		      
				var provinciaNameRaw = provincias[i].properties.provincia.toUpperCase();
				var provinciaName = provinciaNameRaw.replace(/\s+/g, "_"); 

		        //load departamentos
//		        d3.json('resources/data/provincias/' +  provinciaName  + '.json', function(error, dataDept) {		
//		        	
//		        	var departamentos = dataDept.features;
//		        	
//					for(var i = 0; i < departamentos.length; i++){				      
//						departamentosPath.addData(departamentos[i].geometry);				    
//				    }			
//					
//					departamentosPath.setStyle(provinciaStyle);	
//					departamentosPath.setStyle(provinciaStyle);	
//					departamentosPath.addTo(map);
//				});
		    
		    }
		
//			var a1 = topojson.feature(dataProv, dataProv.features);
//			var provinciasFeatures = topojson.feature(data, data.objects.provincias).features;
			**/
			provinciasPath = L.geoJson(dataProv, {
			    style: provinciaStyle
			}).addTo(map);
			
/**
			
			// INFO
			var info = L.control();
			info.onAdd = function (map) {
			    this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
			    this.update();
			    return this._div;
			};
		
			info.update = function (props) {
			    this._div.innerHTML = '<h4>Rep&uacute;blica Argentina</h4>' 
			   	 						+  (props ? props.PROVINCIA : 'Posicione el cursor sobre una provincia');
			};
						
			info.addTo(map);
							 
			function onEachFeature(feature, layer) {
				layer.on({
					mouseover: highlightFeature,
					mouseout: resetHighlight,
					click: zoomToFeature
				});
			}
				 
			// get color depending on population density value
			function getColor(d) {
				return d > 1000 ? '#800026' :
				       d > 500  ? '#BD0026' :
				       d > 200  ? '#E31A1C' :
				       d > 100  ? '#FC4E2A' :
				       d > 50   ? '#FD8D3C' :
				       d > 20   ? '#FEB24C' :
				       d > 10   ? '#FED976' :
				                  '#FFEDA0';
			}

		

			function highlightFeature(e) {	
				console.log(e);
				var layer = e.target;
				var layer_id = _getName(layer.feature.properties.PROVINCIA);
				
				
				if(currentProvincia != null){
					console.log(currentDepartamento);
					var current_prov_id = _getName(currentProvincia.feature.properties.PROVINCIA);
					var current_locality_prov_id = _getName(currentDepartamento.feature.properties.p_id);
				
					console.log(current_locality_prov_id + " > "+ current_prov_id);
					
					if(current_locality_prov_id != current_prov_id){
						layer.setStyle(provinciaHoverStyle);
						if (!L.Browser.ie && !L.Browser.opera) {
							layer.bringToFront();
						}
					}
					if(layer_id != current_prov_id){
						layer.setStyle(provinciaHoverStyle);
					}
				}
				
				else{
					layer.setStyle(provinciaHoverStyle);
				}
				
				
				console.log(layer);
				
				info.update(layer.feature.properties);			
				updateSelectedProvinceLabel(layer.feature.properties.PROVINCIA);	
			
				
			}

			function resetHighlight(e) {
				provinciasPath.resetStyle(e.target);
				info.update();
				updateSelectedProvinceLabel("ARGENTINA");					
			}

			function zoomToFeature(e) {						
				map.fitBounds(e.target.getBounds());				
				var provincia = _getName(e.target.feature.properties.PROVINCIA);
				console.log(provincia);				
				currentProvincia = e.target;
//				map.removeLayer(e.target);
//				e.target.addTo(map);
				loadDepartamentosByProvincia(provincia);				
			} 			
**/
			
		});
		
	}
	
	
	function loadNewDepartamentos(){
		
		
		
		d3.json("resources/data/provincias/CORDOBA.json", function(error, data) {

			console.log(data.features);
			var layer =  new L.geoJson();
			for(var i=0; i<data.features.length; i++){
		      
		        layer.addData(data.features[i].geometry);
		    
		    }
		    layer.setStyle(provinciaStyle);
			layer.addTo(map);

			
		});
		
	}
	
	function loadNewDepartamentos2(){
		
		d3.json("resources/data/provincias/LA_RIOJA.json", function(error, data) {

			console.log(data.features);
			var layer =  new L.geoJson();
			for(var i=0; i<data.features.length; i++){
		      
		        layer.addData(data.features[i].geometry);
		    
		    }
		    layer.setStyle(provinciaStyle);
			layer.addTo(map);

			
		});
		
	}
	
	
	//PROVINCIAS
	function loadProvincias(){		
		
		d3.json("resources/data/argentina.json", function(error, data) {
			 
			console.log(data);
		
			var provinciasConverted = topojson.feature(data, data.objects.provincias);
			var provinciasFeatures = topojson.feature(data, data.objects.provincias).features;
			
			var filter = provinciasFeatures.filter(function (e) {
	              return !('islas-malvinas' ===  _getName(e.properties.PROVINCIA) && AMBA_IDS.indexOf(e.id) == -1);
	          });
			
			provinciasPath = L.geoJson(filter, {
				    style: provinciaStyle,
				    onEachFeature: onEachFeature
			}).addTo(map);
	
			// INFO
			var info = L.control();
			info.onAdd = function (map) {
			    this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
			    this.update();
			    return this._div;
			};
		
			info.update = function (props) {
			    this._div.innerHTML = '<h4>Rep&uacute;blica Argentina</h4>' 
			   	 						+  (props ? props.PROVINCIA : 'Posicione el cursor sobre una provincia');
			};
						
			info.addTo(map);
							 
			function onEachFeature(feature, layer) {
				layer.on({
					mouseover: highlightFeature,
					mouseout: resetHighlight,
					click: zoomToFeature
				});
			}
				 
			// get color depending on population density value
			function getColor(d) {
				return d > 1000 ? '#800026' :
				       d > 500  ? '#BD0026' :
				       d > 200  ? '#E31A1C' :
				       d > 100  ? '#FC4E2A' :
				       d > 50   ? '#FD8D3C' :
				       d > 20   ? '#FEB24C' :
				       d > 10   ? '#FED976' :
				                  '#FFEDA0';
			}

			/*
			function style(feature) {
				return {
					weight: 2,
					opacity: 1,
					color: 'white',
					dashArray: '3',
					fillOpacity: 0.4,
					fillColor: 'yellow'
				};
			}*/  

			function highlightFeature(e) {				
				var layer = e.target;
				var layer_id = _getName(layer.feature.properties.PROVINCIA);
				
				
				if(currentProvincia != null){
					console.log(currentDepartamento);
					var current_prov_id = _getName(currentProvincia.feature.properties.PROVINCIA);
					var current_locality_prov_id = _getName(currentDepartamento.feature.properties.p_id);
				
					console.log(current_locality_prov_id + " > "+ current_prov_id);
					
					if(current_locality_prov_id != current_prov_id){
						layer.setStyle(provinciaHoverStyle);
						if (!L.Browser.ie && !L.Browser.opera) {
							layer.bringToFront();
						}
					}
					if(layer_id != current_prov_id){
						layer.setStyle(provinciaHoverStyle);
					}
				}
				
				else{
					layer.setStyle(provinciaHoverStyle);
				}
				
				
				console.log(layer);
				
				info.update(layer.feature.properties);			
				updateSelectedProvinceLabel(layer.feature.properties.PROVINCIA);	
			
				
			}

			function resetHighlight(e) {
				provinciasPath.resetStyle(e.target);
				info.update();
				updateSelectedProvinceLabel("ARGENTINA");					
			}

			function zoomToFeature(e) {						
				map.fitBounds(e.target.getBounds());				
				var provincia = _getName(e.target.feature.properties.PROVINCIA);
				console.log(provincia);				
				currentProvincia = e.target;
//				map.removeLayer(e.target);
//				e.target.addTo(map);
				loadDepartamentosByProvincia(provincia);				
			} 			
		   
		 });		
	}
	
	function updateSelectedProvinceLabel(selected){		
		$('.selectedProvince').text(selected);		
	}

	//DEPARTAMENTOS
	
	function loadDepartamentosByProvincia(provincia){
		
		d3.json("resources/data/argentina.json", function(error, data) {
			 
			var departamentosConverted = topojson.feature(data, data.objects.departamentos);			
			var departamentosFeatures = topojson.feature(data, data.objects.departamentos).features;
					
			var provincia_key_name = provincia;
						
			var filter = departamentosFeatures.filter(function (e) {
	              return provincia_key_name ===  _getName(e.properties.p_id) && AMBA_IDS.indexOf(e.id) == -1;
	          });
			
			if(departamentoPathByProvincia != null){
				map.removeLayer(departamentoPathByProvincia);				
			}
				 
			departamentoPathByProvincia = L.geoJson(filter, {
			    style: departamentoStyle,
			    onEachFeature: onEachFeature
			}).addTo(map);
			
			
			function onEachFeature(feature, layer) {
				layer.on({
					mouseover: highlightFeature,
					mouseout: resetHighlight,
					click: zoomToFeature
				});
			}
			
			function highlightFeature(e) {	
								
				var layer = e.target;				
				currentDepartamento = layer;
			
				layer.setStyle(provinciaHoverStyle);
				if (!L.Browser.ie && !L.Browser.opera) {
					layer.bringToFront();
				}
								
				console.log(layer);
				updateSelectedProvinceLabel(layer.feature.properties.a + " (" + layer.feature.properties.p.toUpperCase() + ")");					
			}

			function resetHighlight(e) {
				provinciasPath.resetStyle(e.target);
				updateSelectedProvinceLabel("ARGENTINA");					
			}

			function zoomToFeature(e) {				
				map.fitBounds(e.target.getBounds());		
			} 		
			
			
       
		});
	}
	
	function loadDepartamentos(){
		
		d3.json("resources/data/argentina.json", function(error, data) {
			 
			var departamentosConverted = topojson.feature(data, data.objects.departamentos);			
			//var departamentosFeatures = topojson.feature(data, data.objects.departamentos).features;
					
//			var r = name;
//						
//			var filter = departamentosFeatures.filter(function (e) {
//	              return r ===  _getName(e.properties.p_id) && AMBA_IDS.indexOf(e.id) == -1;
//	          });
		
         
//         departamentosPath = L.geoJson(filter, {
//			    style: departamentoStyle
//			}).addTo(map);
         
         departamentosPath = L.geoJson(departamentosConverted, {
        	 	style: departamentoStyle
			});
         
//         function highlightFeature(e) {
//				
//				if(currentZoom > 7){
//					
//					var layer = e.target;
//
//					layer.setStyle({
//						weight: 2,
//						color: '#3997AD',
//						dashArray: '',
//						fillOpacity: 0.6
//					});
//
//					if (!L.Browser.ie && !L.Browser.opera) {
//						layer.bringToFront();
//					}
//
//					info.update(layer.feature.properties);
//					
//				}
//				
//			}
//
//			function resetHighlight(e) {
//				provinciasPath.resetStyle(e.target);
//				info.update();
//			}
//
//			function zoomToFeature(e) {						
//				map.fitBounds(e.target.getBounds());				
//			} 	
           
		   
		 });
	}
	
	   function _getName(e) {
     		return e.replace(/\s+/g, "-").toLowerCase();
   	};
   	
   	
   	
   	function getIssueURL(issueID, issueTitle, type){
		var protocol = window.location.protocol;
		var host = window.location.host;
		var context = "fixeala";
		var subcontext = "issues/" + issueID;		
		var parsedTitle = issueTitle.replace(/\s/g, '-').toLowerCase();	
		var url = protocol + "//" + host + "/" + context + "/" + subcontext + "-" + parsedTitle + ".html";	
		
		if(type == 'link')
			return '<a href="'+ url +'">'+ issueTitle + '</a>';		
		
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
	
	
}






///////////////////// D3


function generateMap(containerId, width, data) {
	
	//Init vars
	var height=700,
	  centered,
	  projection,
	  path,
	  mapa_svg,
	  mainGroup,
	  departamentos,
	  provincias,
	  legend,
	  gran_buenos_aires,
	  gran_buenos_aires_mesh,
	  svg,
	  mini_svg,
	  AMBA_IDS = ["D02003", "D02004", "D02011", "D02017", "D02035", "D02036", "D02132", "D02038", "D02051", "D02052", "D02134", "D02133", "D02129", "D02061", "D02063", "D02062", "D02070", "D02130", "D02075", "D02077", "D02079", "D02080", "D02089", "D02128", "D02092", "D02105", "D02106", "D02053", "D02109", "D02113", "D02118", "D02122", "CAPFED"],
	  projection,
	  mini_projection,
	  amba,
	  mini_path,
	  mini_provincias,
	  tooltip,
	  extraInfo = d3.nest()
	              .key(function(d) { return d[1]; })
	              .map(data, d3.map),
	  color_scale = d3.scale.quantile()
	    .domain([0, d3.max(data, function(d){ return Math.round(d[17]);})])
	    .range(d3.range(9)),
	  color = d3.scale.category20(),
	  pad = d3.format("0ed"),
	  zoom;
  

	function _init() {
		_createMap();
		_createTooltip();
		_createPath();
	};
	

  	function _createTooltip() {
	
		tooltip = d3.select("body").append("div")   
		            .attr("id", "tooltip")               
		            .style("opacity", 0);
		
		svg.on("mousemove", mousemove);
		mini_svg.on("mousemove", mousemove);
		
		function mousemove() {
			tooltip.style("left", (d3.event.pageX + 20) + "px").style("top", (d3.event.pageY - 30) + "px");
		}
		
	}
  	

  	function _createMap() {

		svg = d3.select('#container #' + containerId).append("svg")
		  .attr("width", width)
		  .attr("height", height)
		  .attr("class", "poblacion");

		mini_svg = d3.select('#container #' + containerId).append("svg")
		  .attr("width", 200)
		  .attr("height", 200)
		  .attr("class", "poblacion-mini");

  	};
  	

  	function _getName(e) {
  		return e.replace(/\s+/g, "-").toLowerCase()
	};
	
	  
	function zoomed() {
		mapa_svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");		 
	};

	
	function _createPath() {
		
	    var scale = d3.geo.mercator().scale(900)
	    							 .center([-65, -35])
	    							 .translate([width / 2 - 30, height / 2 - 125]);
	    projection = scale;
	    path = d3.geo.path().projection(scale);

	    var mini_scale = d3.geo.mercator().scale(6600)
	    								  .center([-57.5, -35.6])
	    								  .translate([width / 2 - 30, height / 2 - 125]);
	    mini_projection = mini_scale;
	    mini_path = d3.geo.path().projection(mini_scale);

	    d3.json("resources/data/argentina.json", function(error, e) {
	    	
	    	zoom = d3.behavior.zoom()
					          .translate([0, 0])
					          .scale(1)
					          .scaleExtent([1, 8])
					          .on("zoom", zoomed);

	        svg.call(zoom).on("zoom", zoomed);

	        //mini mapa
	        mini_mapa_svg = mini_svg.append("g").classed("mini-mapa Blues", !0);

	        //mapa
	        mapa_svg = svg.append("g").classed("mapa Blues", !0).attr("transform", "translate(0, 20)");
	        
	        departamentos = mapa_svg.append("g").attr("class", "departamentos");
	        provincias = mapa_svg.append("g").attr("class", "provincias");
	        
	        var featuresProvincias = topojson.feature(e, e.objects.provincias).features,
	            featuresDepartamentos = topojson.feature(e, e.objects.departamentos).features;
	        
	        provincias.selectAll("path")
	          .data(featuresProvincias)
	          .enter()
	          .append("path")
	          .attr("id", function (e) {
	              return _getName(e.properties.PROVINCIA)
	          })
	          .attr("d", path)
	          .attr("class", "provincia");
	  
	        gran_buenos_aires = departamentos.append("g")
	          .attr("class", "gran-buenos-aires");

	        gran_buenos_aires_mesh = topojson.mesh(e, {
	            type: "GeometryCollection",
	            geometries: e.objects.departamentos.geometries.filter(function (e) {
	                return AMBA_IDS.indexOf(e.id) !== -1
	            })
	        });

	        featuresProvincias.forEach(function (e) {
	            var r = _getName(e.properties.PROVINCIA);
	            departamentos.append("g")
	            .attr("id", "provincia-" + r)
	              .selectAll("path")
	              .data(featuresDepartamentos.filter(function (e) {
	                return r === _getName(e.properties.p_id) && AMBA_IDS.indexOf(e.id) == -1;
	              }))
	              .enter()
	              .append("path")
	              .attr("id", function (e) {
	                  return e.id;
	              })
	              .attr("d", path)
	              .attr("class", "departamento")
	        });

	        departamentos.select("g#provincia-buenos-aires")
	          .append("g")
	          .attr("id", "gran-buenos-aires")
	          .selectAll("path")
	          .data(featuresDepartamentos.filter(function (e) {
	              return AMBA_IDS.indexOf(e.id) !== -1
	          }))
	          .enter()
	          .append("path")
	          .attr("id", function (e) {
	              return e.id
	          })
	          .attr("d", path)
	          .attr("class", "departamento")

	        mapa_svg.append("circle")
	          .attr("class", "parte-ampliada")
	          .attr("r",15)
	          .attr("cx",312)
	          .attr("cy",218);

	        //mini mapa
	        mini_mapa_svg.append("rect")
	          .attr("class", "mini-mapa-bg")
	          .attr("width",200)
	          .attr("height",200);

	        mini_provincias = mini_mapa_svg.append("g").attr("class", "mini-provincias");

	        mini_provincias.selectAll("path")
	          .data(featuresProvincias)
	          .enter()
	          .append("path")
	          .attr("id", function (e) {
	              return _getName(e.properties.PROVINCIA)
	          })
	          .attr("d", mini_path)
	          .attr("class", "provincia");

	        amba = mini_mapa_svg.append("g").attr("class", "amba");

	        amba.selectAll("path")
	          .data(featuresDepartamentos.filter(function (e) {
	              return AMBA_IDS.indexOf(e.id) !== -1
	          }))
	          .enter()
	          .append("path")
	          .attr("id", function (e) {
	              return e.id
	          })
	          .attr("d", mini_path)
	          .attr("class", "departamento")

	        //Tooltip
	        var m = mapa_svg.selectAll("path.departamento");
	        var mm = mini_mapa_svg.selectAll("path.departamento");
	        var mmm = mapa_svg.selectAll("path.provincia");

	        function addTooltipListener(s) {
	          s.on("mouseover", function(d) {	        	  
	        	
	        	  var innerHTML =  d.properties.c + '<br/><strong>' + d.properties.p + '</strong>'; 
	        	  
	              tooltip.transition()        
	                     .duration(100)      
	                     .style("opacity", .9)
	                     
	              tooltip.html(innerHTML);
	              
	              $(this)[0].classList.add("hover");
	              
	          })
	          .on("mouseout", function(d) {
	              $(this)[0].classList.remove("hover");
	              tooltip.transition()        
	                      .duration(200)      
	                      .style("opacity", 0);   
	          });
	        };
	        
	        function addTooltipListenerProvincia(s) {
		          s.on("mouseover", function(d) {
		        	  console.log(d);
		        	  var innerHTML =  d.properties.PROVINCIA; 
		        	  
		              tooltip.transition()        
		                     .duration(100)      
		                     .style("opacity", .9)
		                     
		              tooltip.html(innerHTML);
		              
		              $(this)[0].classList.add("hover");
		              
		          })
		          .on("mouseout", function(d) {
		              $(this)[0].classList.remove("hover");
		              tooltip.transition()        
		                      .duration(200)      
		                      .style("opacity", 0);   
		          });
		        };



	        function dotSeparateNumber(val){
	            while (/(\d+)(\d{3})/.test(val.toString())){
	              val = val.toString().replace(/(\d+)(\d{3})/, '$1'+'.'+'$2');
	            }
	            return val;
	        }


	        addTooltipListener(m);

	        addTooltipListener(mm);
	        
//	        addTooltipListenerProvincia(mmm);

	    });

	};


	_init();
	

	return {
    
	    update: function(areas){
	    	
//	    	provincias
//	        .selectAll('path')
//	        .attr('class',function (d){
//	          $(this)[0].classList.remove("selected");
//	          return $(this)[0].classList.toString();
//	        });
//	
//	    	provincias
//	        .selectAll('path')
//	        .attr('class', function (d){
//	          if(areas.indexOf(d.id)>-1){
//	            $(this)[0].classList.add("selected");
//	          } else {
//	            $(this)[0].classList.remove("selected");
//	          }
//	        });
	    	
	      departamentos
	        .selectAll('path')
	        .attr('class',function (d){
	          $(this)[0].classList.remove("selected");
	          return $(this)[0].classList.toString();
	        });
	
	      departamentos
	        .selectAll('path')
	        .attr('class', function (d){
	          if(areas.indexOf(d.id)>-1){
	            $(this)[0].classList.add("selected");
	          } else {
	            $(this)[0].classList.remove("selected");
	          }
	        });
	
	      amba
	        .selectAll('path')
	        .attr('class',function (d){
	          $(this)[0].classList.remove("selected");
	          return $(this)[0].classList.toString();
	        });
	
	      amba
	        .selectAll('path')
	        .attr('class', function (d){
	          if(areas.indexOf(d.id)>-1){
	            $(this)[0].classList.add("selected");
	          } else {
	            $(this)[0].classList.remove("selected");
	          }
	          return $(this)[0].classList.toString();
	        });
	
	    }

	}

}
