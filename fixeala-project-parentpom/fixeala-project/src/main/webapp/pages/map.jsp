<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>USIG - Mapa Interactivo de Buenos Aires</title>
    <link rel="stylesheet" type="text/css" href="css/ejemplos.css" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
	<script src="http://servicios.usig.buenosaires.gob.ar/usig-js/2.3/usig.AutoCompleterFull.min.js" type="text/javascript"></script>
	<script src="http://servicios.usig.buenosaires.gob.ar/usig-js/2.3/usig.MapaInteractivo.min.js" type="text/javascript"></script>

    
	<script type="text/javascript">
	$.noConflict();
	jQuery(document).ready(function($) {
		
		var ac = new usig.AutoCompleter('b', {
       		onReady: function() {
       			$('#b').val('').removeAttr('disabled').focus();	        			
       		},
       		afterGeoCoding: function(pt) {
    			if (pt instanceof usig.Punto) {
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
						  iconUrl: 'http://servicios.usig.buenosaires.gov.ar/symbols/mapabsas/bancos.png',
						  iconWidth: 41,
						  iconHeight: 41,
						  offsetX: 5,
						  offsetY: 5
						}
					);
			},
					
			OpenLayersJS: 'http://servicios.usig.buenosaires.gov.ar/OpenLayers/2.9.1-6/full/OpenLayers.js'
		});
		
		

		
	});	
	
	function myFunction(){
		alert("Triggered!");
	}
	</script>
  </head>
  <body>
    <div id="page">
      <div id="header">
        <div id="logo"><h1>Fixeala - MAPA</h1>       
        </div>
      </div>
      <div id="main">
       <form id="mainForm" accept-charset="utf-8">
       <br/>
      	<label for="b">Buscar</label>
     	<input type="text" size="40" name="b" id="b" title="Lugar a buscar" class="text"/>
     	<span id="ejemplo">ej.: Callao y Corrientes, Florida 550, Teatro San Martín, etc.</span>
	    <div id="mapa"></div>
	    <button id="clear">Limpiar</button>
       </form>
      </div>
      <div id="footer">
        <p>&copy; 2012 USIG - Unidad de Sistemas de Información Geográfica</p>
      </div>
    </div>
  </body>
</html>