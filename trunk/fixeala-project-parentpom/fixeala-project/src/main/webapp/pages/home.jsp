	<div id="content">
	
		<div id="searchBar" class="row-fluid">
		  	<div class="span9">
				<div class="input-append">					
		       		<input type="search" id="search" placeholder="Buscar reclamos o usuarios..." />
			        <button id="btnSearch" class='btn add-on' style="width:70px;">
			            <i class="icon-search"></i>
			        </button>			        
			        <button id="btnAdvancedSearch" class='btn add-on'>
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
		
		<!-- ROW 1 -->
		
		<div class="container" style="margin:0;padding:0;height:450px">
		
		
	
		  <!-- MAP -->  	 				
  	
  				<select id="cbxProvincias" name="cbxProvincias" onchange="findProvincia(value);return false" onfocus="">              	
					<option value="BA">Buenos Aires</option>
					<option value="CF">Capital Federal</option>
					<option value="CT">Catamarca</option>
					<option value="CC">Chaco</option>
					<option value="CH">Chubut</option>
					<option value="CD">Córdoba</option>					
					<option value="CR">Corrientes</option>
					<option value="ER">Entre Ríos</option>
					<option value="FO">Formosa</option>
					<option value="JY">Jujuy</option>
					<option value="LP">La Pampa</option>				
					<option value="LR">La Rioja</option>		
					<option value="MZ">Mendoza</option>
					<option value="MN">Misiones</option>
					<option value="NQ">Neuquén</option>					
					<option value="RN">Río Negro</option>
					<option value="SA">Salta</option>					
					<option value="SJ">San Juan</option>
					<option value="SL">San Luis</option>				
					<option value="SC">Santa Cruz</option>		
					<option value="SF">Santa Fe</option>					
					<option value="SE">Santiago del Estero</option>
					<option value="TF">Tierra del Fuego</option>
					<option value="TM">Tucumán</option>					
		  		</select>
		  		
		  		<div id="map_canvas"></div>	

	
		  		<!-- ISSUE FORM -->
<!-- 				<form id="issueForm" class="form-issue" method="POST">	 -->
<!-- 					 <div id="issueHeader" class="page-header "> -->
<!--     	 				<h4>Carg&aacute; tu reclamo</h4>    	 	 -->
<!--     				 </div>  				  -->
<!-- 					 <div id="fieldWrapper">					  -->
<!-- 					 		STEP 1 -->
<!-- 							<fieldset id="issueStep1" class="step" style="dispay:block"> -->
<!-- 								<input type="hidden" id="latitude" name="latitude"  /> -->
<!-- 								<input type="hidden" id="longitude" name="longitude" />	 -->
													
<!-- 								<input type="text" id="address" name="address" onfocus="geolocate()" autocomplete="off" placeholder="Dirección (calle y altura)" />			 -->
<!-- 								<input type="text" id="neighborhood" name="neighborhood" placeholder="Barrio (opcional)"/>										 -->
<!-- 								<input type="text" id="locality" name="locality" placeholder="Ciudad" />		 -->
<!-- 								<input type="text" id="administrative_area_level_1" name="administrative_area_level_1" placeholder="Provincia"/>								 -->
<!-- 							<div class="pac-container" style="position: absolute; z-index: 1000; display: none;"></div> -->
<!-- 							</fieldset> -->
							
<!-- 							STEP 2 -->
<!-- 						 	<fieldset id="issueStep2" class="step" style="dispay:none"> -->
<!-- 						 		<input type="text" id="title" name="title" placeholder="T&iacute;tulo"/> -->
<!-- 								<textarea rows="5" id="description" name="description" placeholder="Descripci&oacute;n..."></textarea>		 -->
<!-- 						 	</fieldset> -->
					
<!-- 							STEP 3 -->
<!-- 						  	<fieldset id="issueStep3" class="step" style="dispay:none">						 -->
<!-- 								<div class="fileupload fileupload-new" data-provides="fileupload"> -->
<!-- 									<div class="fileupload-new thumbnail" style="width: 304px; height: 150px;"> -->
<!-- 										<img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" /> -->
<!-- 									</div> -->
<!-- 									<div class="fileupload-preview fileupload-exists thumbnail" style="height: 150px;min-width:300px;max-width: 200px; max-height: 150px; line-height: 20px;"></div> -->
<!-- 									<div> -->
<!-- 										<span class="btn btn-file"> -->
<!-- 											<span class="fileupload-new"><i class="icon-plus"></i>&nbsp;&nbsp;Seleccionar imagen</span> -->
<!-- 											<span class="fileupload-exists"><i class="icon-refresh"></i>&nbsp;&nbsp;Cambiar</span> -->
<!-- 											<input type="file" /> -->
<!-- 										</span> -->
<!-- 										<a href="#" class="btn fileupload-exists" data-dismiss="fileupload"><i class="icon-trash"></i>&nbsp;&nbsp; Quitar</a> -->
<!-- 									</div> -->
<!-- 								</div>					 -->
<!-- 								<ul id="eventTags"></ul> -->
<!-- 							</fieldset>							 -->
<!-- 						</div>	 -->
						
