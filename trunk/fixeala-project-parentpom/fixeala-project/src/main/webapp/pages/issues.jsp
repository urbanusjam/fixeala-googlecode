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
				
			//collapse 
			$('.btn-collapse').on('click', function(e) {			
			    e.preventDefault();
			    var $this = $(this);
			    var $collapse = $this.closest('.collapse-group').find('.collapse');
			    $collapse.collapse('toggle');
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
			
			var comentarios = $.parseJSON('${comentariosJson}');				
			var totalItems = comentarios.length;		  
        	var itemsPerPage = 3;
        	var totalPages = Math.ceil(totalItems / itemsPerPage);	
       
			 $('#page-selection').bootpag({
		            total: totalPages,
		            page: 1,
		            maxVisible: 5,
		        }).on("page", function(event, num){
		        	        			        	
		        	var currentPage = num;
		        	var startIndex = (currentPage - 1) * itemsPerPage ;			        	
			    	var endIndex = startIndex+itemsPerPage-1 ;			    
			    	
					var lastPage = totalPages-currentPage;
					
					//is last page
		        	if(lastPage == 0){
						var itemsLeft = totalItems - [ (currentPage-1) * itemsPerPage ]; //ej: 7 - [ (3-1) * 3] = 1
						console.log("items in last page: " + itemsLeft);
		        		if( itemsLeft < itemsPerPage )
		        			endIndex = (currentPage-1) * itemsPerPage + itemsLeft-1;
		        	}
		        			        		
			    	var rows;
			    	
					console.log("total pages:" + totalPages + " - current page: " + currentPage + " > From " + startIndex + " to " + endIndex  );
													
					for(var i = startIndex; i <= endIndex ; i++) {
						
						var index = i+1;
					
						rows +='<tr>'
				     		+			'<td>'
				     		+				'<div class="media">'
				     		+					  '<span class="pull-left">'
				     		+					   		'<img class="media-object thumbnail" src="${pageContext.request.contextPath}/resources/images/nopic64.png">'
							+							 '<center><strong>'+ index  +'</strong></center>'
				     		+					  '</span>'
				     		+					  '<div style="font-size:12px;margin-bottom:10px">'
				     		+					  	'<a href="#"><strong>'+comentarios[i].usuario+'</strong></a> &nbsp; &raquo;  &nbsp; '
				     		+				    	comentarios[i].fecha
				     		+				      '</div>'
				     		+			 		  '<div class="media-body" style="display:block">		'
				     		+				    	'<p style="font-size:13px">'+comentarios[i].mensaje+'</p>'
				     		+			  		'</div>'
				     		+				'</div>		'				
				     		+			'</td>'
				     		+		'</tr>';
					}
					
		             $("#content-comment").html(
		            	'<table id="tblComments" class="table table-hover">'
		            					+rows+
		            	'</table>'
		            		 
		            		 ); 
		        });
		   
				
			
			var issueLocation = [];		
			issueLocation.id = idIssue;
			issueLocation.latitude = latitud;
			issueLocation.longitude = longitud;		
			
			getClosestMarkersByIssue(issueLocation);			
			
			//default config
			$.fn.editable.defaults.mode = 'popup';	
			$.fn.editable.defaults.disabled = true;
			$.mockjaxSettings.responseTime = 300; 
			
			//modify buttons style
			$.fn.editableform.buttons = 
			  '<button type="submit" class="btn btn-warning editable-submit"><i class="icon-ok icon-white"></i></button>' +
			  '<button type="button" class="btn editable-cancel"><i class="icon-remove"></i></button>';     
			
			$('#btn-update').attr('disabled', true);
			$('#btn-update-repair').attr('disabled', true);
			$('#btn-edit').addClass('notClicked');
			
			//enable / disable
			
			$('.editableField').hide();
			
		
		    /*
		    $('#btn-edit-repair').click(function() {
		    	if( $('#btn-update-repair').is(":disabled") == true ){		    	
					$('#btn-update-repair').attr('disabled', false);
					$('#btn-delete-repair').attr('disabled', true);
		    	}
		    	else{
		    		$('#btn-update-repair').attr('disabled', true);
		    		$('#btn-delete-repair').attr('disabled', false);
		    	}
		    		

		    	$('#tbl-licitacion .editable').editable('toggleDisabled');
		    	
		    }); 
		    */
			  
		    
	
			  //--NON-EDITABLE FIELDS
			  
			  $("#issue-id").editable({name: 'id',  disabled: true});			  
			  $("#issue-date").editable({name: 'creationDate', disabled: true});
			  $("#issue-last-update").editable({name: 'lastUpdate', disabled: true});				  
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
			            }
			        },
			        display: function(value) {
			        	var tags = new Array(value.length);
			        	
			            $.each(value,function(i){				            	
			            	var url = "./search.html?type=tag&value=" + $('<p>' + value[i] + '</p>').text();
			            	tags[i] = "<a class=\"taglink\" href=\"" + url + "\"><span class=\"label label-default\">" + $('<p>' + value[i] + '</p>').text() + "</span></a>";
			            });
			            
			            $(this).html(tags.join(" "));
			        },						
			        ajaxOptions: {
				        type: 'put'
				    }			 
		                    
  			  }); 
			 
			  
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
				  value: 'Publica',
			      source: [
						{value: 'Publica', text: 'Publica'},
			            {value: 'Privada', text: 'Privada'},
			            {value: 'Contratacion directa', text: 'Contratacion directa'}
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
			  
// 			  $("#lic-empresaEmail").editable({	
// 				  name: 'empresaEmail',
// 				  emptytext:'Vac&iacute;o',
// 				  ajaxOptions: {
// 				        type: 'put'
// 				  }
// 			  });
			  
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
			  
// 			  $("#lic-representanteEmail").editable({		
// 				  name: 'representanteEmail',
// 				  emptytext:'Vac&iacute;o',
// 				  ajaxOptions: {
// 				        type: 'put'
// 				  }
// 			  });
			 
			  
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
			  
			  
			  
			  $('#lic-fechaEstimadaInicio').editable({
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
			 
			  
			  $('#lic-fechaEstimadaFin').editable({
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
			  
			  $('#lic-fechaRealInicio').editable({
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
			  
			  $('#lic-fechaRealFin').editable({
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
				     $('#lic-fechaEstimadaInicio').editable('setValue', null); 
				     $('#lic-fechaEstimadaFin').editable('setValue', null); 
				     $('#lic-fechaRealInicio').editable('setValue', null); 
				     $('#lic-fechaRealFin').editable('setValue', null); 
			  }
			
			  
			  //--RESET Form Licitacion 
			  $('#btn-reset').click(function() {
// 				 if( $('#btn-update').is(":disabled") == false )
				  	resetLicitacionValues();
				});
			  
			  /*******************************************/
			
			  $('#btn-comment').click(function() {
				  
				  	blockPage("#collapseSix");
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
				        		unBlockPage("#collapseSix");
				        		setTimeout(function(){
				        			window.location.reload();
				        		}, 1000); 
						    }					    	   
				    	    else{
				    	    	unBlockPage("#collapseSix");
				    	    	setTimeout(function(){
				        			bootbox.alert(data.message);	
				        		}, 1000);
				    	    }
	            		}
        			});

			  });
			   
			  	
				$("#repairForm").validate({				
					
					rules: 
					{								 
						 obra: { required: true },			
				 	     nroLicitacion: { required: true },		    			
				 	     nroExpediente: { required: true }
				 	}, 	 		
					
				 	messages: 
					{ 	 	  			 	     			
				 			obra: 
				  			{
				  			 		required: "El campo OBRA es requerido."			 	
				  		 	},	
				  		 	nroLicitacion: 
				  			{
				  			 		required: "El campo N&ordm de LICITACI&Oacute;N es requerido."			 	
				  		 	},	
				  		 	nroExpediente: 
				  			{
				  			 		required: "El campo N&ordm DE EXPEDIENTE es requerido."			 	
				  		 	}
				  	},
				  	
				  	highlight: function (element) { 
	 			       $(element).css({ "border-color": "red" });
	 			    },
		 	    	
	 			    unhighlight: function (element) { 
	 			        $(element).css("border-color", "#ccc"); 
	 			    },
	 			    errorPlacement: function(error, element) {},

	 			    submitHandler: function() {
						var $form = $("#repairForm");
						var formData = 'issueID='+ idIssue + '&userID='+ 'coripel' + '&repairForm='+ $form.serialize();
						$.ajax({
	        			    url: "./saveRepairInfo.html",
					 		type: "POST",	
					 		data: formData,				 								 
					        success: function(data){	
					        	if(data.result){
					        		$("#mdl-repair").modal('hide');
					        		window.location.reload();
					        	}
					        	else{
					        		$("#mdl-repair").modal('hide');
					        		bootbox.alert(data.message); 
					        	}
							}
						});
	  		  		}
				});

				
				$('#btn-update-repair').click(function(e) {	
				
					//var formData = 'issueID='+ idIssue + '&userID='+ 'coripel' + '&licitacion=' + $('#tbl-licitacion .editable').serialize() ;
					
					$('#tbl-licitacion .editable').editable('submit', {
					
					       url: './updateRepairInfo.html', 
					       ajaxOptions: {
					           dataType: 'json'
					       },  				       
					       success: function(data, config) {
					    	   if(data.result){		
					    		   bootbox.alert(data.message); 
					    		   window.location.reload();	
					    	   }						    	   
					    	   else{
					    		   bootbox.alert(data.message);		
					    	   }						    	
					       },
					       error: function (response) {
					           console.log(response);
					       }

					   });//editable 
					   
					
					return false; 
				});
				
				$('#btn-delete-repair').click(function(e) {		
					 bootbox.confirm("&iquest;Confirma que desea eliminar los datos?", function(result){
						  if(result){
							  var formData = 'issueID='+ idIssue + '&userID=' + 'coripel'; //CAMBIAR
								$.ajax({
			        			    url: "./deleteRepairInfo.html",
							 		type: "POST",	
							 		data: formData,				 								 
							        success: function(data){	
							        	if(data.result){
							        		window.location.reload();
							        	}
							        	else{
							        		bootbox.alert(data.message); 
							        	}
									}
								});
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
			    	var iconUnWatch = '<i class="icon-frown" id="icon-unwatch" style="color:#0088CC"></i>';
		        	var iconWatch = '<i class="icon-smile" id="icon-watch"></i>';		        	
		        	var numberOfWatchers = '${cantidadObservadores}';		        	
		        	var data = "issueID=" + idIssue;		        
		        	var loader = '<span class="loader"><img src="${pageContext.request.contextPath}/resources/images/loader.gif" style="margin-left:10px; alt="Loading"/></span>';	  
		        		        	
			        if(isWatching == 'true'){	
			        	$watchingLink.addClass('watching');
			        	$watchingLink.append(iconUnWatch);
// 			        	$(iconUnWatch).insertBefore($watchingLink);
// 			        	$watchingLink.text('Observando');
			        	$watchingLink.attr('title', 'Dejar de observar este reclamo');
			        	$watcherList.html(numberOfWatchers); 
			        }
			        
			        else {
			        	$watchingLink.addClass('unwatch');
// 			        	$(iconWatch).insertBefore($watchingLink);
			        	$watchingLink.append(iconWatch);
// 			        	$watchingLink.text('Observar');
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
										    	f += '<i class="icon-angle-right" style="margin-right: 5px;"></i>&nbsp;';
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
// 						 					$watchingLink.text('Observar');
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
				 			
				 			var reporter = '${usuario}';
				 			
				 			if(loggedUser == reporter){
				 				
				 				bootbox.alert("S&oacute;lo puede observar reclamos publicados por otros usuarios.");
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
	// 						 					$watchingLink.text('Observando');
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
				 		}
				});//watching click
				
				
			    var isVoted = '${isCurrentlyVoted}';
			    var isVoteUp = '${isVoteUp}';
			    
			    var $voteUp = $('.vote-up');
			    var $voteDown = $('.vote-down');
			    
			    var iconUp = '<i id="icon-up" class="icon-thumbs-up"></i>';
			    var iconDown = '<i id="icon-up" class="icon-thumbs-up"></i>';
			    
			    console.log(isVoted);
			    
			    if(isVoted == 'true'){
			    	if(isVoteUp == 'true'){
// 			    		$voteUp.addClass('btn btn-success');
// 				    	$voteDown.addClass('btn disabled');		
				    	$voteUp.addClass('voteActive');
				    	$voteDown.addClass('voteInactive');		
			    	}
			    	else{
// 			    		$voteDown.addClass('btn btn-success');
// 				    	$voteUp.addClass('btn disabled');	
			    		$voteUp.addClass('voteActive');
				    	$voteDown.addClass('voteInactive');		
			    	}
			    	
			    }
// 			    else{
// 			    	$voteUp.addClass('btn btn-info');
// 			    	$voteDown.addClass('btn btn-danger');
// 			    }
			    
			 
			    $('#votes a').click(function(e) {
			    	
			    	var thumb = $(this);
			    	
			    	if(thumb.hasClass('btn disabled'))
			    		e.preventDefault();
			    	
			    	else {
			    		
				    	var voteValue;
				    	var voteUp = false;
				    	
				    	if(thumb.hasClass('vote-up')){
				    		voteValue = 1;
					    	voteUp = true;
				    	}			    		
				    	else if(thumb.hasClass('vote-down'))
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
// 						        			$voteUp.removeClass('btn btn-info');
// 						 					$voteUp.addClass('btn btn-success');
// 					        				$voteDown.removeClass('btn btn-danger');
// 									    	$voteDown.addClass('btn disabled');	
									    	
									    	$voteUp.removeClass('voteInactive');
									    	$voteUp.addClass('voteActive');
									    	$voteDown.addClass('voteActive');		
									    	$voteDown.addClass('voteInactive');		
						        		}
						        		
						        		else{						        			
// 						        			$voteDown.removeClass('btn btn-danger');
// 						 					$voteDown.addClass('btn btn-success');	
// 					        				$voteUp.removeClass('btn btn-info');
// 									    	$voteUp.addClass('btn disabled');	
											$voteDown.removeClass('voteInactive');
						        			$voteDown.addClass('voteActive');
						        			$voteUp.removeClass('voteActive');
									    	$voteUp.addClass('voteInactive');
						        		}
						        		
						        		$('#voteCount').html(data.message); 
						        				
						        	}
						        	
						        	else{
						        		bootbox.alert(data.message);	
						        	}	
			            		}						  
		        			});
				    	
				    	}
			    		
			    	}
			    	
			    	
			    	
			    });
			    
 				$voteDown.click(function() {
			    	
			    });
			    
			
			  
			

		});
		
		
	
		</script>

	
	<div class="container-fluid">
	  	<div class="row-fluid">
	   
		    <div class="span9">
		      <!--Body content-->
		     
  	  <div id="issue-header" class="hero-unit" style="padding:20px; margin-bottom:15px">	  
        <h3 style="display:inline">
        	<a href="#" id="issue-title">${titulo}</a>&nbsp;<i class="icon-pencil editableField"></i>
        	&nbsp;&nbsp;
        	<i class="icon-chevron-right icon-large"></i>&nbsp;&nbsp;<span style="color:${tituloCss}">${estado}</span></h3>
        <p>${direccion}</p>       
      </div>
      
