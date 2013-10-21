$(document).ready(function(){	
	
	function init(){
		
	
		// Create the Google Map�
		var map = new google.maps.Map(d3.select("#map_d3").node(), {
		  zoom: 8,
		  center: new google.maps.LatLng(37.76487, -122.41948),
		  mapTypeId: google.maps.MapTypeId.TERRAIN
		});
		
		
		
	/**	
	
		// Load the station data. When the data comes back, create an overlay.
		d3.json('http://fixeala.googlecode.com/svn/trunk/fixeala-project-parentpom/fixeala-project/src/main/webapp/resources/data/argentina.json', function(data) {
	
			  
		  var overlay = new google.maps.OverlayView();
	
		  // Add the container when the overlay is added to the map.
		  overlay.onAdd = function() {
		    var layer = d3.select(this.getPanes().overlayLayer).append("div")
		        .attr("class", "stations");
	
		    // Draw each marker as a separate SVG element.
		    // We could use a single SVG, but what size would it have?
		    overlay.draw = function() {
		      var projection = this.getProjection(),
		          padding = 10;
	
		      var marker = layer.selectAll("svg")
		          .data(d3.entries(data))
		          .each(transform) // update existing markers
		        .enter().append("svg:svg")
		          .each(transform)
		          .attr("class", "marker");
	
		      // Add a circle.
		      marker.append("svg:circle")
		          .attr("r", 4.5)
		          .attr("cx", padding)
		          .attr("cy", padding);
	
		      // Add a label.
		      marker.append("svg:text")
		          .attr("x", padding + 7)
		          .attr("y", padding)
		          .attr("dy", ".31em")
		          .text(function(d) { return d.key; });
	
		      function transform(d) {
		        d = new google.maps.LatLng(d.value[1], d.value[0]);
		        d = projection.fromLatLngToDivPixel(d);
		        return d3.select(this)
		            .style("left", (d.x - padding) + "px")
		            .style("top", (d.y - padding) + "px");
		      }
		    };
		  };
	
		  // Bind our overlay to the map�
		  overlay.setMap(map);
			
		});**/
	
	}
	// google.maps.event.addDomListener(window, 'load', init); 

});