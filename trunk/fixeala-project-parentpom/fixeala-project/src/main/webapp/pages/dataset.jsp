<script type="text/javascript">

  $(function() {
	  	  
	  //keep at least one checkbox checked
	  $("input[type='checkbox'][name='estados']").click(function() {
		  if( $("input:checked").length == 0 )
			  $(this).attr('checked','checked');			
	  });  
	  
	  var provincias = ["Todas","Buenos Aires", "Catamarca", "Chaco", "Chubut", "Córdoba","Corrientes",
                       "Entre Ríos", "Formosa", "Jujuy", "La Pampa", "La Rioja", "Mendoza",
                       "Misiones", "Neuquén", "Río Negro", "Salta", "San Juan", "San Luis",
                       "Santa Cruz", "Santa Fe", "Santiago del Estero", "Tierra del Fuego", "Tucumán" 
                       ];
	  
	  var provinciaSelect = document.getElementById("provincia");

	  for(var i = 0; i < provincias.length; i++) {
	      var opt = provincias[i];
	      var el = document.createElement("option");
	      el.textContent = opt;
	      el.value = opt;
	      provinciaSelect.appendChild(el);
	  }	
	  
	  $('#from-datepicker').datetimepicker({		  
		  format: 'dd/MM/yyyy',
		  language: 'es',
		
	      pickTime: false
	  });
	  	 	  
	  $('#to-datepicker').datetimepicker({
		  format: 'dd/MM/yyyy',
		  language: 'es',	
		  endDate: today,
	      pickTime: false
	  });
	  	  
	 	
	  var today = new Date();	  
	  var date = new Date();	 
	  date.setMonth(date.getMonth() - 3);	  
	  var lastThreeMonths = date;
	  	 
	  var pickerFrom = $('#from-datepicker').data('datetimepicker');
	  var pickerTo = $('#to-datepicker').data('datetimepicker');
	  pickerFrom.setLocalDate(lastThreeMonths);
	  pickerTo.setLocalDate(today);
	  	  
	  $('#tags').select2({		
		  width: '220',		
		  tags: ${allTags},
	      tokenSeparators: [","],
		  maximumSelectionSize: 5,
		  id: function(item){ 
			  	return item.text;
		  },		 
		  formatSelectionTooBig: function(){ 
			  return "Sólo se permiten 5 etiquetas como máximo.";
		  },		  
		  formatNoMatches: function(){ 
			  return "No se encontraron resultados.";
		  },	  
		  createSearchChoice: function() { return null; }
	  }); 
	    
	  
	  $('#btnExportDataset').click(function(){		  
	  	  var $form = $('#datasetForm');	  	  
	  	  $form.submit(function(e){		  		  
	  		  $.ajax({			
		            data: $form.serialize(),       
		            success: function(data) { 
		            	if(data.result)
			        		bootbox.alert(data.message);
			        }			           
		  	  });
	  	  });		  
	  });
	  
	 
  });
</script>


