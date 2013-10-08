	<div id="content">
	
		<!-- User dashboard -->
    	<ul id="dashboardTab" class="nav nav-tabs">
		    <li class="active"><a href="#profile" data-toggle="tab"><i class="icon-eye-open"></i>&nbsp;&nbsp;PERFIL</a></li>
		    <li><a href="#issues" data-toggle="tab"><i class="icon-list"></i>&nbsp;&nbsp;MIS RECLAMOS</a></li>
		    <li><a href="#activity" data-toggle="tab"><i class="icon-star"></i>&nbsp;&nbsp;ACTIVIDAD</a></li>
		    <li><a href="#messages" data-toggle="tab"><i class="icon-comments"></i>&nbsp;&nbsp;MENSAJES</a></li>
		    <li><a href="#account" data-toggle="tab"><i class="icon-wrench"></i>&nbsp;&nbsp;CUENTA</a></li>
	    </ul>
	  
		<div id="dashboardTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="profile">
				 <ul class="thumbnails">
		    		<li class="span4">
		    		 <div class="thumbnail">		    			
		   					<i class="icon-trophy icon-4x"></i>
		   					<h3>15549</h3>
		   					FIX POINTS	    			
		    		 </div>
		    		</li>	   
		    	</ul>
		
			</div>
			<div class="tab-pane fade" id="issues"><p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p></div>
			<div class="tab-pane fade" id="activity"></div>
			<div class="tab-pane fade" id="messages"></div>
			
			<div class="tab-pane fade" id="account">
			
				<div id="accountBox" class="span6 well">
						
   						<div class="row" >
    					
   								<div class="span6">    								
   									<form id="uploadForm">
   										<fieldset>
		   									<legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Foto de perfil</legend>
<%-- 		   									<sec:authorize access="isAuthenticated()"> --%>
		   									
<%-- 				   								<sec:authentication  var="pic"  property="principal.profilePic"/> --%>
									    		
<!-- 										        	<div class="thumbnail"> -->
<%-- 														 <img id="profilePic" src="${pageContext.request.contextPath}/resources/images/${pic}" alt=""> --%>
<!-- 													</div> -->
									       									        	
<%-- 											</sec:authorize>	 --%>
		   									
		   									
		   									<div class="thumbnail">
												<img id="profilePic" src="${pageContext.request.contextPath}/resources/images/01-mario.jpg" alt=""  >
											</div>
		   								
			   								<span class="btn fileinput-button">
					                   			<i class="icon-plus icon-white"></i>&nbsp;&nbsp;
					                   			<span>Seleccionar archivo</span>
					                   			<input type="file" name="file" id="btnUpload" data-url="${fileUploadUrl}" multiple>			               					
			               					</span>
			               				<output id="list"></output>
										</fieldset>
									</form>
								</div>		
									
								<div class="span6"> 				  
								  	 <form class="form-horizontal">
								  	 	<fieldset>
									  		<legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Datos personales</legend>
											 <div class="input-prepend">
											 	<span class="add-on"><i class="icon-envelope"></i></span>
											 	<input type="text" id="email" placeholder="ejemplo@gmail.com" class="input-xlarge" >											 
											 </div>
											 	
											 <div class="input-prepend">
											 	<span class="add-on"><i class="icon-home"></i></span>
											 	<input type="text" id="barrio" placeholder="Barrio" class="input-xlarge" >
											 	<label class="control-label" style="width:auto;float:right; text-align:left;margin-left:10px;line-height:30px;">(opcional)</label>			
											 </div>		
										 </fieldset>								
									</form>									
								</div>
								
								 <div class="span6" >
										 <fieldset>
										 	<legend></legend>		     					 
											 <button id="btnUpdateAccount" class="btn btn-primary">Guardar cambios</button>&nbsp;&nbsp;
											 <button type="reset" class="btn">Cancelar</button>
										</fieldset>
								 </div>
								 
								 
								 
						</div>
			
			 </div>
							

				
					
			
<%-- 				<form id="changePasswordForm" class="well span5"> --%>
<!-- 					<div class="row"> -->
<!-- 						<legend><i class="icon-lock"></i>&nbsp;&nbsp;Cambio de contraseña</legend> -->
<!-- 			  			<input type="password" id="currentPassword" placeholder="Contraseña actual">		  			 -->
<!-- 			  			<input type="password" id="newPassword" placeholder="Nueva contraseña">	 -->
<!-- 			  			<input type="password" id="newPasswordConfirmation" placeholder="Confirme nueva contraseña"> -->
<!-- 			  			<button type="submit" id="btnChangePassword" class="btn btn-primary">            						 -->
<!-- 				          Guardar cambios -->
<!-- 				    	</button> -->
<!-- 		  			</div> -->
<%-- 				</form> --%>
		
			
			</div>
			
		
		</div>
		<!-- /dashboardTabContent -->
		
		
	
		<!-- Signup -->
    	<div class="page-header">
    	 	<h4><i class="icon-user"></i>&nbsp;&nbsp;<i class="icon-angle-right"></i>&nbsp;&nbsp;Registro de nuevo usuario</h4>    	 	
    	</div>    	
   	    <form id="signupForm" class="well span6">
		    <div class="row">
	  			<div class="input-prepend">
		  			<span class="add-on"><i class="icon-user"></i></span>
		  			<input type="text" id="username" name="username" placeholder="Nombre de usuario">
	  			</div>
	  			<div class="input-prepend">
		  			<span class="add-on"><i class="icon-envelope"></i></span>
		  			<input type="text" id="email" name="email" placeholder="Email">
		  		</div>
	  			<div class="input-prepend">
		  			<span class="add-on"><i class="icon-key"></i></span>
		  			<input type="password" id="password" name="password" placeholder="Contraseña">
		  		</div>
	  			<div class="input-prepend">
	  				<span class="add-on"><i class="icon-key"></i></span>
	  				<input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirmar contraseña">
	  			</div>
 				<div id="captchadiv" ></div> 
 				<div class="span3" > 				
			      	<button type="submit" id="btnSignup" class="btn btn-primary">Crear cuenta</button>&nbsp;&nbsp;		
			    	<button type="reset" class="btn">Cancelar</button>				    	
	    		</div>			
		    </div>
   		</form>
    	<!-- /Signup -->
    	
	    
	    <!-- Reset password -->
	    <div class="page-header">
    	 	<h4><i class="icon-lock"></i>&nbsp;&nbsp;<i class="icon-angle-right"></i>&nbsp;&nbsp;Restablecer contraseña</h4>    	 	
    	</div>    	
   	    <form id="resetPasswordForm" class="well span5">
		    <div class="row">			
			    <input type="text" id="email" placeholder="Dirección de email" class="input-xlarge" >	
		      	<button type="submit" id="btnResetPwd" class="btn btn-primary">            						
		           Enviar
		    	</button>
				<div class="span4">					
			    	<p><i class="icon-caret-right"></i>&nbsp;Introduzca la dirección de correo electrónico que utilizó al crear su cuenta.
			    	Un mensaje será enviado a la brevedad a la dirección provista con un enlace para restablecer tu contraseña.</p>
					<br>
					<p><i class="icon-caret-right"></i>&nbsp;Por razones de seguridad, el enlace tendrá una vigencia de 24 horas. 
					Si el mensaje tarda en llegar, compruebe su carpeta de correo no deseado (spam).</p>
		    	</div>   					
		    </div>
   		</form>
   		<!-- /Reset password -->
    	
    	
	</div>
	<!-- /content -->  