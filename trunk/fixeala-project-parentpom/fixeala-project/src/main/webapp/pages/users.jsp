	<div id="content">
	
        
<%--        <h3>${usuario}</h3> --%>
         
		<!-- User dashboard -->
<!--     	<ul id="dashboardTab" class="nav nav-tabs">		   -->
<!--     	  	<li class="active"><a href="#profile" data-toggle="tab"><i class="icon-user"></i>&nbsp;&nbsp;MI PERFIL</a></li> -->
<!-- 		    <li><a href="#account" data-toggle="tab"><i class="icon-wrench"></i>&nbsp;&nbsp;MI CUENTA</a></li> -->
<!-- 		    <li><a href="#issues" data-toggle="tab"><i class="icon-list"></i>&nbsp;&nbsp;MIS RECLAMOS</a></li> -->
<!-- 		    <li><a href="#messages" data-toggle="tab"><i class="icon-comments"></i>&nbsp;&nbsp;MIS MENSAJES</a></li> -->
<!-- 		    <li><a href="#activity" data-toggle="tab"><i class="icon-star"></i>&nbsp;&nbsp;MI ACTIVIDAD</a></li>		   -->
<!-- 	    </ul> -->
	    
	    <div class="row">
	    	<div class="span4 pull-left" style="padding:10px;text-align:left;margin:0; border:0px solid #000">
			  Bienvenido, <b>Guillermo R. Weissman</b>
			  <br>
			  <small>(Administrador)</small>
			</div>
			<div class="span4 pull-right" style="text-align:right;border:0px solid #000;">
			  <h4>Ministerio de Ambiente y Espacio P�blico</h4>
			  Ciudad de Buenos Aires, BA
			</div> 
		</div>
		
		<br>
	    
		<div class="container-fluid">
		  <div class="row-fluid">
		  
		    <!--Sidebar content-->
		    <div class="span2">
		      
		      <div class="span2" style="border-left:1px solid #ccc; margin-left:0;">
		              <ul id="dahsboard-nav" class="nav nav-list" style="width:170px;">
		                <li class="nav-header">DASHBOARD</li>
		                <li class="active"><a href="#">Inicio</a></li>
		                <li><a href="#notifications" data-toggle="tab">Notificaciones</a></li>
		                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
		                <li><a href="#map" data-toggle="tab">Mapa</a></li>
		                <li><a href="#comments" data-toggle="tab">Comentarios</a></li>
		                <li><a href="#users" data-toggle="tab">Usuarios</a></li>
		              
		                <li class="divider"></li>
		                
		                <li class="nav-header">CUENTA</li>
		                <li><a href="#">Perfil</a></li>
		                <li><a href="#">Seguridad</a></li>
		                <li><a href="#">Desactivación</a></li>
		              </ul>
		            </div>
		    </div>
		    
		    <!--Body content-->
		    <div class="span10">
		    
		    <!-- TAB CONTENT -->
		    <div class="tab-content">
				
				
				<!-- TAB RECLAMOS -->
				<div class="tab-pane fade in active" id="issues">
				    	<div class="page-header">
				    	<h3>Reclamos</h3>
				    	</div>
				    	
				    	<ul class="nav nav-tabs">
					    	<li class="active"><a href="#issuesNuevos" data-toggle="tab">Nuevos (3)</a></li>
						  	<li><a href="#issuesAsignados" data-toggle="tab">Asignados (1)</a></li>
						  	<li><a href="#issuesTodos" data-toggle="tab">Todos (4)</a></li>
						</ul>
						
						<div class="tab-content">
							<div class="tab-pane fade in active" id="issuesNuevos">
							   	<table class="table table-striped table-hover issueTable">
							    	<thead>
							    		<tr>
								   			<th>#</th>
								   			<th>Fecha</th>
								   			<th>Estado</th>
								   			<th>Título</th>
								   			<th>Dirección</th>
								   			<th>Barrio</th>
								   			<th>Usuario</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>2345</td>
							   				<td>12/03/13 14:22</td>
							   				<td>ABIERTO</td>
							   				<td><a href="#">Un bache mal arreglado</a></td>
							   				<td>Libertad 1111</td>
							   				<td>Recoleta</td>
							   				<td>Sin asignar</td>
							   			</tr>
							   			<tr>
							   				<td>4489</td>
							   				<td>15/03/13 09:45</td>
							   				<td>ABIERTO</td>
							   				<td><a href="#">El alumbrado está defectuoso</a></td>
							   				<td>Av. Córdoba 999</td>
							   				<td>San Nicolás</td>
							   				<td>Sin asignar</td>
							   			</tr>
							   			<tr>
							   				<td>7856</td>
							   				<td>12/03/13 14:22</td>
							   				<td>ABIERTO</td>
							   				<td><a href="#">Vereda destruida por obras</a></td>
							   				<td>Cochabamba 888</td>
							   				<td>San Telmo</td>
							   				<td>Sin asignar</td>
							   			</tr>
							   		</tbody>
							   	</table>
							   	<div class="pagination pagination-right">
								  <ul>
								    <li><a href="#">&laquo; Anterior</a></li>
								    <li><a href="#">1</a></li>
								    <li><a href="#">2</a></li>
								    <li><a href="#">3</a></li>
								    <li><a href="#">4</a></li>
								    <li><a href="#">5</a></li>
								    <li><a href="#">Siguiente &raquo;</a></li>
								  </ul>
								</div>
							</div>
							
							<div class="tab-pane fade" id="issuesAsignados">
								<table class="table table-striped table-hover">
							    	<thead>
							    		<tr>
								   			<th>#</th>
								   			<th>Fecha</th>
								   			<th>Estado</th>
								   			<th>Título</th>
								   			<th>Dirección</th>
								   			<th>Barrio</th>
								   			<th>Usuario</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>2345</td>
							   				<td>19/06/13 11:09</td>
							   				<td>ABIERTO</td>
							   				<td><a href="#">Arreglo defectuoso de alcantarilla</a></td>
							   				<td>Av. de Mayo 434</td>
							   				<td>Monsetrrat</td>
							   				<td><a href="#">FerreroP</a></td>
							   			</tr>
							   		</tbody>
							   	</table>
							</div>
						
							<div class="tab-pane fade" id="issuesTodos">
								Todos los reclamos.
							</div>
						</div>
						
						<!-- Context Menu -->
				    	<div id="contextmenu-issue" class="dropdown clearfix">
						    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
						      <li><a tabindex="-1" href="#"><i class="icon-paper-clip"></i>&nbsp;&nbsp;Ver detalles</a></li>
						      <li><a tabindex="-1" href="#"><i class="icon-globe"></i>&nbsp;&nbsp;Ver en mapa</a></li>
						      <li class="divider"></li>
						      <li><a tabindex="-1" href="#"><i class="icon-user"></i>&nbsp;&nbsp;Asignar a usuario</a></li>
						      <li class="divider"></li>
						      <li><a tabindex="-1" href="#"><i class="icon-thumbs-up-alt"></i>&nbsp;&nbsp;Admitir</a></li>
						      <li><a tabindex="-1" href="#"><i class="icon-ok"></i>&nbsp;&nbsp;Resolver</a></li>
						      <li><a tabindex="-1" href="#"><i class="icon-lock"></i>&nbsp;&nbsp;Cerrar</a></li>
						      <li><a tabindex="-1" href="#"><i class="icon-folder-open-alt"></i>&nbsp;&nbsp;Reabrir</a></li>
						    </ul>
  						</div>
				    	
				    	<script>
					    	$(function() {
					    		  
					    		  var $contextMenu = $("#contextmenu-issue");
					    		  
					    		  $("body").on("contextmenu", "table.issueTable tr", function(e) {
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
				    
				    
				    <!-- TAB MAPA -->
				    <div class="tab-pane fade" id="map">
				    	<div class="page-header">
				    		<h3>Mapa</h3>
				    	</div>
		         	</div>
		         	<!-- fin TAB MAPA -->
		         	
		         	
		         	<!-- TAB COMENTARIOS -->   
		         	<div class="tab-pane fade" id="comments">
		         		<div class="page-header">
				    		<h3>Comentarios</h3>
				    	</div>
				    	
				    	<ul class="nav nav-tabs">
					    	<li class="active"><a href="#commentsPublicados" data-toggle="tab">Publicados (1)</a></li>
						  	<li><a href="#commentsRecibidos" data-toggle="tab">Recibidos (1)</a></li>
						</ul>
						
						<div class="tab-content">
							<div class="tab-pane fade in active" id="commentsPublicados">
								<table class="table table-striped table-hover">
							    	<thead>
							    		<tr>
								   			<th>Fecha</th>
								   			<th>Descripción</th>
								   			<th>Nro. Reclamo</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>13/03/13 15:44</td>
							   				<td>El reclamo ha sido admitido. Se le ha asignado el Nº de trámite 98993/2.</td>
							   				<td><a href="#">2345</a></td>
							   			</tr>
							   		</tbody>
							   	</table>
							   	<div class="pagination pagination-right">
								  <ul>
								    <li><a href="#">&laquo; Anterior</a></li>
								    <li><a href="#">1</a></li>
								    <li><a href="#">2</a></li>
								    <li><a href="#">3</a></li>
								    <li><a href="#">4</a></li>
								    <li><a href="#">5</a></li>
								    <li><a href="#">Siguiente &raquo;</a></li>
								  </ul>
								</div>
							 </div>
							 <div class="tab-pane fade" id="commentsRecibidos">
								<table class="table table-striped table-hover">
							    	<thead>
							    		<tr>
								   			<th>Fecha</th>
								   			<th>Descripción</th>
								   			<th>Nro. Reclamo</th>
								   			<th>Usuario</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>14/05/13 09:33</td>
							   				<td>La vereda todavía no fue reparada.</td>
							   				<td><a href="#">7856</a></td>
							   				<td><a href="#">pedro77</a></td>
							   			</tr>
							   		</tbody>
							   	</table>
							 </div>
						</div>
				    </div>
				    <!-- fin TAB COMENTARIOS -->
				    	
				    	
				    <!-- TAB USUARIOS -->
				    <div class="tab-pane fade" id="users"> 	
		         		<div class="page-header">
				    		<h3>Usuarios</h3>
				    	</div>
				    	
				    	
				    	<!-- Modal -->
						<div id="userModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						  <div class="modal-header">
						    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
						    <h3 id="myModalLabel">Registro de nuevo usuario</h3>
						  </div>
						  <div class="modal-body">
						    <form class="form-horizontal">
							  <fieldset>
							  	 <div class="control-group">
								    <label class="control-label" for="inputPassword">Apellido y Nombre(s)</label>
								    <div class="controls">
								      <input type="text" id="inputPassword" placeholder="Nombre y Apellido">
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Usuario</label>
								    <div class="controls">
								      <input type="text" id="inputPassword" placeholder="Nombre de usuario">
								    </div>
							     </div>
								  <div class="control-group">
								  	<label class="control-label" for="inputEmail">Email</label>
								    <div class="controls">
								      <input type="text" id="inputEmail" placeholder="Email">
								    </div>
								  </div>
							      <div class="control-group">
								    <label class="control-label" for="inputPassword">Contrase�a</label>
								    <div class="controls">
								      <input type="password" id="inputPassword" placeholder="Contrase�a">
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Confirme contrase�a</label>
								    <div class="controls">
								      <input type="password" id="inputPassword" placeholder="Confirme contrase�a">
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Cargo</label>
								    <div class="controls">
								      <select class="span7">
								    	<option>Responsable de Area</option>
								    	<option>Asistente</option>
							    	  </select>
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Sub-Area</label>
								    <div class="controls">
									    <select class="span7">
									    	<option>S. S. de Administracion (SSADM)</option>
									    	<option>S. S. de Higiene Urbana (SSHU)</option>
									    	<option>D. G. Cementerios (CGCEM)</option>
									    	<option>D. G. Espacios Verdes (DGEV)</option>
									    	<option>D. G. Reciclado (DGREC)</option>
								    	</select>
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Rol</label>
								    <div class="controls">
								      <select class="span7">
								    	<option>Administrador</option>
								    	<option>Moderador</option>
								    	<option selected="selected">Usuario</option>
							    	  </select>
								    </div>
							     </div>
							   <div class="controls">
							      <label class="checkbox">
							        <input type="checkbox" checked="checked"> Activo
							      </label>
							      
							    </div>
							   
							  </fieldset>
							</form>
						  </div>
						  <div class="modal-footer" style="margin-bottom:0">
						    <button class="btn btn-primary"><i class="icon-ok"></i>&nbsp;&nbsp;Guardar</button>
						    <button class="btn" data-dismiss="modal" aria-hidden="true"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
						  </div>
						</div>
				    	
				    	
				    	<table class="table table-striped table-hover user-table">
					    	<thead>
					    		<tr>
						    		<th width="200">Nombre</th>
						    		<th>Cargo</th>
						    		<th width="200">Área</th>
						    		<th>Sub-Área</th>
						    		<th>Rol</th>
						    		<th>Estado</th>
					    		</tr>
					    	</thead>
					    	<tbody>
					    		<tr>
						    		<td>Fulgencio Pérez</td>
						    		<td>Responsable de Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>-</td>
						    		<td>Moderador</td>
						    		<td><span class="label label-success">Activo</span></td>
					    		</tr>
					    		<tr>
						    		<td>Mariano Daniel Campos</td>
						    		<td>Responsable de Sub-Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>D. G. Limpieza (DGLIM)</td>
						    		<td>Usuario</td>
						    		<td><span class="label label-success">Activo</span></td>
					    		</tr>
					    		<tr>
						    		<td>Gian Pablo Muraglia Pérez</td>
						    		<td>Responsable de Sub-Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>D. G. Alumbrado (DGALUM)</td>
						    		<td>Usuario</td>
						    		<td><span class="label label-error">Inactivo</span></td>
					    		</tr>
					    	</tbody>
				    	</table>
				    	
				    	<br><br>
				    	<center>
					    	<button href="#userModal" type="button" data-toggle="modal" 
					    	class="btn btn-medium btn-warning" >
					    		<i class="icon-plus"></i>&nbsp;&nbsp;Nuevo usuario
					    	</button>
				    	</center>
				    	
				    	<!-- Context Menu -->
				    	<div id="contextmenu-user" class="dropdown clearfix">
						    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
						        <li><a tabindex="-1" href="#"><i class="icon-user"></i>&nbsp;&nbsp;Detalles</a></li>
										      <li><a tabindex="-1" href="#"><i class="icon-pencil"></i>&nbsp;&nbsp;Editar</a></li>
										      <li><a tabindex="-1" href="#"><i class="icon-trash"></i>&nbsp;&nbsp;Borrar</a></li>
										      <li class="divider"></li>
										      <li><a tabindex="-1" href="#"><i class="icon-lock"></i>&nbsp;&nbsp;Deshabilitar</a></li>
							      			  <li class="disabled"><a tabindex="-1" href="#"><i class="icon-unlock"></i>&nbsp;&nbsp;Habilitar</a></li>
						    </ul>
  						</div>
				    	
				    	<script>
					    	$(function() {
					    		  
					    		  var $contextMenu = $("#contextmenu-user");
					    		  
					    		  $("body").on("contextmenu", "table.user-table tr", function(e) {
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
		         	<!-- tab END USUARIOS -->
		         		
		         		
		         		
		         		<!-- ESTADI�STICAS -->
		         		
		         		
	         		<!-- NOTIFICACIONES -->
	         		<div class="tab-pane fade" id="notifications"> 	
		         		<div class="page-header">
				    		<h3>Notificaciones</h3>
				    	</div>
				    	
				    	<table class="table table-hover offset1" style="width:700px;">
					    	<tr>
					    		<td style="border-top:none;"><i class="icon-map-marker"></i></td>
						    	<td style="border-top:none;width:500px">Nuevo reclamo <a href="#">#4455</a> pubicado por <a href="#">fulanito_11</a></td>
						    	<td style="border-top:none;"><i class="icon-time icon-grey"></i> hace 11 minutos</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-comments-alt"></i></td>
						    	<td>Nuevo comentario pubicado por <a href="#">fulanito_11</a></td>
						    	<td><i class="icon-time icon-grey"></i> hace 2 horas</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-ok"></i></td>
						    	<td>El reclamo <a href="#">#78657</a>fue <span class="label label-success">resuelto</span> por <a href="#">fulanito_11</a></td>
						    	<td><i class="icon-time icon-grey"></i> ayer</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-map-marker"></i></td>
						    	<td>Nuevo reclamo <a href="#">#4344</a> publicado por <a href="#">GustavoF</a></td>
						    	<td><i class="icon-time icon-grey"></i> 16/10/2013</td>
						    <tr>
				    	</table>
			    	</div>
			    	<!-- end TAB NOTIFICACIONES -->
				    	
		         		
		         		<!-- ACTIVIDAD -->
		         
						
						<!-- PERFIL -->
						
						
						<!-- CONTRASEÑA -->
						
						
						<!-- DESACTIVACION -->      		
		         		
	         	</div>	
	         	<!-- fin tab content -->
			 
		    </div>
		  </div>
		</div>

	
	   
	  
<!-- 		<div id="dashboardTabContent" class="tab-content"> -->

<!-- 			<div class="tab-pane fade in active" id="profile"> -->
			
<!-- 			<div id="profileBox" class="span6 well">	 -->

<!-- 				Profile... -->
		
<!-- 			</div> -->

<!-- 			</div> -->
			
<!-- 			<div class="tab-pane fade in" id="account"> -->
			
<!-- 				<div id="accountBox" class="span6 well"> -->
										
<!--    						<div class="row" > -->
    					
<!--    								<div class="span6">    								 -->
<!--    									<form class="form-horizontal" id="uploadForm"> -->
<!--    										<fieldset>   									  									 -->
<!-- 		   									<legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Edición de cuenta</legend> -->
<!-- 		   									<div class="thumbnail"> -->
<%-- 												<img id="profilePic" src="${pageContext.request.contextPath}/resources/images/01-mario.jpg" alt=""  > --%>
<!-- 											</div> -->
		   								
<!-- 			   								<span class="btn fileinput-button"> -->
<!-- 					                   			<i class="icon-plus icon-white"></i>&nbsp;&nbsp; -->
<!-- 					                   			<span>Seleccionar archivo</span> -->
<!-- 			               					</span> -->
<!-- 										</fieldset> -->
								
<!-- 								  	 	<fieldset>								  	 					 -->
<!-- 											 <div class="input-prepend"> -->
<!-- 											 	<span class="add-on"><i class="icon-envelope"></i></span> -->
<%-- 											 	<input type="text" id="email" value="${email}" placeholder="Dirección de email" class="input-xlarge" >		 --%>
<!-- 											 	<label class="control-label" style="width:auto;float:right; text-align:left;margin-left:10px;line-height:30px;">(no será publicado)</label>												  -->
<!-- 											 </div>											 	 -->
<!-- 											 <div class="input-prepend"> -->
<!-- 											 	<span class="add-on"><i class="icon-home"></i></span> -->
<%-- 											 	<input type="text" id="barrio" value="${barrio}" placeholder="Barrio / Localidad" class="input-xlarge" > --%>
<!-- 											 	<label class="control-label" style="width:auto;float:right; text-align:left;margin-left:10px;line-height:30px;">(opcional)</label>			 -->
<!-- 											 </div>		 -->
<!-- 										 </fieldset> -->
<!-- 										 <fieldset>										 	 					  -->
<!-- 											 <button id="btnUpdateAccount" class="btn btn-primary">Actualizar datos</button>&nbsp;&nbsp; -->
<!-- 											 <button type="reset" class="btn">Cancelar</button> -->
<!-- 										</fieldset>								 -->
<!-- 									</form>									 -->
<!-- 								</div> -->
<!-- 								<div class="span6"> 			 -->
<!-- 									<form class="form-horizontal"> -->
<!-- 										<fieldset>	 -->
<!-- 										     <legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Cambio de contraseña</legend>	 		 -->
<!-- 											 <div class="input-prepend"> -->
<!-- 												 <span class="add-on"><i class="icon-lock"></i></span> -->
<!-- 												 <input type="password" id="currentPassword" placeholder="Contraseña actual" class="input-xlarge">		  			 -->
<!-- 											 </div> -->
											 
<!-- 											 <div class="input-prepend"> -->
<!-- 												 <span class="add-on"><i class="icon-lock"></i></span> -->
<!-- 												 <input type="password" id="newPassword" placeholder="Nueva contraseña" class="input-xlarge">		  			 -->
<!-- 											 </div> -->
											 
<!-- 											  <div class="input-prepend"> -->
<!-- 												 <span class="add-on"><i class="icon-lock"></i></span> -->
<!-- 												 <input type="password" id="newPasswordConfirmation" placeholder="Confirme nueva contraseña" class="input-xlarge">		  			 -->
<!-- 											 </div>								  								  			 -->
<!-- 							  			</fieldset> -->
<!-- 							  			<fieldset>										 	 					  -->
<!-- 											 <button id="btnUpdateAccount" class="btn btn-primary">Actualizar contraseña</button>&nbsp;&nbsp; -->
<!-- 											 <button type="reset" class="btn">Cancelar</button> -->
<!-- 										</fieldset> -->
<!-- 									</form> -->
<!-- 								</div> -->
							
<!-- 								<div class="span6"> 			 -->
<!-- 									<form id="closeAccountForm" class="form-horizontal"> -->
<!-- 										<fieldset>	 -->
<!-- 										     <legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Desactivación de cuenta</legend>	 		 -->
<!-- 											 <div class="input-prepend"> -->
<!-- 												 <span class="add-on"><i class="icon-lock"></i></span> -->
<!-- 												 <input type="password" id="currentPassword" placeholder="Contraseña actual" class="input-xlarge">		  			 -->
<!-- 											 </div>																				 -->
<!-- 							  			</fieldset> -->
<!-- 							  			<fieldset>										 				  -->
<!-- 											 <button id="btnCloseAccount" class="btn btn-primary">Cerrar cuenta</button>&nbsp;&nbsp; -->
<!-- 											 <button type="reset" class="btn">Cancelar</button> -->
<!-- 										</fieldset> -->
<!-- 									</form> -->
<!-- 								</div>							 -->
<!-- 						</div> -->
			
<!-- 			 </div> -->
				
<!-- 			</div> -->
			
		
		</div>
		<!-- /dashboardTabContent -->
		    
	</div>
	<!-- /content -->  