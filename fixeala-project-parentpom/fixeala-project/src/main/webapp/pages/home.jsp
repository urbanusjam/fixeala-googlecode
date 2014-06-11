
	<script type="text/javascript">    
		$(document).ready(function(){
			
			$("#tags").select2({
				tags: ${allTags},
				tokenSeparators: [",", " "],
				   id: function (item) {
		                return item.text;
				   }
			});
			
		});
	</script>
	
	<div id="content">
	
		<div id="searchBar" class="row-fluid">
		  	<div class="span9">
				<div class="input-append">
					<input id="search" type="text" placeholder="Buscar reclamos (ID, Estado, T&iacute;tulo, Direcci&oacute;n, Barrio, Ciudad o Provincia)" autocomplete="off">					
<!-- 			        <button id="btnSearch" class='btn add-on' style="width:70px;"> -->
<!-- 			            <i class="icon-search"></i> -->
<!-- 			        </button>			         -->
			        <button id="btnAdvancedSearch" class='btn add-on' title="B&uacute;squeda avanzada">
			            <i class="icon-angle-down"></i>
			        </button>  
				</div>
			</div>		
			<div class="span3">	
				<button id="btnIssue" class="btn btn-warning"  data-toggle="button"> 
					<i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;&nbsp;NUEVO RECLAMO
				</button>
			</div>		
		</div>	
		
		<div id="searchFilters">
		Completar filtros de busqueda.
		</div>	
		
		<!-- ROW 1 -->
		
		<div class="container">
	
	
		<!-- MAP -->  	 				
  	
  				<select id="cbxProvincias" name="cbxProvincias" onchange="findProvincia(value);return false" onfocus="">              	
					<option value="BA">Buenos Aires</option>
					<option value="CF">Capital Federal</option>
					<option value="CT">Catamarca</option>
					<option value="CC">Chaco</option>
					<option value="CH">Chubut</option>
					<option value="CD">C�rdoba</option>					
					<option value="CR">Corrientes</option>
					<option value="ER">Entre R�os</option>
					<option value="FO">Formosa</option>
					<option value="JY">Jujuy</option>
					<option value="LP">La Pampa</option>				
					<option value="LR">La Rioja</option>		
					<option value="MZ">Mendoza</option>
					<option value="MN">Misiones</option>
					<option value="NQ">Neuqu�n</option>					
					<option value="RN">R�o Negro</option>
					<option value="SA">Salta</option>					
					<option value="SJ">San Juan</option>
					<option value="SL">San Luis</option>				
					<option value="SC">Santa Cruz</option>		
					<option value="SF">Santa Fe</option>					
					<option value="SE">Santiago del Estero</option>
					<option value="TF">Tierra del Fuego</option>
					<option value="TM">Tucum�n</option>					
		  		</select>
		  		
		  		<div id="map_canvas"></div>	

				
			<br>
				
			<div id="issueFormWizard">
				
				
					
					<form id="issueWizard"  method="POST" class="form-issue form-horizontal">
							
						<!-- begin STEPY WIZARD -->	
							
<!-- 							<div id="bar" class="progress progress-info progress-striped active" style="width:316px; margin-bottom:25px"> -->
<!-- 	  							<div class="bar"></div> -->
<!-- 							</div> -->
					
<!-- 							<fieldset title="1. Ubicaci&oacute;n">	 -->
<!-- 							<legend></legend>												 -->
<!-- 									<input type="hidden" id="latitude" name="latitude"  /> -->
<!-- 									<input type="hidden" id="longitude" name="longitude" />													 -->
<!-- 									<input type="text" id="address" name="address" onfocus="geolocate()" autocomplete="off" placeholder="Direcci&oacute;n (calle y altura)" />	 -->
<!-- 									<input type="text" id="neighborhood" name="neighborhood" placeholder="Barrio (opcional)"/>										 -->
<!-- 									<input type="text" id="locality" name="city" placeholder="Ciudad" />		 -->
<!-- 									<input type="text" id="administrative_area_level_1" name="province" placeholder="Provincia"/>							 -->
<!-- 							</fieldset> -->
							
