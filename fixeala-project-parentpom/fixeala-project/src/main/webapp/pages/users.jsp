<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">

	th, td { font-size: 12px; }
	.table-striped tbody tr.highlight td { background-color: #A8D3E6; }
	
</style>



<div id="content">
	<div class="container-fluid">
	  <div class="row-fluid">
	  
	  <div class="row">
   	   	<div class="span5 pull-left" style="padding:0;text-align:left;margin:0; border:0px solid #000">
 	   				<blockquote>    	   				
		        <h3>${profileUser}</h3> &nbsp;&nbsp;					        
		        <c:if test="${ !isActiveUser }">
		        	<span class="label" style="vertical-align:super;">Este usuario ya no forma parte de Fixeala</span>
		        </c:if> 
		        
		          <c:if test="${ not empty province }">
		           <small><cite><i class="icon-map-marker"></i>&nbsp;&nbsp;<i style="text-transform:uppercase;">${city}, ${province}</i></cite></small>
		          </c:if>
		    </blockquote>
		</div>
	</div>

	<br><br>
	  
	    <!--Sidebar content-->
	    <div id="dashboard-box" class="span3">
	              <ul id="dashboard-nav" class="nav nav-list">			              
              			<!-- ANONYMOUS -->
              			<sec:authorize access="isAnonymous()">
  									<li class="nav-header active">
			              			<a  href="#profileTab" data-toggle="tab">
			              				<i class="icon-caret-right"></i>PERFIL
			              			</a>
			              		</li>
			              		<li class="nav-header"><i class="icon-caret-right"></i>CONTENIDO</li>						               
				                <li><a href="#issuesTab" data-toggle="tab"><i class="icon-pushpin"></i>Reclamos</a></li>
				                <li><a href="#commentsTab" data-toggle="tab"><i class="icon-comments-alt"></i>Comentarios</a></li>							           	    
  							</sec:authorize>			              
	              								              	
		              	<!-- AUTHENTICATED -->
		              	<sec:authorize access="isAuthenticated() and hasRole('ROLE_USER')">
		              					              		
		              		<!-- MENU USER -->
		              		<c:if test="${ loggedMatchesProfile }">
			              		<li class="nav-header active">
			              			<a  href="#profileTab" data-toggle="tab">
			              				<i class="icon-caret-right"></i>PERFIL
			              			</a>
			              		</li>
<!-- 					              		<li class="nav-header"> -->
<!-- 					              			<a  href="#dashboardTab" data-toggle="tab"> -->
<!-- 					              				<i class="icon-caret-right"></i>DASHBOARD -->
<!-- 					              			</a> -->
<!-- 					              		</li> -->
			              		<li class="nav-header"><i class="icon-caret-right"></i>CONTENIDO</li>
<!-- 						                <li><a href="#notificationsTab" data-toggle="tab"><i class="icon-bell"></i>Notificaciones</a></li> -->
<!-- 						                <li><a href="#activityTab" data-toggle="tab"><i class="icon-check"></i>Actividad</a></li> -->
				                <li><a href="#issuesTab" data-toggle="tab"><i class="icon-pushpin"></i>Reclamos</a></li>
				                <li><a href="#commentsTab" data-toggle="tab"><i class="icon-comments-alt"></i>Comentarios</a></li>
<!-- 						                <li><a href="#widgetsTab" data-toggle="tab"><i class="icon-cogs"></i>Widgets</a></li> -->

				                <li class="nav-header"><i class="icon-caret-right"></i>CUENTA</li>
				                <li><a href="#editAccountTab" data-toggle="tab"><i class="icon-edit-sign"></i>Datos personales</a></li>
				                <li><a href="#changePasswordTab" data-toggle="tab"><i class="icon-unlock"></i>Cambio de clave</a></li>
				                <li><a href="#closeAccountTab" data-toggle="tab"><i class="icon-ban-circle"></i>Desactivaci&oacute;n</a></li>
		              		</c:if>
		              		
		              		<!-- MENU ANONYMOUS -->
		              		<c:if test="${ !loggedMatchesProfile }">				              	 	
				              	<li class="nav-header active">
			              			<a  href="#profileTab" data-toggle="tab">
			              				<i class="icon-caret-right"></i>PERFIL
			              			</a>
			              		</li>
			              		<li class="nav-header"><i class="icon-caret-right"></i>CONTENIDO</li>						               
				                <li><a href="#issuesTab" data-toggle="tab"><i class="icon-pushpin"></i>Reclamos</a></li>
				                <li><a href="#commentsTab" data-toggle="tab"><i class="icon-comments-alt"></i>Comentarios</a></li>		
		              	</c:if>
		              	</sec:authorize>			              		
	              </ul>
	    </div>
	    
	    <!--Body content-->
	    <div class="span9" style="float:right; width:940px;">
	    
	    <!-- TAB CONTENT -->
	    <div class="tab-content">			    
	    
    		<!-- TAB PROFILE -->
       			<div class="tab-pane fade in active" id="profileTab"> 	         			
       				<div class="page-header">
		    		<h3>Perfil p&uacute;blico</h3>
		    	</div>				    	
		    	<div class="row-fluid" style="margin: 0 auto; border: 0px solid #000; ">	
		    	
		    		<!-- column 1 -->    	
				    <div class="span3" style="border: 0px solid #000; ">		
				    	
				    	<div class="profilePic">
				    		<c:if test="${empty profilePicUrl}">			     
								<img width="200" height="200" class="thumbnail" src="${pageContext.request.contextPath}/resources/images/nopic_user.png" />
							</c:if>
							<c:if test="${not empty profilePicUrl}">			     
								<img width="200" height="200" class="thumbnail" src="${profilePicUrl}"/>
							</c:if>
				    	</div>
				    		
				    	<div class="changePic">
				    		<c:if test="${ loggedMatchesProfile }">
								<a href="#" class="fileinput-button">
							       Cambiar imagen								        
							     
						    	</a>
						    	   <input type="file" name="file" id="fileupload-profile" accept="image/*" style="position: absolute; top:-100px">  
					    	</c:if>
				    	</div>
												
						<div class="thumbnail" style="text-align:center;">
            						<small style="text-align:center">Miembro desde ${registrationDate}</small>		
  							</div>															

				    </div>
				    
				    <!-- column 2 -->
				    
<!-- 						    <div class="span9" style="border: 1px solid red"> -->
				    
		
				    	<span class="span2 thumbnail" style="text-align:center; width: 120px;" title="Reclamos publicados">
           				
           						<h2>${total_issues}</h2>
           						<strong>PUBLICADOS</strong>
 								</span>   							
  							<span class="span2 thumbnail" style="text-align:center; width: 120px;" title="Reclamos resueltos">
            					
            						<h2>${total_solved}</h2>
            						<strong>RESUELTOS</strong>
  							</span> 
  							<span class="span2 thumbnail" style="text-align:center; width: 120px;" title="Reclamos votados">
            				
            						<h2>${total_voted}</h2>
            						<strong>VOTADOS</strong>
  							</span>   							
  							<span class="span2 thumbnail" style="text-align:center; width: 120px;" title="Reclamos en seguimiento">
            					
            						<h2>${total_followings}</h2>
            						<strong>OBSERVANDO</strong>
  							</span>   							
  							<span class="span2 thumbnail" style="text-align:center; width: 120px;" title="Comentarios realizados">
            					
            						<h2>${total_comments}</h2>
            						<strong>COMENTARIOS</strong>
  							</span> 
				    
				    
<!-- 						    </div> -->
				
 						</div>				    	
	    	</div>
			<!-- fin TAB PROFILE -->
			
								
			<!-- TAB RECLAMOS -->
			<div class="tab-pane fade in" id="issuesTab">
			    	<div class="page-header">
			    		<h3>Reclamos</h3>
			    	</div>
			    	
			    	<ul class="nav nav-tabs">
						<li class="active"><a href="#issuesPublished" data-toggle="tab">Publicados (${total_issues})</a></li>
<!-- 								<li><a href="#issuesFollowing" data-toggle="tab">Siguiendo (0)</a></li> -->
<!-- 								<li><a href="#issuesVoted" data-toggle="tab">Votados (0)</a></li> -->
					</ul>							
												
					<div class="tab-content">							
						<!-- Publicados -->
						<div class="tab-pane fade in active" id="issuesPublished">								
							<table id="tblUserIssues" cellpadding="0" cellspacing="0" border="0" 
  											class="table table-striped table-bordered table-hover dataTable" aria-describedby="users-info" >
								<thead>
									<tr>				
										<th width="50">id</th>
										<th width="70">date</th>		
										<th width="200">title</th>			
										<th width="170">address</th>												
										<th width="120">city</th>
										<th width="120">province</th>																					
										<th width="70">status</th>		
									</tr>
								</thead>
								<tbody>			
								</tbody>	
							</table>								   	
						</div>
							
						<!-- Siguiendo -->							
						<div class="tab-pane fade" id="issuesFollowing">							
						</div>								
					
						<!-- Votados -->							
						<div class="tab-pane fade" id="issuesVoted">								
						</div>														
					</div>
												
					<!-- Context Menu -->
			    	<div id="contextmenu-issue" class="dropdown clearfix">
					    <ul id="ctxMenu" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
					      <li><a tabindex="-1" href="javascript:fxlAccountController.goToIssuePage(fxlAccountController.rowID);"><i class="icon-paper-clip"></i>&nbsp;&nbsp;Ver detalles</a></li>
					      <li><a tabindex="-1" href="#"><i class="icon-globe"></i>&nbsp;&nbsp;Ver en mapa</a></li>							    
					      <li class="divider" id="actionsDivider"></li>						      	
				      	  <li><a tabindex="-1" href="#" onclick="updateStatus('RESUELTO');"><i class="icon-ok"></i>&nbsp;&nbsp;Resolver</a></li>
				      	  <li><a tabindex="-1" href="#" onclick="updateStatus('CERRADO');"><i class="icon-lock"></i>&nbsp;&nbsp;Cerrar</a></li>
				      	  <li><a tabindex="-1" href="#" onclick="updateStatus('REABIERTO');"><i class="icon-folder-open-alt"></i>&nbsp;&nbsp;Reabrir</a></li>  
					    </ul>
 						</div>					    	
			    </div>
			    <!-- fin TAB RECLAMOS -->
			    
			  
	         	
	         	<!-- TAB COMENTARIOS -->   
	         	<div class="tab-pane fade" id="commentsTab">
	         		<div class="page-header">
			    		<h3>Comentarios</h3>
			    	</div>
			    	
			    	<ul class="nav nav-tabs">
				    	<li class="active"><a href="#commentsPublicados" data-toggle="tab">Publicados (${total_comments})</a></li>
<!-- 							  	<li><a href="#commentsRecibidos" data-toggle="tab">Recibidos (0)</a></li> -->
					</ul>
					
					<div class="tab-content">
						<div class="tab-pane fade in active" id="commentsPublicados">								
							<table id="tblUserComments" cellpadding="0" cellspacing="0" border="0" 
  											class="table table-striped table-hover dataTable" aria-describedby="users-info" >
								<thead>
									<tr>	
										<th width="70">fechaFormateada</th>		
										<th width="200">mensaje</th>												
										<th width="70">nroReclamo</th>		
									</tr>
								</thead>
								<tbody>			
								</tbody>	
							</table>
						 </div>
						 <div class="tab-pane fade" id="commentsRecibidos">	
						 </div>
					</div>
			    </div>
			    <!-- fin TAB COMENTARIOS -->
			    
			    
			    
			    
			    
			    
			    <sec:authorize access="isAuthenticated() and hasRole('ROLE_USER')">
			    
				    <!-- TAB DASHBOARD -->
         			<div class="tab-pane fade in" id="dashboardTab"> 	
		         		<div class="page-header">
				    		<h3>Dashboard</h3>
				    	</div>
			    	</div>
					<!-- fin TAB DASHBOARD -->
				
				
					<!-- NOTIFICACIONES -->
	         		<div class="tab-pane fade" id="notifications"> 	
		         		<div class="page-header">
				    		<h3>Notificaciones</h3>
				    	</div>
				    	
				    	<table class="table table-hover" style="width:900px">
					    	<tr>
					    		<td style="border-top:none;"><i class="icon-pencil"></i></td>
						    	<td style="border-top:none; width:700px"><a href="#">Roberto A.</a> modificó la descripción del reclamo <i><a href="#">Hay escombros de construcción desparramados en una esquina... (#4455)</a></i></td>
						    	<td style="border-top:none;"><i class="icon-time icon-grey"></i>hace 11 minutos</td>
						    <tr>
						     <tr>
					    		<td><i class="icon-quote-right"></i></td>
						    	<td><a href="#">fulanito_11</a> comentó el reclamo <i><a href="#">Hay un bache gigante en la calle... (#1100)</a></i></td>
						    	<td class="time"><i class="icon-time icon-grey"></i>hace 1 hora</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-pencil"></i></td>
						    	<td><a href="#">Roberto A.</a> agregó archivos al reclamo <i><a href="#">Semáforo a punto de caerse... (#9568)</a></i></td>
						    	<td class="time"><i class="icon-time icon-grey"></i>hace 5 horas</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-pushpin"></i></td>
						    	<td>El reclamo <i><a href="#">La calle está poceada, hagan algo... (#2222)</a></i> fue <span class="label label-warning">reasignado</span> a <a href="#">COMUNA 12</a></td>
						    	<td class="time"><i class="icon-time icon-grey"></i>hace 13 horas</td>
						    <tr>							   
						    <tr>
					    		<td><i class="icon-quote-right"></i></td>
						    	<td><a href="#">COMUNA 7</a> comentó el reclamo <i><a href="#">Hay residuos olorosos tirados por toda la vereda... (#7574)</a></i></td>
						    	<td class="time"><i class="icon-time icon-grey"></i>hace 14 horas</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-pencil"></i></td>
						    	<td><a href="#">COMUNA 3</a> modificó la información de licitación del reclamo <i><a href="#">Semáforo a punto de caerse... (#9568)</a></i></td>
						    	<td class="time"><i class="icon-time icon-grey"></i>ayer</td>
						    <tr>							    
						    <tr>
					    		<td><i class="icon-pushpin"></i></td>
						    	<td>El reclamo <i><a href="#">Semáforo a punto de caerse... (#9568)</a></i> fue <span class="label label-success">resuelto</span> por <a href="#">MAYEP</a></td>
						    	<td class="time"><i class="icon-time icon-grey"></i>ayer</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-pushpin"></i></td>
						    	<td>El reclamo <i><a href="#">La gente no sabe caminar... (#6688)</a></i> fue <span class="label label-important">rechazado</span> por <a href="#">MAYEP</a></td>
						    	<td class="time"><i class="icon-time icon-grey"></i>ayer</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-thumbs-up"></i></td>
						    	<td><a href="#">claudio_g</a> votó el reclamo <i><a href="#">Tapa de alcantarilla tapada por asfalto... (#4344)</a></i></td>
						    	<td class="time"><i class="icon-time icon-grey"></i>16/10/2013</td>
						    <tr>							    
				    	</table>
			    	</div>
			    	<!-- end TAB NOTIFICACIONES -->
			    	
			    	
			    	<!-- ACTIVIDAD -->
         			<div class="tab-pane fade" id="activityTab"> 	
		         		<div class="page-header">
				    		<h3>Actividad</h3>
				    	</div>
			    	</div>
					<!-- fin tab ACTIVIDAD -->
					
				    
				    <!-- TAB WIDGETS -->   
		         	<div class="tab-pane fade" id="widgetsTab">
		         		<div class="page-header">
				    		<h3>Widgets</h3>
				    	</div>
				    </div>
				     <!-- fin TAB WIDGETS -->
				     
				    
				    <!-- TAB DATOS PERSONALES -->
					<div class="tab-pane fade in" id="editAccountTab">						
						<div class="page-header">
				    		<h3>Datos personales</h3>
				    	</div>	
								
							<div class="row-fluid">
				            <div class="span9">
			                	<div class="span7">
			                		<form class="form-horizontal" id="updateAccountForm">					              
									    <label for="email">Email</label>
									    <input type="text" id="email" name="email" class="input-large" value="${email}">
		   								
		   								<label for="provincia">Provincia</label>
									   	<select name="provincia" id="provincia" onchange="javascript:fxlGlobalController.populateLocalityOnChange('user');">
  											</select>	
								
									 	<label for="ciudad">Ciudad / Localidad</label>						
									    <select name="ciudad" id="ciudad"></select>	
									
									    <hr> 
									    <button id="btnUpdateAccount" class="btn btn-success"><i class="icon-ok"></i>&nbsp;&nbsp; Actualizar datos</button>								 
								  	</form>
								</div>
							</div>
						</div>		
					</div> 
					<!-- fin TAB DATOS PERSONALES --> 
					
					
					<!-- TAB CAMBIO DE CLAVE -->
					<div class="tab-pane fade in" id="changePasswordTab">
						<div class="page-header">
				    		<h3>Cambio de clave</h3>
				    	</div>
				    	
				    	<div class="row-fluid">					    	
					    	<div class="span5">
		                		<form class="form-horizontal" id="changePasswordForm" method="POST">
		                							              
								    <label for="currentPassword">Clave actual</label>
								    <input type="password" id="currentPassword" name="currentPassword">	
								  									
								    <label for="newPassword">Nueva clave</label>
									<input type="password" id="newPassword" id="newPassword" name="newPassword">
								  										
								    <label for="newPasswordConfirmation">Confirme nueva clave</label>
								    <input type="password" id="newPasswordConfirmation" name="newPasswordConfirmation">		  			
								 		
								    <hr>
								    
								    <div style="width:275px; border:0px solid #000">
								    	<button id="btnChangePassword" class="btn btn-success"><i class="icon-ok"></i>&nbsp;&nbsp;Cambiar clave</button>
										<span class="pull-right">
											<button type="reset" class="btn"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
										</span>
									</div>																			 
							  	</form>
							  	
							  	<div class="alert-box" style="display:none"></div>
							  	
							</div>							
						</div>	
		   			</div>
					<!-- fin TAB CAMBIO DE CLAVE --> 
					
					
					<!-- TAB DESACTIVACION -->  
					<div class="tab-pane fade in" id="closeAccountTab">
					
						<div class="page-header">
				    		<h3>Desactivaci&oacute;n de cuenta</h3>
				    	</div>	
					
						<div class="row-fluid">			
					
							<div class="span7">			
								<form id="closeAccountForm" class="form-horizontal" method="POST">
									
									<p>
									   Lorem ipsum dolor sit amet, id nec conceptam conclusionemque. Et eam tation option. 
									   Utinam salutatus ex eum. Ne mea dicit tibique facilisi, ea mei omittam explicari conclusionemque, 
									   ad nobis propriae quaerendum sea.
									</p>
									
										<br>
									
									<label for="currentPassword"><strong>Ingrese su clave:</strong></label>
									<input type="password" id="currentPassword" name="currentPassword" class="input-xlarge">		  			
									
									
									<hr>	
									
									 <div style="width:275px; border:0px solid #000">
								    	<button id="btnCloseAccount" class="btn btn-danger"><i class="icon-minus-sign"></i>&nbsp;&nbsp;Cerrar cuenta</button>
										<span class="pull-right">
											<button type="reset" class="btn"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
										</span>
									</div>																	
					  				
								</form>
							</div>	  
						</div>				   				
		   			</div> 	
				    <!-- fin TAB DESACTIVACION -->
			    
			    </sec:authorize>
			  
         	</div>	
         	<!-- fin tab content -->
		 
	    </div>
	  </div>
	</div><!-- container fluid -->		
</div>
<!-- /content --> 	
<script src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.account.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.file.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/DT_bootstrap.js"></script>
<script type="text/javascript">	
	$(document).ready(function(){	
		var profileUserID = '${profileUser}';		
		fxlGlobalController.populateProvinceCombobox('${provinceList}', 'user');
		fxlAccountController.init(profileUserID);		
	});		
</script>