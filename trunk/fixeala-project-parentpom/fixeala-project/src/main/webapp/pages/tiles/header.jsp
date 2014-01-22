	
	<!-- NAVBAR -->
	<div class="navbar navbar-fixed-top">

      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a> 
          
          <a class="brand" href="${pageContext.request.contextPath}">fixeala&nbsp;<i class=" icon-caret-right"></i></a>
          <div class="nav-collapse collapse">
          
          	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
          	<!-- MAIN NAV -->
            <ul id="menuNav" class="nav">
<%--              	<li><a href="${pageContext.request.contextPath}/index.jsp" title="Reclamos" ><i class="icon-white icon-globe  icon-2x "></i></a></li> --%>
				<li><a href="${pageContext.request.contextPath}/reclamos.html" title="Reclamos"><i class=" icon-pushpin icon-2x"></i></a></li>
				<li><a href="${pageContext.request.contextPath}/usuarios.html" title="Usuarios"><i class="icon-group icon-2x"></i></a></li>				
				<li><a href="${pageContext.request.contextPath}/dataset.html" title="Tu dataset"><i class="icon-tasks icon-2x"></i></a></li>		
				<li><a href="${pageContext.request.contextPath}/widget.html" title="Tu widget"><i class="icon-cogs icon-2x"></i></a></li>	
				<li><a href="#" title="Mobile App"><i class="icon-mobile-phone icon-2x"></i></a></li>			
				<li><a href="#" title="Indicadores"><i class="icon-signal icon-2x"></i></a></li>		
<!-- 				<li><a href="#" title="Acerca de"><i class="icon-question icon-2x"></i></a></li>			 -->
        	</ul>
        	<!-- /MAIN NAV -->
        	
        	<!-- LOGIN NAV -->
         	<ul id="loginNav" class="nav">      
         		
         		<!-- user NOT logged in -->
                <sec:authorize ifNotGranted="ROLE_USER, ROLE_ADMIN, ROLE_MANAGER">               
	           		<li class="dropdown">
	                	<a id="loginLink" href="#" class="dropdown-toggle" data-toggle="dropdown">                	
	                	LOGIN&nbsp;<i class="icon-angle-down "></i>
	                	</a>
	               	  	<ul class="dropdown-menu">
	                	  	<li>
	                	  		<!-- LOGIN FORM -->
		                		<form id="loginForm" class="form-signin" >	
		                			<div class="control-group">
							    		<input type="text" id="username" class="input-block-level" name="j_username" placeholder="Nombre de usuario">	
							    	</div>	
							    	<div class="control-group">				     
							        	<input type="password" class="input-block-level" name="j_password" placeholder="Contraseña">
							        </div>
							      	<button type="submit" id="btnLogin" class="btn btn-primary">            						
							           Login
							    	</button>							    	
							    	<div class="ajax_loading" style="display:none" >
										<img src="${pageContext.request.contextPath}/resources/images/loader.gif" alt="Loading"/>&nbsp;Procesando...
									</div>										
									 <label class="checkbox">									   
									         	<input type="checkbox" id="_spring_security_remember_me" name="_spring_security_remember_me" value="remember_me" > 
							        			Recordarme
									      </label>
    								
							      	
									<div align="center" class="forgotPassLink"><a class="link" href="${pageContext.request.contextPath}/account/forgotPassword.html">¿Olvidaste tu contraseña?</a></div>     
		     					</form>
		     					<!-- /LOGIN FORM -->
							</li>										 
						</ul>
	                </li>
                 	<li class="signupLink"><a href="${pageContext.request.contextPath}/account/signup.html">REGISTRATE</a></li>		
              	 </sec:authorize>
              	 
              	 <!-- user logged in -->
              	 <sec:authorize access="isAuthenticated()">
              	 
              	 <li class="dropdown" style="float:right">
	                	<a id="loginLink" href="${pageContext.request.contextPath}/users/<sec:authentication property="principal.username"/>.html" 
	                		class="dropdown-toggle" data-toggle="dropdown">  
	                		     	
	                	<b><sec:authentication property="principal.username" /></b>
	                	&nbsp;<i class="icon-angle-down "></i>
	                	</a>
	               	  
						 
						  <ul class="dropdown-menu user-menu dropdown-yellow dropdown-caret dropdown-close">
						  	<li><a href="${pageContext.request.contextPath}/users/<sec:authentication property="principal.username"/>.html"><i class="icon-user"></i>Perfil</a></li>
						   	<li><a href="${pageContext.request.contextPath}/users.html"><i class="icon-cog"></i>Cuenta</a></li>
