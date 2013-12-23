<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<!-- <meta http-equiv="content-type" content="text/html; charset=UTF8"> -->
<!--  	<meta name="viewport" content="initial-scale=1.0, user-scalable=no"> -->
	<title><tiles:insertAttribute name="title" ignore="true" /></title>	
	 
<!--   	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3&sensor=false"></script> -->
  	
  	<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&components=country:ar&libraries=places&language=ES"></script> 
  	  	  	
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.jsonp-2.4.0.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-ui-1.10.3.custom.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.mockjax.js"></script> 
  	<script type="text/javascript" src="http://code.jquery.com/jquery-migrate-1.1.0.js"></script>
    
    <script src="http://blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>
	<script src="http://blueimp.github.io/JavaScript-Load-Image/js/load-image.min.js"></script>
	<script src="http://blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
	
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.iframe-transport.js"></script>	
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload.js"></script>	
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-process.js"></script>  
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-image.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-video.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-validate.js"></script>
<%--     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-ui.js"></script> --%>
<%--     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.ui.widget.js"></script> --%>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.uploadify.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.bootpag.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/formToWizard.js"></script>
    
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.geocomplete.js"></script>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/d3.v3.js"></script> --%>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/json/d3.jsonp.js"></script> --%>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/json/togeojson.js"></script> --%>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/json/topojson.js"></script> --%>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/json/json.min.js"></script>	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/map.js"></script>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fixeala-datagrid.js"></script> --%>
  		
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-editable.js"></script>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-datetimepicker.js"></script> --%>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/select2.js"></script>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-sortable.js"></script>  --%>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-rowlink.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-lightbox.js"></script>
  	
  	<!-- Fuel UX CDN link to responsive css -->
<!--     <link href="http://www.fuelcdn.com/fuelux-imh/2.3/css/fuelux-responsive.css" rel="stylesheet" />        -->
<!--   	<link rel="stylesheet" href="https://fuelcdn.com/fuelux/2.3/css/fuelux.min.css"> -->
<!-- 	<script src="https://fuelcdn.com/fuelux/2.3/loader.min.js"></script> -->
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-tags.js"></script> 
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-contextmenu.js"></script> 
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-fileupload.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootbox.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-wysiwyg.js"></script> 
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-paginator.js"></script> 
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.hotkeys.js"></script>	 
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fuelux/require.js"></script> --%>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fuelux/datagrid.js"></script> --%>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fuelux/underscore.js"></script>
  	  	
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.easyWizard.js"></script> --%>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.stepy.js"></script>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.bootstrap.wizard.js"></script> --%>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.form.js"></script>   --%>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.form.wizard.js"></script>    --%>
  	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/markerclusterer.js"></script>	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/markermanager.js"></script>	
    
<%--     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.dataTables.js"></script> --%>
<%--     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/DT_bootstrap.js"></script> --%>
    	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.validate.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.blockUI.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.tagit.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.tooltipster.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/recaptcha_ajax.js"></script>	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.shorten.1.0.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/moment.min.js"></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/util.js"></script>   --%>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/script.js"></script>	
  	
  	<link type="text/css" href="http://fonts.googleapis.com/css?family=Oxygen:400,300,700|Lato:400,900|Graduate:400,900" rel="stylesheet">
  	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/DT_bootstrap.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.tagit.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/tagit.ui-zendesk.css" rel="stylesheet">	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.fileupload.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.fileupload-ui.css" rel="stylesheet">
	 
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.css" rel="stylesheet">   
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-combined.min.css" rel="stylesheet"> 
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-editable.css" rel="stylesheet"> 
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-sortable.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-rowlink.css" rel="stylesheet"> 
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-responsive.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-fileupload.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-lightbox.css" rel="stylesheet">   
<%-- 	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/datetimepicker.css" rel="stylesheet"> --%>
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/select2.css" rel="stylesheet">   
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/select2-bootstrap.css" rel="stylesheet">   
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/font-awesome.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/fuelux/fuelux.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-tags.css" rel="stylesheet">   
	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.uploadify.css" rel="stylesheet">		
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/tooltipster.css" rel="stylesheet">		
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/style2.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.stepy.css" rel="stylesheet"> 
<%-- <link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery-ui-1.10.0.custom.css" rel="stylesheet">	 --%>	
<%-- <link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.dataTables.css" rel="stylesheet"> --%>	
<!-- <link type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/themes/smoothness/jquery-ui.css " rel="stylesheet"> -->
<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->


<style>

path {
  fill: #ccc;
  stroke: #fff;
  stroke-width: .5px;
}

path:hover {
  fill: red;
}

