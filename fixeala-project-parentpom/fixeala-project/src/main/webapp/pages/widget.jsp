<script type="text/javascript">

$(document).ready(function(){
	
	var snippet = '<!-- Place this tag where you want the +1 button to render. -->'	
		+ '\n'
		+ '<div class="g-plusone" data-annotation="inline" data-width="300"></div>'
		+ '\n\n'
		+ '<!-- Place this tag after the last +1 button tag. -->'
		+ '\n'
		+ '<script type="text/javascript">'
		+ '\n'
		+ '  (function() {'
		+ '\n'
		+ '    var po = document.createElement(\'script\'); po.type = \'text/javascript\'; '
		+ '\n'
		+ '    po.async = true;'
		+ '\n'
		+ '    po.src = \'https://apis.google.com/js/platform.js\';'
		+ '\n'
	    + '    var s = document.getElementsByTagName(\'script\')[0];'
	    + '\n'
		+ '    s.parentNode.insertBefore(po, s);'
	    + '\n'
		+ '  })();'
		+ '\n'
		+ '<\/script>';

	$("#widgetCode").val(snippet);
	
	
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
			  
			
			<div class="span7" style="text-align:center;">
				<div class="page-header" style="text-align: left !important;"><h4>Código del widget</h4> </div>			
				<textarea id="widgetCode" style="width: 560px; height: 320px; font-family: Courier New; font-size: 12px;"></textarea>
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
			
				<div class="page-header"><h4>Ejemplo</h4> </div>			
					
				<div class="widgetContainer">
					<div class="widgetHeader">
						&Uacute;ltimos reclamos	
						<span class="pull-right">
							<i class="icon-question-sign"></i> &nbsp;
							<i class="icon-refresh"></i>
						</span>
					</div>
					<div class="widgetBody">
						<div class="widgetRow">
							<span class="widgetRowTitle">
								<a href="#">Hay un pozo en medio de la Avenida!!!</a>
							</span>
							<span class="widgetRowLocation">CABA » Buenos Aires</span>
							<span class="widgetRowDate">hace 3 minutos</span>
						</div>
						<div class="widgetRow">
							<span class="widgetRowTitle">
								<a href="#">La mampostería de viene abajo</a>
							</span>		
							<span class="widgetRowLocation">Paraná » Entre Ríos</span>	
							<span class="widgetRowDate">hace 1 hora</span>
						</div>
						<div class="widgetRow" style="border-bottom: none">
							<span class="widgetRowTitle">
								<a href="#">Basura esparcida por toda la vereda</a>
							</span>			
							<span class="widgetRowLocation">GBA » Buenos Aires</span>	
							<span class="widgetRowDate">ayer</span>
						</div>
					
					</div>
					
					<div class="widgetFooter">
						
						<div class="widgetLogo">
							<a href="#">
								<i>© <strong>Fixeala</strong></i>
							</a>
						</div>
<!-- 						<span class="pull-right"> -->
<!-- 							<i class="icon-refresh"></i> -->
<!-- 						</span>						 -->
					</div>
				</div>
			
			
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