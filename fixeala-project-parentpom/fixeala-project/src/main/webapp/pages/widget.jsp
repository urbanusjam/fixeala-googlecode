<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

	function resizeIframe(iframe) {
    	iframe.height = iframe.contentWindow.document.body.scrollHeight + "px";
  	}

	$(document).ready(function(){
		
		var snippet = '<script type="text/javascript">'
			+ '\n'
			+ '  function resizeIframe(iframe) {'
			+ '\n'
			+ '  	iframe.height = iframe.contentWindow.document.body.scrollHeight + "px";'
			+ '\n'	
			+ '  }'
			+ '\n'
			+ '<\/script>'
			+ '\n'
			+ '\n'
			+ '<iframe style="width: 270px; border: none" onload="resizeIframe(this)" src="http://localhost:8080/fixeala/widget-component.html"></iframe>';
			
		$("#widgetScript").val(snippet);
		
	});

</script>


<div id="content">
		
		<!-- Widget -->
	    <div class="page-header">
    	 	<h4><i class="icon-cogs"></i>&nbsp;&nbsp;<i class="icon-angle-right"></i>&nbsp;&nbsp;Widget Web</h4>    	 	
    	</div>    	
    	
    	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse rhoncus odio eu iaculis malesuada. 
    	Integer at diam sed metus mattis molestie. Aliquam lectus est, volutpat eget rutrum et, facilisis quis diam. 
    	Cras vitae varius nisl, quis feugiat felis. Sed vehicula malesuada orci eget pellentesque. 
    	Sed erat purus, feugiat ut lectus eu, ultrices convallis nisi. Curabitur id ante id turpis dapibus molestie eget vel eros. 
    	Sed eu vehicula erat. Proin ornare libero diam, a luctus magna scelerisque in.</p>
    	
    	
    	<div class="row-fluid">			  
			
			<div class="span7">
				<div class="page-header" style="text-align: left !important;"><h4>C&oacute;digo HTML y JavaScript</h4></div>
				<p>Copie el siguiente código e insértelo en cualquier lugar de su sitio web para embeber el widget.</p>	
				<br>
				<textarea id="widgetScript" style="width: 560px; height: 150px; font-family: Courier New; font-size: 12px;"></textarea>				
			</div>
		
<!-- 			<div class="span8"> -->
<!-- 				 <div class="page-header"><h4>Personalizá tu widget</h4> </div> -->
				   			   
<!-- 				  <table id="tblWidget">			  	 -->
<!-- 	   	   		  	   	<tbody> -->
<!-- 						  	<tr> -->
<!-- 						  		<td colspan="2"> -->
<!-- 					    	   		<label for="url">URL del sitio web (donde será insertado el widget)</label> -->
<!-- 					    	   		<input type="text" id="url" name="url" style="width:465px" placeholder="http://"/> -->
<!-- 			    	   			</td> -->
<!-- 			    	   			<td> -->
<!-- 			    	   				<label>Fecha</label>					    	   	 -->
<!-- 					    	   		<input type="text" id="dateFrom" name="dateFrom" style="width:90px;" placeholder="Desde"/>	 -->
<!-- 					    	   		&nbsp;- &nbsp;		    	   		 -->
<!-- 					    	   		<input type="text" id="dateTo" name="dateTo" style="width:90px;" placeholder="Hasta"/> -->
<!-- 			    	   			</td> -->
<!-- 			    	   		</tr> -->
			    	   		
<!-- 			    	   		<tr>		    	   		 -->
<!-- 			    	   			<td> -->
<!-- 					    	   		<label for="province">Provincia</label> -->
<!-- 					    	   		<select id="province" name="province">								 -->
<!-- 											<option>Buenos Aires</option> -->
<!-- 											<option>Santa F&eacute;</option>	 -->
<!-- 											<option>Mendoza</option>		 -->
<!-- 											<option>Neuqu&eacute;n</option>														 -->
<!-- 									</select> -->
<!-- 								</td> -->
<!-- 								<td> -->
<!-- 				    	   			<label for="city">Ciudad</label> -->
<!-- 				    	   			<select id="city" name="city">						 -->
<!-- 										<option>Ciudad Aut&oacute;noma de Buenos Aires</option>	 -->
<!-- 										<option>Rosario</option>								 -->
<!-- 							 		</select>		 -->
<!-- 							 	</td> -->
<!-- 							 	<td>						 		 -->
<!-- 							 		<label>Barrio / Localidad</label>			    	   		 -->
<!-- 									<input type="text" id="neighborhood" name="neighborhood"/> -->
<!-- 								</td> -->
<!-- 						  	</tr> -->
						  	