<!-- 						<div id="demoNavigation">  -->
<!-- 							<input class="btn btn-primary" id="btnBackNext" type="reset" /> -->
<!-- 							<input class="btn btn-primary" id="btnIssueSubmit" type="submit"/> -->
						
<!-- 						</div>						 -->
<!-- 				</form>	 -->
				
				
<br>
				
			<div id="issueFormWizard">
			
			
				
<!-- 					<form id="issueWizard" class="form-issue form-horizontal" style="overflow:hidden;"> -->
							
<!-- 							<section id="issueStep1" class="step" data-step-title="Localización">													 -->
<!-- 									<input type="hidden" id="latitude" name="latitude"  /> -->
<!-- 									<input type="hidden" id="longitude" name="longitude" />													 -->
<!-- 									<input type="text" id="address" name="address" onfocus="geolocate()" autocomplete="off" placeholder="Dirección (calle y altura)" />			 -->
<!-- 									<input type="text" id="neighborhood" name="neighborhood" placeholder="Barrio (opcional)"/>										 -->
<!-- 									<input type="text" id="locality" name="locality" placeholder="Ciudad" />		 -->
<!-- 									<input type="text" id="administrative_area_level_1" name="administrative_area_level_1" placeholder="Provincia"/>							 -->
<!-- 							</section> -->
							
<!-- 							<section id="issueStep2" class="step" data-step-title="Detalles"> -->
<!-- 								<input type="text" id="title" name="title" placeholder="T&iacute;tulo"/> -->
<!-- 								<textarea rows="5" id="description" name="description" placeholder="Descripci&oacute;n..."></textarea>	 -->
<!-- 							</section> -->
							
<!-- 							<section id="issueStep3" class="step" data-step-title="Imagen">	 -->
<!-- 															<div class="fileupload fileupload-new" data-provides="fileupload"> -->
<!-- 									<div class="fileupload-new thumbnail" style="width: 304px; height: 150px;"> -->
<!-- 										<img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" /> -->
<!-- 									</div> -->
<!-- 									<div class="fileupload-preview fileupload-exists thumbnail" style="height: 150px;min-width:300px;max-width: 200px; max-height: 150px; line-height: 20px;"></div> -->
<!-- 									<div> -->
<!-- 										<span class="btn btn-file"> -->
<!-- 											<span class="fileupload-new"><i class="icon-plus"></i>&nbsp;&nbsp;Seleccionar imagen</span> -->
<!-- 											<span class="fileupload-exists"><i class="icon-refresh"></i>&nbsp;&nbsp;Cambiar</span> -->
<!-- 											<input type="file" /> -->
<!-- 										</span> -->
<!-- 										<a href="#" class="btn fileupload-exists" data-dismiss="fileupload"><i class="icon-trash"></i>&nbsp;&nbsp; Quitar</a> -->
<!-- 									</div> -->
<!-- 								</div>						 -->
<!-- 								<ul id="eventTags"></ul> -->
<!-- 							</section> -->
						
<!-- 					</form> -->



	<!-- EASY WIZARD -->
<!-- 						<form id="issueWizard" enctype="multipart/form-data" method="POST" class="form-issue form-horizontal" style="overflow:hidden;"> -->
							
<!-- 							<section id="issueStep1" class="step" data-step-title="Localización">													 -->
<!-- 									<input type="hidden" id="latitude" name="latitude"  /> -->
<!-- 									<input type="hidden" id="longitude" name="longitude" />													 -->
<!-- 									<input type="text" id="address" name="address" onfocus="geolocate()" autocomplete="off" placeholder="Dirección (calle y altura)" />			 -->
<!-- 									<input type="text" id="neighborhood" name="neighborhood" placeholder="Barrio (opcional)"/>										 -->
<!-- 									<input type="text" id="locality" name="city" placeholder="Ciudad" />		 -->
<!-- 									<input type="text" id="administrative_area_level_1" name="province" placeholder="Provincia"/>							 -->
<!-- 							</section> -->
							
<!-- 							<section id="issueStep2" class="step" data-step-title="Detalles"> -->
<!-- 								<input type="text" id="title" name="title" placeholder="T&iacute;tulo"/> -->
<!-- 								<textarea rows="5" id="description" name="description" placeholder="Descripci&oacute;n..."></textarea>	 -->
<!-- 							</section> -->
							
