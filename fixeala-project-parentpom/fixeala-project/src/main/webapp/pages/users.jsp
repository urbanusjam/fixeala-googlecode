<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">

	th, td { font-size: 12px; }
	.table-striped tbody tr.highlight td { background-color: #A8D3E6; }
	
</style>

<div id="content">

	<script type="text/javascript">
	
	var rowId;
	var rowTitle;
	var selectedUser;
	var currentArea = '${current_areaID}';
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
	
	function assignUser(){
		var url = "http://localhost:8080/fixeala/issues/assignUser.html";
	    var data = 'selectedUser='+ selectedUser + '&issueID='+ rowId;
  
		$.ajax({
				url: url,
			 	dataType: 'text',
			 	data: data,
         		type: 'POST', 
	            success: function(response) { 
	            	$("#assignUserModal").modal('hide');
	            	
	            	setTimeout(function(){
	            		$("#tblUserIssues").datagrid('reload');
	            	}, 1000);
	            	
	            },
	            error: function(jqXHR, exception){
	            	errorHandler (jqXHR, exception);
	            }
	            
		});
	}
	
	function updateStatus(status){
		    var url = "http://localhost:8080/fixeala/issues/updateIssueStatus.html";
		    var data = 'newStatus='+ status + '&issueID='+ rowId;
	     
			$.ajax({
					url: url,
				 	dataType: 'text',
				 	data: data,
             		type: 'POST', 
		            success: function(response) { 
		            	$("#tblUserIssues").datagrid('reload');
		            },
		            error: function(jqXHR, exception){
		            	errorHandler (jqXHR, exception);
		            }
			});
	}
	

	
	$(function(){
		
		 $('#backendUserForm input[type="text"], #backendUserForm input[type="password"]').tooltipster({ 		    
		    	animation: 'fade',		
		    	delay: 200,
		    	interactive: true,
		    	timer: 2500,
		    	maxWidth: 230,
		        trigger: 'custom', 
		        onlyOne: false,    
		        position: 'right'  
		    });
		
		$("#backendUserForm").validate({		
			
			rules: 
			{	 
				 onfocusin: false,	
				 
				 apellido: {  required : true },
				 
				 nombre: {  required : true },
			
				 username: { 
					 required : true, 
					 minlength: 4,
					 maxlength: 20,
					 remote: {
			 	    		url: "http://localhost:8080/fixeala/account/signup/checkUsernameAvailability.html", 
							type: "POST", 
							data: {
						        username: function(){ return $("#backendUserForm #username").val(); }
						    }		
		 	    	 }					 	    	
				 },								
		 	     email: { 
		 	    	 required : true,
		 	    	 email : true,
		 	    	 remote: {
			 	    		url: "http://localhost:8080/fixeala/account/signup/checkEmailAvailability.html", 
							type: "POST", 
							data: {
						        email: function(){ return $("#backendUserForm #email").val(); }
						      }		
		 	    	 }
		 	     },
				 password: {  
					 required : true, 
					 minlength: 6,
					 maxlength: 30
				 } ,
	   	    	 confirmPassword: {		
	   	    		 required : true, 
	   	      		 equalTo: "#password"				   	      		 
	   	    	 },
	   	    	
		 	}, 	 
		 	
			 	messages: 
			 	{ 	 	 
			 			apellido: {	required: "Este campo es requerido." },
			 			
			 			nombre: { required: "Este campo es requerido." },
			 		    
		     			username: 
		     			{		
		     					required: "Este campo es requerido.",	 	     			 	
		     			 		minlength: "El nombre de usuario debe tener por lo menos 4 caracteres.",
		     			 		maxlength: "El m&aacute;ximo es de 20 caracteres.",
		     			 		remote: "El nombre de usuario ya ha sido registrado."
		     		 	},
		     			email: 
		     			{
		     					required: "Este campo es requerido.",	 	
		     					email: "Ingrese una direcci&oacute;n de email v&aacute;lida.",
		     					remote: "La direcci&oacute;n de email ya ha sido registrada."
		     			},
		     			password: 
		     			{		
		     					required: "Este campo es requerido.",	 	
		     			 		minlength: "La contrase&ntilde;a debe tener por lo menos 6 caracteres.",
		     			 		maxlength: "El m&aacute;ximo es de 30 caracteres."
		     		 	},			     				
	 				confirmPassword: 
	 				{			     				
	 						equalTo:  "La contrase&ntilde;a y la confirmaci&oacute;n no coinciden.",
	 						required: "Este campo es requerido."
	 				}
	 				
		     	},
		    	
		    	highlight: function (element) { 
		    		$(element).closest('.control-group').removeClass('success').addClass('error');
			},
		    	
		    unhighlight: function (element) { 
		    	$(element).closest('.control-group').removeClass('error');
		    },

	 		errorPlacement: function (error, element) {
	 			$(element).closest('.control-group').tooltipster('update', $(error).text());
	 			$(element).closest('.control-group').tooltipster('show');				        
	        }
		    	
			});
		
		
		$("#btn-saveBackendUser").click(function(){
			
			$backendUserForm = $("#backendUserForm");
			
			if( $backendUserForm.valid() ){	
				
				alert("valid");
		
				var url = "http://localhost:8080/fixeala/account/signup.html";
				var backendUser = true;
				 
				$.ajax({
						url: url,
						data: 'user='+ $("#backendUserForm").serialize() + '&userArea=' + currentArea + '&backendUser=' + backendUser,
					 	dataType: 'json',
	             		type: 'POST', 
			            success: function(alertStatus) { 
			            	$("#userModal").modal('hide');
			            	
			            	setTimeout(function(){		
			            		bootbox.alert(alertStatus.message);
	// 		            		setTimeout(function(){		
	// 		            			$("#tblUsers").datagrid('reload');
	// 		            		}, 600);
			            	}, 600);
			            },
			            error: function(jqXHR, exception){
			            	errorHandler (jqXHR, exception);
			            }
				});
			}
			
		});
		
		$("#combo-users").select2({
	        placeholder: "Buscar usuario...",
	        minimumInputLength: 1,
	        multiple: true,
	        ajax: { 
	            url: "http://localhost:8080/fixeala/issues/getAvailableUsers/" +currentArea+ ".html",
	        	dataType: 'json',
	        	quietMillis: 100,
	            data: function (term) {
	                return {
	                    term: term
	                };
	            },
	            results: function (data) {
	              var results = [];
	              $.each(data, function(index, item){
	                results.push({
	                  id: item.id,
	                  text: item.nombre + " " + item.apellido + " (" + item.username + ")"
	                });
	              });
	              return {
	                  results: results
	              };
	            },
	            formatResult: function (item) { return item.nombre; },
                formatSelection: function (item) { return item.email; }

	   
	        } 
	    });
		
		$("#combo-users")
//         .on("change", function(e) { 
//         	alert("change "+JSON.stringify({val:e.val, added:e.added, removed:e.removed})); 
//         	})
        .on("select2-selecting", function(e) { 
        	selectedUser = e.val;
        	//alert("selecting val="+ e.val+" choice="+ JSON.stringify(e.choice));
        	})
					
			$('#tblUserIssues').on('click', 'tbody tr', function(event) {
			    $(this).addClass('highlight').siblings().removeClass('highlight');
			});
			
			
			$("#tblUserIssues").delegate("tr", "contextmenu", function(e) {
				$(this).each(function(){
					rowId = $(this).find("td").eq(0).html().trim(); 
					rowTitle = $(this).find("td").eq(2).html().trim(); 
				});
			});
		
		});
	
	</script>

	    
	    
	 	<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	 	<!--------------------------- AUTHENTICATED USER ------------------------------------------------------------------------>
	 	
	    <sec:authorize access="isAuthenticated()">
	    
		    <div class="row">
	    	   	<div class="span4 pull-left" style="padding:10px;text-align:left;margin:0; border:0px solid #000">
	    	   		<c:if test="${ loggedMatchesProfile }">
	    	   			Bienvenid@, <b>${current_nombre} ${current_apellido}</b>
					    <br>
	    	   			<sec:authorize access="hasRole('ROLE_ADMIN')">
					  		<small>(Administrador)</small>
					  	</sec:authorize>
					  	<sec:authorize access="hasRole('ROLE_MANAGER')">
					  		<small>(Moderador)</small>
					  	</sec:authorize>
					</c:if>
				</div>
				<div class="span4 pull-right" style="text-align:right;border:0px solid #000;">
					<c:if test="${ ! empty current_area }">
					  <h3>${current_area}</h3>
					  <br>
					  <small>${current_ciudad}, ${current_provincia}</small>
					</c:if>
					<c:if test="${ !loggedMatchesProfile }">
			  			<h3>${profileUser}</h3>
					  	<br>
					  	<small>${barrio}</small>
			  		</c:if>
				</div> 
			</div>
		
			<br>
	    
			<div class="container-fluid">
			  <div class="row-fluid">
			  
			    <!--Sidebar content-->
			    <div class="span2">
			      	<div class="span2" style="border-left:1px solid #ccc; margin-left:0;">
			              <ul id="dahsboard-nav" class="nav nav-list" style="width:170px;">
			              		<c:if test="${ loggedMatchesProfile }">
			              			<!-- MENU ADMIN -->
					              	<sec:authorize access="hasRole('ROLE_ADMIN')">
					              		<li class="nav-header">DASHBOARD</li>
						                <li class="active"><a href="#">Inicio</a></li>
						                <li><a href="#notifications" data-toggle="tab">Notificaciones</a></li>
						                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
						                <li><a href="#map" data-toggle="tab">Mapa</a></li>
						                <li><a href="#comments" data-toggle="tab">Comentarios</a></li>
						                <li><a href="#users" data-toggle="tab">Usuarios</a></li>
					              	</sec:authorize>
					              	
					              	<!-- MENU MANAGER -->
					              	<sec:authorize access="hasRole('ROLE_MANAGER')">
					              		<li class="nav-header">DASHBOARD</li>
						                <li class="active"><a href="#">Inicio</a></li>
						                <li><a href="#notifications" data-toggle="tab">Notificaciones</a></li>
						                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
						                <li><a href="#map" data-toggle="tab">Mapa</a></li>
						                <li><a href="#comments" data-toggle="tab">Comentarios</a></li>
					              	</sec:authorize>
					              	
					              	<!-- MENU USER -->
					              	<sec:authorize access="hasRole('ROLE_USER')">
						              		<li class="nav-header">DASHBOARD</li>
							                <li class="active"><a href="#">Inicio</a></li>
							                <li><a href="#notifications" data-toggle="tab">Notificaciones</a></li>
							                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
							                <li><a href="#comments" data-toggle="tab">Comentarios</a></li>
							                <li class="divider"></li>
							                <li class="nav-header">CUENTA</li>
							                <li><a href="#">Perfil</a></li>
							                <li><a href="#">Seguridad</a></li>
							                <li><a href="#">Desactivacion</a></li>
					              	</sec:authorize>
			              		</c:if>
			              		
			              		<c:if test="${ !loggedMatchesProfile }">
				              	 	<!-- MENU ADMIN / MAANGER -->
					              	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
					              		<li class="nav-header">DASHBOARD</li>
						                <li class="active"><a href="#">Inicio</a></li>
						                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
					              	</sec:authorize>
					              	
					              	<!-- MENU USER -->
					              	<sec:authorize access="hasRole('ROLE_USER')">
						              	<c:if test="${ !loggedMatchesProfile }">
						              		<li class="nav-header">DASHBOARD</li>
							                <li class="active"><a href="#">Inicio</a></li>
							                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
						              	</c:if>		
					              	</sec:authorize>
				              	</c:if>
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
						    	<li class="active"><a href="#issuesAsignados" data-toggle="tab">Asignados</a></li>
							</ul>
							
							
							<div class="tab-content">
								<div class="tab-pane fade in active" id="issuesAsignados">
								   	<table id="tblUserIssues" cellpadding="0" cellspacing="0" border="0"  data-toggle="context" data-target="#contextmenu-issue"
    								class="table table-striped table-bordered table-hover datagrid datagrid-stretch-header">
									<thead>
									<tr>
										<th>#</th>
										<th>FECHA</th>
										<th>TITULO</th>
										<th>DIRECCION</th>
										<th>BARRIO</th>
										<th>CIUDAD</th>
										<th>PROVINCIA</th>
										<th>USUARIO</th>
										<th>ESTADO</th>
									</tr>
									</thead>
							
									<tfoot>
									<tr>
										<th>
											<div class="datagrid-footer-left" style="display:none;">
												<div class="grid-controls">
													<span>
														<span class="grid-start"></span> -
														<span class="grid-end"></span> de
														<span class="grid-count"></span>
													</span>
													<div class="select grid-pagesize" data-resize="auto">
														<button data-toggle="dropdown" class="btn dropdown-toggle">
															<span class="dropdown-label"></span>
															<span class="caret"></span>
														</button>
														<ul class="dropdown-menu">
															<li data-value="5" data-selected="true"><a href="#">5</a></li>
															<li data-value="10"><a href="#">10</a></li>
															<li data-value="20"><a href="#">20</a></li>
															<li data-value="50"><a href="#">50</a></li>
															<li data-value="100"><a href="#">100</a></li>
														</ul>
													</div>
													<span>Por P�gina</span>
												</div>
											</div>
											<div class="datagrid-footer-right" style="display:none;">
												<div class="grid-pager">
													<button type="button" class="btn grid-prevpage"><i class="icon-chevron-left"></i></button>
													<span>P�gina</span>
							
													<div class="input-append dropdown combobox">
														<input class="span1" type="text">
														<button class="btn" data-toggle="dropdown"><i class="caret"></i></button>
														<ul class="dropdown-menu"></ul>
													</div>
													<span>de <span class="grid-pages"></span></span>
													<button type="button" class="btn grid-nextpage"><i class="icon-chevron-right"></i></button>
												</div>
											</div>
										</th>
									</tr>
									</tfoot>
								</table>
								</div>
													
							</div>
							
							<!-- Context Menu -->
					    	<div id="contextmenu-issue" class="dropdown clearfix">
							    <ul id="ctxMenu" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
							      <li><a tabindex="-1" href="javascript:redirect();"><i class="icon-paper-clip"></i>&nbsp;&nbsp;Ver detalles</a></li>
							      <li><a tabindex="-1" href="#"><i class="icon-globe"></i>&nbsp;&nbsp;Ver en mapa</a></li>
							      <li class="divider"></li>
							      <li><a tabindex="-1" href="#assignUserModal" data-toggle="modal"><i class="icon-user"></i>&nbsp;&nbsp;Asignar a usuario</a></li>
							      <li class="divider" id="actionsDivider"></li>
						      	  <li><a tabindex="-1" href="#" onclick="updateStatus('ADMITIDO');"><i class="icon-thumbs-up-alt"></i>&nbsp;&nbsp;Admitir</a></li>
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
					    	
					    	<table id="tblBackendUsers" class="table table-striped table-bordered table-hover datagrid datagrid-stretch-header">
						    	<thead>  
						    		<tr>
						    			<th></th>
							    		<th>USUARIO</th>
							    		<th>ROL</th>
							    		<th>NOMBRE</th>
							    		<th>APELLIDO</th>
							    		<th>ULTIMO ACCESO</th>
							    		<th>ESTADO</th>
						    		</tr>
						    	</thead>
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
						    		  
						    		  $("body").on("contextmenu", "#tblBackendUsers tr", function(e) {
						    		    $contextMenu.css({
						    		      display: "block",
						    		      left: e.pageX,
						    		      top: e.pageY
						    		    });
						    		    
						    		    $("div#issueAssignment").text(
						    		    		
						    		    		'<h4>Reclamo #'+rowId+'</h4>' +
						    		    		'<p>'+rowTitle+'</p>'
										);
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
						    		<td><i class="icon-map-marker"></i></td>
							    	<td>El reclamo <a href="#">#64256</a> fue <span class="label label-warning">reasignado</span> a <a href="#">fakeuser</a></td>
							    	<td><i class="icon-time icon-grey"></i> ayer</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-map-marker"></i></td>
							    	<td>El reclamo <a href="#">#78657</a> fue <span class="label label-success">resuelto</span> por <a href="#">fulanito_11</a></td>
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
					   			         		
		         	</div>	
		         	<!-- fin tab content -->
				 
			    </div>
			  </div>
			</div><!-- container fluid -->
			
			
			
			<!-- Modal ASSIGN USER -->
			<div id="assignUserModal"class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-header">
			    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
			    <h3 id="myModalLabel">Asignaci�n de usuario</h3>
			  </div>
			  <div class="modal-body">
			    <form class="form-horizontal">
				  <fieldset>
					  <div class="control-group" id="issueAssignment">
						
					     </div>
				  	
				     <div class="control-group">
					    <label>Seleccione usuario:</label>
					    <div>
						    <input type="hidden" id="combo-users" style="width:300px" class="input-xlarge" />
					    </div>
				     </div>
				  </fieldset>
				</form>
			  </div>
			  <div class="modal-footer" style="margin-bottom:0">
			    <button class="btn btn-primary" onclick="assignUser();"><i class="icon-ok"></i>&nbsp;&nbsp;Asignar</button>
			    <button class="btn" data-dismiss="modal" aria-hidden="true"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
			  </div>
			</div>
			
			
			
			<!-- Modal NEW USER -->
			<div id="userModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-header">
			    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
			    <h3 id="myModalLabel">Registro de nuevo usuario</h3>
			  </div>
			  <div class="modal-body">
			    <form id="backendUserForm" class="form-horizontal">
				  <fieldset>
				  	 <div class="control-group">
					    <label class="control-label">Apellido(s)</label>
					    <div class="controls">
					      <input type="text" id="apellido" name="apellido" placeholder="ej: V�squez">
					    </div>
				     </div>		
				     <div class="control-group">
				      	<label class="control-label">Nombre(s)</label>
					    <div class="controls">
					      <input type="text" id="nombre" name="nombre" placeholder="ej: Benancio Alberto">
					    </div>
				     </div>		    
				     <div class="control-group">
					    <label class="control-label">Usuario</label>
					    <div class="controls">
					      <input type="text" id="username" name="username" placeholder="ej: vasquezb">
					    </div>
				     </div>
					  <div class="control-group">
					  	<label class="control-label">Email</label>
					    <div class="controls">
					      <input type="email" id="email" name="email" placeholder="vasquezb@fixeala.com">
					    </div>
					  </div>
				      <div class="control-group">
					    <label class="control-label">Contrase�a</label>
					    <div class="controls">
					      <input type="password" id="password" name="password" placeholder="Contrase�a">
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label">Confirme contrase�a</label>
					    <div class="controls">
					      <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirme contrase�a">
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label" class="input-large">Cargo</label>
					    <div class="controls">
					      <select id="cargo" name="cargo">
					    	<option>Responsable de Area</option>
					    	<option>Asistente</option>
				    	  </select>
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label" class="input-large">Sub-Area</label>
					    <div class="controls">
						    <select id="subarea" name="subarea">
						    	<option>S. S. de Administracion (SSADM)</option>
						    	<option>S. S. de Higiene Urbana (SSHU)</option>
						    	<option>D. G. Cementerios (CGCEM)</option>
						    	<option>D. G. Espacios Verdes (DGEV)</option>
						    	<option>D. G. Reciclado (DGREC)</option>
					    	</select>
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label" class="input-large">Rol</label>
					    <div class="controls">
					      <select id="rol" name="rol">
					    	<option value="ROLE_ADMIN">Administrador</option>
					    	<option value="ROLE_MANAGER" selected="selected">Fiscal</option>
				    	  </select>
					    </div>
				     </div>
				   <div class="control-group">
				       	<label class="control-label">Estado</label>
				      	<div class="controls">
					      	<label class="radio inline">
					        	<input type="radio" name="accountStatus" value="active" name="optionsRadios" checked> Activo
					        </label>
					        <label class="radio inline">
					        	<input type="radio" name="accountStatus" value="blocked" name="optionsRadios"> Bloqueado
					    	</label>
				      </div>
				    </div>
				   
				  </fieldset>
				</form>
			  </div>
			  <div class="modal-footer" style="margin-bottom:0">
			    <button type="submit" id="btn-saveBackendUser" class="btn btn-primary"><i class="icon-ok"></i>&nbsp;&nbsp;Crear usuario</button>
			    <button class="btn" data-dismiss="modal" aria-hidden="true"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
			  </div>
			</div>
						
	    </sec:authorize>
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	 	<!--------------------------- ANONYMOUS USER ---------------------------------------------------------------------------->
	 	
	    <sec:authorize access="isAnonymous()">
	    
	    	<div class="row">
<!--     			<div class="span4 pull-left" style="padding:10px;text-align:left;margin:0; border:0px solid #000"> -->
	    			
<!-- 		  		</div> -->
		  		<div class="span4 pull-right" style="text-align:right;border:0px solid #000;">
				  	<!-- USERprofile -->
	    			<c:if test="${ profileRole eq 'ROLE_USER' }">
			  			<h3>${profileUser}</h3>
					  	<br>
					  	<small>${barrio}</small>
			  		</c:if>
			  		
			  		<!-- AREA profile -->
			  		<c:if test="${ profileRole eq 'ROLE_AREA' }">
			  			<h3>${current_area}</h3>
					  	<br>
					  	<small>${current_ciudad}, ${current_provincia}</small>
			  		</c:if>
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
					                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
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
				    	<h3>Reclamos ()</h3>
				    	</div>
				    	
				    	<ul class="nav nav-tabs">
					    	<li class="active"><a href="#issuesNuevos" data-toggle="tab">Todos</a></li>
<!-- 						  	<li><a href="#issuesAsignados" data-toggle="tab">Asignados (1)</a></li> -->
<!-- 						  	<li><a href="#issuesTodos" data-toggle="tab">Todos (4)</a></li> -->
						</ul>
						
						<div class="tab-content">
							<div class="tab-pane fade in active" id="issuesNuevos">
							   	<table id="tblUserIssues" cellpadding="0" cellspacing="0" border="0" 
    								class="table table-striped table-bordered table-hover datatable">
									<thead>
										<tr>				
											<th width="50">id</th>
											<th width="100">date</th>
											<th width="250">title</th>			
											<th width="200">address</th>
											<th width="150">neighborhood</th>
											<th width="150">city</th>
											<th width="150">province</th>
											<th>status</th>		
										</tr>
									</thead>
									<tbody>			
									</tbody>	
								</table>
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
				    	
				    	
				    	<table class="table table-striped table-hover user-table">
					    	<thead>
					    		<tr>
						    		<th width="200">Nombre de Usuario</th>
						    		<th>Rol</th>
						    		<th>Cargo</th>
						    		<th width="200">Área</th>
						    		<th>Sub-Área</th>
						    		<th>Estado</th>
					    		</tr>
					    	</thead>
					    	<tbody>
					    		<tr>
						    		<td>perezf</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>-</td>
						    		<td><span class="label label-success">Activo</span></td>
					    		</tr>
					    		<tr>
						    		<td>camposm</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de Sub-Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>D. G. Limpieza (DGLIM)</td>
						    		<td><span class="label label-success">Activo</span></td>
					    		</tr>
					    		<tr>
						    		<td>muragliag</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de Sub-Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>D. G. Alumbrado (DGALUM)</td>
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
			</div><!-- container fluid -->
	    
	    
	    </sec:authorize>
	    
	    
	    

	</div>
	<!-- /content -->  
	   
	  
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
<!-- 		</div> -->
		<!-- /dashboardTabContent -->
		    
	