<div id="content">
		
		<!-- Dataset -->
	    <div class="page-header">
    	 	<h4><i class="icon-tasks"></i>&nbsp;&nbsp;<i class="icon-angle-right"></i>&nbsp;&nbsp;Tu Dataset</h4>    	 	
    	</div>    	
    	
    	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse rhoncus odio eu iaculis malesuada. 
    	Integer at diam sed metus mattis molestie. Aliquam lectus est, volutpat eget rutrum et, facilisis quis diam. 
    	Cras vitae varius nisl, quis feugiat felis. Sed vehicula malesuada orci eget pellentesque. 
    	Sed erat purus, feugiat ut lectus eu, ultrices convallis nisi. Curabitur id ante id turpis dapibus molestie eget vel eros. 
    	Sed eu vehicula erat. Proin ornare libero diam, a luctus magna scelerisque in.</p>
    	
    	
    	
		<div class="row-fluid">
			  
			<div class="span6" >
			   
			 <div class="page-header">   <h4>Datasets disponibles</h4> </div>
			   
			   
			  <table id="tblDatasetDownload" class="table-hover table-bordered">			  	
   	   		  	   	<tbody>
					  	<tr>
					  		<td><span class="badge badge-important">XML</span></td>
					  		<td>
					  			<h4>Reclamos cargados en Fixeala</h4>
		    					<p>Listado completo de reclamos cargados en el portal.</p>
		 					</td>
					  		<td>
					  			<button type="button" class="btn btn-danger btn-large">
					  			<i class="icon-download-alt icon-large"></i>&nbsp;&nbsp;DESCARGAR</button>
					  		</td>
					  	</tr>
					  	<tr>
					  		<td><span class="badge badge-success">XLS</span></td>
					  		<td>
					  			<h4>Reclamos cargados en Fixeala</h4>
		    					<p>Listado completo de reclamos cargados en el portal.</p>
		 					</td>
					  		<td>
					  			<button type="button" class="btn btn-success btn-large">
					  			<i class="icon-download-alt icon-large"></i>&nbsp;&nbsp;DESCARGAR</button>
					  		</td>
					  	</tr>
					  	<tr>
					  		<td><span class="badge badge-warning">CSV</span></td>
					  		<td>
					  			<h4>Reclamos cargados en Fixeala</h4>
		    					<p>Listado completo de reclamos cargados en el portal.</p>
		 					</td>
					  		<td>
					  			<button type="button" class="btn btn-warning btn-large">
					  			<i class="icon-download-alt icon-large"></i>&nbsp;&nbsp;DESCARGAR</button>
					  		</td>
					  	</tr>
					  	<tr>
					  		<td><span class="badge badge-info">PDF</span></td>
					  		<td>
					  			<h4>Reclamos cargados en Fixeala</h4>
		    					<p>Listado completo de reclamos cargados en el portal.</p>
		 					</td>
					  		<td>
					  			<button type="button" class="btn btn-info btn-large">
					  			<i class="icon-download-alt icon-large"></i>&nbsp;&nbsp;DESCARGAR</button>
					  		</td>
					  	</tr>
			  		</tbody>
			  
			  </table>
		</div>
		
		<div class="span5 offset1" >	   
	    	   
		    	 <div class="page-header">   <h4>Información adicional</h4> </div>   
		    	 
		    	 <table class="table table-bordered table-striped">
					<tr>
						<th>Autor</th>
						<td>Fixeala</td>
					</tr>
					<tr>
						<th>Frecuencia de actualización</th>
						<td>cada 10 minutos</td>
					</tr>
					<tr>
						<th>Última fecha de actualización</th>
						<td>25/07/13 a las 16:55 hs</td>
					</tr>			
				</table>
				
				
				 <table class="table" style="margin-top:50px;">
				 
				 	<tr >
				 	<td style="border:none">
					 	<a href="#mdl-dataset" class="btn btn-primary btn-large" data-toggle="modal" style="width:300px;height:50px;line-height:50px">
							<i class="icon-magic icon-2x"></i>&nbsp;&nbsp;&nbsp;TU DATASET
						</a>
					<tr>						
					<tr>
						<td style="border:none">
							<a href="#" class="btn btn-inverse btn-large" style="width:300px; height:50px;line-height:50px">
								<i class="icon-file-alt icon-2x"></i>&nbsp;&nbsp;&nbsp; TUTORIAL
							</a>
						</td>
				 	</tr>
				 
				 </table>
				
				<br>
					
	   </div> 
	   
	  
	 </div>
	
	
	
 
	<!-- Modal -->
	<div id="mdl-dataset" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<form id="datasetForm" action="./exportDataset.html" method="POST">     	   
		  	<div class="modal-header">
			    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			    <h4 id="myModalLabel">Personalizá tu dataset</h4>
		  	</div>
		  	<div class="modal-body">	    	
	   	   		<table id="tblCustomDataset">		    	   		  	
	   	   		  	   	<tbody>
		    	   			<tr>
			    	   			<td>
				    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Provincia</label>
				    	   			<br>
				    	   			<select id="provincia" name="provincia">							    	   										
							 		</select>		
							 	</td>								
								<td>
				    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Ciudad</label>
				    	   			<br>
				    	   			<select id="ciudad" name="ciudad">	
				    	   				<option selected="selected">Todas</option>		
				    	   				<option>Ciudad Autónoma de Buenos Aires</option>
							 		</select>		
							 	</td>
							 	<td>
				    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Barrio / Localidad (opcional)</label>
				    	   			<br>
					    	   		<input type="text" id="barrio" name="barrio"/>	
							 	</td>															
			    	   		</tr>   
			    	   						    	   		
			    	   		<tr>		
								<td>
					    	   		<label><i class="icon-double-angle-right"></i>&nbsp;Categorías</label>
					    	   		<br>	
					    	   		<input type="text" id="tags" name="tags" data-type="select2"/>
					    	   		<br><br>
					    	   		<small><i class="icon-info-sign"></i>&nbsp; Si no especifica ninguna categoría, se considerarán <strong>todas</strong>.</small>
			    	   			</td>					    	   			
			    	   			<td>
			    	   				<label><i class="icon-double-angle-right"></i>&nbsp;Rango de fechas</label>
			    	   				<br>						    	   				
			    	   				<div style="margin: 0 auto; border: 0px solid #000; width:210px;">					    	   				
				    	   				<span class="span" style="margin-left:0; margin-right:10px; width:50px; border:0px solid #000; height:30px; line-height:30px; font-size:12px;text-align:right">Desde:</span>
				    	   				<div id="from-datepicker" class="input-append">											   
										    <input name="minFecha" class="datepicker" type="text" readonly></input>
										    <span class="add-on">
										      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
										      </i>
										    </span>
												</div>  											
											</div>		
									<div style="margin: 0 auto; border: 0px solid #000; width:210px;">					
										<span class="span" style="margin-left:0; margin-right:10px; width:50px; border:0px solid #000; height:30px; line-height:30px; font-size:12px;text-align:right">Hasta:</span>
										<div id="to-datepicker" class="input-append">
										   <input name="maxFecha" class="datepicker" type="text" readonly></input>
										    <span class="add-on">
										      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
										      </i>
										    </span>
												</div>
											</div>	
											<small><i class="icon-info-sign"></i>&nbsp; Haga clic sobre el ícono del Calendario para seleccionar las fechas.</small>									
			    	   			</td>						    	   			
			    	   			<td>
									<label for="status"><i class="icon-double-angle-right"></i>&nbsp;Estado del reclamo</label>	
									<br>	
				    	   			<div class="controls span2">						    	   			  	 
					    	   			  <label class="checkbox">
										    <input name="estados" type="checkbox" value="ABIERTO" checked>Abierto										    
										  </label>
										  <label class="checkbox">
										    <input name="estados" type="checkbox" value="ADMITIDO">Admitido										    
										  </label>
										  <label class="checkbox">
										    <input name="estados" type="checkbox" value="EN PROGRESO">En Progreso										    
										  </label>
										  <label class="checkbox">
										    <input name="estados" type="checkbox" value="RESUELTO">Resuelto										    
										  </label>
										  <label class="checkbox">
										    <input name="estados" type="checkbox" value="CERRADO">Cerrado								    
										  </label>											 
				    	   			</div>											  
								</td>							    	   										
			    	   		</tr>		    	   	
			    	   		<tr>					    	   			
			    	   			<td>
			    	   				<label><i class="icon-double-angle-right"></i>&nbsp;Ordenar por</label>
			    	   				<br>
			    	   				<select id="orden" name="orden">						
											<option value="newest">fecha (más recientes)</option>	
											<option value="oldest">fecha (más viejos)</option>	
											<option value="status">estado</option>			
											<option value="tag">categoría</option>																									
									</select>	
			    	   			</td>
			    	   			<td>
					    	   		<label><i class="icon-double-angle-right"></i>&nbsp;Formato del archivo</label>
					    	   		<br>
					    	   		<select id="formatoArchivo" name="formatoArchivo">	
					    	   				<option value="csv">CSV</option>		
					    	   				<option value="html">HTML</option>	
					    	   				<option value="odf">ODF</option>																							
											<option value="pdf" selected="selected">PDF</option>					
					    	   				<option value="xls">XLS</option>					
											<option value="xml">XML</option>																				
									</select>	
								</td>						    	   		
			    	   		</tr>	  			    	   		
		    	   		</tbody>			    	   		
	   	   		</table>		
		  	</div>
		  	<div class="modal-footer">    
		  		<button class="btn btn-primary" id="btnExportDataset"> 
					<i class="icon-save icon-large"></i>Exportar dataset 
				</button>
							
		    	<button class="btn" data-dismiss="modal" aria-hidden="true">
		    		<i class="icon-remove icon-large"></i>Cancelar
		    	</button>
		  	</div>
  	  </form>
	</div>
        
    
   		<!-- /Dataset -->
</div>