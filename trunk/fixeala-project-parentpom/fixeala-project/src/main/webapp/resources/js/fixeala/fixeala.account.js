var fxlAccountController = {
		
	rowID : null,
				
	init : function(profileUserID){		
		
		fxlAccountController.initPasswordChange();
		fxlAccountController.initAccountUpdate();	
		fxlAccountController.initAccountClose();		
		fxlAccountController.loadIssuesTable(profileUserID);
		fxlAccountController.loadCommentsTable(profileUserID);
		fxlAccountController.configContextMenu();
				
		$(".fileinput-button").click(function() {
		    $("#fileupload-profile").click();
		});		
		
		$("#fileupload-profile").change(function(){
			 fileController.handleUserPicUpload(this.files[0], profileUserID);
		});	
				
		var prov = '${province}';
		var city = '${city}';
	
		if(prov == null || prov == ''){
			$('#provincia').append("<option value='none'>NINGUNA</option>");
		}		
		else{
			$('#provincia').val(prov);
			$('#ciudad').append("<option value='"+ city +"'>"+city+"</option>");
		}
		
	},
	
	configContextMenu : function(){
		
		var $contextMenu = $("#contextmenu-issue");
		  
		$("body").on("contextmenu", "#tblUserIssues tr", function(e) {
   			$contextMenu.css({
    		      display: "block",
    		      left: e.pageX,
    		      top: e.pageY
   		    });		
			
   		  	fxlAccountController.rowID = $(this).find("td").eq(0).html().trim(); 							    		
			return false;							    			
	    });
		  
		$contextMenu.on("click", "a", function() {
		     $contextMenu.hide();
		});
		  
		$("body").on("click", function() {
   		     $contextMenu.hide();
   	  	});
		
	},
	
	goToIssuePage : function(rowID){		
		var url = fxlGlobalController.getDomainUrl() + 'issues/' + rowID + '.html';		
		return window.location.href = url;
	},
	
	
	/** ============================================================================================== **/
	/**                                              L O G I N										   **/
	/** ============================================================================================== **/
		
	
	login : function(){

        $('#loginForm').validate({ 
        	
        	 	rules: {
        	 		j_username: { required: true },				    
        	 		j_password: { required: true }
 				},
 				
 			    messages: {
 			    	j_username: { required : "" },
 			    	j_password: { required : "" }			 					
 				},
 				
 				highlight: function (element) { 
 					
 					 $(element).closest('.control-group').addClass('error');
 			    },
	 	    	
 			    unhighlight: function (element) { 
 			  	 $(element).closest('.control-group').removeClass('error');  
 			    },
 						 			    
 			 	submitHandler: function() {
 			 				 			 		
 			 		 // Hide 'Submit' Button
 			        $('#btnLogin').hide();

 			        // Show Gif Spinning Rotator
 			        $('.ajax_loading').show();
 			 		
 			 		 $.ajax({
		        			url: fxlGlobalController.getDomainUrl() + "login.html",
		            		type: "POST",		            	
				            beforeSend: function(xhr) {
				                xhr.withCredentials = true;
				            },
				            data: $("#loginForm").serialize(),				       
				            success: function(data, status) { 
				            	
				            		setTimeout(function () {				                   
						            		$('#btnLogin').show();
						            		$('.ajax_loading').hide(); 
						            		
						            		if(data.loggedIn) {								            			
						            			
						            			$('#loginNav').load(location.href + " #loginNav > *");	
						            			
						            			var pathArray = window.location.pathname.split( '/' );	
						            											            			
												if(pathArray.indexOf("issues") != -1){
													
													var target = $('#userIssueActions');
													var url = location.href + " #userIssueActions > *";
													var urlVote = location.href + " #issue-stats-actions > *";
													
													target.load(url, function(){
														userActionsController.enableUserActions();							
													});	
													
												    var isVoted = '${isCurrentlyVoted}';
												    var isVoteUp = '${isVoteUp}';
												    
													$("#issue-stats-actions").load(urlVote, function(){
														userActionsController.setCurrentVote(isVoted, isVoteUp);	
														$("#numFollowers").text('${cantidadObservadores}'); 
													});	
													
													$("#issueRepair").load(location.href + " #issueRepair > *");

												}
													
												
 							                } else {							                
 							                	fxlAccountController.handleLoginFailure();							                    
							                }				            				
				            		},2000);
				            		
				            		return false;				
				            		
				            },
				            						           
				           error: fxlAccountController.handleLoginFailure				           
		        	});	    	
		        	return false;					        	
 			 	}//end submit	
        });
		
	},
	
	handleLoginFailure : function() {
		
        $(".alert").remove();
        $('#username').before('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">&times;</a>El usuario y/o la contrase&ntildea <br>son incorrectos.</div>');
        $('.ajax_loading').hide();
        $('#btnLogin').show();	
        $('#loginForm').each(function(){
            this.reset();   //Here form fields will be cleared.
        });
        
	},
	
	
	/** ============================================================================================== **/
	/**                                              S I G N  U P									   **/
	/** ============================================================================================== **/
		 			
	
	initSignup : function(){
		
		$('#signupForm #username').focus();
		
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
 	    		
 	    		fxlAccountController.signup();
 	    		
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
		
	},
	
	signup : function(){
		
 		bootbox.confirm('&iquest;Confirma que desea crear la cuenta?', function(result){
 			
 			if(result){
 				
 				bootbox.hideAll(); 				
 				fxlGlobalController.blockPage('html');
 				
 				var $signupForm =  $('#signupForm'); 				
 				var username = $('#signupForm #username').val();
 		 	    var email = $('#signupForm #email').val();
 		 	    var password = $('#signupForm #password').val();					 	    	    								
 		 	    var captcha = $('[name="captcha_answer"]').val();
 		 	  
 				$.ajax({
 					    url: '../account/signup/createAccount.html',
 				 		type: "POST",	
 				 		data: 'username=' + username + '&email=' + email + '&password=' + password + '&captcha_answer=' + captcha,
 				        success: function(data){	
 				        	
 				        	if(data.result){
 				        		console.log('--- signup ok ---');
 				        		bootbox.alert(data.message, function() {
 				        			setTimeout(function() { 
 				        				window.location.href = fxlGlobalController.getDomainUrl();
 				        			}, 1000);	
 				        		});					 	    					
 			    				}
 			    				else{		
 			    					console.log('--- signup fail ---');	    					
 			    					bootbox.alert(data.message, function() {
 			    						fxlGlobalController.unBlockPage('html');
 			    						fxlGlobalController.clearForm($signupForm);
 			    					});	
 			    				}					 	    				
 		        		},
 		        		error: function(){	
 		        			bootbox.alert('Ha ocurrido un error al crear su cuenta.', function() {
	    						fxlGlobalController.unBlockPage('html');
	    						fxlGlobalController.clearForm($signupForm);
		    				});	
 		        		}
 						
 				});
 				
 				return false;
 				
 			}
 			
		});//bootbox
		
	},

	validateCaptcha : function(){				
		
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
		   		url: 'http://www.google.com/recaptcha/api/verify',	    	
		   		type: 'POST',	    		   			   		
		   		contentType: 'application/json; charset=utf-8',
		   		dataType: 'jsonp',	
		   		data: JSON.stringify(captchaInfo),	    		   		
		   		success: function(data){
		   			console.log($.parseJSON(data));
		   		},
    		   	error: function(jqXHR, exception) {
    		   		 bootbox.alert(jqXHR.responseText);	                
	            }
         
	   });
	   
	  return false;
	  
	},
	
	showRecaptcha : function(containerID) {
    	var captchaContent = '<label>Ingrese el texto de la imagen</label><img src="../captchaImg" /><input name="captcha_answer" class="field" />';
    	$("#"+containerID).html (captchaContent);
    },
    
    
    /** ============================================================================================== **/
	/**                                     R E S E T   P A S S W O R D		    		               **/
    /** ============================================================================================== **/
    
    
    initReset : function(){
    	
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
		  			 			fxlGlobalController.showAlert("Ingrese una dirección de correo v&aacute;lida.", "alert-error");	        			  
		  			 		},
		  			 		email: function(){
		  			 			fxlGlobalController.showAlert("Ingrese una dirección de correo v&aacute;lida.", "alert-error");	        		  
			  			 	}	
			  		 	}		
			 	
			  	},
			  			  	
			  	errorPlacement: function (error, element) {
			  		$(element).removeClass('error');				  	   
				},
				
				submitHandler: function()  {					
					fxlAccountController.sendPwdEmailReset();					
				}			
			
		});
    },
    
    sendPwdEmailReset : function(){
    	
    	fxlGlobalController.blockPage('html');
    	
    	var email = $('#passwordResetEmail').val();
		 
	     $.ajax({
	    	  type: "POST",
	          url: "./forgotPassword/sendPasswordResetMail.html",
	          data: "email=" + email,              
	          success: function(data){   
	        	  
	        	  if(data.result){	
	        		  bootbox.alert(data.message, function() {
	        			  fxlGlobalController.unBlockPage('html');
	  					  window.location.href = fxlGlobalController.getDomainUrl();
		    		  });	        		  
	        		
	        	  }else{
	        		  bootbox.alert(data.message, function() {
	        			  fxlGlobalController.unBlockPage('html');
	    			  });		        		          		  
	        	  }
	        	  
	          },
	          error: function(jqXHR, exception) {
	        	  bootbox.alert('Hubo un error al intentar enviar el mail.', function() {
	        		  fxlGlobalController.unBlockPage('html');
	        	  });	   	        	  
	          }
	     });
	     
	     return false;
    	
    },
    
    initResetPwdForm : function(){
    	
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
    	  		fxlAccountController.resetPassword();    	  		
    	    }
    	});
    	
    },
    
    resetPassword : function(){
    	
    	fxlGlobalController.blockPage('html');
    	
    	var newPassword = $('#newPassword').val();					  	     
  	    var path = window.location.pathname;			 
		var token = path.substr(path.lastIndexOf('/') + 1);			 
		var tokenEncode = encodeURIComponent(token);
		 
        $.ajax({
        	  type: "POST",
        	  url: "./" + tokenEncode,
	          data: "newPassword=" + newPassword,    	         
	          success: function(data){        

	        	  if(data.result){			
	        		  bootbox.alert(data.message, function() {
	        			  fxlGlobalController.unBlockPage('html');
	  					  window.location.href = fxlGlobalController.getDomainUrl();
		    		  });	        		  
	        	  }
	        	  else
	        		  bootbox.alert(data.message, function() {
	        			  fxlGlobalController.unBlockPage('html');
	    			  }); 
	        	  
	          },	          
              error: function(jqXHR, exception) {
            	  bootbox.alert('Hubo un error al intentar modificar la clave.', function() {
 	        		  fxlGlobalController.unBlockPage('html');
 	        	  });	
              }
         });
    	
    },
    
    /** ============================================================================================== **/
	/**                                 C H A N G E   P A S S W O R D				    	           **/
    /** ============================================================================================== **/
	
    
    initPasswordChange : function(){
    	
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
    	  		fxlAccountController.changePassword();
    	    }
    	});
    },
    
    changePassword : function(){
    	
    	fxlGlobalController.blockPage('html');
    	
    	var currentPassword = $('#currentPassword').val();
  	    var newPassword = $('#newPassword').val();
  	    var $changePasswordForm = $("#changePasswordForm");
  	    
        $.ajax({
        	  type: "POST",
              url: "../account/changePassword.html",
              data: "currentPassword=" + currentPassword + "&newPassword=" + newPassword,   
              success: function(data){  
            	
              	  if(data.result){              		  
              		  $changePasswordForm.fadeOut('slow');				              		
					  setTimeout(function() { 
					    	$(".alert-box")
								.fadeIn('slow')
								.append('<div id="alertdiv" style="text-align:center;height:45px;line-height:45px;border:2px solid" class="alert alert-success"><span>'+data.message+'</span></div>');
					  }, 1500);		
					  fxlGlobalController.unBlockPage('html');
              	  }
              	  else
              		  bootbox.alert(data.message, function() {
	        			  fxlGlobalController.unBlockPage('html');
	    			  });
		  	      
               },
               error: function(jqXHR, exception) {
            	   bootbox.alert('Hubo un error al intentar modificar la clave.', function() {
  	        		  fxlGlobalController.unBlockPage('html');
  	        	  });	
               }
         });
         
         return false;    	
    },
    
    /** ============================================================================================== **/
	/**                                 U P D A T E   A C C O U N T 						           **/
    /** ============================================================================================== **/
    
    initAccountUpdate : function(){
    	
        $( "#updateAccountForm" ).validate({				
    		
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
    	  		fxlAccountController.updateAccount();
    	  	}
    	  		
    	});
    	
    },
    
    updateAccount : function(){
    	
    	fxlGlobalController.blockPage("html");
		  
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
     					fxlGlobalController.unBlockPage("html");
     					location.reload();
     				}, 1000);	         					              		 
             	}
             	else
             		bootbox.alert(data.message, function() {
             			fxlGlobalController.unBlockPage('html');
	    			});
		  	      
              },
              error: function() {
           	  	bootbox.alert("No se pudieron actualizar los datos de la cuenta."); 
              }
        });
	},
	
	
	/** ============================================================================================== **/
	/**                               C L O S E   A C C O U N T				    		               **/
	/** ============================================================================================== **/
	
	
	initAccountClose : function(){
		
	    $( "#closeAccountForm" ).validate({				
			
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
		  		fxlAccountController.closeAccount();	
		    }
		});
		
	},
	
	closeAccount : function(){
		
		bootbox.confirm("&iquest;Confirma que desea cerrar su cuenta?", function(result){
			  
			  if(result){
				  
				  var $closeAccountForm = $( "#closeAccountForm" );
				  fxlGlobalController.blockPage("html");
				  
				  var currentPassword = $('#closeAccountForm input#currentPassword').val();
				    
			         $.ajax({
			        	  type: "POST",
			              url: "../account/closeAccount.html",
			              data: "password=" + currentPassword,      
			              success: function(data){  
			            	
			              	  if(data.result){						              		  
			              		 setTimeout(function() { 
			              			fxlGlobalController.unBlockPage("html");
			              			window.location.href = fxlGlobalController.getDomainUrl();
								 }, 1000);		
			              	  }
			              	  else
			              		  bootbox.alert(data.message, function() {
			              			  fxlGlobalController.unBlockPage('html');
			              			  fxlGlobalController.clearForm($closeAccountForm);
			              		  });
					  	      
			               },
			              error: function() {
			              	  	bootbox.alert("No se pudo cerrar la cuenta."); 
			              	  	fxlGlobalController.clearForm($closeAccountForm);
			              }
			         });
				  
			  }
		});
		
	},
	
	loadIssuesTable : function(profileUserID){

		var url = fxlGlobalController.getDomainUrl()+ "users/" +profileUserID+ "/loadUserIssues.html";
		
		//DATATABLE ISSUES BY USER
		$('#tblUserIssues').dataTable({
			"bProcessing": true,
			"bServerSide": true,
			"aoColumns" : [	 						
			               	 { "sTitle" : "#" , "mData" : "id" },
			               	 { "sTitle" : "FECHA" , "mData" : "fechaFormateada" },
			               	 { "sTitle" : "TITULO" , "mData" : "title" },
			                 { "sTitle" : "DIRECCION" , "mData" : "address" },		             
			               	 { "sTitle" : "CIUDAD" , "mData" : "city" },
			               	 { "sTitle" : "PROVINCIA" , "mData" : "province" },		   		            
			               	 { "sTitle" : "ESTADO" , "mData" : "status" }		            	
		                  ],		  		
			"sAjaxSource": url,
			"fnServerData": function ( sSource, aoData, fnCallback ) {							 	
		            $.ajax( {
		                "dataType": 'json',
		                "type": "GET",
		                "url": sSource,
		                "data": aoData,
		                "success": fnCallback      	              
		            } );
		        },
		        "fnRowCallback": function( nRow, aData, iDataIndex, iDisplayIndexFull  ) {
		            $(nRow).attr('id', aData.id);
		        },
		    "aaSorting": [[ 0, "desc" ]] 
		});
		
	},
	
	loadCommentsTable : function(profileUserID){
	
		var url = fxlGlobalController.getDomainUrl()+ "users/" +profileUserID+ "/loadUserComments.html";
		
		//DATATABLE COMMENTS BY USER
		$('#tblUserComments').dataTable({
			"bProcessing": true,
			"bServerSide": true,
			"aoColumns" : [	 
			          	 	 { "sTitle" : "FECHA" , "mData" : "fechaFormateada" },
			                 { "sTitle" : "MENSAJE" , "mData" : "mensaje" },		    
			               	 { "sTitle" : "NRO. DE RECLAMO" , "mData" : "nroReclamo" }		               	
		                  ],		  		
			"sAjaxSource": url,
			"fnServerData": function ( sSource, aoData, fnCallback ) {		
		            $.ajax( {
		                "dataType": 'json',
		                "type": "GET",
		                "url": sSource,
		                "data": aoData,
		                "success": fnCallback      	              
		            } );
		        },
		        "fnRowCallback": function( nRow, aData, iDataIndex, iDisplayIndexFull  ) {
		            $(nRow).attr('id', aData.id);
		        },
		    "aaSorting": [[ 0, "desc" ]] 
		});		
		
	}
	

}