<!-- 						  	<tr> -->
<!-- 						  		<td> -->
<!-- 					    	   		<label for="tags">Categorías</label> -->
<!-- 					    	   		<input type="text" id="tags" name="tags"/> -->
<!-- 			    	   			</td>													 -->
<!-- 								<td> -->
<!-- 					    	   		<label for="numberOfItems">Cantidad de ítems a mostrar</label> -->
<!-- 					    	   		<select id="numberOfItems" name="numberOfItems">						 -->
<!-- 											<option>1</option>	 -->
<!-- 											<option>2</option> -->
<!-- 											<option>3</option>	 -->
<!-- 											<option>4</option>		 -->
<!-- 											<option>5</option>							 -->
<!-- 									</select>	 -->
<!-- 								</td>	 -->
<!-- 								<td> -->
<!-- 					    	   		<label for="order">Ordernar por</label> -->
<!-- 					    	   		<select id="order" name="order">						 -->
<!-- 											<option>Fecha (ascendente)</option>	 -->
<!-- 											<option>Fecha (descendente)</option>	 -->
<!-- 											<option>Título (ascendente)</option> -->
<!-- 											<option>Usuario (ascendente)</option>															 -->
<!-- 									</select>	 -->
<!-- 								</td>					  		 -->
<!-- 						  	</tr> -->
						  	
<!-- 						  	<tr> -->
<!-- 						  		<td> -->
<!-- 									<label for="status">Estado del reclamo</label>		 -->
<!-- 				    	   			<div class="controls span2"> -->
<!-- 				    	   			<label class="checkbox"> -->
<!-- 									    <input id="status" type="checkbox" value="">Abierto										     -->
<!-- 									  </label> -->
<!-- 									  <label class="checkbox"> -->
<!-- 									    <input id="status" type="checkbox" value="">Pendiente										     -->
<!-- 									  </label> -->
<!-- 									   <label class="checkbox"> -->
<!-- 									    <input id="status" type="checkbox" value="">Resuelto										     -->
<!-- 									  </label> -->
<!-- 				    	   			</div> -->
<!-- 								</td>		 -->
						  	
<!-- 						  		<td> -->
<!-- 					    	   		<label for="reporter">Reportados por</label> -->
<!-- 					    	   		<label class="radio"> -->
<!-- 									  <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked> -->
<!-- 									 mí -->
<!-- 									</label> -->
<!-- 									<label class="radio"> -->
<!-- 									  <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2"> -->
<!-- 									  todos los usuarios -->
<!-- 									 </label> -->
<!-- 			    	   			</td>		    	   			 -->
<!-- 						  	</tr> -->
<!-- 						</tbody> -->
<!-- 				</table> -->				
<!-- 				</div> -->
			
			
			<div class="span4 pull-right">	 
			
				<div class="page-header"><h4>Previsualización</h4> </div>
				
				<iframe style="width: 270px; border: none;" onload="resizeIframe(this)" src="http://localhost:8080/fixeala/widget-component.html"></iframe>
			
			
<!-- 				 <table class="table" style="margin-top:50px;"> -->
<!-- 					<tr> -->
<!-- 						<td style="text-align:center; border:none"> -->
<!-- 							<a href="#" class="btn btn-primary btn-large" style="width:230px; height:50px;line-height:50px"> -->
<!-- 								<i class="icon-code icon-2x"></i>&nbsp;&nbsp;&nbsp; GENERAR CÓDIGO -->
<!-- 							</a> -->
<!-- 						</td> -->
<!-- 				 	</tr> -->
				 				
<!-- 					<tr> -->
<!-- 						<td style="text-align:center; border:none"> -->
<!-- 							<a href="#" class="btn btn-inverse btn-large" style="width:230px; height:50px;line-height:50px"> -->
<!-- 								<i class="icon-file-alt icon-2x"></i>&nbsp;&nbsp;&nbsp; TUTORIAL SOBRE WIDGETS -->
<!-- 							</a> -->
<!-- 						</td> -->
<!-- 				 	</tr>				  -->
<!-- 				 </table>		 -->
	   		</div> 
	   
		
		</div>
		
		
		
   	    
   		<!-- /widget -->
</div>