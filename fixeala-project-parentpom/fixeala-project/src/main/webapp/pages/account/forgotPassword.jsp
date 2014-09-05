<div id="content">		
		<!-- Reset password -->
	    <div class="page-header">
    	 	<h4><i class="icon-lock"></i>&nbsp;&nbsp;<i class="icon-angle-right"></i>&nbsp;&nbsp;Recuperaci&oacute;n de clave</h4>    	 	
    	</div>    	
   	    <form id="forgotPasswordForm" class="well span5">
		    <div class="row">			
			    <input type="text" id="passwordResetEmail" name="passwordResetEmail" placeholder="ejemplo@correo.com" class="input-xlarge" >	
		      	<button type="submit" id="btnResetPwd" class="btn btn-primary pull-right">            						
		           Enviar
		    	</button>
				<div class="span4">					
			    	<p><i class="icon-caret-right"></i>&nbsp;Introduzca la direcci&oacute;n de email que utiliz&oacute; al crear su cuenta.
			    	Le enviaremos un mensaje a la direcci&oacute;n provista con un enlace para restablecer tu clave.</p>
					<br>
					<p><i class="icon-caret-right"></i>&nbsp;El enlace tiene una <b>vigencia de 24 horas</b>. 
					Si el mensaje tarda en llegar, verifique su carpeta de Correo No Deseado (spam).</p>
		    	</div>   		
		    </div>		 
		    <div class="row" style="height:50px">
		    	<div id="alert_placeholder"></div>		    
		    </div>  
   		</form>   		    
   		<!-- /Reset password -->
</div>
<script src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.account.js"></script> 
<script type="text/javascript">      
	$(document).ready(function(){	fxlAccountController.initReset();	});	
</script> 	