<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
  	
    <link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" />    
    <link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap-responsive.css" rel="stylesheet" />
    <link type="text/css" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" rel="stylesheet" />
  	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/style2.css" rel="stylesheet" />
 	     	
  	
  	<script type="text/javascript">  
  	//<![CDATA[
             $(document).ready(function(){ 		  
			
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
		    
		    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 
			
			var visible = true;		
		
// 			$("#issueForm").formToWizard();						
// 			$(".prev").before(' <button type="submit" id="btnIssueSubmit" class="btn btn-primary">Enviar reclamo</button> ');
					
			var effectReclamo = function() {
				return $("#issueBox").animate({ width: 0 }, "swing");		
				};
				
			var effectMap = function() {
				return $("#map").animate({ width: 1177 }, "swing");		
				};	
				
			var effectSearch = function() {
				return $("#advancedSearchBox").slideUp();
				};
				
				
			$("#btnAdvancedSearch").click(function(){
					 $("#advancedSearchBox").slideToggle(500);
		  	});
			
			$("#btnIssue").click(function(){			
					$("#issueBox").animate({ width: visible ? 300 : 0 }, "swing");
				 	$("#map").animate({ width: visible ? 816 : 1177 }, "swing");	
				 	visible = !visible;  
			});
		});//]]>
		</script>		  
</head>
<body>

	<!-- NAVBAR -->
	<div class="navbar">

      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a> 
          
          <a class="brand" href="#"> {&nbsp;&nbsp;fixeala&nbsp;&nbsp;}</a>
          <div class="nav-collapse collapse">
          
          	<!-- MAIN NAV -->
            <ul class="nav">
             	<li><a href="#" title="Mapa"><i class="icon-globe icon-2x "></i></a></li>
				<li><a href="#" title="Reclamos"><i class=" icon-pushpin icon-2x"></i></a></li>
				<li><a href="#" title="Usuarios"><i class="icon-user icon-2x"></i></a></li>
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
		                	<li>		                   
<!-- 							    <div class="row" style="color:#000 !important;font-size:11px;"> -->
<%-- 								    <div class="span1" style="display:inline-block"><a href="#" class="thumbnail"><img src="${pageContext.request.contextPath}/resources/images/01-mario.jpg"/></a></div> --%>
<!-- 								    <div class="span2" style="text-align:left;display:inline-block"> -->
<%-- 									    <p><sec:authentication property="principal.username" /></p> --%>
<!-- 									    <p><strong>Ciudadano Kane</strong></p> -->
<!-- 									    <span class=" badge badge-info">9856</span> puntos -->
<!-- 								    </div> -->
<!-- 							    </div>							 -->
   							</li>
							<li class="divider"></li>	
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
	
		<div class="input-append">	
		
       		<input type="search" id="search" placeholder="Buscar reclamos o usuarios..." />
	        <button id="btnSearch" class='btn add-on' style="width:70px;">
	            <i class="icon-search"></i>
	        </button>
	        
	        <button id="btnAdvancedSearch" class='btn add-on'>
	            <i class="icon-angle-down"></i>
	        </button>  
			
			<button id="btnIssue" class="btn btn-success"> 
				<i class="icon-map-marker"></i>&nbsp;&nbsp;&nbsp;NUEVO RECLAMO
			</button>
				
		</div>
		
		
		
		<div id="mapWrapper">
		
			<div id="issueBox" class="well span3">
				
				<form id="issueForm" class="form-issue" action="">	
					 <legend>Cargá tu reclamo</legend>	
					 <fieldset>	
						
						<input type="text" id="address" name="address" placeholder="Direcci&oacute;n (calle y altura)"/>
						<input type="text" id="neighbourhood" name="neighbourhood" placeholder="Barrio"/>						
						<input type="text" id="comuna" name="comuna" placeholder="Comuna"/>
						<input type="text" id="type" name="type" placeholder="Tipo"/>
								
					</fieldset>		
							
					<fieldset> 			
						
						<input type="text" id="title" name="title" placeholder="T&iacute;tulo"/>
<!-- 						<textarea id="description" name="description" placeholder="Descripci&oacute;n"></textarea>	 -->
						<input type="text" id="file" name="file" placeholder="Foto"/>
						
<!-- 						<button id="btnIssue" class="btn btn-info prev">  -->
<!-- 							<i class="icon-double-angle-right"></i>&nbsp;Siguiente -->
<!-- 						</button>	 -->
<!-- 						<button id="btnIssue" class="btn btn-info">  -->
<!-- 							<i class="icon-double-angle-left"></i>&nbsp;Atr&aacute;s&nbsp; -->
<!-- 						</button> -->
<!-- 							<button id="btnIssue" class="btn btn-primary">  -->
<!-- 								Subir reclamo -->
<!-- 							</button> -->
					</fieldset>					
				</form>
			
			</div>
			
			<div id="map">
			
		</div>
		
		</div>
		
	</div>

	
	
	<div id="footer">
		Copyright © 2013 UrbanusJam! - Todos los derechos reservados
	</div>

	
  	
</body>
</html>