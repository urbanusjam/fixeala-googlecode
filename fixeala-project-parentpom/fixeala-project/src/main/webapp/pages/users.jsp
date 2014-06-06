<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">

	th, td { font-size: 12px; }
	.table-striped tbody tr.highlight td { background-color: #A8D3E6; }
	
</style>


	<script type="text/javascript">
	
	var rowId;
	var rowTitle;
	var selectedUser;
	var currentUser = '${profileUser}';
	
	function errorHandler (jqXHR, exception) {
        if (jqXHR.status === 0) {
            alert('Not connect.\n Verify Network.');
        } else if (jqXHR.status == 404) {
            alert('Requested page not found. [404]');
        } else if (jqXHR.status == 500) {
            alert('Internal Server Error [500].');
        } else if (exception === 'parsererror') {
            alert('Requested JSON parse failed.');
        } else if (exception === 'timeout') {
            alert('Time out error.');
        } else if (exception === 'abort') {
            alert('Ajax request aborted.');
        } else {
            alert('Uncaught Error.\n' + jqXHR.responseText);
        }
	}
	
	
	function redirect(){
		var url = window.location.origin + '/'+ 'fixeala/issues/' + rowId + '.html';
		return window.location.href = url;
	}
	

	
	</script>




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
					        <small><cite>Vecino de <i>${neighborhood}</i>&nbsp;&nbsp;<i class="icon-map-marker"></i></cite></small>			
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
					              			<a  href="#profile" data-toggle="tab">
					              				<i class="icon-caret-right"></i>PERFIL
					              			</a>
					              		</li>
					              		<li class="nav-header"><i class="icon-caret-right"></i>CONTENIDO</li>						               
						                <li><a href="#issues" data-toggle="tab"><i class="icon-pushpin"></i>Reclamos</a></li>
						                <li><a href="#comments" data-toggle="tab"><i class="icon-comments-alt"></i>Comentarios</a></li>							           	    
    							</sec:authorize>			              
			              								              	
				              	<!-- AUTHENTICATED -->
				              	<sec:authorize access="isAuthenticated() and hasRole('ROLE_USER')">
				              					              		
				              		<!-- MENU USER -->
				              		<c:if test="${ loggedMatchesProfile }">
					              		<li class="nav-header active">
					              			<a  href="#profile" data-toggle="tab">
					              				<i class="icon-caret-right"></i>PERFIL
					              			</a>
					              		</li>
					              		<li class="nav-header">
					              			<a  href="#dashboard" data-toggle="tab">
					              				<i class="icon-caret-right"></i>DASHBOARD
					              			</a>
					              		</li>
					              		<li class="nav-header"><i class="icon-caret-right"></i>CONTENIDO</li>
						                <li><a href="#notifications" data-toggle="tab"><i class="icon-bell"></i>Notificaciones</a></li>
						                <li><a href="#activity" data-toggle="tab"><i class="icon-check"></i>Actividad</a></li>
						                <li><a href="#issues" data-toggle="tab"><i class="icon-pushpin"></i>Reclamos</a></li>
						                <li><a href="#comments" data-toggle="tab"><i class="icon-comments-alt"></i>Comentarios</a></li>
						                <li><a href="#widgets" data-toggle="tab"><i class="icon-cogs"></i>Widgets</a></li>

						                <li class="nav-header"><i class="icon-caret-right"></i>CUENTA</li>
						                <li><a href="#editAccount" data-toggle="tab"><i class="icon-edit-sign"></i>Datos personales</a></li>
						                <li><a href="#changePassword" data-toggle="tab"><i class="icon-unlock"></i>Cambio de clave</a></li>
						                <li><a href="#closeAccount" data-toggle="tab"><i class="icon-ban-circle"></i>Desactivación</a></li>
				              		</c:if>
				              		
				              		<!-- MENU ANONYMOUS -->
				              		<c:if test="${ !loggedMatchesProfile }">				              	 	
						              	<li class="nav-header active">
					              			<a  href="#profile" data-toggle="tab">
					              				<i class="icon-caret-right"></i>PERFIL
					              			</a>
					              		</li>
					              		<li class="nav-header"><i class="icon-caret-right"></i>CONTENIDO</li>						               
						                <li><a href="#issues" data-toggle="tab"><i class="icon-pushpin"></i>Reclamos</a></li>
						                <li><a href="#comments" data-toggle="tab"><i class="icon-comments-alt"></i>Comentarios</a></li>		
				              	</c:if>
				              	</sec:authorize>			              		
			              </ul>
			    </div>
			    
			    <!--Body content-->
			    <div class="span9" style="float:right; width:940px;">
			    
			    <!-- TAB CONTENT -->
			    <div class="tab-content">			    
			    
		    		<!-- TAB PROFILE -->
         			<div class="tab-pane fade in active" id="profile"> 	         			
         				<div class="page-header">
				    		<h3>Perfil p&uacute;blico</h3>
				    	</div>				    	
				    	<div class="row" style="margin: 0 auto; border: 0px solid #000; ">				    	
						    <div class="span3" style="border: 0px solid #000; ">		
						    	<span class="thumbnail" style="width:200px; height:200px">				     
									<img src="${pageContext.request.contextPath}/resources/images/nopic.png" />
								</span>										
								<div class="thumbnail" style="text-align:center; width:200px;">
              						<small style="text-align:center">Registrado el ${registrationDate}</small>		
    							</div>	    																
								 <div class="thumbnail" style="text-align:center; width:200px;">	              						
              						<small style="text-align:center">33 visitas</small>	
    							</div>			
						    </div>
							<div class="span2 thumbnail" style="text-align:center" title="Reclamos publicados">
             						<i class="icon-pushpin icon-4x"></i>
             						<h2>${total_issues}</h2>
             						<strong>PUBLICADOS</strong>
   							</div>   							
   							<div class="span2 thumbnail" style="text-align:center" title="Reclamos resueltos">
             						<i class="icon-ok icon-4x"></i>
             						<h2>${total_solved}</h2>
             						<strong>RESUELTOS</strong>
   							</div> 
   							<div class="span2 thumbnail" style="text-align:center" title="Reclamos votados">
             						<i class="icon-thumbs-up icon-4x"></i>
             						<h2>${total_voted}</h2>
             						<strong>VOTADOS</strong>
   							</div>   							
   							<div class="span2 thumbnail" style="text-align:center" title="Reclamos en seguimiento">
             						<i class="icon-screenshot icon-4x"></i>
             						<h2>${total_followings}</h2>
             						<strong>OBSERVANDO</strong>
   							</div>   							
   							<div class="span2 thumbnail" style="text-align:center" title="Comentarios realizados">
             						<i class="icon-warning-sign icon-4x"></i>
             						<h2>${total_flagged}</h2>
             						<strong>DENUNCIADOS</strong>
   							</div>   							
   							<div class="span2 thumbnail" style="text-align:center" title="Comentarios realizados">
             						<i class="icon-comments icon-4x"></i>
             						<h2>${total_comments}</h2>
             						<strong>COMENTARIOS</strong>
   							</div> 
   							<div class="span2 thumbnail" style="text-align:center">
             						<i class="icon-cogs icon-4x"></i>
             						<h2>${total_widgets}</h2>
             						<strong>WIDGETS</strong>
   							</div>   						
   						</div>				    	
			    	</div>
					<!-- fin TAB PROFILE -->
					
										
					<!-- TAB RECLAMOS -->
					<div class="tab-pane fade in" id="issues">
					    	<div class="page-header">
					    		<h3>Reclamos</h3>
					    	</div>
					    	
					    	<ul class="nav nav-tabs">
								<li class="active"><a href="#issuesPublished" data-toggle="tab">Publicados (${total_issues})</a></li>
								<li><a href="#issuesFollowing" data-toggle="tab">Siguiendo (0)</a></li>
								<li><a href="#issuesVoted" data-toggle="tab">Votados (0)</a></li>
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
							      <li><a tabindex="-1" href="javascript:redirect();"><i class="icon-paper-clip"></i>&nbsp;&nbsp;Ver detalles</a></li>
							      <li><a tabindex="-1" href="#"><i class="icon-globe"></i>&nbsp;&nbsp;Ver en mapa</a></li>							    
							      <li class="divider" id="actionsDivider"></li>						      	
						      	  <li><a tabindex="-1" href="#" onclick="updateStatus('RESUELTO');"><i class="icon-ok"></i>&nbsp;&nbsp;Resolver</a></li>
						      	  <li><a tabindex="-1" href="#" onclick="updateStatus('CERRADO');"><i class="icon-lock"></i>&nbsp;&nbsp;Cerrar</a></li>
						      	  <li><a tabindex="-1" href="#" onclick="updateStatus('REABIERTO');"><i class="icon-folder-open-alt"></i>&nbsp;&nbsp;Reabrir</a></li>  
							    </ul>
	  						</div>
	  											    	
					    	<script>
							    	$(function() {
							    		
							    		  var $contextMenu = $("#contextmenu-issue");
							    		  
							    		  $("body").on("contextmenu", "#tblUserIssues tr", function(e) {
							    		  	$contextMenu.css({
								    		      display: "block",
								    		      left: e.pageX,
								    		      top: e.pageY
							    		    });
							    		    return false;
							    		  });
							    		  
							    		  $contextMenu.on("click", "a", function() {
							    		     $contextMenu.hide();
							    		  });
							    		  
							    		  $("body").on("click", function() {
								    		     $contextMenu.hide();
								    	  });
							    		  
							    	});
					    	</script>
					    	
					    </div>
					    <!-- fin TAB RECLAMOS -->
					    
					  
			         	
			         	<!-- TAB COMENTARIOS -->   
			         	<div class="tab-pane fade" id="comments">
			         		<div class="page-header">
					    		<h3>Comentarios</h3>
					    	</div>
					    	
					    	<ul class="nav nav-tabs">
						    	<li class="active"><a href="#commentsPublicados" data-toggle="tab">Publicados (${total_comments})</a></li>
							  	<li><a href="#commentsRecibidos" data-toggle="tab">Recibidos (0)</a></li>
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
		         			<div class="tab-pane fade in" id="dashboard"> 	
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
		         			<div class="tab-pane fade" id="activity"> 	
				         		<div class="page-header">
						    		<h3>Actividad</h3>
						    	</div>
					    	</div>
							<!-- fin tab ACTIVIDAD -->
							
						    
						    <!-- TAB WIDGETS -->   
				         	<div class="tab-pane fade" id="widgets">
				         		<div class="page-header">
						    		<h3>Widgets</h3>
						    	</div>
						    </div>
						     <!-- fin TAB WIDGETS -->
						     
						    
						    <!-- TAB DATOS PERSONALES -->
							<div class="tab-pane fade in" id="editAccount">						
								<div class="page-header">
						    		<h3>Datos personales</h3>
						    	</div>	
	 								
	 							<div class="row-fluid">
						            <div class="span9">
						                <div class="span5">
							                <div class="logowrapper">
							                    <div class="fileupload fileupload-new" data-provides="fileupload" style="display:inline-block">
													<div class="fileupload-new thumbnail">
														<c:if test="${not empty image}">											    								  	  			  	   		
															<img src="${pageContext.request.contextPath}/uploads/${imageUrl}" alt="${imageName}">	
											    		</c:if>
											    		<c:if test="${empty image}">											    		
															<img src="${pageContext.request.contextPath}/resources/images/nopic.png" alt="">
											    		</c:if>
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail" style="height: 100px;min-width:100px;max-width: 100px; max-height: 100px; line-height: 20px;"></div>
													
													<span class="btn fileinput-button" style="line-height:30px; width:auto; font-size:12px">
												        <i class="icon-plus"></i>&nbsp;&nbsp;
												        <span>Seleccionar archivo</span>									        
												           <input type="file" name="files[]" id="fileupload-profile">
												    </span>									  
												</div>		
							                </div>
						                </div>
					                	<div class="span7">
					                		<form class="form-horizontal" id="updateAccountForm">					              
											    <label for="email">Email</label>
											    <input type="text" id="email" name="email" class="input-large" value="${email}">
											  									
											    <label for="neighborhood">Barrio</label>
											    <input type="text" id="neighborhood" name="neighborhood" value="${neighborhood}" class="input-large"> 
											  										
<!-- 											    <label for="city">Ciudad</label> -->
<%-- 											    <input type="text" id="city" name="city" class="input-large" value="${city}"> --%>
											 										
<!-- 											    <label for="province">Provincia</label> -->
<%-- 											    <input type="text" id="province" name="province" class="input-large" value="${province}">  --%>
											    
											    <hr>
											    <button id="btnUpdateAccount" class="btn btn-success"><i class="icon-ok"></i>&nbsp;&nbsp; Guardar datos</button>								 
										  	</form>
										</div>
									</div>
								</div>		
							</div> 
							<!-- fin TAB DATOS PERSONALES --> 
							
							
							<!-- TAB CAMBIO DE CLAVE -->
							<div class="tab-pane fade in" id="changePassword">
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
							<div class="tab-pane fade in" id="closeAccount">
							
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