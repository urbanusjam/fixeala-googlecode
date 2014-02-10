<script type="text/javascript">
  $(function() {
	 
	  var date = new Date();
	  var today = date;
	  var dateThreeMonthLater = date.setMonth(date.getMonth() + 3);

	  
	  $('#from-datepicker').datetimepicker({		  
		  format: 'dd/MM/yyyy',
		  language: 'es',
		  date: today,
		
	      pickTime: false
	  });
	  
	  $('#to-datepicker').datetimepicker({
		  format: 'dd/MM/yyyy',
		  language: 'es',	
		  endDate: today,
	      pickTime: false
	  });
	  
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
		  
		  var dataForm = $('#datasetForm').serialize();
		
// 		  var statusArray = [];
	      
// 		  $(':checkbox:checked').each(function(i){	       
// 			  statusArray.push($(this).val());
// 	      });
	      
		  		  
		  $.ajax({
	  			url: './exportDataset.html',
	      		type: "POST",		   
	            data: dataForm,       
	            success: function(data, status) { 
		            	
		            	alert("todo bien.");
		            		
		        }
		            						           
		          			           
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
	  	<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    <h4 id="myModalLabel">Personalizá tu dataset</h4>
	  	</div>
	  	<div class="modal-body">
	    	<form id="datasetForm" method="POST">     	   
		    	   		<table id="tblCustomDataset">		    	   		  	
		    	   		  	   	<tbody>
				    	   			<tr>
					    	   			<td>
						    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Provincia</label>
						    	   			<br>
						    	   			<select id="provincia" name="provincia">	
						    	   				<option selected="selected">Buenos Aires</option>	
												<option>Santa Fé</option>								
									 		</select>		
									 	</td>								
										<td>
						    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Ciudad</label>
						    	   			<br>
						    	   			<select id="ciudad" name="ciudad">	
						    	   				<option selected="selected">Ciudad Autónoma de Buenos Aires</option>							    	   				
												<option>Rosario</option>								
									 		</select>		
									 	</td>
									 	<td>
						    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Barrio / Localidad</label>
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
							    	   		<small><i class="icon-info-sign"></i>&nbsp; Si no especifica ninguna categoría, se considerarán todas.</small>
					    	   			</td>					    	   			
					    	   			<td>
					    	   				<label><i class="icon-double-angle-right"></i>&nbsp;Rango de fechas</label>
					    	   				<br>	
					    	   				
					    	   				<div id="from-datepicker" class="input-append">
											    <input name="minFecha" style="width:90px; height: 20px" type="text"></input>
											    <span class="add-on">
											      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
											      </i>
											    </span>
  											</div>
						    	   			
											&nbsp;-&nbsp;
											
											<div id="to-datepicker" class="input-append">
											    <input name="maxFecha" style="width:90px; height: 20px" type="text"></input>
											    <span class="add-on">
											      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
											      </i>
											    </span>
  											</div>
										
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
													<option value="xml">XML</option>	
													<option value="xls">XLS</option>
													<option value="csv">CSV</option>	
													<option value="pdf">PDF</option>							
											</select>	
										</td>						    	   		
					    	   		</tr>	  			    	   		
				    	   		</tbody>			    	   		
		    	   		</table>		    	   	
		    	   </form>
		    	  
											  
											
		    	   
	  	</div>
	  	<div class="modal-footer">    
	  		<button class="btn btn-primary" id="btnExportDataset"> 
				<i class="icon-save icon-large"></i>Exportar dataset 
			</button>
	    	<button class="btn" data-dismiss="modal" aria-hidden="true">
	    		<i class="icon-remove icon-large"></i>Cancelar
	    	</button>
	  	</div>
	</div>
        
   	    
   		<!-- /Dataset -->
</div>