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
		var url = getDomainUrl() + "issues/assignUser.html";
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
		    var url = getDomainUrl() + "issues/updateIssueStatus.html";
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
			 	    		url: getDomainUrl() + "account/signup/checkUsernameAvailability.html", 
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
			 	    		url: getDomainUrl() + "account/signup/checkEmailAvailability.html", 
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
		
				var url = getDomainUrl() + "account/signup.html";
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
	            url: getDomainUrl() + "issues/getAvailableUsers/" +currentArea+ ".html",
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
			    <div id="dashboard-box" class="span3">

			              <ul id="dashboard-nav" class="nav nav-list">
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
							                <li><a href="#closeAccount" data-toggle="tab"><i class="icon-ban-circle"></i>DesactivaciÛn</a></li>
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
			    
			    <!--Body content-->
			    <div class="span9" style="float:right; width:940px;">
			    
			    <!-- TAB CONTENT -->
			    <div class="tab-content">
			    
			    
			    	<!-- TAB PROFILE -->
	         			<div class="tab-pane fade in active" id="profile"> 
	         			
         					  <blockquote>
						        <h3>helloworld</h3>
						        <small><cite>Vecino de <i>San Nicol·s, Ciudad AutÛnoma de Buenos Aires</i>&nbsp;&nbsp;<i class="icon-map-marker"></i></cite></small>						      
						      </blockquote>

					    	
					    	<div class="row" style="margin: 0 auto; border: 0px solid #000; ">
					    	
							    <div class="span3" style="border: 0px solid #000; ">		
							    	<span class="thumbnail" style="width:200px; height:200px">				     
										<img src="${pageContext.request.contextPath}/resources/images/nopic.png" />
									</span>										
									<div class="thumbnail" style="text-align:center; width:200px;">
	              						<small style="text-align:center">Registrado el 15/01/13</small>		
	    							</div>	    																
									 <div class="thumbnail" style="text-align:center; width:200px;">	              						
	              						<small style="text-align:center">Vistas: 33</small>	
	    							</div>			
							    </div>
							   
							 
								<div class="span2 thumbnail" style="text-align:center" title="Reclamos publicados">
              						<i class="icon-pushpin icon-4x"></i>
              						<h2>5</h2>
              						<strong>PUBLICADOS</strong>
    							</div>
    							
    							<div class="span2 thumbnail" style="text-align:center" title="Reclamos resueltos">
              						<i class="icon-ok icon-4x"></i>
              						<h2>2</h2>
              						<strong>RESUELTOS</strong>
    							</div>    							
    							
    							<div class="span2 thumbnail" style="text-align:center" title="Reclamos votados">
              						<i class="icon-thumbs-up icon-4x"></i>
              						<h2>11</h2>
              						<strong>VOTADOS</strong>
    							</div>
    							
    							<div class="span2 thumbnail" style="text-align:center" title="Reclamos en seguimiento">
              						<i class="icon-screenshot icon-4x"></i>
              						<h2>7</h2>
              						<strong>SIGUIENDO</strong>
    							</div>
    							
    							<div class="span2 thumbnail" style="text-align:center" title="Comentarios realizados">
              						<i class="icon-warning-sign icon-4x"></i>
              						<h2>0</h2>
              						<strong>DENUNCIADOS</strong>
    							</div>
    							
    							<div class="span2 thumbnail" style="text-align:center" title="Comentarios realizados">
              						<i class="icon-comments icon-4x"></i>
              						<h2>11</h2>
              						<strong>COMENTARIOS</strong>
    							</div>    	
    							
    							<div class="span2 thumbnail" style="text-align:center">
              						<i class="icon-cogs icon-4x"></i>
              						<h2>0</h2>
              						<strong>WIDGETS</strong>
    							</div>
    						
    						</div>
					    	
				    	</div>
					<!-- fin TAB PROFILE -->
					
					<!-- TAB DASHBOARD -->
	         			<div class="tab-pane fade in" id="dashboard"> 	
			         		<div class="page-header">
					    		<h3>Dashboard</h3>
					    	</div>
				    	</div>
					<!-- fin TAB PROFILE -->
					
					<!-- NOTIFICACIONES -->
		         		<div class="tab-pane fade" id="notifications"> 	
			         		<div class="page-header">
					    		<h3>Notificaciones</h3>
					    	</div>
					    	
					    	<table class="table table-hover" style="width:900px">
						    	<tr>
						    		<td style="border-top:none;"><i class="icon-pencil"></i></td>
							    	<td style="border-top:none; width:700px"><a href="#">Roberto A.</a> modificÛ la descripciÛn del reclamo <i><a href="#">Hay escombros de construcciÛn desparramados en una esquina... (#4455)</a></i></td>
							    	<td style="border-top:none;"><i class="icon-time icon-grey"></i>hace 11 minutos</td>
							    <tr>
							     <tr>
						    		<td><i class="icon-comment"></i></td>
							    	<td><a href="#">fulanito_11</a> comentÛ en el reclamo <a href="#">Hay un bache gigante en la calle... (#1100)</a></td>
							    	<td class="time"><i class="icon-time icon-grey"></i>hace 1 hora</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-pencil"></i></td>
							    	<td><a href="#">Roberto A.</a> agregÛ archivos en el reclamo <i><a href="#">Sem·foro a punto de caerse... (#9568)</a></i></td>
							    	<td class="time"><i class="icon-time icon-grey"></i>hace 5 horas</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-pushpin"></i></td>
							    	<td>El reclamo <i><a href="#">La calle est· poceada, hagan algo... (#2222)</a></i> fue <span class="label label-warning">reasignado</span> a <a href="#">COMUNA 12</a></td>
							    	<td class="time"><i class="icon-time icon-grey"></i>hace 13 horas</td>
							    <tr>							   
							    <tr>
						    		<td><i class="icon-comment"></i></td>
							    	<td><a href="#">COMUNA 7</a> comentÛ en el reclamo <i><a href="#">Hay residuos olorosos tirados por toda la vereda... (#7574)</a></i></td>
							    	<td class="time"><i class="icon-time icon-grey"></i>hace 14 horas</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-pencil"></i></td>
							    	<td><a href="#">COMUNA 3</a> modificÛ la informaciÛn de licitaciÛn del reclamo <i><a href="#">Sem·foro a punto de caerse... (#9568)</a></i></td>
							    	<td class="time"><i class="icon-time icon-grey"></i>ayer</td>
							    <tr>							    
							    <tr>
						    		<td><i class="icon-pushpin"></i></td>
							    	<td>El reclamo <i><a href="#">Sem·foro a punto de caerse... (#9568)</a></i> fue <span class="label label-success">resuelto</span> por <a href="#">MAYEP</a></td>
							    	<td class="time"><i class="icon-time icon-grey"></i>ayer</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-pushpin"></i></td>
							    	<td>El reclamo <i><a href="#">La gente no sabe caminar... (#6688)</a></i> fue <span class="label label-important">rechazado</span> por <a href="#">MAYEP</a></td>
							    	<td class="time"><i class="icon-time icon-grey"></i>ayer</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-thumbs-up"></i></td>
							    	<td><a href="#">claudio_g</a> votÛ el reclamo <i><a href="#">Tapa de alcantarilla tapada por asfalto... (#4344)</a></i></td>
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
					
					
					<!-- TAB RECLAMOS -->
					<div class="tab-pane fade in" id="issues">
					    	<div class="page-header">
					    		<h3>Reclamos</h3>
					    	</div>
					    	
					    	<ul class="nav nav-tabs">
<!-- 						    	<li class="active"><a href="#issuesAsignados" data-toggle="tab">Asignados</a></li> -->
									<li class="active"><a href="#issuesPublished" data-toggle="tab">Publicados (3)</a></li>
									<li><a href="#issuesFollowing" data-toggle="tab">Siguiendo (7)</a></li>
									<li><a href="#issuesVoted" data-toggle="tab">Votados (1)</a></li>
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
													<span>Por P·gina</span>
												</div>
											</div>
											<div class="datagrid-footer-right" style="display:none;">
												<div class="grid-pager">
													<button type="button" class="btn grid-prevpage"><i class="icon-chevron-left"></i></button>
													<span>P·gina</span>
							
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
									   			<th>Descripci√≥n</th>
									   			<th>Nro. Reclamo</th>
								   			</tr>
								   		<tbody>
								   			<tr>
								   				<td>13/03/13 15:44</td>
								   				<td>El reclamo ha sido admitido. Se le ha asignado el N¬∫ de tr√°mite 98993/2.</td>
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
									   			<th>Descripci√≥n</th>
									   			<th>Nro. Reclamo</th>
									   			<th>Usuario</th>
								   			</tr>
								   		<tbody>
								   			<tr>
								   				<td>14/05/13 09:33</td>
								   				<td>La vereda todav√≠a no fue reparada.</td>
								   				<td><a href="#">7856</a></td>
								   				<td><a href="#">pedro77</a></td>
								   			</tr>
								   		</tbody>
								   	</table>
								 </div>
							</div>
					    </div>
					    <!-- fin TAB COMENTARIOS -->
					    
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
						                    <a href="#" class="thumbnail" style="width: 150px; height: 150px;">
										    	<img src="${pageContext.request.contextPath}/resources/images/01-mario.jpg" />
										    </a>
										    <br>
									        <span class="btn" style="line-height:30px; width:135px; font-size:12px;">
												<i class="icon-plus"></i>&nbsp;&nbsp;Seleccionar archivo
											</span>		
						                </div>
					                </div>
				                	<div class="span7">
				                		<form class="form-horizontal" id="uploadForm">					              
										    <label for="inputEmail">Email</label>
										    <input type="text" id="inputEmail" class="input-large" value="${email}" placeholder="usuario@gmail.com">
										  									
										    <label for="inputEmail">Barrio</label>
										    <input type="text" id="inputEmail" class="input-large" placeholder="Villa Urquiza"> 
										  										
										    <label for="inputEmail">Ciudad</label>
										    <input type="text" id="inputEmail" class="input-large" placeholder="Ciudad AutÛnoma de Buenos Aires">
										 										
										    <label for="inputEmail">Provincia</label>
										    <input type="text" id="inputEmail" class="input-large" placeholder="Buenos Aires"> 
										    
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
			                		<form class="form-horizontal" id="changePasswordForm">
			                							              
									    <label for="inputEmail">Clave actual</label>
									    <input type="password" id="currentPassword">	
									  									
									    <label for="inputEmail">Nueva clave</label>
										<input type="password" id="newPassword">
									  										
									    <label for="inputEmail">Confirme nueva clave</label>
									    <input type="password" id="newPasswordConfirmation">		  			
									 		
									    <hr>
									    
									    <div style="width:275px; border:0px solid #000">
									    	<button id="btnChangePassword" class="btn btn-success"><i class="icon-ok"></i>&nbsp;&nbsp;Cambiar clave</button>
											<span class="pull-right">
												<button type="reset" class="btn"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
											</span>
										</div>
																		 
								  	</form>
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
									<form id="closeAccountForm" class="form-horizontal">
										
										<p>
										   Lorem ipsum dolor sit amet, id nec conceptam conclusionemque. Et eam tation option. 
										   Utinam salutatus ex eum. Ne mea dicit tibique facilisi, ea mei omittam explicari conclusionemque, 
										   ad nobis propriae quaerendum sea.
										</p>
										
											<br>
										
										<label for="currentPassword"><strong>Ingrese su clave actual:</strong></label>
										<input type="password" id="currentPassword" class="input-xlarge">		  			
										
										
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
			         		
			         				         		
			         		
		         		
					   			         		
		         	</div>	
		         	<!-- fin tab content -->
				 
			    </div>
			  </div>
			</div><!-- container fluid -->
			
			
			
			<!-- Modal ASSIGN USER -->
			<div id="assignUserModal"class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-header">
			    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
			    <h3 id="myModalLabel">AsignaciÛn de usuario</h3>
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
					      <input type="text" id="apellido" name="apellido" placeholder="ej: V·squez">
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
					    <label class="control-label">ContraseÒa</label>
					    <div class="controls">
					      <input type="password" id="password" name="password" placeholder="ContraseÒa">
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label">Confirme contraseÒa</label>
					    <div class="controls">
					      <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirme contraseÒa">
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
								   			<th>T√≠tulo</th>
								   			<th>Direcci√≥n</th>
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
								   			<th>Descripci√≥n</th>
								   			<th>Nro. Reclamo</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>13/03/13 15:44</td>
							   				<td>El reclamo ha sido admitido. Se le ha asignado el N¬∫ de tr√°mite 98993/2.</td>
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
								   			<th>Descripci√≥n</th>
								   			<th>Nro. Reclamo</th>
								   			<th>Usuario</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>14/05/13 09:33</td>
							   				<td>La vereda todav√≠a no fue reparada.</td>
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
						    		<th width="200">√Årea</th>
						    		<th>Sub-√Årea</th>
						    		<th>Estado</th>
					    		</tr>
					    	</thead>
					    	<tbody>
					    		<tr>
						    		<td>perezf</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de √Årea</td>
						    		<td>Ministerio de Ambiente y Espacio P√∫blico (MAYEPGC)</td>
						    		<td>-</td>
						    		<td><span class="label label-success">Activo</span></td>
					    		</tr>
					    		<tr>
						    		<td>camposm</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de Sub-√Årea</td>
						    		<td>Ministerio de Ambiente y Espacio P√∫blico (MAYEPGC)</td>
						    		<td>D. G. Limpieza (DGLIM)</td>
						    		<td><span class="label label-success">Activo</span></td>
					    		</tr>
					    		<tr>
						    		<td>muragliag</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de Sub-√Årea</td>
						    		<td>Ministerio de Ambiente y Espacio P√∫blico (MAYEPGC)</td>
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
		         		
		         	
		         		
		         		
	         		<!-- NOTIFICACIONES -->
<!-- 	         		<div class="tab-pane fade" id="notifications"> 	 -->
<!-- 		         		<div class="page-header"> -->
<!-- 				    		<h3>Notificaciones</h3> -->
<!-- 				    	</div> -->
				    	
<!-- 				    	<table class="table table-hover offset1" style="width:700px;"> -->
<!-- 					    	<tr> -->
<!-- 					    		<td style="border-top:none;"><i class="icon-map-marker"></i></td> -->
<!-- 						    	<td style="border-top:none;width:500px">Nuevo reclamo <a href="#">#4455</a> pubicado por <a href="#">fulanito_11</a></td> -->
<!-- 						    	<td style="border-top:none;"><i class="icon-time icon-grey"></i> hace 11 minutos</td> -->
<!-- 						    <tr> -->
<!-- 						    <tr> -->
<!-- 					    		<td><i class="icon-comments-alt"></i></td> -->
<!-- 						    	<td>Nuevo comentario pubicado por <a href="#">fulanito_11</a></td> -->
<!-- 						    	<td><i class="icon-time icon-grey"></i> hace 2 horas</td> -->
<!-- 						    <tr> -->
<!-- 						    <tr> -->
<!-- 					    		<td><i class="icon-ok"></i></td> -->
<!-- 						    	<td>El reclamo <a href="#">#78657</a>fue <span class="label label-success">resuelto</span> por <a href="#">fulanito_11</a></td> -->
<!-- 						    	<td><i class="icon-time icon-grey"></i> ayer</td> -->
<!-- 						    <tr> -->
<!-- 						    <tr> -->
<!-- 					    		<td><i class="icon-map-marker"></i></td> -->
<!-- 						    	<td>Nuevo reclamo <a href="#">#4344</a> publicado por <a href="#">GustavoF</a></td> -->
<!-- 						    	<td><i class="icon-time icon-grey"></i> 16/10/2013</td> -->
<!-- 						    <tr> -->
<!-- 				    	</table> -->
<!-- 			    	</div> -->
				    <!-- end TAB NOTIFICACIONES -->
				    
				    
				    
			
			         		
		         	</div>	
		         	<!-- fin tab content -->
				 
			    </div>
			  </div>
			</div><!-- container fluid -->
	    
	    
	    </sec:authorize>
	    
	    
	    

	</div>
	<!-- /content -->  
	   
	  
		
			
	
		    
	