<!--      <hr> -->
      
      <div class="row" style="border: 0px solid #000; height: 40px; padding: 10px 0 10px 0; 
      				border-top: 1px solid #ccc; border-bottom: 1px solid #ccc; margin-bottom: 20px;">
      
      	<ul class="user-action-nav">
      		<li class="withText" title="Visitas"><span>${cantidadVisitas}</span><i class="icon-eye-open"></i></li>
      		<li class="withText" id="votes">
      			<div class="text" title="Votos"><span id="voteCount">${cantidadVotos}</span></div>
      			<div class="arrows">
      				<a href="#" class="vote-up" id="icon-up" title="Voto positivo"><i class="icon-caret-up "></i></a>
      				<a href="#" class="vote-down" id="icon-down" title="Voto negativo"><i class="icon-caret-down "></i></a>
      			</div>      			
      		</li>
      		<li class="withText">
      			<div id="watchers" style="display:inline-block">      			
				(<a href="#" id="view-watcher-list" data-toggle="popover"></a>)
				<a href="#" id="watching-toggle"></a>
				</div>
			</li>
      		<li class="withText" title="Comentarios"><span>${cantidadComentarios}</span><i class="icon-comments"></i></li>
      		<li>      			
      			<a id="bookmarkme" href="#" rel="sidebar" title="Agregar a Favoritos"><i class="icon-star"></i></a>
      		</li>
      		<li>
      			<a href="#" onclick="javascript:window.print();" title="Imprimir"><i class="icon-print"></i></a>
      		</li>