<!-- 							<fieldset title="2. Detalles"> -->
<!-- 							<legend></legend>				 -->
<!-- 								<input type="text" id="title" name="title" placeholder="T&iacute;tulo"/> -->
<!-- 								<textarea rows="5" id="description" name="description" placeholder="Descripci&oacute;n..."></textarea>	 -->
<!-- 							</fieldset> -->
							
<!-- 							<fieldset title="3. Imagen">	 -->
<!-- 								<legend></legend>	 -->
<!-- 								<div class="fileupload fileupload-new" data-provides="fileupload" style="display:inline-block"> -->
<!-- 									<div class="fileupload-new thumbnail" style="width: 304px; height: 150px;"> -->
<%-- 										<img src="${pageContext.request.contextPath}/resources/images/nopic.png" /> --%>
<!-- 									</div> -->
<!-- 									<div class="fileupload-preview fileupload-exists thumbnail" style="height: 150px;min-width:300px;max-width: 200px; max-height: 150px; line-height: 20px;"></div> -->
									
<!-- 									<span class="btn fileinput-button" style="line-height:30px; width:auto; font-size:12px"> -->
<!-- 								        <i class="icon-plus"></i>&nbsp;&nbsp; -->
<!-- 								        <span>Seleccionar archivo</span>									         -->
<!-- 								           <input type="file" name="files[]" id="fileupload"> -->
<!-- 								    </span>									   -->
<!-- 								</div>	 -->
<!-- 	   							<input type="hidden" id="tags" name="tags" style="width:300px" class="input-xlarge"  placeholder="Etiquetas"/>       -->
<!-- 							</fieldset> -->
<!-- 						<input id="submitIssue" type="submit" class="finish"/> -->
						
					<!-- end STEPY WIZARD -->	
					
					<!-- begin BOOTSTRAP WIZARD -->
					
					<div id="rootwizard" style="margin-top:10px;">
						<ul>
						  	<li><a href="#tab1" data-toggle="tab">1. UBICACI&Oacute;N</a></li>
							<li><a href="#tab2" data-toggle="tab">2. DATOS</a></li>
							<li><a href="#tab3" data-toggle="tab">3. ARCHIVO</a></li>
						</ul>
						<div id="bar" class="progress progress-striped active">
						  <div class="bar"></div>
						</div>
						<div class="tab-content">
						 	<!-- TAB 1 -->
						    <div class="tab-pane" id="tab1">
						     	<input type="hidden" id="latitude" name="latitude"  />
								<input type="hidden" id="longitude" name="longitude" />											
								<div class="form-group">
   	 								<input type="text" class="form-control" name="address" id="address" placeholder="Direcci&oacute;n (calle y altura)" required>
  								</div>			