<%-- 						   	<li><a href="${pageContext.request.contextPath}/users.html"><i class="icon-map-marker"></i>Reclamos</a></li> --%>
<%-- 						   	<li><a href="${pageContext.request.contextPath}/users.html"><i class="icon-envelope"></i>Mensajes</a></li> --%>
						    <li class="divider"></li>
						    <li> 
		                  	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		                  		<c:url value="${pageContext.request.contextPath}/logout.html" var="logoutUrl"/>
		                  		<a class="last" href="${logoutUrl}"> 
		                  			<span><i class="icon-off"></i></span>Salir
		                  		</a>
 		                  	</li>     
						  </ul>
						</li>
						
						
<!-- 						<div id="btnLoggedUser" class="btn-group"> -->
<%-- 						  <a class="btn btn-info" href="${pageContext.request.contextPath}/users/<sec:authentication property="principal.username"/>.html"> --%>
<!-- 						  	<i class="icon-user icon-white"></i>&nbsp;&nbsp; -->
<%-- 						  	<sec:authentication property="principal.username" /> --%>
<!-- 						  </a> -->
<!-- 						  <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-angle-down "></i></a> -->
<!-- 						  <ul class="dropdown-menu"> -->
<%-- 						  	<li><a href="${pageContext.request.contextPath}/users/<sec:authentication property="principal.username"/>.html">Mi Perfil<i class="icon-list-alt icon-large pull-left"></i></a></li> --%>
<%-- 						   	<li><a href="${pageContext.request.contextPath}/users.html">Mi Cuenta<i class="icon-cog icon-large pull-left"></i></a></li> --%>
<%-- 						   	<li><a href="${pageContext.request.contextPath}/users.html"><i class="icon-map-marker icon-large pull-left"></i>Mis Reclamos</a></li> --%>
<%-- 						   	<li><a href="${pageContext.request.contextPath}/users.html"><i class="icon-envelope icon-large pull-left"></i>Mis Mensajes</a></li> --%>
<!-- 						    <li class="divider"></li> -->
<!-- 						    <li>  -->
<%-- 		                  	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- 		                  		<c:url value="${pageContext.request.contextPath}/logout.html" var="logoutUrl"/> --%>
<%-- 		                  		<a class="last" href="${logoutUrl}">  --%>
<!-- 		                  			<span><i class="icon-off icon-large"></i></span>Salir -->
<!-- 		                  		</a> -->
<!--  		                  	</li>      -->
<!-- 						  </ul> -->
<!-- 						</div> -->
              	 
              	 
<!-- 	              	<li class="dropdown"> -->
<!-- 		                <a href="#" class="dropdown-toggle" data-toggle="dropdown">                	 -->
<%-- 		                	<sec:authentication property="principal.username" />&nbsp;&nbsp;<i class="icon-angle-down "></i>		                	  --%>
<!-- 		               	</a>     -->
<!-- 		                <ul class="dropdown-menu">		                 -->
<%-- 		                  	<li><a href="${pageContext.request.contextPath}/account/profile.html"><i class="icon-wrench"></i>&nbsp;&nbsp;Mi Cuenta</a></li>   				                          	              --%>
<!-- 		                  	<li class="divider"></li>		                  -->
<!-- 		                  	<li> -->
<%-- 		                  	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- 		                  		<c:url value="${pageContext.request.contextPath}/logout.html" var="logoutUrl"/> --%>
<%-- 		                  		<a class="last" href="${logoutUrl}">  --%>
<!-- 		                  			<i class="icon-remove"></i>&nbsp;&nbsp;Salir -->
<!-- 		                  		</a> -->
<!-- 		                  	</li>               -->
<!-- 		                </ul> -->
<!-- 	                </li> -->
               	  </sec:authorize> 
               	               	
            	</ul>
            	<!-- /LOGIN NAV -->
            </div>
          </div>
        </div>
    </div>
    <!-- /NAVBAR -->