<!--       		<li> -->
<!--       			<a href="#" onclick="javascript:;" title="Denunciar reclamo"><i class="icon-flag"></i></a> -->
<!--       		</li> -->
      		<li>
	      		<a href="#" onclick="javascript:;" title="Compartir"><i class="icon-share"></i></a>
	      	</li>
      	</ul>
   
			<div id="userIssueActions" class="user-action-btns">						
				<sec:authorize access="hasRole('ROLE_USER')">
					<div class="btn-group" style="float:right;">
						<button id="btn-update" class="btn btn-info" title="Guardar cambios"><i class="icon-ok icon-large"></i></button>			
					</div>
					<div class="btn-group" style="float:right;margin-right:5px;">
						<button id="btn-edit" class="btn" title="Editar"><i class="icon-pencil icon-large"></i></button>			
					</div>	
					<c:if test="${estado eq 'ABIERTO' || estado eq 'REABIERTO'}">
						<div id="btn-status" data-toggle="modal" class="btn-group" style="float:right; ">			
							<button class="btn btn-success" title="Resolver"><i class="icon-wrench icon-large"></i></button>
						</div>
					</c:if>
					<c:if test="${estado eq 'RESUELTO' || estado eq 'CERRADO'}">
						<div id="btn-status" data-toggle="modal" class="btn-group" style="float:right;">			
							<button class="btn btn-warning" title="Reabrir"><i class="icon-rotate-right icon-large"></i></button>
						</div>
					</c:if>						
					<script type="text/javascript">
						userActionsController.enableUserActions();
					</script>										
				</sec:authorize>			
			</div>
			
	
	   </div>
	 
	  <div class="row">
	  
	 
	  <div class="row-fluid">
	   
		 <div class="span4">  

		 <ul class="thumbnails">
	  	   		<li style="margin-left:0">		
		    		<c:if test="${not empty image}">
		    			<a data-lightbox="issue-lightbox2" class="thumbnail" href="${imageUrl}">							  	  			  	   		
							<img src="${imageUrl}" alt="${imageName}">	 
						</a>		
		    		</c:if>
		    		<c:if test="${empty image}">
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
						    <th>&Uacute;ltima actualizaci&oacute;n:</th>
						    <td><a href="#" id="issue-last-update">${fechaUltimaActualizacion}</a></td>						   
						 </tr>
						  <tr>
						    <th>Informante:</th>
						    <td><script type="text/javascript">document.write( getUserURL('${usuario}') );</script></td>						    		    
						 </tr>