<!-- 								<input type="text" id="address" name="address" onfocus="geolocate()" autocomplete="off" placeholder="Direcci&oacute;n (calle y altura)" />	 -->
								<div class="form-group">
									<input type="text" id="neighborhood" name="neighborhood" placeholder="Barrio (opcional)"/>	
								</div>
								
								<div class="form-group">
									<input type="text" id="locality" name="city" placeholder="Ciudad" required/>		
								</div>
								
								<div class="form-group">
									<input type="text" id="administrative_area_level_1" name="province" placeholder="Provincia" required/>	
								</div>
								
																	
									
								
								
													
						    </div>
						    <!-- TAB 2 -->
						    <div class="tab-pane" id="tab2">
						    	<div class="form-group">
									<input type="text" id="title" name="title" placeholder="T&iacute;tulo" required/>	
								</div>
								<div class="form-group">
									<textarea rows="5" id="description" name="description" placeholder="Descripci&oacute;n..." required></textarea>	
								</div>
						      	
								
						    </div>
						     <!-- TAB 3 -->
							<div class="tab-pane" id="tab3">
								<div class="fileupload fileupload-new" data-provides="fileupload" style="display:inline-block">
									<div class="fileupload-new thumbnail" style="width: 304px; height: 150px;">
										<img src="${pageContext.request.contextPath}/resources/images/nopic.png" />
									</div>
									<div class="fileupload-preview fileupload-exists thumbnail" style="height: 150px;min-width:300px;max-width: 200px; max-height: 150px; line-height: 20px;"></div>
									
									<span class="btn fileinput-button" style="line-height:30px; width:auto; font-size:12px">
								        <i class="icon-plus"></i>&nbsp;&nbsp;
								        <span>Seleccionar archivo</span>									        
								           <input type="file" name="files[]" id="fileupload">
								    </span>									  
								</div>	
	   							<input type="hidden" id="tags" name="tags" style="width:300px" class="input-xlarge"  placeholder="Etiquetas"/>
						    </div>
							<ul class="pager wizard">
								<li class="previous"><a href="javascript:;"><i class="icon-long-arrow-left"></i>&nbsp;&nbsp;Anterior</a></li>
							  	<li class="next"><a href="javascript:;">Siguiente&nbsp;&nbsp;<i class="icon-long-arrow-right"></i></a></li>
							  	<li class="next finish" style="display:none;"><a href="javascript:;">Publicar</a></li>
							</ul>
						</div>	
					</div>
					
				<!-- end BOOTSTRAP WIZARD -->
						
					</form>
					
				</div>			
				
				<div class="clearfix"></div>
				
				
				
				
				
	<!-- ROW 2 -->

		<!--Sidebar content-->
		<div class="row-fluid" style="height:auto;margin-top:30px;">
		
		 <div class="span3">
			<div class="page-header">
    	   		<h4><i class="icon-user icon-large"></i>&nbsp;&nbsp;Usuarios m&aacute;s activos</h4>    	 	
    	   </div>    
		      
	      	<table class="table table-hover">
				<tr>
					<td style="border-top:none">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">ariel_xyz</h5></a>				    
						    <p style="font-size:11px">1101 reclamos <br>
						    99 comentarios</p>			
						 				
						  </div>
						</div>
					</td>				
				</tr>	
				<tr>
					<td style="border-top:1px dashed #dddddd; border-bottom:1px dashed #dddddd">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">SuperUser</h5></a>				    
						    <p style="font-size:11px">977 reclamos <br>
						    142 comentarios</p>									 				
						  </div>
						</div>
					</td>				
				</tr>	
			</table>		
			<p style="text-align:center;"><a href="#" >ver m&aacute;s</a>	</p>	
		</div>
		
		<div class="span5">
		   <div class="page-header">
    	   		<h4><i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;&Uacute;ltimos reclamos</h4>    	 	
    	   </div>    
		      
	      	<table class="table table-hover">
				<tr>
					<td style="border-top:none">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">Ramas de �rbol tapan sem�foro</h5></a>		
						    <p style="font-size:11px">10/06/13 en <a href="#">Mendoza</a><br>
						    Reportado por: <a href="#">el_user_22</a>
						     </p>	
						  </div>
						</div>
					</td>				
				</tr>	
				<tr>
					<td style="border-top:1px dashed #dddddd; border-bottom:1px dashed #dddddd">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">Mamposter�a de edificio deteriorada</h5></a>		
						    <p style="font-size:11px">10/06/13 en <a href="#">Buenos Aires</a><br>
						    Reportado por: <a href="#">pablivo-clavo-un-clavito</a>
						     </p>	
						  </div>
						</div>
					</td>				
				</tr>
			</table>
			<p style="text-align:center;"><a href="#" >ver m&aacute;s</a>	</p>	
		</div>
		
		
		 
     </div>
      
	</div>
	</div><!-- /CONTENT -->