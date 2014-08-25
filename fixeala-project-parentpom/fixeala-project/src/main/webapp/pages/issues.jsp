<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Boolean isCommonUser -->
<!-- needed for creating the boolean: !isUser -->
<c:set var="isCommonUser" value="false" />
<sec:authorize access="hasRole('ROLE_USER')">
    <c:set var="isCommonUser" value="true" />
</sec:authorize>


	
<div id="content">	


		<!-- Issue -->
		
		<script type="text/javascript">
		

     

		jQuery.extend(jQuery.validator.messages, {
		    required: "Campo obligatorio."//,
// 		    remote: "Please fix this field.",
// 		    email: "Please enter a valid email address.",
// 		    url: "Please enter a valid URL.",
// 		    date: "Please enter a valid date.",
// 		    dateISO: "Please enter a valid date (ISO).",
// 		    number: "Please enter a valid number.",
// 		    digits: "Please enter only digits.",
// 		    creditcard: "Please enter a valid credit card number.",
// 		    equalTo: "Please enter the same value again.",
// 		    accept: "Please enter a value with a valid extension.",
// 		    maxlength: jQuery.validator.format("Please enter no more than {0} characters."),
// 		    minlength: jQuery.validator.format("Please enter at least {0} characters."),
// 		    rangelength: jQuery.validator.format("Please enter a value between {0} and {1} characters long."),
// 		    range: jQuery.validator.format("Please enter a value between {0} and {1}."),
// 		    max: jQuery.validator.format("Please enter a value less than or equal to {0}."),
// 		    min: jQuery.validator.format("Please enter a value greater than or equal to {0}.")
		});
			
			var issueID = ${id};
		  	var updatedFields =  { "title": 0 , "desc": 0, "barrio": 0};			 
		  	var oldFields = $.parseJSON('${oldFields}');
		  
		  	var idIssue = '${id}'; //duplicado
			var loggedUser = '${loggedUser}';
	   		var latitud = '${latitud}';
	   		var longitud = '${longitud}';
			var newTitle = "";	
			
			var statusLabel = "";

			$('[data-toggle="popover"]').popover();
	
			$('body').on('click', function (e) {
			    $('[data-toggle="popover"]').each(function () {
			        //the 'is' for buttons that trigger popups
			        //the 'has' for icons within a button that triggers a popup
			        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
			            $(this).popover('hide');
			        }
			    });
			});
			
		//////////////////////////////////////////////////////////////////////	
		
			$(function(e){	
				
			
			$("#btn-update-status").click(function(event){
				var statusForm =  $("#modalStatusForm");
				statusForm.validate();
				
				if(!statusForm.valid()){
					return false;
				}				
				else{
					userActionsController.editIssueStatus(event);
				}
				
			});
			
			
			$('#invalid-container').hide();
			
			$("#tipoResolucion").change(function(){
				
				if( $(this).val() == "Invalido" ){
					var $options = $('#tipoInvalido');
					$options.append($("<option />").val("No es un reclamo").text("NO ES UN RECLAMO"));
					$options.append($("<option />").val("Ubicacion incorrecta").text("UBICACION INCORRECTA"));
					$options.append($("<option />").val("Informacion falsa").text("INFORMACION FALSA"));
					$options.append($("<option />").val("Datos personales").text("DATOS PERSONALES"));					
					$options.append($("<option />").val("Contenido ofensivo").text("CONTENIDO OFENSIVO"));
					 
					$('#invalid-container').show();
				}
				
				else{
					$('#invalid-container').hide();
				}
				
				
			});
	
			$('#fecha-estimada-from').datetimepicker({		  
				  format: 'dd/MM/yyyy',
				  language: 'es',		
			      pickTime: false
			 });
			$('#fecha-estimada-to').datetimepicker({		  
				  format: 'dd/MM/yyyy',
				  language: 'es',		
			      pickTime: false
			 });
			$('#fecha-real-from').datetimepicker({		  
				  format: 'dd/MM/yyyy',
				  language: 'es',		
			      pickTime: false
			 });
			$('#fecha-real-to').datetimepicker({		  
				  format: 'dd/MM/yyyy',
				  language: 'es',		
			      pickTime: false
			 });
			
			
			//default config
			$.fn.editable.defaults.mode = 'popup';	
			$.fn.editable.defaults.disabled = true;
			$.mockjaxSettings.responseTime = 300; 
			
			//modify buttons style
			$.fn.editableform.buttons = 
			  '<button type="submit" class="btn btn-warning editable-submit"><i class="icon-ok icon-white"></i></button>' +
			  '<button type="button" class="btn editable-cancel"><i class="icon-remove"></i></button>';     
			
			$('#btn-update').attr('disabled', true);
// 			$('#btn-save-repair').attr('disabled', true);
			$('#btn-edit').addClass('notClicked');
			
			//enable / disable
			
			$('.editableField').hide();
			
			
			
			$('#btn-add-repair').live('click', function() {
				
				$('#mdl-repair').modal('show');
				$('#presupuestoAdjudicacion').val(0);
				$('#presupuestoFinal').val(0);
				$('#plazo').val(0);
			
			});
		    
		    $('#btn-edit-repair').live('click', function() {

				$('#obra').val('${obra}');
				$('#estadoObra').val('${estadoObra}');
				$('#nroLicitacion').val('${nroLicitacion}');
				$('#nroExpediente').val('${nroExpediente}');
				$('#plazo').val('${plazo}');
				$('#empresaNombre').val('${empresaNombre}');
				$('#empresaCuit').val('${empresaCuit}');
				$('#representanteNombre').val('${representanteNombre}');
				$('#representanteMatricula').val('${representanteMatricula}');
				$('#unidadEjecutora').val('${unidadEjecutora}');
				$('#unidadFinanciamiento').val('${unidadFinanciamiento}');
				$('#presupuestoAdjudicacion').val('${presupuestoAdjudicacion}');
				$('#presupuestoFinal').val('${presupuestoFinal}');
				$('#fechaEstimadaInicio').val('${fechaEstimadaInicio}');
				$('#fechaEstimadaFin').val('${fechaEstimadaFin}');			
				$('#fechaRealInicio').val('${fechaRealInicio}');
				$('#fechaRealFin').val('${fechaRealFin}');
				$('#observaciones').val('${observaciones}');

		    	$('#mdl-repair').modal('show');
		    	
		    }); 
		    
		    $('#btn-save-repair').click(function(e) {	
				
				$.ajax({
			       url: './addRepairInfo', 
			       type: 'POST',
			       data: $('#repairForm').serialize(),
			       dataType: 'json',					       			       
			       success: function(data) {
			    	   if(data.result){					    		
			    		   window.location.reload();	
			    	   }						    	   
			    	   else{
			    		   bootbox.alert(data.message);		
			    	   }						    	
			       },
			       error: function (response) {
			    	   bootbox.alert('No se pudo guardar la informaci&oacute;n. Intente de nuevo.');		
			       },
			       complete: function(){
			    	   $('#mdl-repair').modal('hide');
			       }

			   });				   
				
				return false; 
			});
		    
		    $('#obra').keyup(function(){
			      if($(this).val().length > 0){
			         $('#btn-save-repair').prop('disabled',false);
			      }else{
			         $('#btn-save-repair').prop('disabled',true);
			      }
			 });
			
			
			$('#btn-delete-repair').live('click', function(e) {	
				
				 bootbox.confirm("&iquest;Confirma que desea eliminar los datos?", function(result){
					  if(result){	
							$.ajax({
		        			    url: './deleteRepairInfo',
						 		type: 'POST',			
						 		dataType: 'json',		
						        success: function(data){	
						        	if(data.result){
						        		window.location.reload();
						        	}
						        	else{
						        		bootbox.alert(data.message); 
						        	}
								},
								error: function (response) {
							    	   bootbox.alert('No se pudo eliminar la informaci&oacute;n. Intente de nuevo.');		
							    },
							    complete: function(){
							    	   $('#mdl-repair').modal('hide');
							    }
							});
							
							return false; 
					  }
				});
			});
		    
			  //--NON-EDITABLE FIELDS
			  
			  $("#issue-id").editable({name: 'id',  disabled: true});			  
			  $("#issue-date").editable({name: 'creationDate', disabled: true});
// 			  $("#issue-last-update").editable({name: 'lastUpdate', disabled: true});				  
			  $("#issue-street").editable({name: 'address', disabled: true});		
			  $("#issue-city").editable({name: 'city', disabled: true});			  
			  $("#issue-province").editable({name: 'province', disabled: true});
			  $("#issue-lat").editable({name: 'latitude', disabled: true});
			  $("#issue-lng").editable({name: 'longitude', disabled: true});
			  $("#issue-status").editable({name: 'status', disabled: true});
			  $("#issue-user").editable({name: 'username', disabled: true});
			  $("#issue-area").editable({name: 'area', disabled: true});
			  
			  //--EDITABLE FIELDS
			  
			
			 
			  $("#issue-title").editable({
				  pk: 1,  
				  name: 'title', 
				  type: 'text',
				  mode: 'popup',
				  placement: 'right',
				  ajaxOptions: {
				        type: 'put'
				  },
				  validate: function(value) {
					  
						var pattern = /^\s*[a-zA-ZÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ0-9,\s]+\s*$/;

					    if($.trim(value) == '') {
					        return 'Campo obligatorio.';
					    }
					    
					    if($.trim(value).length > 80) {
					        return 'La longitud m&aacute;xima del campo es de 80 caracteres.';
					    }
					    
// 					    if(!pattern.test(value)){
// 					    	return 'No se permiten caracteres especiales.';
// 					    }
					    
				  },
				  success: function(response, newValue) {	
		               newTitle =  newValue;
					   if(newValue != oldFields.title)
						   updatedFields.title = 1;
					   else
					   	updatedFields.title = 0;
		          }
				
			  });

			  $("#issue-desc").editable({ 		
				  pk: 2, 
				  name: 'description',
				  type: 'textarea', 
				  mode: 'popup',	
				  placement: 'right',
				  inputclass: 'issue-textarea',
				  ajaxOptions: {
				        type: 'put'
				  },				
				  validate: function(value) {
					  
						var pattern = /^[^'"]*$/;
						
					    if($.trim(value) == '') {
					        return 'Campo obligatorio.';
					    }
					    
					    if($.trim(value).length > 600) {
					        return 'La longitud m&aacute;xima del campo es de 600 caracteres.';
					    }
					    
					    if(!pattern.test(value)){
					    	return 'No se permiten comillas simples o dobles.';
					    }
				  },
				  success: function(response, newValue) {
					  if(newValue != oldFields.desc)
						   updatedFields.desc = 1;
					  else
						  updatedFields.desc = 0;
				     
		          }			  	
			  });
			  
			
			  
			  $("#issue-barrio").editable({
				  pk: 3,  
				  name: 'neighborhood', 	
				  mode: 'popup',	
				  placement: 'right',
				  emptytext: 'A definir',
				  ajaxOptions: {
					  dataType: 'json'
				  },			
				  validate: function(value) {		
					  
					 	var pattern = /^\s*[a-zA-ZÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ0-9,\s]+\s*$/;
					  
					    if($.trim(value).length > 30) {
					        return 'La longitud m&aacute;xima del campo es de 30 caracteres.';
					    }
					   					   
// 					    if(!pattern.test(value)){
// 					    	return 'No se permiten caracteres especiales.';
// 					    }
				  },
				  success: function(response, newValue) {
					  if(newValue != oldFields.barrio)
						   updatedFields.barrio = 1;
					  else
						  updatedFields.barrio = 0;
				     
		          }
			  });
		
			  $('#issue-tags').editable({
				    pk: 22,
				 	name: 'tagsMap',				 
				    placement: 'top',      
				    mode: 'popup',					 
      				emptytext: 'No hay etiquetas definidas',
      				inputclass: 'input-large',
			        select2: {				
			        	tags: ${allTags},
			            tokenSeparators: [",", " "],
			            id: function (item) {
			                return item.text;
			            },
			            multiple: true,	
// 			            minimumInputLength: 1,
			            maximumSelectionSize: 5,
			            formatSelectionTooBig: function (limit) {
			                return 'S&oacute;lo se permiten 5 etiquetas.';
			            },
			            allowClear: true			           
			        },
			        display: function(value) {
			        	if(value != null){
			        		var tags = new Array(value.length);
				        	
				            $.each(value,function(i){				            	
				            	var url = "./search.html?type=tag&value=" + $('<p>' + value[i] + '</p>').text();
				            	tags[i] = "<a class=\"taglink\" href=\"" + url + "\"><span class=\"label label-default\">" + $('<p>' + value[i] + '</p>').text() + "</span></a>";
				            });
				            
				            $(this).html(tags.join(" "));
			        	}
			        	
			        },						
			        ajaxOptions: {
				        type: 'put'
				    }			 
		                    
  			  }); 
		
				
			  /*******************************************/
			
				
				$('#comment-text').keyup(function(){
				      if($(this).val().length > 0){
				         $('#btn-comment').prop('disabled',false);
				      }else{
				         $('#btn-comment').prop('disabled',true);
				      }
				 });
				
			  $('#btn-comment').click(function() {				  
				  
				  	blockPage($commentContainer);
				  	
					var message = $("#comment-text").val();
					var id = ${id};					
					var data = 'issueID='+ id + '&comment='+ message;		
				
					$.ajax({
        			    url: "./addComment.html",
				 		type: "POST",	
				 		data: data,
				 		dataType: "json",									 
				        success: function(data){
				        	if(data.result){
				        		unBlockPage($commentContainer);
				        		setTimeout(function(){
				        			window.location.reload();
				        		}, 1000); 
						    }					    	   
				    	    else{
				    	    	unBlockPage($commentContainer);
				    	    	setTimeout(function(){
				        			bootbox.alert(data.message);	
				        		}, 1000);
				    	    }
	            		}
        			});

			  });
			   
				
				
				
				$(function () {
				    'use strict';				   
				    
				    $('#btnAddFiles').click(function(e){
				    	
						var loggedUser = '${loggedUser}';
				    	
				    	if(loggedUser == ""){
				    		$("#mdl-fileupload").modal('hide');
				    		e.stopPropagation();
				    		bootbox.alert("Debe estar logueado para agregar archivos.");
				    	}	
				    	
				    });
				    
				    
				    $('#multiplefileupload').fileupload();
				
				    $('#multiplefileupload').fileupload({
				    	 url: './handleMultipleFileUpload.html',
					     type: "POST",
					     dataType: 'json',
					     contentType: false,
						 processData: false,
						 formData: [ { name: 'issueID', value: ${id} }, { name: 'userID', value: loggedUser }],
					     maxNumberOfFiles: 5,
						 maxFileSize: 5000000, // 5 MB		
						 acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
						 singleFileUploads: false,
						 autoUpload: true,	
						 disableImageResize: /Android(?!.*Chrome)|Opera/
						        .test(window.navigator && navigator.userAgent),				
				         previewMinWidth : 100,
				         previewMaxHeight : 60,	
						 imageCrop: false						
				    }).bind('fileuploaddone', function(e, data){				    	
				    	console.log(data);		
					    data.files = parsedResult;					    
					    updateFilesInfo(data.result.totalUploadedFiles);
 					});
				    
				});
				
				
				$('#tbl-fileupload').on('click', '.btn-file-delete', function() {
					
					var issueID = ${id};
					var contenidoID = $(this).closest('tr').attr('id');					
					var data = 'issueID='+ issueID + '&fileID='+ contenidoID + '&userID='+ loggedUser;
					
					console.log(data);

					  bootbox.confirm("&iquest;Confirma que desea eliminar el archivo?", "Cancelar", "Eliminar", function(result){
						  
						  if(result){
							  
							  $.ajax({
			        			    url: "./deleteFile.html",
							 		type: "POST",	
							 		data: data,							 
							        success: function(data){	
							        	
							        	if(data.status){
							        		
							        		var deleteRow = $("#tbl-fileupload tr[id^='" + contenidoID +"']");	 
											
								        	deleteRow.fadeOut('slow',function() {								        		
								        		deleteRow.remove();	
								        	});		
								        	
								        	updateFilesInfo(data.totalUploadedFiles);
						        
							        		
							        	}
							        	
							        	else{
							        		bootbox.alert(data.message);	
							        	}							        	
							    	
				            		}
							  
			        			});
							  
						  }
				
						   
					  });//bootbox   
				});
				
				function updateFilesInfo(numberOfFiles){
 
					if(numberOfFiles == 5){
						$(".modal-footer .fileinput-button").addClass("disabled");
						$(".modal-footer .fileinput-button > input").attr("disabled", true);
					}
					else if(numberOfFiles < 5){
						$(".modal-footer .fileinput-button").removeClass("disabled");
						$(".modal-footer .fileinput-button > input").attr("disabled", false);
					}

					$('.cantidadContenidos').fadeOut('slow', function(){ 
			        		$(this).html(numberOfFiles).fadeIn('slow'); 
			        });	
					
					$('#collapseFive').load(location.href + '#collapseFive #lst-file-thumnails'); 
				}

				function getFormData(){
					var fileInput = document.getElementById('multipleFileupload');
					var files = fileInput.files;
					var formData = new FormData();	
					
					for (var i = 0; i < files.length; i++) { 
						formData.append("files", files[i]);
					}
					
					var issueID = ${id};			
					formData.append('issueID', issueID);

					return formData;
					
				}
			
				    
				    function getFilesArray(){
				    	
	 					var fileInput = document.getElementById('multipleFileupload');
	 					var files = fileInput.files;
	 					var formData = new FormData();	
						
	 					for (var i = 0; i < files.length; i++) { 
	 						formData.append("files[]", files[i]);
	 					}
						
	 					var issueID = ${id};			
	 					formData.append('issueID', issueID);
	 					
	 					return formData;
				    	
				    }
				    
				    function getFilenameWithoutExtension(input){				    	
				    	return input.substr(0, input.lastIndexOf('.'));				    	
				    }
				    
				    function getFileSizeInMB(fileSize){
				    	return Math.round(fileSize / 1024);				    	
				    }
				    
				    
				    /*** RECLAMOS CERCANOS ***/
				    
					var issueLocation = [];		
					issueLocation.id = idIssue;
					issueLocation.latitude = latitud;
					issueLocation.longitude = longitud;		
					
					mapController.getClosestMarkersByIssue(issueLocation);			
					
				    
				    
				  //Add to Favorites
					
			        $('#bookmarkme').click(function() {
			            if (window.sidebar && window.sidebar.addPanel) { // Mozilla Firefox Bookmark
			                window.sidebar.addPanel(document.title,window.location.href,'');
			            } else if(window.external && ('AddFavorite' in window.external)) { // IE Favorite
			                window.external.AddFavorite(location.href,document.title); 
			            } else if(window.opera && window.print) { // Opera Hotlist
			                this.title=document.title;
			                return true;
			            } else { // webkit - safari/chrome
			            	bootbox.alert('Esta funci&oacute;n no est&aacute; disponible para los navegadores Chrome y Safari.<br>' + 
			            					'Presione las teclas <b>' + (navigator.userAgent.toLowerCase().indexOf('mac') != - 1 ? 'Command/Cmd' : 'CTRL') + ' + D</b> para agregar la p&aacute;gina a Favoritos.');
			                
			            }
			        });
			        
			        
			        ///*** WATCH ***/////
			        
			        var isWatching = '${isUserWatching}';
		        	var $watcherList = $('#followers-list');	 	        	
		        	var data = "issueID=" + idIssue;		        
		        	var loader = '<button class="btn btn-default pull-right loader"><img src="${pageContext.request.contextPath}/resources/images/loader6.gif" alt="Loading" height=15 width=15 /></button>';	  

					$watcherList.live('click', function(){
						
							$.ajax({
					        	   url: './displayIssueFollowers.html',
					               type: 'POST',
					               dataType: 'json',
					               data: data,
					               success: function(response){		
					            	   
					            	   if(response.length == 0 ){
					            		   $('#mdl-followers .modal-body').text('No hay usuarios siguiendo este reclamo.');
					            	   }
					            	   
					            	   else{
					            		   var followers = '';				             
										    $.each(response, function(i, follower){	
										    	followers += '<i class="icon-angle-right" style="margin-right: 5px;"></i>&nbsp;';
										    	followers += mapController.getUserURL(follower);
										    	followers += '<br>';
										    });
										    
						                   $('#mdl-followers .modal-body').html(followers);
						               
					            	   }
					            	   
					            	    $('#mdl-followers').modal('show');	
					               }
					           });
					
					});
						
				 		
			        $('#btn-watch-issue').live('click', function() {
			        	
			 			var reporter = '${usuario}';
			 			
			 			if(loggedUser == reporter){
			 				bootbox.alert("S&oacute;lo puede seguir reclamos publicados por otros usuarios.");
			 			}
			 			
			 			else{
			 				
			 				$(this).replaceWith(loader);
			 				
				 			$.ajax({
		        			    url: "./watch/",
						 		type: "POST",	
						 		data: data,							 
						        success: function(data){
						        	if(data.result){	
						        		setTimeout(function(){		
						        			$('.loader').replaceWith('<button id="btn-unwatch-issue" class="btn btn-info pull-right">Siguiendo</button>');
						        		
						        			$('#numFollowers').text(data.message);
						 				}, 1000);
						        	}
						        	else{
						        		bootbox.alert(data.message);	
						        		$('.loader').replaceWith('<button id="btn-watch-issue" class="btn btn-default pull-right">@ Segu&iacute; el reclamo</button>');
						        	}	
			            		}						  
		        			});	
			 			}
					});
				
				
			        $('#btn-unwatch-issue')
		        		.live('mouseover', function(){
			        		$(this).removeClass('btn-info').addClass('btn-inverse').text('DEJAR DE SEGUIR');
			        	})
			        	.live('mouseleave', function(){
			        		$(this).removeClass('btn-inverse').addClass('btn-info').text('@ SIGUIENDO');  
			        	})
			        	.live('click', function() {
			        		
			        		$(this).replaceWith(loader);
			        	
				 			$.ajax({
		        			    url: "./unwatch",
						 		type: "POST",	
						 		data: data,							 
						        success: function(data){							        	
						        	if(data.result){
						        		setTimeout(function(){
						        			$('.loader').replaceWith('<button id="btn-watch-issue" class="btn btn-default pull-right">@ Segu&iacute; el reclamo</button>');
						        			$watcherList.text(data.message);	
						        		}, 1000);
						        	}
						        	else{
						        		bootbox.alert(data.message);	
						        		
						        	}	
			            		}						  
		        			});				 				
			        	});
				
				
			    //*** VOTE ***//
			    
			    var isVoted = '${isCurrentlyVoted}';
			    var isVoteUp = '${isVoteUp}';
			    
			    userActionsController.setCurrentVote(isVoted, isVoteUp);
			    
			    $('#votes button').live('click', function(e) {
			    	
			    	var thumb = $(this).attr('id');
			    	var $voteUp = $('#vote-up');
					var $voteDown = $('#vote-down');				  
				    var voteUp = false;
				    var voteValue;
				    	
				    	if(thumb == 'vote-up'){
				    		voteValue = 1;
					    	voteUp = true;
				    	}			    		
				    	else
				    		voteValue =  -1;
				    	
				    	if(isVoted == 'true'){
				    		bootbox.alert("Ya ha votado por este reclamo.");	
				    	}
				    	
				    	else{ 					    	
					    	
					    	$.ajax({
		        			    url: "./voteIssue.html",
						 		type: "POST",	
						 		data: "issueID=" + idIssue + "&vote=" + voteValue,							 
						        success: function(data){						        	
						        	if(data.result){
						        		
						        		if(voteUp){	
									    	$voteDown.removeClass('btn-danger').addClass('btn-default');
						        		}
						        		
						        		else{
						        			$voteDown.removeClass('btn-success').addClass('btn-default');
						        		}
						        			
						        		$voteUp.prop('disabled', true);
							    		$voteDown.prop('disabled', true);
						        		$('#voteCount').text(data.message); 
						        				
						        	}
						        	
						        	else{
						        		bootbox.alert(data.message);	
						        	}	
			            		}						  
		        			});
				    	
				    	}
			    });
			    
 				//adds tab href to url + opens tab based on hash on page load:
 				if (location.hash !== '') {
 					$('a[href="' + location.hash + '"]').tab('show');
 					
 				}
 				return $('a[data-toggle="tab"]').on('shown', function(e) {
 			    	return location.hash = $(e.target).attr('href').substr(1);
 			    });
 				
 				//Prevents Jump When Tabs Are Clicked
//  				$('.nav-tabs li a').click( function(e) {
//  					history.pushState( null, null, $(this).attr('href') );
//  				});
 				
 				

		});
		
		
		
	
			
		$(document).ready(function(){
			
			
			//*** INFINITE SCROLL ***//
			
			/** Load first page of issues **/
			
			var $containerUpdates = $('#infinite-container-updates');
			var $containerComments = $('#infinite-container-comments');
		
			var updatesJson = '${jsonUpdates}';
			var commentsJson = '${jsonComments}';
			var updatesArray = JSON.parse(updatesJson);
			var commentsArray = JSON.parse(commentsJson);
			
			if(updatesJson.length > 0){
				$('#btn-more-updates').show();
			}
			
			if(commentsArray.length > 0){
				$('#btn-more-comments').show();
			}
			
			/* LOAD FIRST PAGE */
			loadFirstPage(updatesArray, commentsArray);
				
			function renderToHtml(element, type){
				
				var html = '';
				var userLink = mapController.getUserPlainURL(element.username);
				
				if(type == 'update'){
					
					var btnDisplay; 					
					var obs = element.obs;
					
					if(obs == null || obs == ''){
						btnDisplay =  'hide';
					}
					else{
						btnDisplay = 'show';
					}					
					
					html =  '<div class="brick-update">'
						+		'<span class="index">'+element.id+'</span>'		
						+		'<span class="date">'+element.date+'</span>'			    		
						+		'<span class="user">'
							+		'<a href="'+userLink+'">'+element.username+'</a>'
 						+		'</span>'
					    +		'<span class="motive">'+element.motive+'</span>'
					    +		'<span class="obs">'					   
						+			'<button class="btn '+btnDisplay+'" onclick="userActionsController.loadDetailModal(\''+obs+'\')" data-toggle="modal">Ver detalle &raquo;</button>'
						+		'</span>'
						+ 	'</div>';
				}

				else{
					
					html = '<div class="brick-comment"><div class="media">'
						+		'<span class="pull-left">'
						+	  		'<img class="media-object thumbnail" src="${pageContext.request.contextPath}/resources/images/nopic64.png">'
						+	 	'</span>'
						+	    '<div style="font-size:12px;margin-bottom:10px">'
						+	  		'<a href="#"><strong>'+element.username+'</strong></a><span class="pull-right" style="margin-right: 30px">'+element.date+'</span></div>'
	 					+	  '<div class="media-body" style="display:block">'		
						+     		'<p style="font-size:13px">'+element.message+'</p>'	 
	  					+	  '</div>'
						+	'</div></div>';
					
				}
		
				return html;
					
			}
			
			function loadFirstPage(updatesArray, commentsArray){
				
				if(updatesArray.length > 0){
					var html =  [];	
					$.each( updatesArray, function( i, value ) {	            
	            		var item = renderToHtml(value, "update");
		        		html.push(item);
		        	});
	            	$containerUpdates.append(html);
	            	
				}
				
				if(commentsArray.length > 0){
					var html =  [];
					$.each( commentsArray, function( i, value ) {	            
	            		var item = renderToHtml(value, "comment");
		        		html.push(item);
		        	});
	            	$containerComments.append(html);
				}
            
			}
			
			/* updates */
			$containerUpdates.imagesLoaded( function(){                
	            $containerUpdates.masonry({
	                itemSelector : '.brick-update'
	            });
	        });
			
  			$containerUpdates.infinitescroll({
				navSelector  	: "#page-nav-update",
  				nextSelector 	: "#page-nav-update a",
				itemSelector 	: ".brick-update",  
				pixelsFromNavToBottom : "20",
				debug: true,
  				dataType: 'json',
  				appendCallback: false,
  				loading: {
  		            finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
  		            msgText: "<h4>Cargando actualizaciones...</h4>",
  		            speed: 'slow'
  		        }  		      
			 }, function (newElements) {
			 		var html = '';
 			 		$.each( newElements, function( i, element ) {
 			 			 html += renderToHtml(element, 'update');
 			        });
 			 		var $newElems = $( html ).css({ opacity: 0 });
 			 		
	 			    $newElems.imagesLoaded(function(){
	 					$newElems.animate({ opacity: 1 });
	 					$containerUpdates.append( $newElems ).masonry( 'appended', $newElems );
		 			});
			});
	  			
  			$containerUpdates.infinitescroll('pause');
			
  			/* comments */
			$containerComments.imagesLoaded( function(){                
	            $containerComments.masonry({
	                itemSelector : '.brick-comment'
	            });
	        });
			
  			$containerComments.infinitescroll({
				navSelector  	: "#page-nav-comment",
  				nextSelector 	: "#page-nav-comment a",
				itemSelector 	: ".brick-comment",  
				pixelsFromNavToBottom : "20",
				debug: true,
  				dataType: 'json',
  				appendCallback: false,
  				loading: {
  		            finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
  		            msgText: "<h4>Cargando comentarios...</h4>",
  		            speed: 'slow'
  		        }  		      
			 }, function (newElements) {
			 		var html = '';
 			 		$.each( newElements, function( i, element ) {
 			 			 html += renderToHtml(element, 'comment');
 			        });
					 	
 			 		var $newElems = $( html ).css({ opacity: 0 });

	 			    $newElems.imagesLoaded(function(){
	 					$newElems.animate({ opacity: 1 });
	 					$containerComments.append( $newElems ).masonry( 'appended', $newElems );
		 			});
			});
	  			
  			$containerComments.infinitescroll('pause');
  			
  			
  			$('.nav-tabs li').on('shown.bs.tab', function (e) {
				var clickedTab = $(this).find('a').attr('href');
			 	if(clickedTab == "#issueComments"){
				  	$containerComments.masonry('layout');
			 	}	
			 	else{
				  	$containerUpdates.masonry('layout');
			 	}	
			});
  			
 			
  			$(' .btn-more ').click(function(e){
 			     // call this whenever you want to retrieve the next page of content
 			     // likely this would go in a click handler of some sort
 			     e.preventDefault();
 			    
 			    if( $(this).hasClass( 'update' ) ){
 			    	$containerUpdates.infinitescroll('retrieve');
 				  	$('#page-nav-updates').hide(); 
 			   	}  				
 			    else{
 			    	$containerComments.infinitescroll('retrieve');
 			      	$('#page-nav-comments').hide(); 
 			    }
 			  
 			    return false;
 			  });
			
		});
				
	  			
	  			
		
		
	
		</script>

	
	<div class="container-fluid">
	  	<div class="row-fluid" >
	   
		    <div class="span9">
		      <!--Body content-->
		     
		  	  <div id="issue-header" class="hero-unit" style="padding:20px; margin-bottom:15px">	  
		        <h3 style="display:inline">
		        	<a href="#" id="issue-title">${titulo}</a>&nbsp;<i class="icon-pencil editableField"></i><span class="pull-right" style="color:${tituloCss}">(${estado})</span></h3>
		        <p>${direccion}</p>       
		      </div>

			  <div class="row">
			  	<div class="row-fluid" style="margin-bottom: 30px;">
					 <div class="span4">  
						 <ul class="thumbnails">
					  	   		<li style="margin-left:0">		
						    		<c:if test="${cantidadContenidos gt 0}">
						    			<a data-lightbox="issue-lightbox2" class="thumbnail" href="${imageUrl}">							  	  			  	   		
											<img src="${imageUrl}" alt="${imageUrl}">	 
										</a>		
						    		</c:if>
						    		<c:if test="${cantidadContenidos eq 0}">
						    			<a data-lightbox="issue-lightbox2" class="thumbnail" href="${pageContext.request.contextPath}/resources/images/nopic.png" >							  	  			  	   		
											<img src="${pageContext.request.contextPath}/resources/images/nopic.png" alt="">	
										</a>
						    		</c:if>
					    			<br>
					    			<div class="caption">
					    				<a id="btnAddFiles" href="#mdl-fileupload" data-toggle="modal" class="btn btn-info">
					    				<i class="icon-upload-alt"></i>&nbsp;&nbsp;&nbsp;Agregar imagenes
					    				</a>
					    			</div>
					  			</li>	
					      </ul>
				 	</div>
			 		<div class="span8">  	 	
		 				<table id="tbl-issue" class="table table-hover table-bordered table-striped">			        					
							 <tr>
							    <th>ID:</th>
							    <td><a href="#" id="issue-id">${id}</a></td>						  
							 </tr>
							 <tr>
							    <th>Fecha de publicaci&oacute;n:</th>
							    <td><a href="#" id="issue-date">${fechaCreacion}</a></td>						   
							 </tr>
							  <tr>
							    <th>Informante:</th>
							    <td><script type="text/javascript">document.write( mapController.getUserURL('${usuario}') );</script></td>						    		    
							 </tr>
							 <tr>
							    <th>Direcci&oacute;n:</th>
							    <td><a href="#" id="issue-street">${calle}</a></td>						   
							 </tr>
							 <tr>
							    <th>Barrio:</th>
							    <td><a href="#" id="issue-barrio">${barrio}</a>&nbsp;<i class="icon-pencil editableField"></i></td>						   
							 </tr>
							 <tr>
							    <th>Ciudad / Localidad:</th>
							    <td><a href="#" id="issue-city">${ciudad}</a></td>						   
							 </tr>
							 <tr>
							    <th>Provincia</th>
							    <td><a href="#" id="issue-province">${provincia}</a></td>						   
							 </tr>
							 <tr>
							    <th>Coordenadas:</th>
							    <td><a href="#" id="issue-lat">${latitud}</a>, <a href="#" id="issue-lng">${longitud}</a></td>						   
							 </tr>
							  <tr>
							    <th>Descripci&oacute;n:</th>
							    <td><a href="#" id="issue-desc">${descripcion}</a>&nbsp;<i class="icon-pencil editableField"></i></td>						   
							 </tr>
							 <tr>
							    <th>Estado:</th>
							    <td><a class="taglink" href="./search.html?type=status&value=${estado}" id="issue-status" data-type="text"><span class="${estadoCss}">${estado}</span></a><b>${resolucion}</b></td>						   
							 </tr>
							 <tr>
							    <th>Categor&iacute;as:</th>
							    <td>
		      						<a id="issue-tags" href="#" data-type="select2">${tagsByIssue}</a>&nbsp;<i class="icon-pencil editableField"></i>
							    </td>						   
							 </tr>
						</table>	 	
			 		</div>
			 	 </div>
		      </div><!-- row -->
      
      <ul id="issue-tabs" class="nav nav-tabs">
		<li class="active"><a href="#issueHistory" data-toggle="tab"><i class="icon-time icon-large"></i>&nbsp;&nbsp;ACTUALIZACIONES (${cantidadRevisiones})</a></li>
		<li><a href="#issueFiles" data-toggle="tab"><i class="icon-picture icon-large"></i>&nbsp;&nbsp;IM&Aacute;GENES (<span class="cantidadContenidos">${cantidadContenidos}</span>)</a></li>
		<li><a href="#issueComments" data-toggle="tab"><i class="icon-comments icon-large"></i>&nbsp;&nbsp;COMENTARIOS (${cantidadComentarios})</a></li>
		<li><a href="#issueRepair" data-toggle="tab"><i class="icon-wrench icon-large"></i>&nbsp;&nbsp;REPARACI&Oacute;N (${infoReparacion})</a></li>
	  </ul>	
	  
	  <div class="tab-content">							
	
		<!-- 1 Historial -->
		<div class="tab-pane fade in active" id="issueHistory">
		
			<div class="row" style="margin-bottom: 30px;">	
		 		<!-- infinite scroll -->
				 <div id="infinite-container-updates"></div>
				 
				 <nav id="page-nav-update" style="display: none;">
	 			 	<a href="${id}/loadmore/update/2"></a>
				 </nav>
			 
			 	<center><a href="#" id="btn-more-updates" class="btn btn-default btn-more update" style="display: none;">Mostrar m&aacute;s resultados</a></center>
			</div>

		</div>
		
		<!-- 2 Archivos -->							
		<div class="tab-pane fade" id="issueFiles">				
			<div class="row-fluid">			
				<c:if test="${fn:length(contenidos) eq 0}">
					<h4 style="padding-bottom: 20px; margin-left: 15px;">No hay archivos subidos.</h4>
				</c:if>
			    <c:if test="${fn:length(contenidos) gt 0}">
			        <ul id="lst-file-thumnails" class="thumbnails" style="margin-top:30px;">
			        	<c:forEach items="${contenidos}" var="contenido">	
			        		<li style="margin-right:20px;">					                
			                	<a class="thumbnail"  style="width:100px; height: 60px; max-height:60px; text-align: center" data-lightbox="issue-lightbox" href="${contenido.link}" >							  	  			  	   		
				      				<img style="max-width:100px; max-height:60px;" src="${contenido.link}" > 
				    			</a>
		                	</li>
			        	</c:forEach>
	      			</ul>
      			</c:if>
	        </div>			
		</div>								
							
		<!-- 3 Comentarios -->							
		<div class="tab-pane fade" id="issueComments">	
		 	<div class="row-fluid">	
		 		<span>
		 			<textarea id="comment-text" name="comment-text"
                	placeholder="Ingrese su comentario" rows="5"></textarea>
		 		</span>
		 		<span>
		 			<button id="btn-comment" class="btn btn-warning" type="submit" disabled 
					style="width: 150px; margin-left: 20px;">Publicar</button>
		 		</span>
			</div>	
				<div class="row-fluid" style="margin-bottom: 30px;">		
		 		 <!-- infinite scroll -->
				 <div id="infinite-container-comments"></div>
				 <nav id="page-nav-comment" style="display: none;">
	 			 	<a href="${id}/loadmore/comment/2"></a>
				 </nav>			 
			 	<center><a href="#" id="btn-more-comments" class="btn btn-default btn-more comment" style="display: none;">Mostrar m&aacute;s resultados</a></center>
		 	</div>
		</div>	
		
		<!-- 4 Reparacion -->							
		<div class="tab-pane fade" id="issueRepair">	
				
			<sec:authorize access="isAnonymous()">
				<c:if test="${infoReparacion eq 'Sin datos'}">			
					<h4 style="padding-bottom: 20px; margin-left: 15px;">No hay informaci&oacute;n cargada.</h4>
				</c:if>
			</sec:authorize>			
					
			<sec:authorize access="hasRole('ROLE_USER')">			
				<c:if test="${infoReparacion eq 'Sin datos'}">				
					<center>
					 	<button id="btn-add-repair" data-toggle="modal" class="btn btn-danger" title="Agregar informaci&oacute;n sobre la reparación del reclamo" 
					 		style="font-size: 11px; text-transform: uppercase; margin-top: 20px">
					 		<i class="icon icon-plus"></i>Cargar informaci&oacute;n
					 	</button> 				
					</center>
				</c:if>
				
				<c:if test="${infoReparacion ne 'Sin datos'}">	
				
					<div style="width: 100%; text-align: right; padding: 10px 0 10px 0; margin-bottom: 20px; background: #F5F5F5; border-top: 1px dashed #CCC;border-bottom: 1px dashed #CCC; display: block; ">
						<button id="btn-delete-repair" class="btn" title="Eliminar"><i class="icon-trash icon-large"></i></button>	
						<button id="btn-edit-repair" class="btn" title="Editar"><i class="icon-pencil icon-large"></i></button>	
					</div>
					</c:if>					
			</sec:authorize>			
				
				
			<c:if test="${infoReparacion ne 'Sin datos'}">	
			<div class="row-fluid">
	  			<div class="span6">
	  				<label><i class="icon icon-angle-right"></i>Obra / Proyecto</label>					    
		    	    <span class="align">${obra}</span>
	  			</div>	  		
	  			<div class="span3 offset2">
	  				<label><i class="icon icon-angle-right"></i>Estado</label>	
			 		<span class="align">${estadoObra}</span>
			 	</div>
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">
	  			<div class="span4">
	  				<label><i class="icon icon-angle-right"></i>N&ordm de Licitaci&oacute;n</label>					    		
	  				<span class="align">${nroLicitacion}</span>
	  			</div>
	  			<div class="span4">
	  				<label><i class="icon icon-angle-right"></i>N&ordm de de Expediente</label>		 
				 	<span class="align">${nroExpediente}</span>	
				</div>
         		<div class="span4">
         			<label><i class="icon icon-angle-right"></i>Plazo de obra</label>		 
         			<span class="align">${plazo} meses</span>
         		</div>
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">
	  			<div class="span4">
	  				<label><i class="icon icon-angle-right"></i>Empresa contratada</label>
	 				<span class="align">${empresaNombre}</span>
	 				<span class="align"><i>CUIT ${empresaCuit}</i></span> 					
	  			</div>	  			
	  			<div class="span4">
	  				<label><i class="icon icon-angle-right"></i>Representante t&eacute;cnico</label>
	 				<span class="align">${representanteNombre}</span>
	 				<span class="align"><i>Matricula N&ordm ${representanteMatricula}</i></span>
	  			</div>	  		
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">
	  			<div class="span6">
	  				<label><i class="icon icon-angle-right"></i>Unidad ejecutora</label>
	  				<span class="align">${unidadEjecutora}</span>
	  			</div>	  			
	  			<div class="span6">
	  				<label><i class="icon icon-angle-right"></i>Unidad de financiamiento</label>
	  				<span class="align">${unidadFinanciamiento}</span>
	  			</div>	  		
	  		</div>	  		
	  		<hr style="border: 2px solid #C64A48;">	  				
	  		<div class="row-fluid">		  	
	  			<div class="span4">
	  				<label><i class="icon icon-angle-right"></i>Presupuesto de adjudicaci&oacute;n</label>
	    			<span class="align">$ ${presupuestoAdjudicacion}</span>
	    		</div>
	    		<div class="span4">
	    			<label><i class="icon icon-angle-right"></i>Fecha estimada de inicio</label>
		    	   	<span class="align">${fechaEstimadaInicio}</span>
	 			</div>	  				
 				<div class="span4">	  
 					<label><i class="icon icon-angle-right"></i>Fecha estimada de finalizaci&oacute;n</label>			
  					<span class="align">${fechaEstimadaFin}</span>
	 			</div>
	  		</div>	  		
	  		
	  		<hr>
	  		
	  		<div class="row-fluid">	  	
		  		<div class="span4">
			    	<label><i class="icon icon-angle-right"></i>Presupuesto final</label>
	    	   		<span class="align">$ ${presupuestoFinal}</span>
	  			</div>	  			 
	  			<div class="span4">
	  				<label><i class="icon icon-angle-right"></i>Fecha real de inicio</label>			
		    	  	<span class="align">${fechaRealInicio}</span>
	  			</div>	  		
	  			<div class="span4">	  
	  				<label><i class="icon icon-angle-right"></i>Fecha real de finalizaci&oacute;n</label>						
	  				<span class="align">${fechaRealFin}</span>
	  			</div>	  				
	  		</div>	  	
	  			
	  		<hr style="border: 2px solid #C64A48;">	  	
	  				
	  		<div class="row-fluid">
	  			<div class="span6">
	  				<label><i class="icon icon-angle-right"></i>Observaciones</label>					    
		    	   	<span class="align">${observaciones}</span>
	  			</div>	  	
	  		</div>	 		
	</c:if>
			
			
		
			
		</div>
								
		</div>
     
		</div>
		    
		    
		    
		    
		<!-- COLUMNA 2 -->    
		<div class="span3">
		<!--Sidebar content-->
		
			<div id="issue-stats" class="stats-container">
				<div class="stats-box">
					<span class="text-small">votos totales</span><span id="voteCount" class="text-big pull-right">${cantidadVotos}</span>
				</div> 
				<div class="stats-box"><span class="text-small">visitas</span><span class="text-big pull-right">${cantidadVisitas}</span></div>
				<div class="stats-box"><span class="text-small">comentarios</span><span class="text-big pull-right">${cantidadComentarios}</span></div>
				<div id="watchers" class="stats-box">					
					<span class="text-small">seguidores</span>
					<span class="text-big pull-right">
						<a href="#mdl-followers" id="followers-list" data-toggle="modal"><span id="numFollowers">${cantidadObservadores}</span></a>
					</span> 
				</div>
			</div>			
					
			<div id="issue-stats-actions">	
				<sec:authorize access="hasRole('ROLE_USER')">		
				<div class="stats-container">
					<span id="votes">
						<button id="vote-up" class="btn btn-success" title="Voto positivo"><i class="icon-thumbs-up "></i></button>
						<button id="vote-down" class="btn btn-danger" title="Voto negativo"><i class="icon-thumbs-down "></i></button>
					</span>						
					<span class="pull-right">
						<c:if test="${isUserWatching}">
							<button id="btn-unwatch-issue" class="btn btn-info">@ Siguiendo</button>
						</c:if>
						<c:if test="${!isUserWatching}">
							<button id="btn-watch-issue" class="btn pull-right">@ Segu&iacute; el reclamo</button>
						</c:if>
					</span>		
				
					</div>		
				</sec:authorize>					
			</div>
			
			<div class="stats-container">
				&Uacute;ltima actualización: <span class="pull-right"><b>${fechaUltimaActualizacion}</b></span>
			</div>
			
			<div id="userIssueActions">
				<sec:authorize access="hasRole('ROLE_USER')">				
					<c:if test="${estado ne 'CERRADO'}">
						<div class="stats-container">
							<button id="btn-edit" class="btn" title="Editar"><i class="icon-pencil icon-large"></i></button>	
							<button id="btn-update" class="btn btn-primary" title="Guardar cambios"><i class="icon-save icon-large"></i></button>	
							<c:if test="${estado eq 'ABIERTO' || estado eq 'REABIERTO'}">
								<div id="btn-status" data-toggle="modal" class="pull-right">			
									<button class="btn btn-success" title="Resolver"><i class="icon-ok icon-large"></i> RESOLVER</button>
								</div>
							</c:if>
							<c:if test="${estado eq 'RESUELTO'}">
								<div id="btn-status" data-toggle="modal" class="pull-right">			
									<button class="btn btn-warning" title="Reabrir"><i class="icon-rotate-right icon-large"></i> REABRIR</button>
								</div>
							</c:if>						
							<script type="text/javascript">
								userActionsController.enableUserActions();
							</script>
						</div>
					</c:if>
					<c:if test="${estado eq 'CERRADO'}">
						<div class="stats-container" style="color: #fff; background: #333; font-weight: bold; border: none; text-align: center;">
							Este reclamo ya no puede editarse.
						</div>
					</c:if>
				</sec:authorize>	
			</div>
<!--       			<a id="bookmarkme" href="#" rel="sidebar" title="Agregar a Favoritos"><i class="icon-star"></i></a> -->
<!--       			<a href="#" onclick="javascript:window.print();" title="Imprimir"><i class="icon-print"></i></a> -->


		   <div class="page-header">
    	   		<h4><i class="icon-globe icon-large"></i>&nbsp;&nbsp;Vista en el mapa</h4>    	 	
    	   </div>     	   
		   		 
		   	<script type="text/javascript">		
			   $(document).ready(function(){
			   		mapController.initMiniMap(${latitud}, ${longitud}, '${titulo}'); 
			   });		   	
		   	</script>
		   	
		   	<div id="mini_map"></div>
		   
		   <div class="page-header">
    	   		<h4><i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;Reclamos cercanos</h4>    	 	
    	   </div>    
		      
	      	<table id="tblNearbyIssues" class="table table-hover">
	      		<tbody></tbody>
			</table>		
		</div>
		  		
  		</div><!-- ROW FLUID -->
	</div><!-- CONTAINER FLUID -->
	
	
	
	<div id="mdl-detail" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-header">
		    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>	
			    <h4>Detalle</h4>
	  	</div>
		<div class="modal-body"></div>
		<div class="modal-footer"> 				 		  		
	  		<button class="btn" data-dismiss="modal" aria-hidden="true">
		    		<i class="icon-remove icon-large"></i>&nbsp;&nbsp;&nbsp;Cerrar
		    </button>	 
	  	</div>
	</div>
	
	<div id="mdl-followers" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>	
			<h4>Usuarios que siguen este reclamo</h4>
	  	</div>
		<div class="modal-body"></div>
		<div class="modal-footer"> 				 		  		
	  		<button class="btn" data-dismiss="modal" aria-hidden="true">
		    	<i class="icon-remove icon-large"></i>&nbsp;&nbsp;&nbsp;Cerrar
		    </button>	 
	  	</div>
	</div>
	
	<div id="mdl-status" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-header">
	    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>		    	
	    	<h4 id="fileUploadLabel"> 
		    	Actualizar estado
	    	</h4>
	  	</div>
	  	<form id="modalStatusForm" enctype="multipart/form-data"  class="form-horizontal form-inline">
  			<!-- modal body -->
  			<div class="modal-body">  				
  				<div class="control-group">  			
        			<label class="control-label">Resoluci&oacute;n</label>
        			<div class="controls">
           				<select id="tipoResolucion" name="tipoResolucion"></select>		
        			</div>
    			</div>    
    			<div class="control-group" id="invalid-container">  		       
        			<div class="controls">
           				<select id="tipoInvalido" name="tipoInvalido"></select>		
        			</div>
    			</div>    			
			    <div class="control-group">
			        <label class="control-label" for="observacion">Comentario</label>
			        <div class="controls">
			        	<textarea id="observacion"  class="form-control"  name="observacion" style="width:280px; height: 100px" required></textarea>
			        </div>
			    </div>  				
  			</div>
  			<!-- modal footer -->
			<div class="modal-footer"> 
				<button id="btn-update-status" class="btn btn-info" aria-hidden="true">
			    		<i class="icon-ok icon-large"></i>&nbsp;&nbsp;&nbsp;Aceptar
			    </button>	  		  		
		  		<button class="btn" data-dismiss="modal" aria-hidden="true">
			    		<i class="icon-remove icon-large"></i>&nbsp;&nbsp;&nbsp;Cancelar
			    </button>	 
		  	</div>
	  	</form>
	</div>
	
<!-- 	<div id="mdl-fileupload" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="fileUploadLabel" aria-hidden="true"> -->
<!-- 	  	<div class="modal-header"> -->
<!-- 	    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>		    	 -->
<!-- 	    	<h4 id="fileUploadLabel">  -->
<!-- 		    	Gesti&oacute;n de archivos -->
<!-- 	    	</h4> -->
<!-- 	  	</div> -->
<!-- 	  	<form id="multiplefileupload" enctype="multipart/form-data" > -->
<!--  			modal body -->
<!--  			<div class="modal-body">   		 -->
<!-- 	   			<div class="alert alert-success" style="height:30px; line-height:30px; font-size:13px;">  -->
<%-- 	 				<i class="icon-info-sign"></i>&nbsp; Hay <b><span class="cantidadContenidos">${cantidadContenidos}</span></b> archivo(s) subido(s). M&aacute;ximo: 5 archivos. --%>
<!-- 				</div>   			 -->
<!-- 	   			<table id="tbl-fileupload" role="presentation" class="table table-hover">    			 -->
<!-- 	  	   		  	   	<tbody class="files">   	   		  	   	 -->
<%-- 	  	   		  	   		<c:forEach items="${contenidos}" var="contenido">	 --%>
<%-- 							<tr id="${contenido.id}"> --%>
<!-- 			    	   			<td width="100">					    	   			 -->
<!-- 				    	   			<span class="preview thumbnail" style="max-height:60px; text-align: center"> -->
<!-- 				                    	<a style="width:100px; height:60px; " href="#" title="{%=file.name%}"> -->
<%-- 											<img style="max-width:100px; max-height:60px;" src="${pageContext.request.contextPath}/uploads/${contenido.nombreConExtension}"> --%>
<!-- 										</a> -->
<!-- 	          							</span> -->
<!-- 								</td>										 -->
<!-- 								<td> -->
<%-- 									${contenido.fileSize} --%>
<!-- 							 	</td> -->
<!-- 							 	<td width="100" class="centered"> -->
<!-- 								 	<a href="#" class="btn btn-small btn-file-delete"> -->
<!-- 								 		<i class="icon-trash icon-large" title="Eliminar archivo"></i> -->
<!-- 								 	</a>							 		 -->
<!-- 							 	</td>						 -->
<!-- 		    	   			</tr> -->
<%-- 						</c:forEach> --%>
<!-- 		    	   	</tbody> -->
<!-- 				</table>  -->
<!-- 			</div> -->
<!-- 			<!-- modal footer --> 
<!-- 		  	<div class="modal-footer">   -->
<%-- 		  		<c:if test="${cantidadContenidos eq 5}"> --%>
<!-- 			  		<span class="btn btn-danger fileinput-button disabled"> -->
<!-- 		                   <i class="icon-plus"></i> -->
<!-- 		                   <span>Seleccionar archivos</span> -->
<!-- 		                   <input type="file" name="files[]" multiple disabled> -->
<!-- 		            </span> -->
<%-- 		  		</c:if>	  			  		 --%>
<%-- 		  		<c:if test="${cantidadContenidos lt 5}"> --%>
<!-- 			  		<span class="btn btn-danger fileinput-button"> -->
<!-- 		                   <i class="icon-plus"></i> -->
<!-- 		                   <span>Seleccionar archivos</span> -->
<!-- 		                   <input type="file" name="files[]" multiple> -->
<!-- 		            </span> -->
<%-- 		  		</c:if>			  	 --%>
<!-- 		  		<button class="btn" data-dismiss="modal" aria-hidden="true"> -->
<!-- 			    		<i class="icon-remove icon-large"></i>&nbsp;&nbsp;&nbsp;Cerrar -->
<!-- 			    </button>	  -->
<!-- 		  	</div> -->
<!-- 	  	</form> -->
<!-- 	</div> -->
	
	
	<div id="mdl-repair" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="fileUploadLabel" aria-hidden="true">
	  	<form id="repairForm">
	  	<div class="modal-header">
	    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>		    	
	    	<h4 id="fileUploadLabel"> 
		    	Detalle de la reparaci&oacute;n del reclamo
	    	</h4>
	  	</div>
	  	<!-- modal body -->
  		<div class="modal-body">
	  		<div class="row-fluid">
	  			<div class="span6">
	  				<label>Obra / Proyecto</label>					    
		    	   	<textarea id="obra" name="obra" required></textarea>	
	  			</div>	  		
	  			<div class="span3 offset2">
	  				<label>Estado</label>	
			 		<select id="estadoObra" name="estadoObra">						 		
	   	   				<option value="Sin iniciar">Sin iniciar</option>
	   	   				<option value="En curso">En curso</option>
	   	   				<option value="Terminada">Terminada</option>
	   	   				<option value="Inconclusa">Inconclusa</option>
	   	   				<option value="Suspendida">Suspendida</option>
	   	   				<option value="Cancelada">Cancelada</option>
			 		</select>	
			 	</div>
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">
	  			<div class="span4">
	  				<label>N&ordm de Licitaci&oacute;n</label>					    		
	  				<input type="text" id="nroLicitacion" name="nroLicitacion"/>	
	  			</div>
	  			<div class="span4">
	  				<label>N&ordm de de Expediente</label>		 
				 	<input type="text" id="nroExpediente" name="nroExpediente"/>		
				</div>
	         		<div class="span4">
	         			<label>Plazo (en meses)</label>		 
	         			<input type="number" id="plazo" name="plazo"/>	
	         		</div>
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">
	  			<div class="span4">
	  				<label>Empresa contratada</label>
	 					<input type="text" id="empresaNombre" name="empresaNombre" placeholder="Raz&oacute;n social"/>	
	 					<input type="text" id="empresaCuit" name="empresaCuit" placeholder="CUIT"/>		  					
	  			</div>	  			
	  			<div class="span4">
	  				<label>Representante t&eacute;cnico</label>
	 					<input type="text" id="representanteNombre" name="representanteNombre" placeholder="Nombre(s) y Apellido(s)"/>	
	 					<input type="text" id="representanteMatricula" name="representanteMatricula" placeholder="Matr&iacute;cula"/>	
	  			</div>	  		
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">
	  			<div class="span6">
	  				<label>Unidad ejecutora</label>
	  				<input style="width: 92%" type="text" id="unidadEjecutora" name="unidadEjecutora"/>	
	  			</div>	  			
	  			<div class="span6">
	  				<label>Unidad de financiamiento</label>
	  				<input style="width: 92%" type="text" id="unidadFinanciamiento" name="unidadFinanciamiento"/>	
	  			</div>	  		
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">		  	
	  			<div class="span4">
	  				<label>Presupuesto de adjudicaci&oacute;n</label>
	    			<input type="text" id="presupuestoAdjudicacion" name="presupuestoAdjudicacion" placeholder="en $ argentinos"/>		
	    		</div>
	    		<div class="span4">
	    			<label>Fecha estimada de inicio</label>
		    	   	<div id="fecha-estimada-from" class="input-append">											   
					    <input id="fechaEstimadaInicio" name="fechaEstimadaInicio" type="text" class="repairDate" placeholder="dd/mm/aaaa"/>
					    <span class="add-on">
					      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
					      </i>
					    </span>
					</div> 
	 				</div>	  				
	 				<div class="span4">	  
	 					<label>Fecha estimada de finalizaci&oacute;n</label>			
	  				<div id="fecha-estimada-to" class="input-append">											   
					    <input id="fechaEstimadaFin" name="fechaEstimadaFin" type="text" class="repairDate" placeholder="dd/mm/aaaa"/>
					    <span class="add-on">
					      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
					      </i>
					    </span>
					</div>  	
	 			</div>
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">	  	
		  		<div class="span4">
			    	   	<label>Presupuesto final</label>
	    	   		<input type="text" id="presupuestoFinal" name="presupuestoFinal" placeholder="en $ argentinos"/>	
	  			</div>	  			 
	  			<div class="span4">
	  				<label>Fecha real de inicio</label>			
		    	   	<div id="fecha-real-from" class="input-append">											   
					    <input id="fechaRealInicio" name="fechaRealInicio" type="text" class="repairDate" placeholder="dd/mm/aaaa"/>
					    <span class="add-on">
					      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
					      </i>
					    </span>
					</div>
	  			</div>	  		
	  			<div class="span4">	  
	  				<label>Fecha real de finalizaci&oacute;n</label>						
	  				<div id="fecha-real-to" class="input-append">											   
					    <input id="fechaRealFin" name="fechaRealFin" type="text" class="repairDate" placeholder="dd/mm/aaaa"/>
					    <span class="add-on">
					      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
					      </i>
					    </span>
					</div>  	
	  			</div>	  				
	  		</div>	  		
	  		<hr>	  		
	  		<div class="row-fluid">
	  			<div class="span6">
	  				<label>Observaciones</label>					    
		    	   	<textarea id="observaciones" name="observaciones"></textarea>	
	  			</div>	  	
	  		</div>	 
		</div>
		<!-- modal footer -->
	  	<div class="modal-footer"> 	
	  		<button id="btn-save-repair" class="btn btn-info" aria-hidden="true" disabled>
		    	<i class="icon-ok icon-large"></i>Guardar
		    </button>  			  	
	  		<button class="btn" data-dismiss="modal" aria-hidden="true">
		    	<i class="icon-remove icon-large"></i>Cancelar
		    </button>	
	  	</div>
	  	</form>
	</div>
	

<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
		<td width="100">	 	  			  	   		
				 <span class="preview thumbnail" style="max-height:60px; text-align: center"></span>
		</td>
		
			<td>
            	Procesando...
				{%=file.name%} 
            	<div class="progress progress-success progress-striped"><div class="bar" style="width:0%;"></div></div>		
				<strong class="error text-danger" style="color: red"></strong>
            	
				
        	</td>

        	<td width="100" class="centered">				
            	{% if (!i && !o.options.autoUpload) { %}
                	<button class="btn btn-primary start" disabled>
                    	<i class="icon-upload"></i>
                	</button>
            	{% } %}

				
            	{% if (!i) { %}
				
                		<button class="btn btn-warning cancel">
                    		<i class="icon-ban-circle"></i>                    		
                		</button>
            	
				{% } %}   
        	</td>
    </tr>
{% } %}
</script>