<!-- 						 <tr> -->
<!-- 						    <th>Responsable:</th> -->
<%-- 						    <td><a href="#" id="issue-area">${area}</a></td>						    --%>
<!-- 						 </tr> -->
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
						    <td><a class="taglink" href="./search.html?type=status&value=${estado}" id="issue-status" data-type="text"><span class="${estadoCss}">${estado}</span></a></td>						   
						 </tr>
						  <tr>
						    <th>Categor&iacute;as:</th>
						    <td>
       							<a id="issue-tags" href="#" data-type="select2">${tagsByIssue}</a>&nbsp;<i class="icon-pencil editableField"></i>
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
			       <h4><i class="icon-time icon-large"></i>HISTORIAL DE CAMBIOS (${cantidadRevisiones})</h4>
			      </a>
			    </div>
			    <div id="collapseThree" class="accordion-body collapse">
			      <div class="accordion-inner">			      	
			      	<table class="table table-hover" style="width:100%" id="tbl-issue-updates">
			      		<c:forEach items="${historial}" var="revision">					        
					    	<c:set var="count" value="${count + 1}" scope="page"/>	
					        <tr>
					        	<td style="border-top:none; width:5%"><c:out value="${count}" /></td>			
					          	<td style="border-top:none; ">${revision.fechaFormateada}</td>				    		
					    		<td style="border-top:none; ">
					    			<a href="#"><script type="text/javascript">document.write( getUserURL('${revision.username}') );</script></a>
					    		</td>
					    		<td style="border-top:none; width:35%; border: 0px solid red">${revision.detalle}</td>
					    		<td class="collapse-group" style="border-top:none; width:35%;" >					   
					    			<c:if test="${not empty revision.observaciones}">	
										<a class="btn-collapse" class="link" href="javascript:;">Ver detalle &raquo;</a>
										<p class="collapse" >${revision.observaciones}</p>
      								</c:if> 
      							</td>				    		
					    	</tr>					    
						 </c:forEach>
					</table>
			
			      </div>
			    </div>
			  </div>
			  
			  
			  <!-- 3 REPARACION --> <!-- FUERA DEL ALCANCE -->
