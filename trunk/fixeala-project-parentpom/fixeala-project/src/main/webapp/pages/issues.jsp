<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		
		$(function(e){	
		
			
			
			var idIssue = '${id}';
			var loggedUser = '${loggedUser}';
	   		var latitud = '${latitud}';
	   		var longitud = '${longitud}';
			var newTitle;			
		
			var issueLocation = [];		
			issueLocation.id = idIssue;
			issueLocation.latitude = latitud;
			issueLocation.longitude = longitud;		
			
			getClosestMarkersByIssue(issueLocation);
			
			$('#btn-update').attr('disabled', true);
			
			//default config
			$.fn.editable.defaults.mode = 'popup';	
			$.fn.editable.defaults.disabled = true;
			$.mockjaxSettings.responseTime = 300; 
			
			//modify buttons style
			$.fn.editableform.buttons = 
			  '<button type="submit" class="btn btn-warning editable-submit"><i class="icon-ok icon-white"></i></button>' +
			  '<button type="button" class="btn editable-cancel"><i class="icon-remove"></i></button>';     
			
			$('#btn-edit').addClass('notClicked');
			
			//enable / disable
		    $('#btn-edit').click(function() {
		    	enableDisableFields();
		    	if( $('#btn-update').is(":disabled") == true )
					$('#btn-update').attr('disabled', false);
		    	else
		    		$('#btn-update').attr('disabled', true);
		    }); 
			  
		    function enableDisableFields(){
			   $('#issue-title').editable('toggleDisabled');
		       $('#issue-barrio').editable('toggleDisabled');
		       $('#issue-desc').editable('toggleDisabled');
		       $('#issue-tags').editable('toggleDisabled');
		       
		       var iconTags =  $('#edit-tags');
		       
		       if(iconTags.is(':visible')){
		    	   $('#edit-tags').hide();
		       }
		       else{
		    	   $('#edit-tags').show();
		       }
		       
			   if(!${isCommonUser})
		       		$('#tbl-licitacion .editable').editable('toggleDisabled');
		    }
	
			  //--NON-EDITABLE FIELDS
			  
			  $("#issue-id").editable({name: 'id',  disabled: true});			  
			  $("#issue-date").editable({name: 'date', disabled: true});		
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
				        type: 'json'
				  },
				  validate: function(value) {
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
					    if($.trim(value).length > 50) {
					        return 'La longitud máxima del campo es de 50 caracteres.';
					    }
				  },
				  success: function(response, newValue) {		             
		               newTitle =  newValue;
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
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
					    if($.trim(value).length > 600) {
					        return 'La longitud maxima del campo es de 600 caracteres.';
					    }
				  }
			  	
			  });
			  
			  $("#issue-barrio").editable({
				  pk: 3,  
				  name: 'neighborhood', 	
				  mode: 'popup',	
				  placement: 'right',
				  ajaxOptions: {
				        type: 'put'
				  },
				  validate: function(value) {					   
					    if($.trim(value).length > 50) {
					        return 'La longitud maxima del campo es de 50 caracteres.';
					    }
				  },
				  success: function(response, newValue) {
		                console.log(response, newValue);
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
			            }
			        },
// 			        display: function(value) {
// 			            $.each(value,function(i){			           
// 			               value[i] = "<span class='label'>" + $('<p>' + value[i] + '</p>').text() + "</span>";
// 			            });
// 			            $(this).html(value.join(" "));
// 			        },						
			        ajaxOptions: {
				        type: 'put'
				    }			 
// 				    success: function(response, newValue) {
// 		                console.log(response, newValue);
// 		            },
		                    
  			  }); 

// 			  $('.issue-tags').on('shown', function() {
// 				    var editable = $(this).data('editable');
// 				    value = editable.value;
// 				    $.each(value,function(i){
// 				       value[i] = $('<p>' + value[i] + '</p>').text();
// 				    });				    
// 			  });
	
