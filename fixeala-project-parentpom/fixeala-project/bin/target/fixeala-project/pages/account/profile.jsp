	<div id="content">
	    <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<!-- user NOT logged in -->
        <sec:authorize ifNotGranted="ROLE_USER">   
        
        <c:redirect url="${pageContext.request.contextPath}/home.html"></c:redirect>
        
        </sec:authorize>
        
        
        
	 	<!-- user logged in -->
        <sec:authorize access="isAuthenticated()">
	
		<!-- User dashboard -->
    	<ul id="dashboardTab" class="nav nav-tabs">
<!-- 		    <li><a href="#profile" data-toggle="tab"><i class="icon-eye-open"></i>&nbsp;&nbsp;MI PERFIL</a></li> -->
<!-- 		    <li><a href="#issues" data-toggle="tab"><i class="icon-list"></i>&nbsp;&nbsp;MIS RECLAMOS</a></li> -->
<!-- 		    <li><a href="#activity" data-toggle="tab"><i class="icon-star"></i>&nbsp;&nbsp;ACTIVIDAD</a></li> -->
<!-- 		    <li><a href="#messages" data-toggle="tab"><i class="icon-comments"></i>&nbsp;&nbsp;MENSAJES</a></li> -->
		    <li class="active"><a href="#account" data-toggle="tab"><i class="icon-wrench"></i>&nbsp;&nbsp;MI CUENTA</a></li>
	    </ul>
	  
		<div id="dashboardTabContent" class="tab-content">
<!-- 			<div class="tab-pane fade in active" id="profile"> -->
<!-- 				 <ul class="thumbnails"> -->
<!-- 		    		<li class="span4"> -->
<!-- 		    		 <div class="thumbnail">		    			 -->
<!-- 		   					<i class="icon-trophy icon-4x"></i> -->
<!-- 		   					<h3>15549</h3> -->
<!-- 		   					FIX POINTS	    			 -->
<!-- 		    		 </div> -->
<!-- 		    		</li>	    -->
<!-- 		    	</ul> -->
		
<!-- 			</div> -->
<!-- 			<div class="tab-pane fade" id="issues"><p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p></div> -->
<!-- 			<div class="tab-pane fade" id="activity"></div> -->
<!-- 			<div class="tab-pane fade" id="messages"></div> -->
			
			<div class="tab-pane fade in active" id="account">
			
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
											 	<input type="text" id="email" placeholder="Dirección de email" class="input-xlarge" >		
											 	<label class="control-label" style="width:auto;float:right; text-align:left;margin-left:10px;line-height:30px;">(no será publicado)</label>												 
											 </div>											 	
											 <div class="input-prepend">
											 	<span class="add-on"><i class="icon-home"></i></span>
											 	<input type="text" id="barrio" placeholder="Barrio / Localidad" class="input-xlarge" >
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
		    	
	    
	    </sec:authorize>
	  
    	
	</div>
	<!-- /content -->  