    <div id="content">	
		<!-- Signup -->
    	<div class="page-header">
    	 	<h4><i class="icon-user"></i>&nbsp;&nbsp;<i class="icon-angle-right"></i>&nbsp;&nbsp;Registro de nuevo usuario</h4>    	 	
    	</div>    	
   	    <form id="signupForm" method="POST" class="well span6">
		    <div class="row">
	  			<div class="input-prepend">
<!-- 		  			<span class="add-on"><i class="icon-user"></i></span> -->
					<label>Nombre de usuario</label>
		  			<input type="text" id="username" name="username" placeholder="ejemplo1234">
	  			</div>
	  			<div class="input-prepend">
<!-- 		  			<span class="add-on"><i class="icon-envelope"></i></span> -->
					<label>Email</label>
		  			<input type="text" id="email" name="email" placeholder="ejemplo1234@micorreo.com">
		  		</div>
	  			<div class="input-prepend">
<!-- 		  			<span class="add-on"><i class="icon-lock"></i></span> -->
					<label>Contraseña</label>
		  			<input type="password" id="password" name="password" placeholder="***********">
		  		</div>
	  			<div class="input-prepend">
<!-- 	  				<span class="add-on"><i class="icon-lock"></i></span> -->
	  				<label>Confirme contraseña</label>
	  				<input type="password" id="confirmPassword" name="confirmPassword" placeholder="***********">
	  			</div>

 				<div id="captcha_register"> 
 					<label>Ingrese el texto de la imagen</label>
					<img src="../captchaImg" />
				    <input name="captcha_answer" class="field" /> 
				</div>
				<span class="captcha_refresh"><a class="link" href="javascript:showRecaptcha('captcha_register');"><i class="icon-refresh"></i> Recargar</a></span>
 						
 				<div class="span3" > 				
			      	<button type="submit" id="btnSignup" class="btn btn-primary">Crear cuenta</button>&nbsp;&nbsp;		
			    	<button type="reset" class="btn">Cancelar</button>				    	
	    		</div>			
		    </div>
   		</form>		 
</div>	