<!-- 							<section id="issueStep3" class="step" data-step-title="Imagen">	 -->
<!-- 								<div class="fileupload fileupload-new" data-provides="fileupload"> -->
<!-- 									<div class="fileupload-new thumbnail" style="width: 304px; height: 150px;"> -->
<!-- 										<img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" /> -->
<!-- 									</div> -->
<!-- 									<div class="fileupload-preview fileupload-exists thumbnail" style="height: 150px;min-width:300px;max-width: 200px; max-height: 150px; line-height: 20px;"></div> -->
<!-- 									<div> -->
<!-- 										<span class="btn btn-file"> -->
<!-- 											<span class="fileupload-new"><i class="icon-plus"></i>&nbsp;&nbsp;Seleccionar imagen</span> -->
<!-- 											<span class="fileupload-exists"><i class="icon-refresh"></i>&nbsp;&nbsp;Cambiar</span> -->
<!-- 											<input type="file" name="file" id="file" /> -->
<!-- 										</span> -->
<!-- 										<a href="#" class="btn fileupload-exists" data-dismiss="fileupload"><i class="icon-trash"></i>&nbsp;&nbsp; Quitar</a> -->
<!-- 									</div> -->
<!-- 								</div>						 -->
<!-- 								<ul id="eventTags"></ul> -->
<!-- 							</section> -->
						
<!-- 					</form> -->
					
					
					
					
					
				<!-- STEPY WIZARD -->	
					
					<form id="issueWizard" enctype="multipart/form-data" method="POST" class="form-issue form-horizontal">
							
							<div id="bar" class="progress progress-info progress-striped active" style="width:316px; margin-bottom:25px">
	  							<div class="bar"></div>
							</div>
					
							<fieldset title="1. Ubicación">	
							<legend></legend>												
									<input type="hidden" id="latitude" name="latitude"  />
									<input type="hidden" id="longitude" name="longitude" />													
									<input type="text" id="address" name="address" onfocus="geolocate()" autocomplete="off" placeholder="Dirección (calle y altura)" />			
									<input type="text" id="neighborhood" name="neighborhood" placeholder="Barrio (opcional)"/>										
									<input type="text" id="locality" name="city" placeholder="Ciudad" />		
									<input type="text" id="administrative_area_level_1" name="province" placeholder="Provincia"/>							
							</fieldset>
							
							<fieldset title="2. Detalles">
							<legend></legend>				
								<input type="text" id="title" name="title" placeholder="T&iacute;tulo"/>
								<textarea rows="5" id="description" name="description" placeholder="Descripci&oacute;n..."></textarea>	
							</fieldset>
							
							<fieldset title="3. Archivo">	
							<legend></legend>				
									<div class="fileupload fileupload-new" data-provides="fileupload">
									<div class="fileupload-new thumbnail" style="width: 304px; height: 150px;">
										<img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" />
									</div>
									<div class="fileupload-preview fileupload-exists thumbnail" style="height: 150px;min-width:300px;max-width: 200px; max-height: 150px; line-height: 20px;"></div>
									<div>
										<span class="btn btn-file">
											<span class="fileupload-new"><i class="icon-plus"></i>&nbsp;&nbsp;Seleccionar imagen</span>
											<span class="fileupload-exists"><i class="icon-refresh"></i>&nbsp;&nbsp;Cambiar</span>
											<input type="file" id="file" name="file" />
										</span>
										<a href="#" class="btn fileupload-exists" data-dismiss="fileupload"><i class="icon-trash"></i>&nbsp;&nbsp; Quitar</a>
									</div>
								</div>						
								<ul id="eventTags"></ul>
							</fieldset>
						<input id="submitIssue" type="submit" class="finish"/>
					</form>
				
					
				
				</div>
			
				
				<div class="clearfix"></div>
				
				
				
				
				
				
				
				
				
		
	<!-- ROW 2 -->

		<!--Sidebar content-->
		<div class="row-fluid" style="height:auto;margin-top:30px;">
		
		 <div class="span3">
			<div class="page-header">
    	   		<h4><i class="icon-user icon-large"></i>&nbsp;&nbsp;Usuarios más activos</h4>    	 	
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
			<p style="text-align:center;"><a href="#" >ver más</a>	</p>	
		</div>
		
		<div class="span4">
		   <div class="page-header">
    	   		<h4><i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;Últimos reclamos</h4>    	 	
    	   </div>    
		      
	      	<table class="table table-hover">
				<tr>
					<td style="border-top:none">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">Ramas de árbol tapan semáforo</h5></a>		
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
						    <a href="#"><h5 class="media-heading">Mampostería de edificio deteriorada</h5></a>		
						    <p style="font-size:11px">10/06/13 en <a href="#">Buenos Aires</a><br>
						    Reportado por: <a href="#">pablivo-clavo-un-clavito</a>
						     </p>	
						  </div>
						</div>
					</td>				
				</tr>
			</table>
			<p style="text-align:center;"><a href="#" >ver más</a>	</p>	
		</div>
		
		 
     </div>
      
	</div>
	</div><!-- /CONTENT -->