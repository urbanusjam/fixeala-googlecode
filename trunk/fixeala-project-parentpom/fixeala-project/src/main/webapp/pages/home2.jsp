	<div id="content">
	
<!-- 		<div id="searchBar" class="row-fluid"> -->
<!-- 		  	<div class="span9"> -->
<!-- 				<div class="input-append">					 -->
<!-- 		       		<input type="search" id="search" placeholder="Buscar reclamos o usuarios..." /> -->
<!-- 			        <button id="btnSearch" class='btn add-on' style="width:70px;"> -->
<!-- 			            <i class="icon-search"></i> -->
<!-- 			        </button>			         -->
<!-- 			        <button id="btnAdvancedSearch" class='btn add-on'> -->
<!-- 			            <i class="icon-angle-down"></i> -->
<!-- 			        </button>   -->
<!-- 				</div> -->
<!-- 			</div>		 -->
<!-- 			<div class="span3">	 -->
<!-- 				<button id="btnIssue" class="btn btn-warning"  data-toggle="button">  -->
<!-- 					<i class="icon-map-marker"></i>&nbsp;&nbsp;&nbsp;NUEVO RECLAMO -->
<!-- 				</button> -->
<!-- 			</div>		 -->
<!-- 		</div>	 -->
		
	
			<a href="#" class="floating-tab marker" >
				<i class="icon-white icon-pushpin icon-3x"></i>
			</a>
			
			<a href="#" class="floating-tab search" >
				<i class="icon-white icon-search icon-3x"></i>
			</a>	
	
		<!-- ROW 1 -->
		
		
	
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
      
	
	</div><!-- /CONTENT -->