<!-- 			  <div class="accordion-group"> -->
<!-- 			    <div class="accordion-heading"> -->
<!-- 			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo"> -->
<%-- 			        <h4><i class="icon-wrench icon-large"></i>REPARACI&Oacute;N (${estadoLicitacion})</h4> --%>
<!-- 			      </a>			      -->
<!-- 			    </div> -->
<!-- 			    <div id="collapseTwo" class="accordion-body collapse"> -->
<!-- 			      <div class="accordion-inner">	 -->
<%-- 					<c:if test="${cantidadLicitacion eq 0}"> --%>
<!-- 						No hay informaci&oacute;n disponible.	 -->
<!-- 						 <button id="btn-add-repair"  href="#mdl-repair" data-toggle="modal" class="btn btn-success">Agregar datos</button>	  -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${cantidadLicitacion ne 0}"> --%>
					
<%-- 					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')"> --%>
<!-- 						<div style="width: 200px; float: right; margin: 20px 10px 20px 0;"> -->
<!-- 							<button id="btn-delete-repair" class="btn" title="Eliminar"><i class="icon-trash icon-large"></i></button>	 -->
<!-- 							<button id="btn-edit-repair" class="btn" title="Editar"><i class="icon-pencil icon-large"></i></button>	 -->
<!-- 							<button id="btn-update-repair" class="btn" title="Guardar"><i class="icon-ok icon-large"></i></button>						 -->
<!-- 						</div>					 -->
<%-- 					</sec:authorize> --%>
											