/* #issueWizard {zwidth:600px;border:1px solid #ccc}  */
.easyWizardSteps {list-style:none;width:100%;overflow:hidden;margin:0;padding:0;border-bottom:1px solid #ccc;margin-bottom:20px}
.easyWizardSteps li {font-size:12px;display:inline-block;padding:15px 0px 10px 0px;color:#B0B1B3;margin-right:20px;}
.easyWizardSteps li span {font-size:24px}
.easyWizardSteps li.current {color:#000}

.easyWizardButtons {overflow:hidden;padding:5px;}
.easyWizardButtons button, .easyWizardButtons .submit {cursor:pointer; }
.easyWizardButtons .prev {float:left}
.easyWizardButtons .next, .easyWizardButtons .submit {float:right}

.step{display:inline;} 

.easyWizardWrapper{height:280px;width:600px;}  

#issueWizard fieldset{width:300px; padding:0; border:none;}
/* #issueWizard legend.none{display:none;} */

</style>

  	<script type="text/javascript">
    //<![CDATA[
        
		$(document).ready(function(){
			
			var options = {
	                currentPage: 1
	                , totalPages: 10
	                , numberOfPages:3
	                , size:'normal'
	                , alignment:'center'
	                , onPageChanged: function(e,oldPage,newPage){
	                    $('.pag').text("Current page changed, old: "+oldPage+" new: "+newPage);
	                }
	              
	            }

// 	        $('#comments-pag').bootstrapPaginator(options);
			
			$('#comments-pag').bootpag({
			    total: 10
			    , page: 1
			    , maxVisible: 3
			    , next: 'Siguiente &raquo;'
			    , prev: '&laquo; Anterior'
			}).on("page", function(event, num){
			    $(".content").html("Page " + num); // or some ajax content loading...
			});
		
			
			$(".finish").addClass("btn btn-success");
			
			var isValid = false;

// 			$("#fileupload").change(function(){				
			
// 				var fileInput = document.getElementById('fileupload');
// 				var file = fileInput.files[0];
// 				var formData = new FormData();			
// 				formData.append('fileUpload', file);
	                
// 					$.ajax({ 
// 					 		url: "./handleFileUpload.html", 		
// 					 		type: "POST",						 				 	
// 					 		data : formData,
// 					 		contentType: false,
// 					        processData: false,	
// 					 		success : function(alertStatus){
// 					 			var input = $("#fileUpload");
// 					 			if(!alertStatus.result){
// 					 				bootbox.alert(alertStatus.message);
// 					 				input.replaceWith(input.val('').clone(true));
// 					 			}
// 					 		},						 		 
// 					 		error: function(jqXHR, exception) {
// 				                   if (jqXHR.status === 0) {
// 				                       alert('Not connect.\n Verify Network.');
// 				                   } else if (jqXHR.status == 404) {
// 				                       alert('Requested page not found. [404]');
// 				                   } else if (jqXHR.status == 500) {
// 				                       alert('Internal Server Error [500].');
// 				                   } else if (exception === 'parsererror') {
// 				                       alert('Requested JSON parse failed.');
// 				                   } else if (exception === 'timeout') {
// 				                       alert('Time out error.');
// 				                   } else if (exception === 'abort') {
// 				                       alert('Ajax request aborted.');
// 				                   } else {
// 				                       alert('Uncaught Error.\n' + jqXHR.responseText);
// 				                   }
// 				               }
// 					 	});
				
// 			});

				
			function updateProgressBar(navItems, stepIndex){
				var $total = navItems;		
				var $current = stepIndex;			
				var $percent = ($current/$total) * 100;
				$('.bar').css({width:$percent+'%'});
			}
			
			
			$('#issueWizard').stepy({
				backLabel  : '&laquo; Anterior',
				nextLabel  : 'Siguiente &raquo;', 
				errorImage :  false,
				legend     :  false,
				transition : 'fade',
				block: true,
				validate: true,
				next: function(index) {
					
					if($("#issueWizard").valid()){
						
						if(index-1 == 1){
							
							//valido direccion ingresada a mano
							geocodeAddress(function(value) { isValid = value; });	
		
					    	if(!isValid)
					    		return false;
					    	
					    	else{					    		
					    		$('#issueWizard').stepy('step', 2);
					    		updateProgressBar(3, index-1);
					    	}									    	
						}
						
					}
					
				   
				},
				back: function(index) {
					updateProgressBar(3, index-1);
				
				}, finish: function(index) {
					
					var $form = $("#issueWizard");
								
					$.ajax({ 
					 		url: "./reportIssue.html", 		
					 		type: "POST",					 	
					 		data : $form.serialize(),	
					 		success : function(alertStatus){					 		
					 			if(alertStatus.result){
					 				
					 				bootbox.alert(alertStatus.message, function() {
					 					setTimeout(function () {
			 	    						window.location.reload();
			 	    					}, 400);	
					 				});		 	    					
		 	    				}
		 	    				else{	 	    			
		 	    					bootbox.alert(alertStatus.message);	 	    										 	    					
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
					
					return false;
			  }
			});
			
			
			$(function(){
				function initToolbarBootstrapBindings() {
					$('a[title]').tooltip({container:'.text-editor'});
					$('.dropdown-menu input').click(function() {return false;})
						.change(function () {$(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');})
						.keydown('esc', function () {this.value='';$(this).change();});
				};
				function showErrorAlert (reason, detail) {
					var msg='';
					if (reason==='unsupported-file-type') { msg = "Unsupported format " +detail; }
					else {
						console.log("error uploading file", reason, detail);
					}
					$('File upload error '+ msg + '').prependTo('#alerts');
				};
				
				initToolbarBootstrapBindings();

				$('#commentTextEditor').wysiwyg({ fileUploadError: showErrorAlert} );
			});
			
		
		
			
			$("#issueClose").click(function(){		
					 $("#issueForm").fadeIn('slow');					
			});
		
			
			 // initialize tooltipster on form input elements
		    $('#issueWizard input[type="text"], #issueWizard textarea').tooltipster({ 		    
		    	animation: 'fade',		
		    	delay: 200,
		    	interactive: true,
		    	timer: 2500,
		    	maxWidth: 230,
		        trigger: 'custom', // default is 'hover' which is no good here
		        onlyOne: false,    // allow multiple tips to be open at a time
		        position: 'right'  // display the tips to the right of the element
		    });
			
			/** ======================================================================================================== **/
			/**                                               I S S U E	S		  	  								     **/
			/** ======================================================================================================== **/
			
			var visible = true;		
			
			function showAlert(message, alertType) {
				$('#alert_placeholder')
					.fadeIn('slow')
					.append('<div id="alertdiv" style="text-align:center;height:45px;line-height:45px;border:2px solid" class="alert ' +  alertType + '"><a id="issueClose" class="close" data-dismiss="alert">&times;</a><span>'+message+'</span></div>');
			    setTimeout(function() { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs
			      $("#alertdiv").fadeOut('slow');					 
			    }, 3000);
			}  
	

			$("#issueWizard").validate({				
					rules: {
			 			address: { required: true},					 		
			 			city: { required: true},		
			 			province: { required: true},		
	 				    title: { required: true, maxlength: 50},				    
	 				    description: { required: true, maxlength: 300}							
	 				  },
	 			    messages: {
	 			    	  address: { required : 'Este campo es requerido.'},			 			    
	 			    	  city: { required : 'Este campo es requerido.' },	
	 			    	  province: { required : 'Este campo es requerido.' },
	 					  title: { required : 'Este campo es requerido.', maxlength: 'El m&aacute;ximo es de 50 caracteres.' },
	 					  description: { required : 'Este campo es requerido.' , maxlength: 'El m&aacute;ximo es de 300 caracteres'}
	 					
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
	  		        }
			});
			
			
			
			function initBlokUI(){				
					
				$("#issueFormWizard").block({ 
	                message: '<img src="resources/images/loader5.gif" />', 
	                css: { 
	                	border: 'none', 
	                	width:  '100px', 
	                	height: '100px', 
	                	top:    '50%',
	                	left:   '50%'
	                },		       
	                overlayCSS:  { 
	                    backgroundColor: '#000', 
	                    opacity:          0.2		                 
	                },				              
	                fadeOut: 500
	            });
			}
			
			function getUrl(){
				 return "http://localhost:8080/fixeala";
			}
						
			$('.navbar .nav > li > a').tooltip({
  				placement: 'bottom'
  			});
			
			
			//-------------------------------
            // USER LOGIN
            //-------------------------------
			
			var loginFailed = function(data, status) {
		        $(".alert").remove();
		        $('#username').before('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">&times;</a>El usuario y/o la contraseña <br>son incorrectos.</div>');
		        $('.ajax_loading').hide();
		        $('#btnLogin').show();	
		        $('#loginForm').each(function(){
                    this.reset();   //Here form fields will be cleared.
                });
		              
			};
			
		    $("#btnLogin").click( function(e) {	
		        
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
				        			url: getUrl() + "/login.html",
				            		type: "POST",		            	
						            beforeSend: function(xhr) {
						                xhr.withCredentials = true;
						            },
						            data: $("#loginForm").serialize(),				       
						            success: function(data, status) { 
						            	
						            		setTimeout(function () {				                   
								            		$('#btnLogin').show();
								            		$('.ajax_loading').hide(); 
								            		
								            		if (data.loggedIn) {						            			
									                	 $('#loginNav').load(location.href + " #loginNav > *");	
// 									                	 window.location.reload();
									                	 return false;
											          
		 							                } else {							                
									                    loginFailed(data);							                    
									                }				            				
						            		},2000);	
						            		
						            },
						            						           
						           error: loginFailed				           
				        	});	    	
				        	return false;					        	
		 			 	}	
		        });
		       
		    });
		    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 
			
			
					
			//-------------------------------
            // Tag events
            //-------------------------------
            
            //var sampleTags = ['luminaria apagada', 'acera rota', 'bache', 'vehÃ­culo abandonado', 'residuos'];
            var eventTags = $('#eventTags');

            var addEvent = function(text) {
                $('#events_container').append(text + '<br>');
            };
            eventTags.tagit({
            	//availableTags: sampleTags,     
            	 autocomplete: {
            		 messages: {
            		        noResults: '',
            		        results: function() {}
            		    }
            	 },
            	tagSource: function(search, showChoices) {
            		var filter = search.term.toLowerCase();

            		$.ajax({ 
            			  url: "http://localhost:8080/fixeala/loadTags.html",
	            		  type: "GET",	
            			  success: function(data){
		            		var choices = $.grep(data, function(element) {
		            		// Only match autocomplete options that begin with the search term.
		            		// (Case insensitive.)
		            		return (element.toLowerCase().indexOf(filter) === 0);
		            		});
	            			showChoices(choices);
	            		},
	            		dataType: 'json'
            		});
            	},              
                allowSpaces: true,
                tagLimit: 5,
                beforeTagAdded: function(evt, ui) {
                    if (!ui.duringInitialization) {
                        addEvent('beforeTagAdded: ' + eventTags.tagit('tagLabel', ui.tag));
                    }
                },
                afterTagAdded: function(evt, ui) {
                    if (!ui.duringInitialization) {
                        addEvent('afterTagAdded: ' + eventTags.tagit('tagLabel', ui.tag));
                    }
                },
                beforeTagRemoved: function(evt, ui) {
                    addEvent('beforeTagRemoved: ' + eventTags.tagit('tagLabel', ui.tag));
                },
                afterTagRemoved: function(evt, ui) {
                    addEvent('afterTagRemoved: ' + eventTags.tagit('tagLabel', ui.tag));
                },
                onTagClicked: function(evt, ui) {
                    addEvent('onTagClicked: ' + eventTags.tagit('tagLabel', ui.tag));
                },
                onTagExists: function(evt, ui) {
                    addEvent('onTagExists: ' + eventTags.tagit('tagLabel', ui.existingTag));
                }
            });
								
            /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 
					
			function loadCaptcha(){
				
				//CAPTCHA
	      	   	Recaptcha.create("6Lck8coSAAAAAKsNsoJdRVpHrCYfpbC60xhY7Ywv", 'captchadiv', {                              
	      	   		theme: "clean",
	      	   		callback: Recaptcha.focus_response_field
	      	   	});  
				
			}
            
         
            
            
            $('#btnIssue').click(function(){ 
            	
            	var $issueBox = $("#issueForm");            	
            	            	
            	 $issueBox.animate({
                     width: "toggle",
                     right:'306px',
                     opacity: "toggle"                   
                 }, 'slow');
            	 
            	 $("#map_canvas").animate({            		 
            		  width : parseInt($issueBox.css('width'), 10) == 316 ? 1178 : 826                       		
                 }, 'slow');
            	 
            	  $("#cbxProvincias").animate({
            		    marginRight : parseInt($issueBox.css('width')) == 316 ? 115 : 468        
            	  }, 'slow');
            	
            });
            
            
            function setInitMarker(){
          	
          		map.setCenter(init_coord); 		
          		
          		var marker = new google.maps.Marker({ 
          			 map: map,
          			 position: init_coord,
          			 draggable: true          			 
          		}); 
          	
          	}	
            
            
            function clearForm(form) {
            	  // iterate over all of the inputs for the form
            	  // element that was passed in
            	  $(':input', form).each(function() {
            	    var type = this.type;
            	    var tag = this.tagName.toLowerCase(); // normalize case
            	    // it's ok to reset the value attr of text inputs,
            	    // password inputs, and textareas
            	    if (type == 'text' || type == 'password' || tag == 'textarea')
            	      this.value = "";
            	    // checkboxes and radios need to have their checked state cleared
            	    // but should *not* have their 'value' changed
            	    else if (type == 'checkbox' || type == 'radio')
            	      this.checked = false;
            	    // select elements need to have their 'selectedIndex' property set to -1
            	    // (this works for both single and multiple select elements)
            	    else if (tag == 'select')
            	      this.selectedIndex = -1;
            	  });
            	};


		});
		
		
		 /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 
		//]]>
    
	</script>

</head>

<body>

  <tiles:insertAttribute name="header" />
  
  <tiles:insertAttribute name="body" />
 
  <tiles:insertAttribute name="footer" />
  
</body>

</html>