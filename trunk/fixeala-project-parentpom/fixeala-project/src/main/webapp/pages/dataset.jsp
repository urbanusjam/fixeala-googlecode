<script type="text/javascript">

  $(function() {
	  
	  fxlGlobalController.populateProvinceCombobox('${provinceList}', 'dataset');
	  	  
	  //keep at least one checkbox checked
	  $("input[type='checkbox'][name='estados']").click(function() {
		  if( $("input:checked").length == 0 )
			  $(this).attr('checked','checked');			
	  });  
	  	  
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
			  return "S&oacute;lo se permiten 5 etiquetas como m&aacute;ximo.";
		  },		  
		  formatNoMatches: function(){ 
			  return "No se encontraron cateogr&iacute;as.";
		  },	  
		  createSearchChoice: function() { return null; }
	  }); 
	    	  
	  $('#btnExportDataset').click(function(){		  
	  	  var $form = $('#datasetForm');	
	  	  
	  	  $form.submit(function(e){	
	  		e.stopPropagation() ;
	  		  $.ajax({			
		            data: $form.serialize(),       
		            success: function(result) { 
		            
			        	if(!result)
			        		boobox.alert("No se encontraron resultados.");
			        }
		  	  });
	  	  });		  
	  });
	  	 
  });
  
  function downloadDataset(fileFormat){
	
	  $.ajax({			
            url : "./exportDataset",
            data: "fileFormat=" + fileFormat,
            success: function() { 
            	return null;
	        },
	        error: function (){
	        	return null;
	        }
  	  });
	  
  }
  
 
</script>



<div id="content">
		
		<!-- Dataset -->
	    <div class="page-header">
    	 	<h3><i class="icon-tasks"></i>&nbsp;&nbsp;Datasets / Cat&aacute;logos de Datos</h3>    	 	
    	</div>    	
    	
    	<p>FIXEALA pone a disposici&oacute;n de los ciudadanos el conjunto completo de datos referentes a los reclamos barriales comprendidos 
    	dentro de los l&iacute;mites de la Rep&uacute;blica Argentina, que han sido publicados 
    	por los propios usuarios de la plataforma para facilitar el proceso de b&uacute;squeda, descubrimiento y acceso, 
    	dentro del marco de las pol&iacute;ticas de Gobierno Abierto. Estos cat&aacute;logos podr&aacute;n ser descargados en diversos formatos (.xls, .csv, .xml, .json) para su libre uso.</p>
    	    	
    	
		<div class="row-fluid">
			  
			<div class="span6" >
			   
				 <div class="page-header"><h4>Datasets disponibles</h4></div>
			 
				 <!-- XLS -->
				 <div class="row dataset">
	  				<div class="span2"><span class="badge badge-success">XLS</span></div>
	  				<div class="span7">Listado completo de reclamos en formato EXCEL.</div>
	  				<div class="span3">
	  					<a href="dataset/download?format=xls" class="btn btn-default">
	  						<i class="icon icon-download"></i><span>Descargar</span>
	  					</a>		
	  				</div>
				 </div>
				 <!-- CSV -->
				 <div class="row dataset">
	  				<div class="span2"><span class="badge badge-info">CSV</span></div>
	  				<div class="span7">Listado completo de reclamos en formato CSV.</div>
	  				<div class="span3">
	  					<a href="dataset/download?format=csv" class="btn btn-default">
	  						<i class="icon icon-download"></i><span>Descargar</span>
	  					</a>		
	  				</div>
				 </div>				
				 <!-- XML -->
				 <div class="row dataset">
	  				<div class="span2"><span class="badge badge-important">XML</span></div>
	  				<div class="span7">Listado completo de reclamos en formato XML.</div>
	  				<div class="span3">
	  					<a href="dataset/download?format=xml" class="btn btn-default">
	  						<i class="icon icon-download"></i><span>Descargar</span>
	  					</a>		
	  				</div>
				 </div>
				 <!-- JSON -->
				 <div class="row dataset">
	  				<div class="span2"><span class="badge badge-default">JSON</span></div>
	  				<div class="span7">Listado completo de reclamos en formato JSON.</div>
	  				<div class="span3">
	  					<a href="dataset/download?format=json" class="btn btn-default">
	  						<i class="icon icon-download"></i><span>Descargar</span>
	  					</a>		
	  				</div>
				 </div>
		</div>
		
		<div class="span5 offset1">	 
		 	<div class="page-header"><h4>Dataset personalizado</h4></div>   		    	