<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr id="{%=file.id%}" class="template-download fade">

        <td width="100"> 	   		
				<span class="preview thumbnail" style="max-height:60px; text-align: center">
                 	{% if (file.thumbnailUrl) { %}
                    	<a style="width:100px; height:60px; " href="#" title="{%=file.name%}">
							<img style="max-width:100px; max-height:60px;" src="${pageContext.request.contextPath}/uploads/{%=file.name%}">
						</a>
  				 	{% } %}
            	</span>
		</td>

        <td>
            
 			<span class="size">{%=o.formatFileSize(file.size)%}</span>
            {% if (file.error) { %}
                <div><span class="label label-danger">Error</span> {%=file.error%}</div>
			{% } %}

        </td>
       
        <td width="100" class="centered">
			 {% if (file.error) { %}
                		<button class="btn btn-warning cancel">
                    		<i class="icon-ban-circle"></i>                    		
                		</button>
             {% } else { %}

                                        <a href="#" class="btn btn-small btn-file-delete">
									 		<i class="icon-trash icon-large" title="Eliminar archivo"></i>
									 	</a>

  			{% } %}
										
           
        </td>
    </tr>
{% } %}
</script>
	
		<!-- Go to www.addthis.com/dashboard to customize your tools -->
<!-- <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-53d8340b75bafe45"></script> -->
		
</div><!-- CONTENT -->
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.3.1/jquery.maskedinput.min.js"></script>