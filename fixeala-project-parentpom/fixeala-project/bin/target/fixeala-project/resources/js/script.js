$(document).ready(function(){

			$('#signupForm #username').focus();
			
			
			
		
 			
// 			$.validator.addMethod("passwordCheck",function(value,element)
// 					{
// 					return this.optional(element) || /^(?=.{8,16})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$_-]).*$/.test(value);
// 					}, "La contrase√±a no cumple con el formato requerido.");
			
// 			$.validator.addMethod("usernameCheck",function(value,element)
// 					{
// 					return this.optional(element) || /^[a-z0-9_-]{3,15}$/.test(value);
// 					}, "El nombre de usuario no cumple con el formato requerido.");
 			
 			
 			$.validator.addMethod("emailCheck", function(value, element)
				{
				return this.optional(element) || /^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$/.test(value);
				}, "Ingrese una direcci&oacute;n de email v&aacute;lida." +
						"<br/> (ej: hola@ejemplo.com)");
 			
 			$.validator.addMethod(
 				    "regex",
 				    function(value, element, regexp) {
 				        var check = false;
 				        return this.optional(element) || regexp.test(value);
 				    },
 				    "El texto ingresado no cumple con el formato requerido."
 				);
 			
 		
 			/** ======================================================================================================== **/
			/**                                              S I G N  U P												 **/
			/** ======================================================================================================== **/
 			 			
 			$('#signupForm input').popover(); 			
 		
			$("#signupForm").validate({		
				
						rules: 
						{	 onfocusin: false,								 
							 username: { 
								 required : true, 
								 // regex : /^[a-z0-9_-]{3,15}$/,
								 minlength: 4,
			    				 maxlength: 20,
			    				 remote: {
						 	    		url: "./signup/checkUsernameAvailability.html", 
										type: "POST", 
										data: {
									        username: function(){ return $("#signupForm #username").val(); }
									    }		
					 	    	 }
							 },								
					 	     email: { 
					 	    	 required : true,
					 	    	 email : true,
					 	    	 remote: {
						 	    		url: "./signup/checkEmailAvailability.html", 
										type: "POST", 
										data: {
									        email: function(){ return $("#signupForm #email").val(); }
									      }		
					 	    	 }
					 	     },
			    			 password: {  
			    				 required : true, 
			    				 // regex : /^(?=.{8,16})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$_-]).*$/
			    				 minlength: 6,
			    				 maxlength: 30
			    			 } ,
				   	    	 confirmPassword: {		
				   	    		 required : true, 
				   	      		 equalTo: "#password"				   	      		 
				   	    	 }
					 	}, 	 
					 	
			 		 	messages: 
			 		 	{ 	 	  
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
			 	     			 		minlength: "Debe tener por lo menos 6 caracteres.",
			 	     			 		maxlength: "El m&aacute;ximo es de 30 caracteres."
			 	     		 	},			     				
			     				confirmPassword: 
			     				{			     				
			     						equalTo:  "La contrase&ntilde;a y la confirmaci&oacute;n no coinciden.",
			     						required: "Este campo es requerido."
			     				}
			 	     	},
			 	     	
			 	    	submitHandler: function() {
			 	    		
			 	    		var username = $('#signupForm #username').val();
			 	    	    var email = $('#signupForm #email').val();
			 	    	    var password = $('#signupForm #password').val();

			 	    	    $.ajax({
			 	    	        type: "POST",
			 	    	        url: "./signup/createAccount.html",
			 	    	        data: "username=" + username + "&email=" + email + "&password=" + password,
			 	    	        async:false,
			 	    	        success: function(response){        			 	    	        	
			 	    	        	window.location.href = "http://localhost:8080/fixeala";
			 	    	         },
			 	    	         error: function(xhr, textStatus, errorThrown){
			 	    	             alert("Error! Status = " + xhr.status);
			 	    	         }
			 	    	    });
			 	    		
			 	    	},
			 	    	
			 	    	highlight: function(element) {
			 	    		$(element).closest('.input-prepend').removeClass('success').addClass('error');
			 	    	},
			 	    	
			 	    	success: function(element) {
			 	    		element
			 	    		.text('OK!').addClass('valid')
			 	    		.closest('.input-prepend').removeClass('error').addClass('success');
			 	    	}
			 });
			
			
			/** ======================================================================================================== **/
			/**                                          P A S S W O R D												 **/
			/** ======================================================================================================== **/
			
			$.validator.addMethod("notEqualTo", function(value, element, param) {
				 return this.optional(element) || value != $(param).val();
			});
				
			$( "#changepasswordform" ).validate({				
				
				rules: 
				{								 
					 currentPassword: "required",					
			 	     newPassword: { 
			 	    	 required : true,
			 	    	 notEqualTo: "#currentPassword"
			 	     },			    			
			 	     newPasswordConfirmation: {					   	    		
			      		 equalTo: "#newPassword"
			    	 }
			 	}, 	 		
				
			 	messages: 
				{ 	 	  			 	     			
			  			currentPassword: 
			  			{
			  			 		required: "Este campo es requerido."			 	
			  		 	},	
			  		 	newPassword: 
			  			{
			  			 		required: "Este campo es requerido.",
			  			 		notEqualTo: "La nueva clave debe ser distinta a la actual."
			  		 	},	
			  		 	newPasswordConfirmation: 
						{			     					
								equalTo:  "La nueva clave y la confirmaci&oacute;n no coinciden."
						}
			  	},
			  	
			  	submitHandler: function() {
			  		
			  		 var currentPassword = $('#currentPassword').val();
			  	     var newPassword = $('#newPassword').val();
			  	    
			         $.ajax({
			        	  type: "POST",
			              url: "./changePassword/doChange",
			              data: "password=" + currentPassword + "&newPassword=" + newPassword,      
			              success: function(response){  
			            	  alert("ddd");
			              	  if(response){
			              		//  alert("La clave ha sido modificada.");
			              	      var newUrl = window.location.protocol + "//" + window.location.host + "/fixeala";	
			              	      alert(newUrl);
			              	      window.location.href = newUrl;
			              	  }
			              	  else
			              		  alert("La clave ingresada es incorrecta.");
					  	      
			               },
			               error: function(jqXHR, exception) {
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
			         });
			     }
			});
			
			
			$("#forgotPasswordForm").validate({ 
				
//				rules: 
//				{								 
//					 email: "required"		 	    
//			 	}, 	 		
//				
//			 	messages: 
//				{ 	 	  			 	     			
//			 			email: 
//			  			{
//			  			 		required: function(){
//			  			 		  showAlert("Debe ingresar una direcci√≥n de correo.", "alert-error");	        		  
//			  			 		}		 	
//			  		 	}
//			  		 
//			  	},
				
				submitHandler: function()  {
					
					var email = $('#email').val();
					 
				     $.ajax({
				    	  type: "POST",
				          url: "./forgotPassword/sendEmailToken.html",
				          data: "email=" + email,    
				          async: false,
				          success: function(result){   
				        	
				        	  if(result){	        		  
				        		  showAlert("°Felicitaciones! El reclamo ha sido registrado con Èxito.", "alert-success");
				        		
				        	  }else{
				        		  showAlert("La direcci&oacute;n de correo no est&aacute; registrada en el sitio.", "alert-error");	        		  
				        	  }
				          },
				           error: function(jqXHR, exception) {
				        	   showAlert("Ha ocurrido un error al procesar su requerimiento. Por favor, intente m&aacute;s tarde.", "alert-error");	   	        	  
				           }
				     });
				     return false;
				}
				
				
			});
			
			
			
			
			
			
		}); //end document ready

	
		
	function showAlert(message, alertType) {

	    $('#alert_placeholder').append('<div id="alertdiv" style="text-align:center;height:45px;line-height:45px;border:2px solid" class="alert ' +  alertType + '"><a class="close" data-dismiss="alert">&times;</a><span>'+message+'</span></div>');

	    setTimeout(function() { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs

	      $("#alertdiv").fadeOut('slow');
	      //$("#alertdiv").remove();

	    }, 6000);
	}

	
	
	function doResetPasswordAjaxPost(){
		 var password = $('#password').val();
		 var passwordConfirmation = $('#passwordConfirmation').val();
		 
		 if(passwordConfirmation != password){
			 alert("La clave y la confirmaci√≥n deben coincidir.");
		 }
		 else{
			 var path = window.location.pathname;			 
			 var tokenu = path.substr(path.lastIndexOf('/') + 1);			 
			 var token = encodeURIComponent(tokenu);
			
			 $.ajax({
		    	  type: "POST",
		          url: "./" + token,
		          data: "newPassword=" + password,    
		          async: false,
		          success: function(response){        
		        	  alert(response);
		        	  var newUrl = window.location.protocol + "//" + window.location.host + "/fixeala";			              	      
              	      window.location.href = newUrl;	  
		           },
		           error: function(jqXHR, exception) {
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
		     });
			 
		 }				 
	     
	     return true;
	}
	
	
	
	

