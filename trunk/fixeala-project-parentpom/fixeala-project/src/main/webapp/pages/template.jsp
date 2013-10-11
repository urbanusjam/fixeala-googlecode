<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:url value="/template/message" var="messageUploadUrl"/>
<c:url value="/template/file" var="fileUploadUrl"/>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Fixeala - Tu plataforma para reportar reclamos</title>
     
 	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.9.0.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-ui-1.10.0.custom.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/formToWizard.js"></script>  	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/json.min.js"></script>	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/recaptcha_ajax.js"></script>	
  	
  	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-fileupload/jquery.ui.widget.js"></script>	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-fileupload/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-fileupload/jquery.fileupload.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/util.js"></script>
	
	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">    
    <link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap-responsive.css" rel="stylesheet">
    <link type="text/css" href="${pageContext.request.contextPath}/resources/css/font-awesome.css" rel="stylesheet">
  	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/style2.css" rel="stylesheet">
  	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.fileupload-ui.css" rel="stylesheet">
  	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery-ui-1.10.0.custom.min.css" rel="stylesheet">
  	
  

  	<script type="text/javascript">
  	
  		
		$(document).ready(function(){ 			
		
			/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 	
			
			//Image preview
			
			function handleFileSelect(evt) {
			    var files = evt.target.files; // FileList object

			    // Loop through the FileList and render image files as thumbnails.
			    for (var i = 0, f; f = files[i]; i++) {

			      // Only process image files.
			      if (!f.type.match('image.*')) {
			        continue;
			      }

			      var reader = new FileReader();

			      // Closure to capture the file information.
			      reader.onload = (function(theFile) {
			        return function(e) {
			          // Render thumbnail.
			             
			          
			          $("#profilePic").attr("src", e.target.result);			
			          $("#profilePic").attr("title", escape(theFile.name));			
			          
			        };
			      })(f);

			      // Read in the image file as a data URL.
			      reader.readAsDataURL(f);
			    }
			  }

			  document.getElementById('btnUpload').addEventListener('change', handleFileSelect, false);
			  
			/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 	
			
			
			//CAPTCHA
      	   	Recaptcha.create("6Lck8coSAAAAAKsNsoJdRVpHrCYfpbC60xhY7Ywv", 'captchadiv', {                              
      	   		theme: "clean",
      	   		callback: Recaptcha.focus_response_field
      	   	});    
			
			$('.navbar .nav > li > a').tooltip({
  				placement: 'bottom'
  			});
			
			var loginFailed = function(data, status) {
		        $(".alert").remove();
		        $('#username').before('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">&times;</a>El usuario y/o la contraseña <br>son incorrectos.</div>');
		    };

		    $("#login").click( function(e) {		    
		        e.preventDefault();	
		     // Hide 'Submit' Button
		        $('#login').hide();

		        // Show Gif Spinning Rotator
		        $('.ajax_loading').show();
		        
		        $.ajax({
		        			url: "./index",
		            		type: "POST",
				            beforeSend: function(xhr) {
				                xhr.withCredentials = true;
				            },
				            data: $("#loginForm").serialize(),
				            success: function(data, status) {				            	
				            	
				            	$(document).ajaxComplete(function(event, request, settings){
				            		
				            		setTimeout(function () {
				                   
						            		$('#login').show();
						            		$('.ajax_loading').hide(); 
						            		
						            		if (data.loggedIn) {						            			
							                	 $("#loginNav").load(location.href + " #loginNav > *");
									                return false;
							                } else {							                
							                    loginFailed(data);							                    
							                }
				            				
				            		},1000);				            			            		 
				            	
				            	});				            					                
				               
				            },
				            error: loginFailed
// 				            error: function(xhr, textStatus, errorThrown){
// 		 	    	             alert("Error! Status = " + xhr.status);
// 		 	    	         }
				           
		        });
		        return false;
		    });

		    $('#username').focus();
		    		    
		
		});
		
		
		 /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 
		
</script>
  
