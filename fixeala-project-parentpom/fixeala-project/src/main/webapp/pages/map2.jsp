<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<title>Fixeala - Mapa</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
				
   		<script type="text/javascript" src="resources/js/libs/jquery-1.9.0.min.js"></script>
		<script type="text/javascript" src="resources/js/libs/jquery.validate.min.js"></script>
		<script type="text/javascript" src="resources/js/libs/jquery.ui.autocomplete.autoSelect.js"></script>
 		<script type="text/javascript" src="resources/js/libs/ba/usig.AutoCompleterFull.min.js"></script>
		<script type="text/javascript" src="resources/js/libs/ba/usig.MapaInteractivo.min.js"></script>
		
<!-- 	<script type="text/javascript" src="http://servicios.usig.buenosaires.gob.ar/usig-js/2.3/usig.AutoCompleterFull.min.js"></script> -->
<!-- 	<script type="text/javascript" src="http://servicios.usig.buenosaires.gob.ar/usig-js/2.3/usig.MapaInteractivo.min.js"></script> -->

		<link type="text/css" href="resources/css/jquery-ui.css" rel="stylesheet" />
		<link type="text/css" href="resources/css/ejemplos.css" rel="stylesheet"  />
		
    
		<script type="text/javascript">
		
			$.noConflict();
			
			jQuery(document).ready(function($) {
				
				//Interactive Map 
				var ac = new usig.AutoCompleter('address', {
		       		onReady: function() {
		       			$('#address').val('').removeAttr('disabled').focus();	        			
		       		},
		       		afterGeoCoding: function(pt) {
		    			if (pt instanceof usig.Punto) {
		    				alert(pt.getX() + " - " + pt.getY());
		    				miMapa.goTo(pt, true);
		    			}       			
		       		}
		       	});
			
				$('#mainForm').bind("submit", function () {
					return false;
				});
				
				$('#mapa').css('width', 600).css('height', 450);
		        
				miMapa = new usig.MapaInteractivo('mapa', {
					onReady: function() {
						var outputFormatter = new OpenLayers.Format.GeoJSON();
						
						function serialize(feature) {
							var str = outputFormatter.write(feature, false);
						    document.getElementById('output').value = str;
						};
						      
						var vlayer = new OpenLayers.Layer.Vector( "Editable" );
						miMapa.api.layers.vector = vlayer;
						miMapa.api.addControl(new OpenLayers.Control.EditingToolbar(vlayer));
						miMapa.api.addLayer(vlayer);
						var select = new OpenLayers.Control.SelectFeature(vlayer, {
							hover: true,
							onSelect: serialize
						});
						miMapa.api.addControl(select);
						select.activate();
						$('#clear').click(function() {
							miMapa.api.layers.vector.removeFeatures(miMapa.api.layers.vector.features);
							miMapa.api.layers.vector.destroyFeatures();
							document.getElementById('output').value = '';
						});
						
						
						var button = new OpenLayers.Control.Button({
						    displayClass: "MyButton", trigger: myFunction
						});
					    
					    
					    var panel = new OpenLayers.Control.Panel({defaultControl: button});
			            panel.addControls([button]);
			            miMapa.addPanel(panel);
						
					},
					
					onMapClick: function(){
						var markerId = miMapa.addMarker(
								'peru 652', 
								true, 
								'Texto popup',
								{
// 								  iconUrl: 'http://servicios.usig.buenosaires.gov.ar/symbols/mapabsas/bancos.png',
  								  iconUrl: 'resources/js/tick.png',
								  iconWidth: 41,
								  iconHeight: 41,
								  offsetX: 5,
								  offsetY: 5
								}
							);
					},
							
 			//		OpenLayersJS: 'http://servicios.usig.buenosaires.gov.ar/OpenLayers/2.9.1-6/full/OpenLayers.js'
					OpenLayersJS: 'resources/js/libs/ba/OpenLayers.js'
				});
				
				
				//Issue form validation	
				$( "#issueForm" ).validate({
					
			 		 rules: {	
								 address: "required",	
								 title: "required",	
								 description: "required",	
								 tags: "required"				 	   
					 }, 	 		
			 		 messages: { 	 	  
			 	     			address: {
			 	     			 			required: "Este campo es obligatorio."
			 	     		 	},
			 	     		 	title: {
	 	     			 					required: "Este campo es obligatorio."
	 	     		 			},
	 	     		 			description: {
	 	     			 					required: "Este campo es obligatorio."
	 	     		 			},	
	 	     		 			tags: {
	 	     			 					required: "Este campo es obligatorio."
	 	     		 			}
			 	     }
			 	     	
			 	 });		
				
			});	
		
		</script>
</head>

<style type="text/css">

	html{
		margin:0 auto;
		padding:0;
	
		
	}
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	
	.center {
   width: 1200px;
   height: 500px;
   position: absolute;
   left: 20%;
   top: 35%; 
   margin-left: -150px;
   margin-top: -150px;
   border:1px solid #000;
}

</style>
  
<body>

	<div class="center">
	
	<sec:authorize access="isAuthenticated()">		
		
		 	Bienvenido, <b><sec:authentication property="principal.username" /></b>			
			<a href="<c:url value="/doLogout" />" >(Salir)</a>	
			
	</sec:authorize>
	
		<table align="center">
			<tr>
				<td>	
					<form id="mainForm" accept-charset="utf-8">			     
					    <div id="mapa"></div>
					    <button id="clear">Limpiar</button>
				    </form>	
				</td>
				
				<td>
					<form:form id="issueForm" modelAttribute="issue" action="issue/doReport" method="POST" >
						<table>
							<tr>
								<td><label for="address">Calle:</label></td>
								<td><input type="text" id="address" name="address" size="40"/>	
								<span id="ejemplo">Ej: Callao y Corrientes, Florida 550, Teatro San Martín, etc.</span></td>				
							</tr>	
							<tr>
								<td><label for="neighbourhood">Barrio:</label></td>
								<td><input type="text" id="neighbourhood" name="neighbourhood" readonly="readonly" value="San Telmo"/></td>				
							</tr>
							<tr>
								<td><label for="comuna">CGPC:</label></td>
								<td><input type="text" id="comuna" name="comuna" readonly="readonly" value="Comuna 1"/></td>					
							</tr>	
							<tr>
								<td><label for="title">Título:</label></td>
								<td><input type="text" id="title" name="title"/></td>				
							</tr>			
							<tr>
								<td><label for="description">Descripción:</label></td>
								<td><textarea id="description" name="description" cols="30" rows="8"></textarea></td>				
							</tr>			
							<tr>
								<td><label for="file">Adjuntar una imagen:</label></td>
								<td><input type="file" id="file" name="file"/></td>				
							</tr>					
							<tr>
								<td><label for="tags">Palabras clave:</label></td>
								<td><input type="text" id="tags" name="tags"/></td>				
							</tr>						
							<tr>
								<td colspan="2" style="text-align:right;">
									<input name="submit" type="submit" value="Reportar reclamo" />
								</td>			
							</tr>
						</table>
					</form:form>
				</td>	
			</tr>	
		</table>
	</div>
   
</body>
</html>