// 			  $('[id^="tags-edit-"]').click(function(e) {
// 				    e.stopPropagation();
// 				    e.preventDefault();
// 				    $('#' + $(this).data('editable') ).editable('toggle');
// 			  });
			  
			 
			  
			//---- CAMPOS LICITACION
			 
			
			  $("#lic-obra").editable({	
				  pk: 5,  
				  name: 'obra',
				  emptytext:'Vac&iacute;o',
				  placement:'bottom',
				  inputclass: 'licitacion-textarea',
				  ajaxOptions: {
				        type: 'put'
				  }
// 				  validate: function(value) {
// 					    if($.trim(value) == '') {
// 					        return 'Este campo es requerido.';
// 					    }
// 					    if($.trim(value).length > 600) {
// 					        return 'La longitud máxima del campo es de 600 caracteres.';
// 					    }
// 				  }
			  });
			  
			  $("#lic-nroLicitacion").editable({
				  pk: 6,  
				  name: 'nroLicitacion',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
// 				  validate: function(value) {
// 					    if($.trim(value) == '') {
// 					        return 'Este campo es requerido.';
// 					    }
// 				  }
			  });
			  
			  $("#lic-nroExpediente").editable({	
				  pk: 7, 
				  name: 'nroExpediente',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
// 				  validate: function(value) {
// 					    if($.trim(value) == '') {
// 					        return 'Este campo es requerido.';
// 					    }
// 				  }
			  });
			  
			  $('#lic-tipo').editable({
				  name: 'tipoObra',
				  value: 'Indefinido',
			      source: [
						{value: 'Indefinido', text: 'Indefinido'},
						{value: 'P&uacute;blica', text: 'P&uacute;blica'},
			            {value: 'Privada', text: 'Privada'},
			            {value: 'Contrataci&oacute;n directa', text: 'Contrataci&oacute;n directa'}
			        ]
			    });    
			  
			  $('#lic-estadoObra').editable({
				  name: 'estadoObra',
				  value: 'Sin iniciar',
			      source: [
					    {value: 'Sin iniciar', text: 'Sin iniciar'},
			            {value: 'En curso', text: 'En curso'},
			            {value: 'Interrumpida', text: 'Interrumpida'},
			            {value: 'Finalizada', text: 'Finalizada'}
			        ]
			  });  
			  
			  $("#lic-valorPliego").editable({	
				  name: 'valorPliego',
				  ajaxOptions: {
				        type: 'put'
				  },
				  value: 0
			  });
			  
			  $("#lic-unidadEjecutora").editable({
				  name: 'unidadEjecutora',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-unidadFinanciamiento").editable({				
				  name: 'unidadFinanciamiento',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }		 
			  });
			  
			  $("#lic-empresaNombre").editable({	
				  name: 'empresaNombre',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-empresaCuit").editable({		
				  name: 'empresaCuit',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-empresaEmail").editable({	
				  name: 'empresaEmail',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-representanteNombre").editable({			
				  name: 'representanteNombre',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-representanteDni").editable({			
				  name: 'representanteDni',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-representanteEmail").editable({		
				  name: 'representanteEmail',
				  emptytext:'Vac&iacute;o',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			 
			  
			  $("#lic-presupuestoAdjudicado").editable({	
				  name: 'presupuestoAdjudicado',
				  value: 0,
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-presupuestoFinal").editable({	
				  name: 'presupuestoFinal',
				  value: 0,
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  
			  
			  $('#fechaEstimadaInicio').editable({
				  name:'fechaEstimadaInicio',
				  mode: 'popup',
				  placement: 'top',
				  emptytext:'Vac&iacute;o',
				  format: 'DD-MM-YYYY',    
			      viewformat: 'DD/MM/YYYY',    
			      combodate: {
			                minYear: 2013,
			                maxYear: 2015,
			                minuteStep: 1,
			                value: new Date()
			      },
			      ajaxOptions: {
				        type: 'put'
				  }
			    });
			 
			  
			  $('#fechaEstimadaFin').editable({
				  name:'fechaEstimadaFin',
				  mode: 'popup',
				  placement: 'right',
				  emptytext:'Vac&iacute;o',
				  format: 'DD-MM-YYYY', 
				  viewformat: 'DD/MM/YYYY',    
			      combodate: {
			    	  	minYear: 2013,
		                maxYear: 2015,
		                minuteStep: 1,
		                value: new Date()
			      },
			      ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $('#fechaRealInicio').editable({
				  name:'fechaRealInicio',	
				  mode: 'popup',
				  placement: 'top',
				  emptytext:'Vac&iacute;o',
				  format: 'DD-MM-YYYY',    
			      viewformat: 'DD/MM/YYYY',    
			      combodate: {
			    	  	minYear: 2013,
		                maxYear: 2015,
		                minuteStep: 1,
		                value: new Date()
			      },
			      ajaxOptions: {
				        type: 'put'
				  }
			    });
			  
			  $('#fechaRealFin').editable({
				  name:'fechaRealFin',	
				  mode: 'popup',
				  placement: 'right',
				  emptytext:'Vac&iacute;o',
				  format: 'DD-MM-YYYY',    
			      viewformat: 'DD/MM/YYYY',   
			      combodate: {
			    	  	minYear: 2013,
		                maxYear: 2015,
		                minuteStep: 1,
		                value: new Date()
			      }
			    });
			  
			  
			  function resetLicitacionValues(){
				  	 $('#lic-obra').editable('setValue', null); 
				     $('#lic-nroLicitacion').editable('setValue', null); 
				     $('#lic-nroExpediente').editable('setValue', null); 
				     $('#lic-valorPliego').editable('setValue', 0); 
				     $('#lic-unidadEjecutora').editable('setValue', null); 
				     $('#lic-unidadFinanciamiento').editable('setValue', null); 
				     $('#lic-empresaNombre').editable('setValue', null); 
				     $('#lic-empresaCuit').editable('setValue', null); 
				     $('#lic-empresaEmail').editable('setValue', null); 
				     $('#lic-representanteNombre').editable('setValue', null); 
				     $('#lic-representanteDni').editable('setValue', null); 
				     $('#lic-representanteEmail').editable('setValue', null); 
				     $('#lic-presupuestoAdjudicado').editable('setValue', 0); 
				     $('#lic-presupuestoFinal').editable('setValue', 0); 
				     $('#lic-tipo').editable('setValue', 1); 
				     $('#lic-estadoObra').editable('setValue', 1); 
				     $('#fechaEstimadaInicio').editable('setValue', null); 
				     $('#fechaEstimadaFin').editable('setValue', null); 
				     $('#fechaRealInicio').editable('setValue', null); 
				     $('#fechaRealFin').editable('setValue', null); 
			  }
			
			  
			  //--RESET Form Licitacion 
			  $('#reset-btn').click(function() {
				  resetLicitacionValues();
				});
			  
			  /*******************************************/
			
			   $('#btn-comment').click(function() {
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
						    	window.location.reload();
						    }					    	   
				    	    else{
				    		    bootbox.alert(data.message);		
				    	    }
	            		}
        			});
			  });
			   
			   
			  
			  
			
			  $('#btn-update').click(function() {				  
				 				  
				  bootbox.confirm("&iquest;Desea confirmar los cambios?", function(result){
					  
					  if(result){
						  
						  $('.editable').editable('submit', {
							  
						       url: './updateIssue.html', 
						       ajaxOptions: {
						           dataType: 'json'
						       },  				       
						       success: function(data, config) {	
						    	   
						    	   if(data.result){		
						    		   bootbox.alert(data.message); 
						    			setTimeout(function () {	
						    				var url = getIssueURL(id, newTitle, 'plain');
						    				alert(url);
							    			window.location.href= url;	
						    			}, 500);		
						    	   }						    	   
						    	   else{
						    		   bootbox.alert(data.message);		
						    	   }						    	
						       },
						       error: function (response) {
						           console.log(response);
						       }

						   });//editable 
						  
					  }
			
					   
				  });//bootbox   
				});
			  
			  
			  	//update status only
				$('#btn-status').click(function() {
					var label = $(this).text().trim();
					var status = "";
					var id = ${id};
					var title = '${titulo}';
					
					if(label == 'Resolver')
						status = 'RESUELTO';
					
					if(label == 'Reabrir')
						status = "REABIERTO";
					
					var data = 'issueID='+ id + '&newStatus='+ status;
				
					$.ajax({
        			    url: "./updateIssueStatus.html",
				 		type: "POST",	
				 		data: data,
				 		dataType: "json",									 
				        success: function(data){		
				        	if(data.result){				
				        		
				        			bootbox.alert(data.message); 
				        			
					    			setTimeout(function () {
					    				var url = getIssueURL(id, title, 'plain');
						    			window.location.href= url;	
					    			}, 2000);						    			

					    	   }
					    	   
					    	   else{
					    		   bootbox.alert(data.message);		
					    	   }
	            		}
        			});
						  
				});
			  	
			  	
				
				
				$(function () {
				    'use strict';

				    $('#multiplefileupload').fileupload();
				
				    $('#multiplefileupload').fileupload({
				    	 url: './handleMultipleFileUpload.html',
					     type: "POST",
					     dataType: 'json',
					     contentType: false,
						 processData: false,
						 formData: [{ name: 'issueID', value: ${id} }],
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
				    	var parsedResult = $.parseJSON(data.result.uploadedFiles);	
					    data.files = parsedResult;					    
					    updateFilesInfo(data.result.totalUploadedFiles);
 					});
				    
				});
				
				
				$('#tbl-fileupload').on('click', '.btn-file-delete', function() {
					
					var issueID = ${id};
					var contenidoID = $(this).closest('tr').attr('id');					
					var data = 'issueID='+ issueID + '&fileID='+ contenidoID;

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
			        
			        
			        ///*******/////
			        
			        var isWatching = '${isUserWatching}';
			         
			        var $watcherDiv = $('#watchers');
		        	var $watchingLink = $('#watching-toggle');
		        	var $watcherList = $('#view-watcher-list');	       
			    	var iconUnWatch = '<i class="icon-eye-close" id="icon-unwatch" style="margin-right:5px;"></i>';
		        	var iconWatch = '<i class="icon-eye-open" id="icon-watch" style="margin-right:5px;"></i>';
		        	
		        	var numberOfWatchers = '${cantidadObservadores}';
		        	
		        	var data = "issueID=" + idIssue;
		        	
		        	var loader = '<span class="loader"><img src="${pageContext.request.contextPath}/resources/images/loader.gif" style="margin-right:5px; alt="Loading"/></span>';	  
		        		        	
			        if(isWatching == 'true'){	
			        	$watchingLink.addClass('watching');
			        	$(iconUnWatch).insertBefore($watchingLink);
			        	$watchingLink.text('Observando');
			        	$watchingLink.attr('title', 'Dejar de observar este reclamo');
			        	$watcherList.html(numberOfWatchers); 
			        }
			        
			        else {
			        	$watchingLink.addClass('unwatch');
			        	$(iconWatch).insertBefore($watchingLink);
			        	$watchingLink.text('Observar');
			        	$watchingLink.attr('title', 'Observar este reclamo');
			        	$watcherList.html(numberOfWatchers); 
			        }			        
			       
			       
			       $watcherList.popover({trigger: 'manual', title: '', html : true})
						       .click(function(e){
						           var element = $(this);
						           $.ajax({
						        	   url: './displayIssueFollowers.html',
						               type: 'POST',
						               dataType: 'json',
						               data: data,
						               success: function(response){
						            	   
							    	        var f = '';				             
										    $.each(response, function(i, follower){	
										    	f += '<i class="icon-angle-right"></i>&nbsp;';
										    	f += getUserURL(follower);
										    	f += '<br>';
										    });
						                   $(element).attr('data-content',f).popover('show');
						               }
						           });
						           e.preventDefault();
						       });
	        	
			    
			        $('#watching-toggle').click(function() {
			        	
				 		if($watchingLink.hasClass('watching')){
				 			
				 			$.ajax({
		        			    url: "./unwatchIssue.html",
						 		type: "POST",	
						 		data: data,							 
						        success: function(data){							        	
						        	if(data.result){
						        		
						        		$watchingLink.removeClass('watching');
						 				$watchingLink.addClass('unwatch');
						 				
						 			    $('#icon-unwatch').replaceWith(loader);
						 										 				
						 				setTimeout(function(){
						 					$('.loader').replaceWith(iconWatch);
						 					$watchingLink.text('Observar');
							 				$watchingLink.attr('title', 'Observar este reclamo');							 		
							 				$('#view-watcher-list').html(data.message);							 					 						      
						 				}, 1000);
						        	}
						        	
						        	else{
						        		bootbox.alert(data.message);	
						        	}	
			            		}						  
		        			});				 				
				 		}
				 		
				 		else{
				 			
				 			$.ajax({
		        			    url: "./watchIssue.html",
						 		type: "POST",	
						 		data: data,							 
						        success: function(data){						        	
						        	if(data.result){	
						        		
						        		$('#icon-watch').replaceWith(loader);
						        		
						        		$watchingLink.removeClass('unwatch');
					 					$watchingLink.addClass('watching');
						        		
						        		setTimeout(function(){							 					
						 					$('.loader').replaceWith(iconUnWatch);
						 					$watchingLink.text('Observando');
							 				$watchingLink.attr('title', 'Dejar de observar este reclamo');
							 				$('#view-watcher-list').html(data.message);
							 			
						 				}, 1000);	
						        	}
						        	
						        	else{
						        		bootbox.alert(data.message);	
						        	}	
			            		}						  
		        			});				 			
				 		}
				});//watching click
				
			

		});
		
		
	
		</script>

	
	<div class="container-fluid">
	  	<div class="row-fluid">
	   
		    <div class="span9">
		      <!--Body content-->
		     
  	  <div class="hero-unit" style="padding:20px; margin-bottom:15px">	  
        <h3 style="display:inline">
        	<a href="#" id="issue-title">${titulo}</a>
        	&nbsp;&nbsp;
        	<i class="icon-chevron-right icon-large"></i>&nbsp;&nbsp;<span style="color:green">${estado}</span></h3>
        <p>${direccion}</p>       
      </div>
      
    
      
      <div class="row">
      
      
      	
<!--   			  <li><a href="#" title="Vistas"><h4>Vistas (0)</h4></a></li> -->
<!--   			   <li><a href="#" title="Votos"><h4>Votar (0)</h4></a></li> -->
  			<div style="display:inline-block">	
  			  	<i class="icon-ok"></i>
  			  	Visto ${cantidadVisitas} veces
  			</div>
  			||
  			<div id="watchers" style="display:inline-block">		  	
	    		<a href="#" id="watching-toggle"></a>
 			    (<a href="#" id="view-watcher-list" data-toggle="popover"></a>)
  			</div>
  			||
  			<div style="display:inline-block">	
  			  	<i class="icon-star"></i>
  			  	<a id="bookmarkme" href="#" rel="sidebar" title="Agregar a favoritos">Agregar a Favoritos</a>
  			</div>  	
  			    	
  			  
<%--   			    <a href="#" title="Comentarios">Comentarios (${cantidadComentarios})</a> --%>
<!--   			    <a id="bookmarkme" href="#" rel="sidebar" title="Agregar a favoritos"><h4><i class="icon-star"></i></h4></a> -->
<!--   			     <li><a href="#" title="Imprimir"><h4><i class="icon-print"></i></h4></a></li> -->
<!--   			     <li><a href="#" title="Denunciar"><h4><i class="icon-warning-sign"></i></h4></a></li>  			     -->
		  

		  		  		
<!-- 	 	  <div id="btnGroupSocial" class="btn-group"> -->
<!-- 	 			<button class="btn"><i class="icon-share icon-large"></i>&nbsp;&nbsp;Compartir</button> -->
<!-- 	 			<button class="btn dropdown-toggle" data-toggle="dropdown"> -->
<!-- 	   			<span class="caret"></span> -->
<!-- 	 			</button>	  	 -->
<!-- 	 			<ul class="dropdown-menu"> -->
<!-- 		    	<li><a href="#" title=""><i class="icon-envelope-alt icon-large"></i>&nbsp;&nbsp;&nbsp;Email</a></li> -->
<!-- 		    	<li><a href="#" title=""><i class="icon-facebook-sign icon-large"></i>&nbsp;&nbsp;&nbsp;Facebook</a></li> -->
<!-- 		    	<li><a href="#" title=""><i class="icon-google-plus icon-large"></i>&nbsp;&nbsp;&nbsp;Google+</a></li> -->
<!-- 		    	<li><a href="#" title=""><i class="icon-twitter icon-large"></i>&nbsp;&nbsp;&nbsp;Twitter</a></li> -->
<!-- 	 			</ul> -->
<!-- 		   </div> -->

			<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN', 'ROLE_MANAGER')">
				<c:if test="${estado eq 'ABIERTO' || estado eq 'REABIERTO'}">
					<div id="btn-status" class="btn-group" style="float:right;">			
						<button class="btn btn-success"><i class="icon-ok icon-large"></i>&nbsp;&nbsp;Resolver</button>
					</div>
				</c:if>
				<c:if test="${estado eq 'RESUELTO' || estado eq 'CERRADO'}">
					<div id="btn-status" class="btn-group" style="float:right;">			
						<button class="btn btn-warning"><i class="icon-rotate-right icon-large"></i>&nbsp;&nbsp;Reabrir</button>
					</div>
				</c:if>	
				<div class="btn-group" style="float:right;">
					<button id="btn-update"  class="btn btn-primary"><i class="icon-save icon-large"></i>&nbsp;&nbsp;Guardar</button>			
				</div>
				<div class="btn-group" style="float:right;">
					<button id="btn-edit" class="btn btn-info"><i class="icon-pencil icon-large"></i>&nbsp;&nbsp;Editar</button>			
				</div>		
				
			</sec:authorize>
	
	   </div>
	   
	   <hr>
	 
	  <div class="row">
	  
	 
	  <div class="row-fluid">
	   
		 <div class="span4">  

		 <ul class="thumbnails">
	  	   		<li style="margin-left:0">		
		    		<c:if test="${not empty image}">
		    			<a data-lightbox="issue-lightbox2" class="thumbnail" href="${pageContext.request.contextPath}/uploads/${imageUrl}">							  	  			  	   		
							<img src="${pageContext.request.contextPath}/uploads/${imageUrl}" alt="${imageName}">	 
						</a>		
		    		</c:if>
		    		<c:if test="${empty image}">
		    			<a data-lightbox="issue-lightbox2" class="thumbnail" href="${pageContext.request.contextPath}/resources/images/nopic.png" >							  	  			  	   		
							<img src="${pageContext.request.contextPath}/resources/images/nopic.png" alt="">	
						</a>
		    		</c:if>
		    	
	    			<br>
	    			<div class="caption">
	    				<a href="#mdl-fileupload" data-toggle="modal" class="btn btn-info">
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
						    <th>Fecha:</th>
						    <td><a href="#" id="issue-date">${fecha}</a></td>						   
						 </tr>
						 <tr>
						    <th>Direcci&oacute;n:</th>
						    <td><a href="#" id="issue-street">${calle}</a></td>						   
						 </tr>
						 <tr>
						    <th>Barrio:</th>
						    <td><a href="#" id="issue-barrio">${barrio}</a></td>						   
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
						    <th>Reportado por:</th>
						    <td><script type="text/javascript">document.write( getUserURL('${usuario}') );</script></td>							    		   
						 </tr>
						 <tr>
						    <th>Asignado a:</th>
						    <td><a href="#" id="issue-area">${area}</a></td>						   
						 </tr>
						  <tr>
						    <th>Descripci&oacute;n:</th>
						    <td><a href="#" id="issue-desc">${descripcion}</a></td>						   
						 </tr>
						 <tr>
						    <th>Estado:</th>
						    <td><a href="#" id="issue-status" data-type="text"><span class="${estadoCss}">${estado}</span></a></td>						   
						 </tr>
						  <tr>
						    <th>Etiquetas:</th>
						    <td>
<!-- 						        <span class="issue-tags"  -->
<!-- 						        	  id="tags-editable-1"            					 -->
<!--             						  data-type="select2" -->
<%--             						  data-value="${tagsByIssue}"> --%>
<!--             					</span> -->
<!--        							<a href="#" id="tags-edit-1" data-editable="tags-editable-1">        							 -->
<!--        								<i id="edit-tags" class="icon-pencil" style="display:none"></i> -->
<!--        							</a> -->
       							<a id="issue-tags" href="#" data-type="select2">${tagsByIssue}</a>
						    </td>						   
						 </tr>
					</table>	 	
	 		</div>
	 		
	 	
	 	 </div><!-- fluid -->
	 	 	
	 
      </div>
     
		
		<div class="accordion" id="accordion2">
 
 			  <br>

			  <!-- 2 HISTORIAL -->
			  <div class="accordion-group">
			    <div class="accordion-heading">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
			       <h4><i class="icon-time icon-large"></i>&nbsp;&nbsp;HISTORIAL DE ACTUALIZACIONES (${cantidadRevisiones})</h4>
			      </a>
			    </div>
			    <div id="collapseThree" class="accordion-body collapse">
			      <div class="accordion-inner">
			        <table class="table table-hover table-bordered table-striped">			        	
			        	<thead>			        
					        <tr>
					        	<th>#</th>
					        	<th>Fecha y Hora</th>					        	
					        	<th>Motivo</th>
					        	<th>Usuario</th>
					        	<th>Estado del reclamo</th>
					        	<th>Observaciones</th>
					        </tr>
				        </thead>	
				        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
				      
				         <c:forEach items="${historial}" var="revision">	
				        
				         <c:set var="count" value="${count + 1}" scope="page"/>		
						 <tr>		
						 	<td><c:out value="${count}" /></td>						 	
						    <td>${revision.fechaFormateada}</td>						  
						    <td>${revision.motivo}</td>
						    <td><script type="text/javascript">document.write( getUserURL('${revision.username}') );</script></td>
						    <td>${revision.estado}</td>
						    <td>${revision.observaciones}</td>
						 </tr>
						 </c:forEach>
					</table>
			      </div>
			    </div>
			  </div>
			  
			  
			  <!-- 3 LICITACION -->
			  <div class="accordion-group">
			    <div class="accordion-heading">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
			        <h4><i class="icon-wrench icon-large"></i>&nbsp;&nbsp;LICITACI&Oacute;N (${cantidadLicitacion})</h4>
			      </a>			     
			    </div>
			    <div id="collapseTwo" class="accordion-body collapse">
			      <div class="accordion-inner">			      
			      
<!-- 			    <button id="reset-btn" class="btn btn-large btn-danger" style="margin-left:595px">Resetear valores</button> -->
					
					<c:if test="${cantidadLicitacion eq 0}">
						Por el momento no hay informaci&oacute;n disponible.		 
					</c:if>
					
					<c:if test="${cantidadLicitacion gt 0}">	
						<table id="tbl-licitacion" class="table table-hover table-bordered table-striped">							
							 <tr>
							    <th>Obra:</th>
							    <td><a href="#" id="lic-obra" data-type="textarea">${obra}</a></td>						  
							 </tr>
							 <tr>
							    <th>N&ordm de Licitaci&oacute;n:</th>
							    <td><a href="#" id="lic-nroLicitacion" data-type="text">${nroLicitacion}</a>						  
							 </tr>
							 <tr>
							    <th>N&ordm de Expediente:</th>
							    <td><a href="#" id="lic-nroExpediente" data-type="text">${nroExpediente}</a></td>						  
							 </tr>
							 <tr>
							    <th>Estado de la obra:</th>
							    <td><a href="#" id="lic-estadoObra" data-type="select">${estadoObra}</a></td>						  
							 </tr>
							 <tr>
							    <th>Tipo:</th>
							    <td><a href="#" id="lic-tipo" data-type="select" >${tipoObra}</a></td>						  
							 </tr>
							 <tr>
							 	<th>Unidad ejecutora:</th>
							    <td><a href="#" id="lic-unidadEjecutora" data-type="text">${unidadEjecutora}</a></td>
							 </tr>	
							 <tr>	
							    <th>Unidad de financiaci&oacute;n:</th>
							    <td><a href="#" id="lic-unidadFinanciamiento" data-type="text">${unidadFinanciamiento}</a></td>		
							 </tr>
							 <tr>	
							    <th>Valor del pliego:</th>
							    <td>$ <a href="#" id="lic-valorPliego" data-type="number">${valorPliego}</a></td>		
							 </tr>						 <tr>
							    <th>Empresa constructora:</th>
							  	<td>
							    	Raz&oacute;n social: <a href="#" id="lic-empresaNombre" data-type="text">${empresaNombre}</a>
							    	<br>CUIT: <a href="#" id="lic-empresaCuit" data-type="text">${empresaCuit}</a>	
							    	<br>Email: <a href="#" id="lic-empresaEmail" data-type="email">${empresaEmail}</a>
							    </td>
							 </tr>
							 <tr>
							    <th>Representante t&eacute;cnico:</th>
							      <td>
							    	Nombre y Apellido: <a href="#" id="lic-representanteNombre" data-type="text">${representanteNombre}</a>
							    	<br>DNI: <a href="#" id="lic-representanteDni" data-type="number">${representanteDni}</a>
							    	<br>Email: <a href="#" id="lic-representanteEmail" data-type="email">${representanteEmail}</a>	
							      </td>								   						  
							 </tr>
							 <tr>
							    <th>Presupuesto Adjudicado:</th>
							    <td>
							    	$ <a href="#" id="lic-presupuestoAdjudicado" data-type="number">${presupuestoAdjudicado}</a>
							    </td>
							 </tr>
							 <tr>	
							    <th>Presupuesto Final:</th>
							    <td>
							    	$ <a href="#" id="lic-presupuestoFinal" data-type="number">${presupuestoFinal}</a>
							    </td>					  
							 </tr>
							 <tr>
							    <th>Fechas estimadas:</th>
							    <td>
							    	<a href="#" id="fechaEstimadaInicio" data-type="combodate">${fechaEstimadaInicio}</a>
													&mdash;
													<a href="#" id="fechaEstimadaFin" data-type="combodate">${fechaEstimadaFinal}</a>
							    </td>	
							 </tr>
							 <tr>
							    <th>Fechas reales:</th>
							    <td>
							    	<a href="#" id="fechaRealInicio" data-type="combodate">${fechaRealInicio}</a>	
													&mdash;
													<a href="#" id="fechaRealFin" data-type="combodate">${fechaRealFinal}</a>	
							    </td>					  
							 </tr>
				  		</table>	
					</c:if>
							
					
			  			
				</div>

			    </div>
			  </div>			  
			  
		
			  <!-- 4 RECLAMOS SIMILARES -->
			  <div class="accordion-group">
			    <div class="accordion-heading">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseFour">
			        <h4><i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;RECLAMOS SIMILARES (${cantidadReclamosSimilares})</h4>
			      </a>
			    </div>
			    <div id="collapseFour" class="accordion-body collapse">
			      <div class="accordion-inner">
			       	<div class="row-fluid">
			            <ul class="thumbnails">
			              <li class="span3">
			                <div class="thumbnail">
			                  <img style="width: 200px; height: 150px;" src="${pageContext.request.contextPath}/resources/images/nopicsmall.png" alt="">
			                  <div class="caption">
			                  	<h5>Thumbnail label</h5>		                   
			                  </div>
			                </div>
			              </li>
			              <li class="span3">
			                <div class="thumbnail">
			                  <img style="width: 200px; height: 150px;" src="${pageContext.request.contextPath}/resources/images/nopicsmall.png" alt="">
			                  <div class="caption">
			                     <h5>Thumbnail label</h5>		                   
			                  </div>
			                </div>
			              </li>
			              <li class="span3">
			                <div class="thumbnail">
			                 <img style="width: 200px; height: 150px;" src="${pageContext.request.contextPath}/resources/images/nopicsmall.png" alt="">
			                  <div class="caption">
			                      <h5>Thumbnail label</h5>		                  
			                  </div>
			                </div>
			              </li>
			            </ul>
		        	</div>		   	
			      </div>
			    </div>
			  </div>
			  			  
			  <!-- 5 IMAGES & VIDEOS -->
			  <div class="accordion-group">
			    <div class="accordion-heading">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseFive">
			       <h4><i class="icon-camera icon-large"></i>&nbsp;&nbsp;IM&Aacute;GENES (<span class="cantidadContenidos">${cantidadContenidos}</span>)</h4>			        
			      </a>
			    </div>
			    <div id="collapseFive" class="accordion-body collapse">
			      <div class="accordion-inner">
			        <div class="row-fluid">			        
				        <ul id="lst-file-thumnails" class="thumbnails" style="margin-top:30px;">
				        	<c:forEach items="${contenidos}" var="contenido">	
				        		<li style="margin-right:20px;">					                
				                	<a class="thumbnail"  style="width:100px; height: 60px; max-height:60px; text-align: center" data-lightbox="issue-lightbox" href="${pageContext.request.contextPath}/uploads/${contenido.nombreConExtension}" >							  	  			  	   		
					      				<img style="max-width:100px; max-height:60px;" src="${pageContext.request.contextPath}/uploads/${contenido.nombreConExtension}" > 
					    			</a>
			                	</li>
				        	</c:forEach>
		      			</ul>
			        </div>
			      </div>
			    </div>
			  </div>
				  
			  <!-- 6 COMENTARIOS -->
			  <div class="accordion-group">
			    <div class="accordion-heading ">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseSix">
			       <h4><i class="icon-comments icon-large"></i>&nbsp;&nbsp;COMENTARIOS (${cantidadComentarios})</h4>
			      </a>
			    </div>
			    <div id="collapseSix" class="accordion-body collapse">
			      <div class="accordion-inner">
			      			     
			    <!-- EDITOR BOX-->   
			    <div style=" width:660px;margin:20px 0;">
			   
		                <textarea class="span9" id="comment-text" name="comment-text"
		                	placeholder="Ingrese su comentario" rows="5"></textarea>
		           
		               	<button id="btn-comment" type="submit" style="float:right;margin-top:15px;margin-bottom:15px;" class="btn btn-info">Publicar</button>	
		        
				<div class="comment-list">
						
				<table id="tblComments" class="table table-hover">				        
				   <c:forEach items="${comentarios}" var="comentario" varStatus="i">	
						<tr>
							<td>
								<div class="media">

									  <span class="pull-left">
									  <img class="media-object thumbnail" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
									 	<center><strong>${i.index + 1}</strong></center>
									 </span>
									  <div style="font-size:12px;margin-bottom:10px">
									  	<a href="#"><strong>${comentario.usuario}</strong></a> &nbsp; &raquo;  &nbsp; 
								    	${comentario.fechaFormateada}
								      </div>
							 		  <div class="media-body" style="display:block">				    	
								    	
								    	<p style="font-size:13px">${comentario.mensaje}</p>	 
							  		</div>
								</div>						
							</td>
						</tr>
					</c:forEach>
				</table>
				
				<div id="comments-pag"></div>	
			
				</div>
				
					</div>
			       
			      </div>
			    </div>
			  </div>
			  
	    </div>
		    </div>
		    
		    
		    
		    
		<!-- COLUMNA 2 -->    
		<div class="span3">
		<!--Sidebar content-->
		
		   <div class="page-header">
    	   		<h4><i class="icon-globe icon-large"></i>&nbsp;&nbsp;Vista en el mapa</h4>    	 	
    	   </div>     	   
		   		 
		   	<script type="text/javascript">		
			   $(document).ready(function(){
			   		initializeMiniMap(${latitud}, ${longitud}, '${titulo}'); 
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
	
	
	
	<div id="mdl-fileupload" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="fileUploadLabel" aria-hidden="true">
	  	<div class="modal-header">
		    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		    	
		    	<h4 id="fileUploadLabel"> 
			    	Gesti&oacute;n de archivos
		    	</h4>
	  	</div>
	  	<form id="multiplefileupload" enctype="multipart/form-data" >
  				<div class="modal-body">
    		
    			<div class="alert alert-success" style="height:30px; line-height:30px; font-size:13px;"> 
  					<i class="icon-info-sign"></i>&nbsp; Hay <b><span class="cantidadContenidos">${cantidadContenidos}</span></b> archivo(s) subido(s). M&aacute;ximo: 5 archivos.
				</div>
    			
		    			<table id="tbl-fileupload" role="presentation" class="table table-hover">    			
		   	   		  	   	<tbody class="files">   	   		  	   	
		   	   		  	   		<c:forEach items="${contenidos}" var="contenido">	
									<tr id="${contenido.id}">
					    	   			<td width="100">					    	   			
						    	   			<span class="preview thumbnail" style="max-height:60px; text-align: center">
						                    	<a style="width:100px; height:60px; " href="#" title="{%=file.name%}">
													<img style="max-width:100px; max-height:60px;" src="${pageContext.request.contextPath}/uploads/${contenido.nombreConExtension}">
												</a>
	            							</span>
										</td>										
										<td>
											${contenido.fileSize}
									 	</td>
									 	<td width="100" class="centered">
										 	<a href="#" class="btn btn-small btn-file-delete">
										 		<i class="icon-trash icon-large" title="Eliminar archivo"></i>
										 	</a>							 		
									 	</td>						
				    	   			</tr>
								</c:forEach>
				    	   	</tbody>
						</table> 
						
							
		</div>
	  	<div class="modal-footer">  
	  		<c:if test="${cantidadContenidos eq 5}">
		  		<span class="btn btn-danger fileinput-button disabled">
	                   <i class="icon-plus"></i>
	                   <span>Seleccionar archivos</span>
	                   <input type="file" name="files[]" multiple disabled>
	            </span>
	  		</c:if>	  			  		
	  		<c:if test="${cantidadContenidos lt 5}">
		  		<span class="btn btn-danger fileinput-button">
	                   <i class="icon-plus"></i>
	                   <span>Seleccionar archivos</span>
	                   <input type="file" name="files[]" multiple>
	            </span>
	  		</c:if>			  	
	  		<button class="btn" data-dismiss="modal" aria-hidden="true">
		    		<i class="icon-remove icon-large"></i>&nbsp;&nbsp;&nbsp;Cerrar
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
	
</div><!-- CONTENT -->