<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

	function resizeIframe(iframe) {
    	iframe.height = iframe.contentWindow.document.body.scrollHeight + "px";
  	}

	$(document).ready(function(){
		
		var snippet = '\n'
					+'<script type="text/javascript">'
					+ '\n\n'
					+ '  function resizeIframe(iframe) {'
					+ '\n'
					+ '  	iframe.height = iframe.contentWindow.document.body.scrollHeight + "px";'
					+ '\n'	
					+ '  }'
					+ '\n\n'
					+ '<\/script>'
					+ '\n'
					+ '\n'
					+ '<iframe style="width:300px;border:none;" onload="resizeIframe(this)" src="http://localhost:8080/fixeala/widget-web.html">'
					+ '\n'
					+ '</iframe>';
			
		$("#widget-script").text(snippet);
		
	});

</script>


<div id="content">
		
		<!-- Widget -->
	    <div class="page-header">
    	 	<h3><i class="icon-cogs"></i>&nbsp;&nbsp;Widget Web</h3>    	 	
    	</div>    	
    	
    	<p>Es un peque&ntilde;o componente web f&aacute;cil de integrar a tu sitio o blog
    		que te permitir&aacute; mostrar informaci&oacute;n referente a los &uacute;ltimos reclamos cargados en la plataforma de FIXEALA 
    		con un m&iacute;nimo bloque de c&oacute;digo. </p>
    	
    	
    	<div class="row-fluid">			  
			
			<div class="span7">
				<div class="page-header" style="text-align: left !important;"><h4>C&oacute;digo HTML y JavaScript</h4></div>
				<p>Para empezar a usar el widget, copi&aacute; el siguiente c&oacute;digo e insertalo en cualquier secci&oacute;n de tu p&aacute;gina web.</p>	
				<br>
				<div class="docs-example">
					<pre>
						<code id="widget-script"></code>
					</pre>
				</div>
			
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
			
			
			<div class="span4 pull-right" style="text-align: center;">	
				<div class="page-header" style="text-align: left;"><h4>Previsualizaci&oacute;n</h4></div>				
				<iframe style="width:300px;border:none;" onload="resizeIframe(this)" src="http://localhost:8080/fixeala/widget-web.html"></iframe>
	   		</div> 
	   
		
		</div>
		
		
		
   	    
   		<!-- /widget -->
</div>