<!-- 						<table id="tbl-licitacion" class="table table-hover ">							 -->
<!-- 							 <tr> -->
<!-- 							    <th>Obra:</th> -->
<%-- 							    <td><a href="#" id="lic-obra" data-type="textarea">${obra}</a></td>						   --%>
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							    <th>N&ordm de Licitaci&oacute;n:</th> -->
<%-- 							    <td><a href="#" id="lic-nroLicitacion" data-type="text">${nroLicitacion}</a>						   --%>
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							    <th>N&ordm de Expediente:</th> -->
<%-- 							    <td><a href="#" id="lic-nroExpediente" data-type="text">${nroExpediente}</a></td>						   --%>
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							    <th>Estado de la obra:</th> -->
<%-- 							    <td><a href="#" id="lic-estadoObra" data-type="select">${estadoObra}</a></td>						   --%>
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							    <th>Tipo:</th> -->
<%-- 							    <td><a href="#" id="lic-tipo" data-type="select" >${tipoObra}</a></td>						   --%>
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							 	<th>Unidad ejecutora:</th> -->
<%-- 							    <td><a href="#" id="lic-unidadEjecutora" data-type="text">${unidadEjecutora}</a></td> --%>
<!-- 							 </tr>	 -->
<!-- 							 <tr>	 -->
<!-- 							    <th>Unidad de financiaci&oacute;n:</th> -->
<%-- 							    <td><a href="#" id="lic-unidadFinanciamiento" data-type="text">${unidadFinanciamiento}</a></td>		 --%>
<!-- 							 </tr> -->
<!-- 							 <tr>	 -->
<!-- 							    <th>Valor del pliego:</th> -->
<%-- 							    <td>$ <a href="#" id="lic-valorPliego" data-type="number">${valorPliego}</a></td>		 --%>
<!-- 							 </tr>						 <tr> -->
<!-- 							    <th>Empresa contratada:</th> -->
<!-- 							  	<td> -->
<%-- 							    	Raz&oacute;n social: <a href="#" id="lic-empresaNombre" data-type="text">${empresaNombre}</a> --%>
<%-- 							    	<br>CUIT: <a href="#" id="lic-empresaCuit" data-type="text">${empresaCuit}</a>	 --%>
<!-- 							    </td> -->
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							    <th>Representante t&eacute;cnico:</th> -->
<!-- 							      <td> -->
<%-- 							    	Nombre y Apellido: <a href="#" id="lic-representanteNombre" data-type="text">${representanteNombre}</a> --%>
<%-- 							    	<br>DNI: <a href="#" id="lic-representanteDni" data-type="number">${representanteDni}</a> --%>
<!-- 							      </td>								   						   -->
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							    <th>Presupuesto adjudicado:</th> -->
<!-- 							    <td> -->
<%-- 							    	$ <a href="#" id="lic-presupuestoAdjudicado" data-type="number">${presupuestoAdjudicado}</a> --%>
<!-- 							    </td> -->
<!-- 							 </tr> -->
<!-- 							 <tr>	 -->
<!-- 							    <th>Presupuesto final:</th> -->
<!-- 							    <td> -->
<%-- 							    	$ <a href="#" id="lic-presupuestoFinal" data-type="number">${presupuestoFinal}</a> --%>
<!-- 							    </td>					   -->
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							    <th>Fechas estimadas:</th> -->
<!-- 							    <td> -->
<%-- 							    	<a href="#" id="lic-fechaEstimadaInicio" data-type="combodate">${fechaEstimadaInicio}</a> --%>
<!-- 													&mdash; -->
<%-- 													<a href="#" id="lic-fechaEstimadaFin" data-type="combodate">${fechaEstimadaFinal}</a> --%>
<!-- 							    </td>	 -->
<!-- 							 </tr> -->
<!-- 							 <tr> -->
<!-- 							    <th>Fechas reales:</th> -->
<!-- 							    <td> -->
<%-- 							    	<a href="#" id="lic-fechaRealInicio" data-type="combodate">${fechaRealInicio}</a>	 --%>
<!-- 													&mdash; -->
<%-- 									<a href="#" id="lic-fechaRealFin" data-type="combodate">${fechaRealFinal}</a>	 --%>
<!-- 							    </td>					   -->
<!-- 							 </tr> -->
<!-- 				  		</table>	 -->
<%-- 					</c:if> --%>
<!-- 					</div> -->
<!-- 			    </div> -->
<!-- 			  </div>		 -->
			  <!-- 3 REPARACION --> <!-- FUERA DEL ALCANCE -->	  
			  
		
			  <!-- 4 RECLAMOS SIMILARES -->
