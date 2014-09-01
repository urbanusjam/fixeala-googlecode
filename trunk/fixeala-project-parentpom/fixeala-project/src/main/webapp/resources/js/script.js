$(document).ready(function(){
	
			$('#signupForm #username').focus();
			
 			
// 			$.validator.addMethod("passwordCheck",function(value,element)
// 					{
// 					return this.optional(element) || /^(?=.{8,16})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$_-]).*$/.test(value);
// 					}, "La contraseña no cumple con el formato requerido.");
			
// 			$.validator.addMethod("usernameCheck",function(value,element)
// 					{
// 					return this.optional(element) || /^[a-z0-9_-]{3,15}$/.test(value);
// 					}, "El nombre de usuario no cumple con el formato requerido.");
 			
			
// 			$.validator.addMethod("emailCheck", function(value, element)
//				{
//				return this.optional(element) || /^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$/.test(value);
//				}, "Ingrese una direcci&oacute;n de email v&aacute;lida." +
//						"<br/> (ej: hola@ejemplo.com)");
// 			
// 			$.validator.addMethod(
// 				    "regex",
// 				    function(value, element, regexp) {
// 				        var check = false;
// 				        return this.optional(element) || regexp.test(value);
// 				    },
// 				    "El texto ingresado no cumple con el formato requerido."
// 				);
 			
 		
 			/** ======================================================================================================== **/
			/**                                              S I G N  U P												 **/
			/** ======================================================================================================== **/
 			 			
 			//$('#signupForm input').popover(); 	
 			
 			 $('#signupForm input[type="text"], #signupForm input[type="password"], #signupForm textarea').tooltipster({ 		    
 		    	animation: 'fade',		
 		    	delay: 200,
 		    	interactive: true,
 		    	timer: 2500,
 		    	maxWidth: 230,
 		        trigger: 'custom', 
 		        onlyOne: false,    
 		        position: 'right'  
 		    });  			 
 			
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
				   	    	 },
				   	    	
					 	}, 	 
					 	
			 		 	messages: 
			 		 	{ 	 	  
			 		 		    recaptcha_response_field: 
			 		 		    { 
			 		 		    	required :  "Este campo es requerido.",
			 		 		    	remote: "Captcha inv&aacute;lido"
			 		 		    },
			 		 		    
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
			 	    
			 	    	submitHandler: function() {
			 	    		
//			 	    		bootbox.confirm("&iquest;Confirma que desea crear la cuenta?", function(result){	
			 	    			
			 	    			var username = $('#signupForm #username').val();
				 	    	    var email = $('#signupForm #email').val();
				 	    	    var password = $('#signupForm #password').val();					 	    	    								
				 	    	    var captcha = $('[name="captcha_answer"]').val();
				 	    	  
			            		$.ajax({
			            			    url: "../account/signup/createAccount.html",
								 		type: "POST",	
								 		data: "username=" + username + "&email=" + email + "&password=" + password + "&captcha_answer=" + captcha ,								 
								        success: function(data){
								        	
								        	if(data.result){	 
								        		bootbox.alert(data.message, function() {
								        			setTimeout(function() { 
								        				window.location.href = getDomainUrl();
								        			}, 1000);	
								        		});					 	    					
					 	    				}
					 	    				else{					 	
					 	    					bootbox.alert(data.message);
					 	    				}					 	    				
					            		}		 	    			
			            		});
				            		
//			 	    		});
			 	    		

			 	    	},
			 	    	
			 	    	highlight: function (element) { 
			 	    		$(element).closest('.input-prepend').removeClass('success').addClass('error');
		 			    },
			 	    	
		 			    unhighlight: function (element) { 
		 			    	$(element).closest('.input-prepend').removeClass('error');
		 			    },
				
		 		 		errorPlacement: function (error, element) {
		 		 			$(element).closest('.input-prepend').tooltipster('update', $(error).text());
		 		 			$(element).closest('.input-prepend').tooltipster('show');				        
		  		        }
			 	    	
			 	    	/*
			 	    	success: function(element) {
			 	    		element
			 	    		.text('OK!').addClass('valid')
			 	    		.closest('.input-prepend').removeClass('error').addClass('success');
			 	    	}*/
			 });
			
		
		
			
