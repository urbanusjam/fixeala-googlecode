	<div id="content">
        
       <h3>${usuario}</h3>
         
		<!-- User dashboard -->
    	<ul id="dashboardTab" class="nav nav-tabs">		  
    	  	<li class="active"><a href="#profile" data-toggle="tab"><i class="icon-user"></i>&nbsp;&nbsp;MI PERFIL</a></li>
		    <li><a href="#account" data-toggle="tab"><i class="icon-wrench"></i>&nbsp;&nbsp;MI CUENTA</a></li>
		    <li><a href="#issues" data-toggle="tab"><i class="icon-list"></i>&nbsp;&nbsp;MIS RECLAMOS</a></li>
		    <li><a href="#messages" data-toggle="tab"><i class="icon-comments"></i>&nbsp;&nbsp;MIS MENSAJES</a></li>
		    <li><a href="#activity" data-toggle="tab"><i class="icon-star"></i>&nbsp;&nbsp;MI ACTIVIDAD</a></li>		  
	    </ul>
	  
		<div id="dashboardTabContent" class="tab-content">

			<div class="tab-pane fade in active" id="profile">
			
			<div id="profileBox" class="span6 well">	

				Profile...
		
			</div>

			</div>
			
			<div class="tab-pane fade in" id="account">
			
				<div id="accountBox" class="span6 well">
										
   						<div class="row" >
    					
   								<div class="span6">    								
   									<form class="form-horizontal" id="uploadForm">
   										<fieldset>   									  									
		   									<legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Edición de cuenta</legend>
		   									<div class="thumbnail">
												<img id="profilePic" src="${pageContext.request.contextPath}/resources/images/01-mario.jpg" alt=""  >
											</div>
		   								
			   								<span class="btn fileinput-button">
					                   			<i class="icon-plus icon-white"></i>&nbsp;&nbsp;
					                   			<span>Seleccionar archivo</span>
<%-- 					                   			<input type="file" name="file" id="btnUpload" data-url="${fileUploadUrl}" multiple />			               					 --%>
			               					</span>
<!-- 			               				<output id="list"></output> -->
										</fieldset>
								
								  	 	<fieldset>								  	 					
											 <div class="input-prepend">
											 	<span class="add-on"><i class="icon-envelope"></i></span>
											 	<input type="text" id="email" value="${email}" placeholder="Dirección de email" class="input-xlarge" >		
											 	<label class="control-label" style="width:auto;float:right; text-align:left;margin-left:10px;line-height:30px;">(no será publicado)</label>												 
											 </div>											 	
											 <div class="input-prepend">
											 	<span class="add-on"><i class="icon-home"></i></span>
											 	<input type="text" id="barrio" value="${barrio}" placeholder="Barrio / Localidad" class="input-xlarge" >
											 	<label class="control-label" style="width:auto;float:right; text-align:left;margin-left:10px;line-height:30px;">(opcional)</label>			
											 </div>		
										 </fieldset>
										 <fieldset>										 	 					 
											 <button id="btnUpdateAccount" class="btn btn-primary">Actualizar datos</button>&nbsp;&nbsp;
											 <button type="reset" class="btn">Cancelar</button>
										</fieldset>								
									</form>									
								</div>
								<div class="span6"> 			
									<form class="form-horizontal">
										<fieldset>	
										     <legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Cambio de contraseña</legend>	 		
											 <div class="input-prepend">
												 <span class="add-on"><i class="icon-lock"></i></span>
												 <input type="password" id="currentPassword" placeholder="Contraseña actual" class="input-xlarge">		  			
											 </div>
											 
											 <div class="input-prepend">
												 <span class="add-on"><i class="icon-lock"></i></span>
												 <input type="password" id="newPassword" placeholder="Nueva contraseña" class="input-xlarge">		  			
											 </div>
											 
											  <div class="input-prepend">
												 <span class="add-on"><i class="icon-lock"></i></span>
												 <input type="password" id="newPasswordConfirmation" placeholder="Confirme nueva contraseña" class="input-xlarge">		  			
											 </div>								  								  			
							  			</fieldset>
							  			<fieldset>										 	 					 
											 <button id="btnUpdateAccount" class="btn btn-primary">Actualizar contraseña</button>&nbsp;&nbsp;
											 <button type="reset" class="btn">Cancelar</button>
										</fieldset>
									</form>
								</div>
							
								<div class="span6"> 			
									<form id="closeAccountForm" class="form-horizontal">
										<fieldset>	
										     <legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Desactivación de cuenta</legend>	 		
											 <div class="input-prepend">
												 <span class="add-on"><i class="icon-lock"></i></span>
												 <input type="password" id="currentPassword" placeholder="Contraseña actual" class="input-xlarge">		  			
											 </div>																				
							  			</fieldset>
							  			<fieldset>										 				 
											 <button id="btnCloseAccount" class="btn btn-primary">Cerrar cuenta</button>&nbsp;&nbsp;
											 <button type="reset" class="btn">Cancelar</button>
										</fieldset>
									</form>
								</div>							
						</div>
			
			 </div>
							

				
					
			
				
		
			
			</div>
			
		
		</div>
		<!-- /dashboardTabContent -->
		    
	</div>
	<!-- /content -->  