<!-- 	    	 <div class="page-header"><h4>Informaci&oacute;n adicional</h4></div>   		    	  -->
<!-- 	    	 <table class="table table-bordered table-striped"> -->
<!-- 				<tr> -->
<!-- 					<th>Autor</th> -->
<!-- 					<td>Fixeala</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>Frecuencia de actualizaci&oacute;n</th> -->
<!-- 					<td>cada 10 minutos</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>&Uacute;ltima fecha de actualizaci&oacute;n</th> -->
<!-- 					<td>25/07/13 a las 16:55 hs</td> -->
<!-- 				</tr>			 -->
<!-- 			</table>		 -->
<!-- 			<center>					 -->
<!-- 				<a href="#mdl-dataset" class="btn btn-primary btn-large" data-toggle="modal" style="margin-top:30px;"> -->
<!-- 					<i class="icon icon-magic"></i>&nbsp;&nbsp;Personaliz&aacute; tu Dataset -->
<!-- 				</a> -->
<!-- 			</center> -->
			
			
			<div class="hero-unit">
			<center>					
				<a href="#mdl-dataset" class="btn btn-primary btn-large" data-toggle="modal">
					<i class="icon icon-magic"></i>Configurar opciones del Dataset
				</a>
			</center>
			
			</div>
			
	   </div> 
	   
	  
	 </div>
	
	
	
 
	<!-- Modal -->
	<div id="mdl-dataset" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<form id="datasetForm" action="dataset/export" method="GET">     	   
		  	<div class="modal-header">
			    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
			    <h4 id="myModalLabel">Configuraci&oacute;n de opciones del Dataset</h4>
		  	</div>
		  	<div class="modal-body">	    	
	   	   		<table id="tblCustomDataset">		    	   		  	
	   	   		  	   	<tbody>
		    	   			<tr>
			    	   			<td>
				    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Provincia</label>
				    	   			<br>
									<select name="provincia" id="provincia" onchange="javascript:fxlGlobalController.populateLocalityOnChange('dataset')">
    									<option value="todas">TODAS</option>
    								</select>											    	
							 	</td>								
								<td>
				    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Ciudad / Localidad</label>
				    	   			<br>
							 		<select name="ciudad" id="ciudad">
							 			<option value="todas">TODAS</option>
							 		</select>	
							 	</td>
							 	<td>
				    	   			<label><i class="icon-double-angle-right"></i>&nbsp;Barrio (opcional)</label>
				    	   			<br>
					    	   		<input type="text" id="barrio" name="barrio"/>	
							 	</td>															
			    	   		</tr>   
			    	   						    	   		
			    	   		<tr>		
								<td>
					    	   		<label><i class="icon-double-angle-right"></i>&nbsp;Categor&iacute;as</label>
					    	   		<br>	
					    	   		<input type="text" id="tags" name="tags" data-type="select2"/>
					    	   		<br><br>
					    	   		<small><i class="icon-info-sign"></i>&nbsp; Si no especifica ninguna categor&iacute;a, se considerar&aacute;n <strong>todas</strong>.</small>
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
									<small><i class="icon-info-sign"></i>&nbsp; Haga clic sobre el &iacute;cono del Calendario para seleccionar las fechas.</small>									
			    	   			</td>						    	   			
			    	   			<td>
									<label for="status"><i class="icon-double-angle-right"></i>&nbsp;Estado del reclamo</label>	
									<br>	
				    	   			<div class="controls span2">						    	   			  	 
					    	   			  <label class="checkbox">
										    <input name="estados" type="checkbox" value="ABIERTO" checked>Abierto										    
										  </label>
										  <label class="checkbox">
										    <input name="estados" type="checkbox" value="REABIERTO">Reabierto										    
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
											<option value="newest">fecha (m&aacute;s recientes)</option>	
											<option value="oldest">fecha (m&aacute;s viejos)</option>	
											<option value="status">estado</option>			
											<option value="tag">categor&iacute;a</option>																									
									</select>	
			    	   			</td>
			    	   			<td>
					    	   		<label><i class="icon-double-angle-right"></i>&nbsp;Formato del archivo</label>
					    	   		<br>
					    	   		<select id="formatoArchivo" name="formatoArchivo">	
					    	   				<option value="xls" selected="selected">XLS (MS Excel)</option>
					    	   				<option value="csv">CSV</option>
											<option value="xml">XML</option>	
											<option value="json">JSON</option>																				
									</select>	
								</td>						    	   		
			    	   		</tr>	  			    	   		
		    	   		</tbody>			    	   		
	   	   		</table>		
		  	</div>
		  	<div class="modal-footer">    
		  		<button class="btn btn-primary" id="btnExportDataset"> 
					<i class="icon-save"></i>&nbsp;Exportar  
				</button>
							
		    	<button class="btn" data-dismiss="modal" aria-hidden="true">
		    		<i class="icon-remove"></i>&nbsp;Cancelar
		    	</button>
		  	</div>
  	  </form>
	</div>
        
    
   		<!-- /Dataset -->
</div>