<!-- 			  <div class="accordion-group"> -->
<!-- 			    <div class="accordion-heading"> -->
<!-- 			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseFour"> -->
<%-- 			        <h4><i class="icon-pushpin icon-large"></i>RECLAMOS SIMILARES (${cantidadReclamosSimilares})</h4> --%>
<!-- 			      </a> -->
<!-- 			    </div> -->
<!-- 			    <div id="collapseFour" class="accordion-body collapse"> -->
<!-- 			      <div class="accordion-inner"> -->
<!-- 			       	<div class="row-fluid"> -->
<!-- 			            <ul class="thumbnails"> -->
<!-- 			              <li class="span3"> -->
<!-- 			                <div class="thumbnail"> -->
<%-- 			                  <img style="width: 200px; height: 150px;" src="${pageContext.request.contextPath}/resources/images/nopicsmall.png" alt=""> --%>
<!-- 			                  <div class="caption"> -->
<!-- 			                  	<h5>Thumbnail label</h5>		                    -->
<!-- 			                  </div> -->
<!-- 			                </div> -->
<!-- 			              </li> -->
<!-- 			              <li class="span3"> -->
<!-- 			                <div class="thumbnail"> -->
<%-- 			                  <img style="width: 200px; height: 150px;" src="${pageContext.request.contextPath}/resources/images/nopicsmall.png" alt=""> --%>
<!-- 			                  <div class="caption"> -->
<!-- 			                     <h5>Thumbnail label</h5>		                    -->
<!-- 			                  </div> -->
<!-- 			                </div> -->
<!-- 			              </li> -->
<!-- 			              <li class="span3"> -->
<!-- 			                <div class="thumbnail"> -->
<%-- 			                 <img style="width: 200px; height: 150px;" src="${pageContext.request.contextPath}/resources/images/nopicsmall.png" alt=""> --%>
<!-- 			                  <div class="caption"> -->
<!-- 			                      <h5>Thumbnail label</h5>		                   -->
<!-- 			                  </div> -->
<!-- 			                </div> -->
<!-- 			              </li> -->
<!-- 			            </ul> -->
<!-- 		        	</div>		   	 -->
<!-- 			      </div> -->
<!-- 			    </div> -->
<!-- 			  </div> -->
			  			  
			  <!-- 5 IMAGES & VIDEOS -->
			  <div class="accordion-group">
			    <div class="accordion-heading">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseFive">
			       <h4><i class="icon-picture icon-large"></i>IM&Aacute;GENES (<span class="cantidadContenidos">${cantidadContenidos}</span>)</h4>			        
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
			       <h4><i class="icon-comments icon-large"></i>COMENTARIOS (${cantidadComentarios})</h4>
			      </a>
			    </div>
			    <div id="collapseSix" class="accordion-body collapse">
			      <div class="accordion-inner">
			      			     
			    <!-- EDITOR BOX-->   
			    <div style=" width:660px;margin:20px 0;">			   
		                <textarea class="span9" id="comment-text" name="comment-text"
		                	placeholder="Ingrese su comentario" rows="5"></textarea>
		           
		               	<button id="btn-comment" type="submit" style="float:right;margin-top:15px;margin-bottom:15px;" class="btn btn-info">Publicar</button>	
		        
						<div id="content-comment">
							<table id="tblComments" class="table table-hover">				        
							   <c:forEach items="${comentarios}" var="comentario" varStatus="i" begin="0" end="2">	
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
						 </div>
						 <div id="page-selection"></div>		
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
	
	
	<div id="mdl-status" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-header">
		    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>		    	
		    	<h4 id="fileUploadLabel"> 
			    	Actualizar estado
		    	</h4>
	  	</div>
	  	<form id="modalStatusForm" enctype="multipart/form-data"  class="form-horizontal form-inline">
  				<div class="modal-body">
  				
  				<div class="control-group">  			
        			<label class="control-label">Resoluci&oacute;n</label>
        			<div class="controls">
           				<select id="tipoResolucion" name="tipoResolucion"></select>		
        			</div>
    			</div>    			
			    <div class="control-group">
			        <label class="control-label" for="observacion">Comentario</label>
			        <div class="controls">
			        	<textarea id="observacion"  class="form-control"  name="observacion" style="width:280px; height: 100px" required></textarea>
			        </div>
			    </div>
  				
  				</div>
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
	
	
	<div id="mdl-repair" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="fileUploadLabel" aria-hidden="true">
	  	<form id="repairForm">
	  	<div class="modal-header">
		    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		    	
		    	<h4 id="fileUploadLabel"> 
			    	Reparaci&oacute;n de la incidencia
		    	</h4>
	  	</div>
	  	
	  		<div class="modal-body">
	  		
	  		<table id="tbl-repair">
	  			<tr>
	  				<td colspan="2">				    
		    	   		<textarea id="obra" name="obra" placeholder="Descripci&oacute;n de la obra..."></textarea>	
					</td>
					<td>	    	   		
						<label>Tipo</label>
	    	   			<select id="tipoObra" name="tipoObra">		
	    	   				<option value="Publica">Publica</option>
	    	   				<option value="Privada">Privada</option>
	    	   				<option value="Contratacion directa">Contratacion directa</option>	    	   	
				 		</select>	
				 		<label>Estado</label>	
				 		<select id="estadoObra" name="estadoObra">		
	    	   				<option value="Sin iniciar">Sin iniciar</option>
	    	   				<option value="En Curso">En curso</option>
	    	   				<option value="Interrumpida">Interrumpida</option>
	    	   				<option value="Finalizada">Finalizada</option>
	    	   				<option value="Cancelada">Cancelada</option>
				 		</select>		
				 	</td>					
	  			</tr>	  			
	  			<tr>	  				
	  				<td>	  					
	  					<input type="text" id="nroLicitacion" name="nroLicitacion" placeholder="N&ordm de Licitaci&oacute;n"/>		 
				 		<input type="text" id="nroExpediente" name="nroExpediente" placeholder="N&ordm de de Expediente"/>				    	   		
					</td>					
					<td>
						<input type="text" id="unidadEjecutora" name="unidadEjecutora" placeholder="Unidad ejecutora"/>	
		    	   		<input type="text" id="unidadFinanciamiento" name="unidadFinanciamiento" placeholder="Unidad de financiamiento"/>		    	   	
		    	   	
				 	</td>
				 	<td>
				 		<input type="text" id="valorPliego" name="valorPliego" placeholder="Valor del pliego (en $ argentinos)"/>			 	
				 	</td>		
	  			</tr>
	  			<tr><td colspan="3"><hr></td></tr>
	  			
	  			<tr>
	  				<td>
	  					<label>Empresa contratada</label>
	  					<input type="text" id="empresaNombre" name="empresaNombre" placeholder="Raz&oacute;n social"/>	
	  					<input type="text" id="empresaCuit" name="empresaCuit" placeholder="CUIT"/>	
	  				</td>
	  				<td>
	  					<label>Representante t&eacute;cnico</label>
	  					<input type="text" id="representanteNombre" name="representanteNombre" placeholder="Nombre(s) y Apellido(s)"/>	
	  					<input type="text" id="representanteDni" name="representanteDni" placeholder="DNI"/>	
	  				</td>
	  				<td>
					</td>
	  			</tr>
	  				
	  			<tr><td colspan="3"><hr></td></tr>
	  			<tr>
	  				<td>
				    	<label>Estimaci&oacute;n</label>
		    	   		<input type="text" id="presupuestoAdjudicado" name="presupuestoAdjudicado" placeholder="Presupuesto adjudicado (en $ argentinos)"/>		
 		    	   		
 		    	   		<div id="fecha-estimada-from" class="input-append">											   
						    <input id="fechaEstimadaInicio" name="fechaEstimadaInicio" type="text" class="repairDate" placeholder="Fecha inicio (dd/mm/aaaa)"/>
						    <span class="add-on">
						      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
						      </i>
						    </span>
						</div>  	
						
						<div id="fecha-estimada-to" class="input-append">											   
						    <input id="fechaEstimadaFin" name="fechaEstimadaFin" type="text" class="repairDate" placeholder="Fecha fin (dd/mm/aaaa)"/>
						    <span class="add-on">
						      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
						      </i>
						    </span>
						</div>  		
 				    	   	    
					</td>	
					<td>
				    	<label>Ejecuci&oacute;n</label>
		    	   		<input type="text" id="presupuestoFinal" name="presupuestoFinal" placeholder="Presupuesto final (en $ argentinos)"/>	
		    	   		
		    	   		<div id="fecha-real-from" class="input-append">											   
						    <input id="fechaRealInicio" name="fechaRealInicio" type="text" class="repairDate" placeholder="Fecha inicio (dd/mm/aaaa)"/>
						    <span class="add-on">
						      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
						      </i>
						    </span>
						</div>  							
						<div id="fecha-real-to" class="input-append">											   
						    <input id="fechaRealFin" name="fechaRealFin" type="text" class="repairDate" placeholder="Fecha fin (dd/mm/aaaa)"/>
						    <span class="add-on">
						      <i data-time-icon="icon-time" data-date-icon="icon-calendar">
						      </i>
						    </span>
						</div>  		  	   	 
					</td>	
					<td>
						 <input type="text" id="plazoEjecucionEnDias" name="plazoEjecucionEnDias" placeholder="Plazo (en d&iacute;as)"/>	
		    	   				
					</td>								
	  			</tr>		
	  				
	  		
	  		</table>
	    	
								
			</div>
		  	<div class="modal-footer"> 	
		  		<div class="btn-container">
			  		<button  type="submit" class="btn btn-info" id="btn-save-repair">
				    	<i class="icon-ok icon-large"></i>Guardar
				    </button>  			  	
			  		<button class="btn" data-dismiss="modal" aria-hidden="true">
				    	<i class="icon-remove icon-large"></i>Cerrar
				    </button>	
		  		</div>
		  		 
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