//			$('#signupForm').submit(function() {
//		        return validateCaptcha();
//		    });
			
			
			function validateCaptcha(){				
				
	    	    var captchaPrivateKey = "6LdIQfQSAAAAAP_NbTRB9gRBTAzgN345VOHincSt";
	    	    var captchaIP = "172.16.67.108";
	    	    var captchaChallenge = Recaptcha.get_challenge();
	    	    var captchaResponse =  Recaptcha.get_response();  	    	    
	    	 
	    	    var captchaInfo =
	            {
    	    		"privatekey":  captchaPrivateKey,
    	    		"remoteip"  :  captchaIP,
    	    		"challenge" :  captchaChallenge,
    	    	    "response"  :  captchaResponse	    	    		
	            };
	    	    
	    	    console.log(JSON.stringify(captchaInfo));
	    	  
	    	   $.ajax({
	    		   		type: 'POST',
	    		   		url: 'http://www.google.com/recaptcha/api/verify',	    		   		
	    		   		contentType: 'application/json; charset=utf-8',
	    		   		dataType: 'jsonp',	
	    		   		data: JSON.stringify(captchaInfo),	    		   		
	    		   		success: function(data){
	    		   			console.log($.parseJSON(data));
	    		   		},
		    		   	 error: function(jqXHR, exception) {
		    		   		 console.log(jqXHR);
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
	    	   
	    	 
	    	  
	    	  return false;
			}
			
			
			/** ======================================================================================================== **/
			/**                                          P A S S W O R D												 **/
			/** ======================================================================================================== **/
			
			$.validator.addMethod("notEqualTo", function(value, element, param) {
				 return this.optional(element) || value != $(param).val();
			});
			
			// initialize tooltipster on form input elements
		    $('#changePasswordForm input[type="password"], #resetCredentialsForm input[type="password"], #closeAccountForm input[type="password"], #updateAccountForm input#email').tooltipster({ 		    
		    	animation: 'fade',		
		    	delay: 200,
		    	interactive: true,
		    	timer: 2500,
		    	maxWidth: 230,
		        trigger: 'custom', // default is 'hover' which is no good here
		        onlyOne: false,    // allow multiple tips to be open at a time
		        position: 'right'  // display the tips to the right of the element
		    });
		    
		    var $changePasswordForm = $( "#changePasswordForm" );
				
		    $changePasswordForm.validate({				
				
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
			  	
			  	highlight: function (element) { 
 			        $(element).addClass("error"); 
 			    },
	 	    	
 			    unhighlight: function (element) { 
 			        $(element).removeClass("error"); 
 			    },
		
 		 		errorPlacement: function (error, element) {
 		            $(element).tooltipster('update', $(error).text());
 		            $(element).tooltipster('show');				        
  		        },
			  	
			  	submitHandler: function() {
			  		
			  		 var currentPassword = $('#currentPassword').val();
			  	     var newPassword = $('#newPassword').val();
			  	     $("#changePasswordForm").serialize();
			  	    
			         $.ajax({
			        	  type: "POST",
			              url: "../account/changePassword.html",
			              data: "currentPassword=" + currentPassword + "&newPassword=" + newPassword,   
			              data:  $("#changePasswordForm").serialize(),
			              success: function(data){  
			            	
			              	  if(data.result){
				              		$changePasswordForm.fadeOut('slow');				              		
								    setTimeout(function() { 
								    	$(".alert-box")
											.fadeIn('slow')
											.append('<div id="alertdiv" style="text-align:center;height:45px;line-height:45px;border:2px solid" class="alert alert-success"><span>'+data.message+'</span></div>');
								    }, 1500);							    
			              	  }
			              	  else
			              		  bootbox.alert(data.message); 
					  	      
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
			         return false;
			     }
			});
		    
		    
		    var $closeAccountForm = $( "#closeAccountForm" );
			
		    $closeAccountForm.validate({				
				
				rules: 
				{								 
					 currentPassword: "required"	
			 	}, 	 		
				
			 	messages: 
				{ 	 	  			 	     			
			  			currentPassword: 
			  			{
			  			 		required: "Este campo es requerido."			 	
			  		 	}			  		 	
			  	},
			  	
			  	highlight: function (element) { 
 			        $(element).addClass("error"); 
 			    },
	 	    	
 			    unhighlight: function (element) { 
 			        $(element).removeClass("error"); 
 			    },
		
 		 		errorPlacement: function (error, element) {
 		            $(element).tooltipster('update', $(error).text());
 		            $(element).tooltipster('show');				        
  		        },
			  	
			  	submitHandler: function() {
			  		
			  		bootbox.confirm("&iquest;Confirma que desea cerrar su cuenta?", function(result){
						  
						  if(result){
							  
							  var currentPassword = $('#closeAccountForm input#currentPassword').val();
							    
						         $.ajax({
						        	  type: "POST",
						              url: "../account/closeAccount.html",
						              data: "password=" + currentPassword,      
						              success: function(data){  
						            	
						              	  if(data.result){						              		  
						              		 setTimeout(function() { 
						              			window.location.href = getDomainUrl() + data.pageRedirect;
											 }, 1500);		
						              	  }
						              	  else
						              		  bootbox.alert(data.message); 
								  	      
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
			  		
			  		 
			     }
			});
		    
		    
		    //// RESET PASSWORD  ////
		   
		    $( "#resetCredentialsForm" ).validate({				
				
				rules: 
				{				
			 	     newPassword: { 
			 	    	 required : true			 	    
			 	     },			    			
			 	     newPasswordConfirmation: {					   	    		
			      		 equalTo: "#newPassword"
			    	 }
			 	}, 	 		
				
			 	messages: 
				{ 	 	
			  		 	newPassword: 
			  			{
			  			 		required: "Este campo es requerido."			  			 		
			  		 	},	
			  		 	newPasswordConfirmation: 
						{			     					
								equalTo:  "La nueva clave y la confirmaci&oacute;n no coinciden."
						}
			  	},
			  	
			  	highlight: function (element) { 
 			        $(element).addClass("error"); 
 			    },
	 	    	
 			    unhighlight: function (element) { 
 			        $(element).removeClass("error"); 
 			    },
		
 		 		errorPlacement: function (error, element) {
 		            $(element).tooltipster('update', $(error).text());
 		            $(element).tooltipster('show');				        
  		        },
			  	
			  	submitHandler: function() {
			  		
			  		 var newPassword = $('#newPassword').val();					  	     
			  	     var path = window.location.pathname;			 
					 var token = path.substr(path.lastIndexOf('/') + 1);			 
					 var tokenEncode = encodeURIComponent(token);
					 
					 alert(tokenEncode);
			  	  
			         $.ajax({
			        	  type: "POST",
			        	  url: "./" + tokenEncode,
				          data: "newPassword=" + newPassword,    
				          async: false,
				          success: function(data){        

				        	  if(data.result){				        		  
				        		  setTimeout(function() { 
				        				window.location.href = getDomainUrl();
				        		  }, 1000);	
				        	  }
				        	  else
				        		  bootbox.alert(data.message);    		  
				        	  
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
		    
		    
		    /**
		    $("#fileupload-profile").change(function(){				
				
				var fileInput = document.getElementById('fileupload-profile');
				var file = fileInput.files;
				var formData = new FormData();			
				formData.append('file', file[0]);
				formData.append('isProfilePic', true);
				
				console.log(formData);
					                
					$.ajax({ 
					 		url: "../handleFileUpload.html", 		
					 		type: "POST",						 				 	
					 		data : formData,
					 		contentType: false,
					        processData: false,	
					 		success : function(response){				 		
					 			var input = $("#fileupload-profile");
					 			if(!response.result){
// 					 				bootbox.alert(alertStatus.message);
					 				input.replaceWith(input.val('').clone(true));
					 			}
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
				
			});
		    **/
		    
		    var $updateAccountForm = $( "#updateAccountForm" );
			
		    $updateAccountForm.validate({				
				
				rules: 
				{								 
					 email: { 
			 	    	 required : true,
			 	    	 email : true			 	    	
			 	     }
			 	     
			 	}, 	 		
				
			 	messages: 
				{ 	 	  			 	     			
			 		email: 
 	     			{
 	     					required: "Este campo es requerido.",	 	
 	     					email: "Ingrese una direcci&oacute;n de email v&aacute;lida."
 	     				
 	     			}	  		 	
			  	},
			  	
			  	highlight: function (element) { 
 			        $(element).addClass("error"); 
 			    },
	 	    	
 			    unhighlight: function (element) { 
 			        $(element).removeClass("error"); 
 			    },
		
 		 		errorPlacement: function (error, element) {
 		            $(element).tooltipster('update', $(error).text());
 		            $(element).tooltipster('show');				        
  		        },
			  	
			  	submitHandler: function() {

			  		blockPage("html");
							  
						  	 var newEmail = $('#updateAccountForm input#email').val();
						  	 var newCity = $('#updateAccountForm #ciudad').find('option:selected').val();
						  	 var newProvince = $('#updateAccountForm #provincia').find('option:selected').val();
						    
					         $.ajax({
					        	  type: "POST",
					              url: "../account/updateAccount.html",
					              data: "newEmail=" + newEmail + "&newCity=" + newCity + "&newProvince=" + newProvince,      
					              success: function(data){  
					            	
					              	  if(data.status){
					              		 setTimeout(function(){
					              			unBlockPage("html");					              			
					              			 setTimeout(function(){
					              				location.reload();
					              			 }, 500);	
					              		 }, 1000);					              		 
					              	  }
					              	  else
					              		  bootbox.alert(data.message); 
							  	      
					               },
					               error: function(jqXHR, exception) {
					            	   bootbox.alert("No se pudieron actualizar los datos de la cuenta."); 
					               }
					         });
			     }
			});
			
			
			$("#forgotPasswordForm").validate({ 
				
				rules: 
				{								 
					 passwordResetEmail: { 
			 	    	 required : true,
			 	    	 email : true			 	    	
			 	     }
			 	}, 	 		
				
			 	messages: 
				{ 	 	  			 	     			
			 			passwordResetEmail: 
			  			{
		  			 		required: function(){
		  			 			showAlert("Ingrese una dirección de correo v&aacute;lida.", "alert-error");	        			  
		  			 		},
		  			 		email: function(){
			  			 		showAlert("Ingrese una dirección de correo v&aacute;lida.", "alert-error");	        		  
			  			 	}	
			  		 	}		
			 	
			  	},
			  			  	
			  	errorPlacement: function (error, element) {
			  		$(element).removeClass('error');				  	   
				},
				
				submitHandler: function()  {
					
					var email = $('#passwordResetEmail').val();
					 
				     $.ajax({
				    	  type: "POST",
				          url: "./forgotPassword/sendPasswordResetMail.html",
				          data: "email=" + email,    
				          async: false,
				          success: function(data){   
				        	  
				        	  if(data.result){	        		  
				        		  showAlert(data.message, "alert-success");
				        		
				        	  }else{
				        		  showAlert(data.message, "alert-error");	        		  
				        	  }
				          },
				           error: function(jqXHR, exception) {
				        	   showAlert(data.message, "alert-error");	   	        	  
				           }
				     });
				     return false;
				}
				
				
			});
			
			
			
			
			
			
		}); //end document ready

	
		
	function showAlert(message, alertType) {

	    $('#alert_placeholder').html('<div id="alertdiv" style="text-align:center;height:auto;padding: 15px;border:2px solid" class="alert ' 
	    		+  alertType + '"><a class="close" data-dismiss="alert">&times;</a><span>'+message+'</span></div>');

	    setTimeout(function() { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs

//	      $("#alertdiv").fadeOut('slow');
	      //$("#alertdiv").remove();

	    }, 6000);
	}

	
	
	function doResetPasswordAjaxPost(){
		 var password = $('#password').val();
		 var passwordConfirmation = $('#passwordConfirmation').val();
		 
		 if(passwordConfirmation != password){
			 alert("La clave y la confirmación deben coincidir.");
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
	
	
	
	

