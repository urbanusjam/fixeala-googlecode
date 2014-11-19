<header>
	<!-- NAVBAR -->
	<div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>           
          <a class="brand" href="/">fixeala&nbsp;<img src="resources/images/fixeala_logo.png" width=32 height=32 /></a>
          <div class="nav-collapse collapse">          
          	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
          	<!-- MAIN NAV -->
            <ul id="menuNav" class="nav">
<!-- 				<li><a href="dataset" title="Datasets"><i class="icon-tasks icon-2x"></i></a></li>					 -->
<!-- 				<li><a href="widget" title="Tu Gadget Web"><i class="icon-cogs icon-2x"></i></a></li>	 -->
<!-- 				<li><a href="mobile" title="Aplicaci&oacute;n M&oacute;vil"><i class="icon-android icon-2x"></i></a></li> -->
<!-- 				<li><a href="api" title="API"><i class="icon-bullseye icon-2x"></i></a></li>		 -->

				<li><a href="dataset">Cat&aacute;logos de Datos</a></li>
				<li><a href="mobile">Aplicaci&oacute;n M&oacute;vil</a></li>					
				<li><a href="widget">Widget</a></li>					
				<li><a href="api">API</a></li>		
				
<%-- 			<li><a href="help" title="Ayuda"><i class="icon-question-sign icon-2x"></i></a></li>			 --%>
        	</ul>
        	<!-- /MAIN NAV -->        	
        	<!-- LOGIN NAV -->
         	<ul id="loginNav" class="nav"> 
         		<!-- user NOT logged in -->
                <sec:authorize ifNotGranted="ROLE_USER">
                	<li  class="dropdown"><a id="loginLink" href="#" data-toggle="modal" data-target="#loginModal"><i class="icon icon-caret-right"></i>LOGIN</a></li>  
                 	<li class="signupLink"><a href="account/signup.html">REGISTRATE</a></li>		
              	 </sec:authorize>              	 
              	 <!-- user logged in -->
              	 <sec:authorize access="isAuthenticated()">              	 
              	 	<li class="dropdown" style="float:right">
	                	<a id="loginLink" href="users/<sec:authentication property="principal.username"/>.html" 
	                		class="dropdown-toggle" data-toggle="dropdown">   	
	                	<b><sec:authentication property="principal.username" /></b>
	                	&nbsp;<i class="icon-angle-down "></i>
	                	</a>	               	 						 
						<ul class="dropdown-menu user-menu dropdown-yellow dropdown-caret dropdown-close">
							<li><a href="users/<sec:authentication property="principal.username"/>.html"><i class="icon-user"></i>Mi cuenta</a></li>
						    <li class="divider"></li>
						    <li> 
		                  	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		                  		<c:url value="logout.html" var="logoutUrl"/>
		                  		<a class="last" href="${logoutUrl}"> 
		                  			<span><i class="icon-off"></i></span>Salir
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
    
    <!-- Modal LOGIN -->
	<div id="loginModal" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog" >
	    	<div class="modal-content">
	      		<div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			        <h4 class="modal-title" id="myModalLabel">Iniciar sesi&oacute;n</h4>
	      		</div>
	      		<!-- form -->
	      		<form id="loginForm" class="form-horizontal form-inline">
	      			<!-- modal body -->
	       			<div class="modal-body"> 	       				
						<div class="form-login">
			            	<label>Nombre de usuario</label>
			            	<div class="control-group">
				    			<input type="text" class="input-block-level" id="username"  name="j_username" placeholder="Nombre de usuario">	
				    		</div>	
				    		<label>Clave</label>
					    	<div class="control-group">			    		
					        	<input type="password" class="input-block-level" id="password" name="j_password" placeholder="Clave">
					        </div>    		
							<div class="row-fluid" style="width: 350px;">
								<div class="span5 pull-left forgotPassLink">
									<a class="link" href="account/forgotPassword.html">
										&iquest;Olvidaste tu clave?
									</a>
								</div>  					
								<div class="span5 pull-right rememberme">
									<label class="checkbox">									   
							         	<input type="checkbox" id="_spring_security_remember_me" name="_spring_security_remember_me" value="remember_me" > 
					        			Recordarme
								    </label>	
								</div>					
							</div>
							<div class="alert alert-error" style="display:none;">
								<a class="close" data-dismiss="alert" href="#">&times;</a>
							</div>		
			   			</div> 
	      			</div>
	      			<!-- modal footer -->
	      			<div class="modal-footer">
						<div class="ajax_loading" style="display:none" >
							<img src="resources/images/loader.gif" alt="Loading"/>&nbsp;Procesando...
						</div>	
						<button id="btnLogin" class="btn btn-primary" aria-hidden="true" onclick="javascript:fxlAccountController.initLogin();"><i class="icon icon-ok"></i>Ingresar</button>      
			       		<button class="btn" data-dismiss="modal" aria-hidden="true"><i class="icon icon-remove"></i>Cancelar</button>      
			      	</div>
	      		</form>
	    	</div>
	  	</div>
	</div>
</header> 	