</head>
<body>

	<!-- NAVBAR -->
	<div class="navbar navbar-fixed-top">

      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a> 
          
          <a class="brand" href="#"> {&nbsp;&nbsp;fixeala.<b>BA</b>&nbsp;&nbsp;}</a>
          <div class="nav-collapse collapse">
          
          	<!-- MAIN NAV -->
            <ul class="nav">
             	<li><a href="#" title="Mapa"><i class="icon-globe icon-2x "></i></a></li>
				<li><a href="#" title="Reclamos"><i class=" icon-pushpin icon-2x"></i></a></li>
				<li><a href="#" title="Usuarios"><i class="icon-group icon-2x"></i></a></li>
				<li><a href="#" title="Info"><i class="icon-info-sign icon-2x"></i></a></li>
				<li><a href="#" title="Contacto"><i class="icon-envelope-alt icon-2x"></i></a></li>		
        	</ul>
        	<!-- /MAIN NAV -->
        	
        	<!-- LOGIN NAV -->
         	<ul id="loginNav" class="nav">      
         		
         		<!-- user NOT logged in -->
                <sec:authorize ifNotGranted="ROLE_USER">               
	           		<li class="dropdown">
	                	<a id="loginLink" href="#" class="dropdown-toggle" data-toggle="dropdown">                	
	                	LOGIN&nbsp;<i class="icon-angle-down "></i>
	                	</a>
	               	  	<ul class="dropdown-menu">
	                	  	<li>
	                	  		<!-- LOGIN FORM -->
		                		<form id="loginForm" class="form-signin" action="doLogin" method="POST">	
							    	<input type="text" id="username" class="input-block-level" name="j_username" placeholder="Nombre de usuario">						     
							        <input type="password" class="input-block-level" name="j_password" placeholder="Contraseña">
							      	<button type="submit" id="login" class="btn btn-primary">            						
							           Login
							    	</button>							    	
							    	<div class="ajax_loading" style="display:none" >
										<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif" alt="Loading"/>&nbsp;Procesando...
									</div>		
							      	<label class="checkbox">
							        	<input type="checkbox" id="_spring_security_remember_me" name="_spring_security_remember_me" value="remember-me"> 
							        	Recordarme
			      					</label>	
									<div align="center"><a class="link" href="#">¿Olvidaste tu contraseña?</a></div>     
		     					</form>
		     					<!-- /LOGIN FORM -->
							</li>										 
						</ul>
	                </li>
                 	<li class="signuplink"><a href="#">REGISTRATE</a></li>		
              	 </sec:authorize>
              	 
              	 <!-- user logged in -->
              	 <sec:authorize access="isAuthenticated()">
	              	<li class="dropdown">
		                <a href="#" class="dropdown-toggle" data-toggle="dropdown">                	
		                	<sec:authentication property="principal.username" />&nbsp;<i class="icon-angle-down "></i>		                	 
		               	</a>	                
		                <ul class="dropdown-menu">		                
		                  	<li><a href="#"><i class="icon-eye-open"></i>&nbsp;&nbsp;Perfil</a></li>
		                  	<li><a href="#"><i class="icon-list"></i>&nbsp;&nbsp;Mis reclamos </a></li>   
		                  	<li><a href="#"><i class="icon-star"></i>&nbsp;&nbsp;Actividad</a></li>   
		                  	<li><a href="#"><i class="icon-comments"></i>&nbsp;&nbsp;Mensajes&nbsp;<span class="badge badge-info">4</span></a></li>   
		                  	<li><a href="#"><i class="icon-wrench"></i>&nbsp;&nbsp;Cuenta</a></li>   				                          	             
		                  	<li class="divider"></li>		                 
		                  	<li>
		                  		<a class="last" href="<c:url value="/doLogout" />" >
		                  			<i class="icon-remove"></i>&nbsp;&nbsp;Salir
		                  		</a>
		                  	</li>             
		                </ul>
	                </li>
               	  </sec:authorize> 
               	               	
            	</ul>
            	<!-- /LOGIN NAV -->
            </div>
          </div>
        </div>
    </div>
    <!-- /NAVBAR -->
   

	
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
      
	    
    	
	
	
	<div id="footer">
		Copyright © 2013 UrbanusJam! &nbsp;&ndash;&nbsp; Todos los derechos reservados.
	</div>

  	
</body>
</html>