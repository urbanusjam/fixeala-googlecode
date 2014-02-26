<div id="content">	
		<!-- Signup -->
    	<div class="page-header">
    	 	<h4><i class="icon-user"></i>&nbsp;&nbsp;<i class="icon-angle-right"></i>&nbsp;&nbsp;Registro de nuevo usuario</h4>    	 	
    	</div>    	
   	    <form id="signupForm" class="well span6" method="POST">
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
		  			<span class="add-on"><i class="icon-lock"></i></span>
		  			<input type="password" id="password" name="password" placeholder="Contraseña">
		  		</div>
	  			<div class="input-prepend">
	  				<span class="add-on"><i class="icon-lock"></i></span>
	  				<input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirme contraseña">
	  			</div>
	  			
	  			<!-- CAPTCHA -->
	  			<script type="text/javascript">  		
					$(document).ready(function(){ 
						//CAPTCHA
			      	   	Recaptcha.create("6Lck8coSAAAAAKsNsoJdRVpHrCYfpbC60xhY7Ywv", 'captchadiv', {                              
			      	   		theme: "clean"
// 			      	   		callback: Recaptcha.focus_response_field
			      	   	});    			  
					});
				</script>
 				<div id="captchadiv"></div>  				
 				<div class="span3" > 				
			      	<button type="submit" id="btnSignup" class="btn btn-primary">Crear cuenta</button>&nbsp;&nbsp;		
			    	<button type="reset" class="btn">Cancelar</button>				    	
	    		</div>			
		    </div>
   		</form>		 
</div>	