<div id="content">	
	<!-- Password Reset -->
	<div class="page-header">
  	 	<h4><i class="icon-lock"></i>&nbsp;&nbsp;<i class="icon-angle-right"></i>&nbsp;&nbsp;Modificaci&oacute;n de clave</h4>    	 	
  		</div>   
	<form id="resetCredentialsForm" class="well span5">
	    <div class="row">			
			<div class="input-prepend">
				<label>Ingrese la nueva clave</label>
	  			<input type="password" id="newPassword" name="newPassword" class="input-xlarge">
	  		</div>
 			<div class="input-prepend">
 				<label>Confirme la nueva clave</label>
 				<input type="password" id="newPasswordConfirmation" name="newPasswordConfirmation" class="input-xlarge">
 			</div>
 			<div class="span3" > 				
	      		<button type="submit" id="btnResetPass" class="btn btn-primary">Cambiar clave</button>&nbsp;&nbsp;		
	    		<button type="reset" class="btn">Limpiar campos</button>				    	
  			</div>				     
	    </div> 
		<div class="row" style="height:50px;">
			<div id="alert_placeholder"></div>		    
		</div>
  	</form>
</div>
<script src="resources/js/fixeala/fixeala.account.js"></script> 
<script type="text/javascript">      
	$(document).ready(function(){	fxlAccountController.initResetPwdForm();	});	
</script> 			