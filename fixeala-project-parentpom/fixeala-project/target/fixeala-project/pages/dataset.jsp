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
	    	   
		    	 <div class="page-header">   <h4>Informaci�n adicional</h4> </div>   
		    	 
		    	 <table class="table table-bordered table-striped">
					<tr>
						<th>Autor</th>
						<td>Fixeala</td>
					</tr>
					<tr>
						<th>Frecuencia de actualizaci�n</th>
						<td>cada 10 minutos</td>
					</tr>
					<tr>
						<th>�ltima fecha de actualizaci�n</th>
						<td>25/07/13 a las 16:55 hs</td>
					</tr>			
				</table>
				
				
				 <table class="table" style="margin-top:50px;">
				 
				 	<tr >
				 	<td style="text-align:center; border:none">
					 	<a href="#myModal" class="btn btn-primary btn-large" data-toggle="modal" style="width:230px;height:50px;line-height:50px">
							<i class="icon-magic icon-2x"></i>&nbsp;&nbsp;&nbsp;PERSONALIZ� TU DATASET
						</a>
					<tr>						
					<tr>
						<td style="text-align:center; border:none">
							<a href="#" class="btn btn-inverse btn-large" style="width:230px; height:50px;line-height:50px">
								<i class="icon-file-alt icon-2x"></i>&nbsp;&nbsp;&nbsp; TUTORIAL SOBRE DATASETS
							</a>
						</td>
				 	</tr>
				 
				 </table>
				
				<br>
				
				
				
				
			
	
	   </div> 
	   
	  
	 </div>
	
	
	
 
	<!-- Modal -->
	<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  	<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">�</button>
		    <h4 id="myModalLabel">Personaliz� tu dataset dataset</h4>
	  	</div>
	  	<div class="modal-body">
	    	<form id="customDatasetForm" >     	   
		    	   		<table id="tblCustomDataset">
		    	   		  	
		    	   		  	   	<tbody>
				    	   			<tr>
					    	   			<td>
							    	   		<label for="province">Provincia</label>
							    	   		<select id="province" name="province">								
													<option>Buenos Aires</option>
													<option>Santa F&eacute;</option>	
													<option>Mendoza</option>		
													<option>Neuqu&eacute;n</option>														
											</select>
										</td>										
										<td>
						    	   			<label for="city">Ciudad</label>
						    	   			<select id="city" name="city">						
												<option>Ciudad Aut&oacute;noma de Buenos Aires</option>	
												<option>Rosario</option>								
									 		</select>		
									 	</td>
																		
					    	   		</tr>
					    	   		
					    	   		<tr>
					    	   			<td><label>Barrio / Localidad</label>			    	   		
											<input type="text" id="neighborhood" name="neighborhood"/>
										</td>
										<td>
							    	   		<label for="tags">Categor�as</label>
							    	   		<input type="text" id="tags" name="tags"/>
					    	   			</td>						    	   		
									 
					    	   		</tr>
					    	   		
					    	   		<tr>
					    	   			<td>
											<label for="status">Estado del reclamo</label>		
						    	   			<div class="controls span2">
						    	   			<label class="checkbox">
											    <input id="status" type="checkbox" value="">Abierto										    
											  </label>
											  <label class="checkbox">
											    <input id="status" type="checkbox" value="">Pendiente										    
											  </label>
											   <label class="checkbox">
											    <input id="status" type="checkbox" value="">Resuelto										    
											  </label>
						    	   			</div>											  
										</td>	
						    	   		<td>
					    	   				<label>Fecha</label>					    	   	
							    	   		<input type="text" id="dateFrom" name="dateFrom" style="width:90px;" placeholder="Desde"/>	
							    	   		&nbsp;- &nbsp;		    	   		
							    	   		<input type="text" id="dateTo" name="dateTo" style="width:90px;" placeholder="Hasta"/>
					    	   			</td>										
					    	   		</tr>
					    	   		
					    	   		<tr>					    	   			
					    	   			<td>
					    	   				<label for="order">Ordenar por</label>
					    	   				<select id="order" name="order">						
													<option>Fecha (m�s recientes)</option>	
													<option>Fecha (m�s antiguos)</option>	
													<option>Tipo de reclamo (en orden alfab�tico)</option>
													<option>Estado (en orden alfab�tico)</option>															
											</select>	
					    	   			</td>
					    	   			<td>
							    	   		<label>Formato del archivo</label>
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
				<i class="icon-save icon-large"></i>&nbsp;&nbsp;&nbsp;Exportar 
			</button>
	    	<button class="btn" data-dismiss="modal" aria-hidden="true">Cancelar</button>
	  	</div>
	</div>
        
   	    
   		<!-- /Dataset -->
</div>