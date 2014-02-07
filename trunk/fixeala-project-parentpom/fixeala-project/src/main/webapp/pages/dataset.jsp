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
	    	<form id="customDatasetForm" >     	   
		    	   		<table id="tblCustomDataset">		    	   		  	
		    	   		  	   	<tbody>
				    	   			<tr>
					    	   			<td>
							    	   		<label for="province"><i class="icon-double-angle-right"></i>&nbsp;Provincia</label>
							    	   		<br>
							    	   		<select id="province" name="province">								
													<option>Buenos Aires</option>
													<option>Santa F&eacute;</option>	
													<option>Mendoza</option>		
													<option>Neuqu&eacute;n</option>														
											</select>
										</td>										
										<td>
						    	   			<label for="city"><i class="icon-double-angle-right"></i>&nbsp;Ciudad</label>
						    	   			<br>
						    	   			<select id="city" name="city">						
												<option>Ciudad Aut&oacute;noma de Buenos Aires</option>	
												<option>Rosario</option>								
									 		</select>		
									 	</td>
									 	<td>
						    	   			<label for="neighborhood"><i class="icon-double-angle-right"></i>&nbsp;Barrio / Localidad</label>
						    	   			<br>
							    	   		<input type="text" id="neighborhood" name="neighborhood"/>	
									 	</td>
															
					    	   		</tr>   
					    	   						    	   		
					    	   		<tr>		
										<td>
							    	   		<label for="tags"><i class="icon-double-angle-right"></i>&nbsp;Categorías</label>
							    	   		<br>	
							    	   		<input type="text" id="tags" name="tags"/>
							    	   		<br>
							    	   		<small><i class="icon-info-sign"></i>&nbsp; Si no especifica ninguna categoría, se considerarán todas.</small>
					    	   			</td>					    	   			
					    	   			<td>
					    	   				<label><i class="icon-double-angle-right"></i>&nbsp;Rango de fechas</label>
					    	   				<br>	
						    	   			<input type="text" id="dateFrom" name="dateFrom" class="input-small" value="06/02/14"/>	
											&nbsp;-&nbsp;
						    	   			<input type="text" id="dateTo" name="dateTo" class="input-small" value="07/02/14"/>
					    	   			</td>						    	   			
					    	   			<td>
											<label for="status"><i class="icon-double-angle-right"></i>&nbsp;Estado del reclamo</label>	
											<br>	
						    	   			<div class="controls span2">
						    	   			  	  <label class="checkbox">
												    <input id="status" type="checkbox" value="checked" checked>Todos										    
												  </label>
							    	   			  <label class="checkbox">
												    <input id="status" type="checkbox" value="">Abierto										    
												  </label>
												  <label class="checkbox">
												    <input id="status" type="checkbox" value="">Admitido										    
												  </label>
												  <label class="checkbox">
												    <input id="status" type="checkbox" value="">En Progreso										    
												  </label>
												  <label class="checkbox">
												    <input id="status" type="checkbox" value="">Resuelto										    
												  </label>
												  <label class="checkbox">
												    <input id="status" type="checkbox" value="">Cerrado								    
												  </label>											 
						    	   			</div>											  
										</td>							    	   										
					    	   		</tr>
					    	   	
					    	   		<tr>					    	   			
					    	   			<td>
					    	   				<label for="order"><i class="icon-double-angle-right"></i>&nbsp;Ordenar por</label>
					    	   				<br>
					    	   				<select id="order" name="order">						
													<option>fecha (más recientes)</option>	
													<option>fecha (más viejos)</option>	
													<option>estado</option>			
													<option>categoría</option>																									
											</select>	
					    	   			</td>
					    	   			<td>
							    	   		<label><i class="icon-double-angle-right"></i>&nbsp;Formato del archivo</label>
							    	   		<br>
							    	   		<select id="fileFormat" name="fileFormat">						
													<option>XML</option>	
													<option>XLS</option>
													<option>CSV</option>	
													<option>PDF</option>							
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