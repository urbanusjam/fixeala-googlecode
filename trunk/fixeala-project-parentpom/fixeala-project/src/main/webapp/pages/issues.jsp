<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Boolean isUser -->
<!-- needed for creating the boolean: !isUser -->
<c:set var="isUser" value="false" />
<sec:authorize access="hasRole('ROLE_USER')">
    <c:set var="isUser" value="true" />
</sec:authorize>


<div id="content">	


		<!-- Issue -->
		<script type="text/javascript">
		
		
		//--NON-EDITABLE FIELDS
		
// 			var id = '${id}';
//    		var usuario = '${usuario}';   	
//    		var fecha = '${fecha}';
//    		var calle = '${direccion}';
//    		var barrio = '${barrio}';
//    		var ciudad = '${ciudad}';
//    		var provincia = '${provincia}';
//    		var latitud = '${latitud}';
//    		var longitud = '${longitud}';
//    		var estado = '${estado}';
   		
		</script>
		
		<script type="text/javascript">
		
	
		$(function(){	
			
			var id = '${id}';
			var newTitle;
			
			$('#btn-update').attr('disabled', true);
			
			//default config
			$.fn.editable.defaults.mode = 'popup';	
			$.fn.editable.defaults.disabled = true;
			
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
// 		       $('#issue-tags').editable('toggleDisabled');

			   if(!${isUser})
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
					        return 'La longitud m√°xima del campo es de 50 caracteres.';
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
					        return 'La longitud m√°xima del campo es de 600 caracteres.';
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
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
					    if($.trim(value).length > 50) {
					        return 'La longitud m√°xima del campo es de 50 caracteres.';
					    }
					}
			  });
			  
// 			  $('#issue-tags').editable({
// 				  	pk: 4,  
// 				  	mode: 'popup',	
// 				  	name: 'tags',
// 					placement: 'right',
// 					emptytext:'VacÌo',
// 			        inputclass: 'input-large',
// 			        select2: {
// 			        	tags: ['alumbrado', 'asfalto', 'bache', 'pozo'],
// 			            tokenSeparators: [",", " "]
// 			        },
// 					ajaxOptions: {
// 					    type: 'put'
// 					}  
// 			    }); 
			  
			  
			  
			  
			//---- CAMPOS LICITACION
			 
			
			  $("#lic-obra").editable({	
				  pk: 5,  
				  name: 'obra',
				  emptytext:'VacÌo',
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
// 					        return 'La longitud m√°xima del campo es de 600 caracteres.';
// 					    }
// 				  }
			  });
			  
			  $("#lic-nroLicitacion").editable({
				  pk: 6,  
				  name: 'nroLicitacion',
				  emptytext:'VacÌo',
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
				  emptytext:'VacÌo',
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
						{value: 'P˙blica', text: 'P˙blica'},
			            {value: 'Privada', text: 'Privada'},
			            {value: 'ContrataciÛn directa', text: 'ContrataciÛn directa'}
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
				  emptytext:'VacÌo',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-unidadFinanciamiento").editable({				
				  name: 'unidadFinanciamiento',
				  emptytext:'VacÌo',
				  ajaxOptions: {
				        type: 'put'
				  }		 
			  });
			  
			  $("#lic-empresaNombre").editable({	
				  name: 'empresaNombre',
				  emptytext:'VacÌo',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-empresaCuit").editable({		
				  name: 'empresaCuit',
				  emptytext:'VacÌo',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-empresaEmail").editable({	
				  name: 'empresaEmail',
				  emptytext:'VacÌo',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-representanteNombre").editable({			
				  name: 'representanteNombre',
				  emptytext:'VacÌo',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-representanteDni").editable({			
				  name: 'representanteDni',
				  emptytext:'VacÌo',
				  ajaxOptions: {
				        type: 'put'
				  }
			  });
			  
			  $("#lic-representanteEmail").editable({		
				  name: 'representanteEmail',
				  emptytext:'VacÌo',
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
				  emptytext:'VacÌo',
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
				  emptytext:'VacÌo',
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
				  emptytext:'VacÌo',
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
				  emptytext:'VacÌo',
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
			  
			
			  $('#btn-update').click(function() {
				  
				  bootbox.confirm("øDesea confirmar los cambios?", function(result){
					  
					  if(result){
						  
						  $('.editable').editable('submit', { 					   
							   
						       url: './updateIssue.html', 
						       ajaxOptions: {
						           dataType: 'json' //assuming json response		
						       },  						      
						       success: function(data, config) {
						    	
						    	   if(data.result){						    		   

						    		   bootbox.alert(data.message); 
						    			setTimeout(function () {	
						    				var url = getIssueURL(id, newTitle, 'plain');
							    			window.location.href= url;	
						    			}, 500);						    			

						    	   }
						    	   
						    	   else{
						    		   bootbox.alert(data.message);		
						    	   }
						    	
						       },
						       error: function(errors) {
						           var msg = '';
						           if(errors && errors.responseText) { //ajax error, errors = xhr object
						               msg = errors.responseText;
						           } else { //validation error (client-side or server-side)
						               $.each(errors, function(k, v) { msg += k+": "+v+"<br>"; });
						           } 
						           $('#msg').removeClass('alert-success').addClass('alert-error').html(msg).show();
						       }
						   });//editable
						  
					  }
			
					   
				  });//bootbox   
				});
			  
			  
			  
			  
			  
			//ajax mocks
			    $.mockjaxSettings.responseTime = 500; 
			    
			    $.mockjax({
			        url: '/post',
			        response: function(settings) {
			            log(settings, this);
			        }
			    });


		});
		
		</script>
		
		
		<div class="row-fluid">
		
		  <div class="span9">
				<div class="input-append">	
				
		       		<input type="search" id="search" placeholder="Buscar reclamos o usuarios..." />
			        <button id="btnSearch" class='btn add-on' style="width:70px;">
			            <i class="icon-search"></i>
			        </button>
			        
			        <button id="btnAdvancedSearch" class='btn add-on'>
			            <i class="icon-angle-down"></i>
			        </button>  
				</div>
			</div>
		
			<div class="span3">	
				<button id="btnIssue" class="btn btn-warning"> 
					<i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;&nbsp;NUEVO RECLAMO
				</button>
			</div>
		
		</div>		
		
	
	
	<div class="container-fluid">
	  	<div class="row-fluid">
	   
		    <div class="span9">
		      <!--Body content-->
		     
  	  <div class="hero-unit" style="padding:20px; margin-bottom:15px">	  
        <h3 style="display:inline">
        	<a href="#" id="issue-title">${titulo}</a>
        	&nbsp;&nbsp;
        	<i class="icon-chevron-right icon-large"></i>&nbsp;&nbsp;<span style="color:red">${estado}</span></h3>
        <p>${direccion}</p>       
      </div>
      
    
      
      <div class="row">
      
	      <div id="btnGroupActions" class="btn-group" data-toggle="buttons-checkbox">
			  <button type="button" class="btn" title="Votos">3<i class="icon-thumbs-up-alt icon-large"></i></button>
			  <button type="button" class="btn" title="Seguidores">1<i class="icon-eye-open icon-large"></i></button>
			  <button type="button" class="btn" title="Comentarios">0<i class="icon-comment icon-large"></i></button>
			  
			  <button type="button" class="btn" title="Agregar a favoritos"><i class="icon-star icon-large"></i></button>		
			  <button type="button" class="btn" title="Imprimir"><i class="icon-print icon-large"></i></button>
			  <button type="button" class="btn" title="Denunciar"><i class="icon-warning-sign icon-large"></i></button>
		  </div>
		  		  		
	 	  <div id="btnGroupSocial" class="btn-group">
	 			<button class="btn"><i class="icon-share icon-large"></i>&nbsp;&nbsp;Compartir</button>
	 			<button class="btn dropdown-toggle" data-toggle="dropdown">
	   			<span class="caret"></span>
	 			</button>	  	
	 			<ul class="dropdown-menu">
		    	<li><a href="#" title=""><i class="icon-envelope-alt icon-large"></i>&nbsp;&nbsp;&nbsp;Email</a></li>
		    	<li><a href="#" title=""><i class="icon-facebook-sign icon-large"></i>&nbsp;&nbsp;&nbsp;Facebook</a></li>
		    	<li><a href="#" title=""><i class="icon-google-plus icon-large"></i>&nbsp;&nbsp;&nbsp;Google+</a></li>
		    	<li><a href="#" title=""><i class="icon-twitter icon-large"></i>&nbsp;&nbsp;&nbsp;Twitter</a></li>
	 			</ul>
		   </div>

<!-- 			<div class="btn-group" style="float:right;">			 -->
<!-- 				<button class="btn btn-success"><i class="icon-ok icon-large"></i>&nbsp;&nbsp;&nbsp;Resolver</button> -->
<!-- 			</div> -->
 
			<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN', 'ROLE_MANAGER')">


			<div class="btn-group" style="float:right;">
				<button id="btn-update"  class="btn btn-success"><i class="icon-save icon-large"></i>&nbsp;&nbsp;&nbsp;Guardar</button>			
			</div>
			<div class="btn-group" style="float:right;">
				<button id="btn-edit" class="btn btn-info"><i class="icon-pencil icon-large"></i>&nbsp;&nbsp;&nbsp;Editar</button>			
			</div>			
			
			</sec:authorize>
	
	   </div>
	   
	   <hr>
	 
	  <div class="row">
	  
	 
	  <div class="row-fluid">
	   
		 <div class="span4">  
	   
		   <ul class="thumbnails">
	  	   		<li  style="margin-left:0">
	    			<a href="#" class="thumbnail">
	      				<img src="${pageContext.request.contextPath}/resources/images/nopic.png" alt="">	    
	    			</a>
	    				<br>
	    			<div class="caption"><button class="btn btn-info"><i class="icon-camera"></i>&nbsp;&nbsp;&nbsp;m√°s fotos y videos</button>	</div>
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
						    <th>Direcci√≥n:</th>
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
						    <td><a href="#">minAyEBA</a></td>						   
						 </tr>
						  <tr>
						    <th>Descripci√≥n:</th>
						    <td><a href="#" id="issue-desc">${descripcion}</a></td>						   
						 </tr>
						 <tr>
						    <th>Estado:</th>
						    <td><a href="#" id="issue-status" data-type="text">${estado}</a></td>						   
						 </tr>
						  <tr>
						    <th>Etiquetas:</th>
						    <td>
<%-- 						    	<a href="#" id="issue-tags" data-type="select2" class="select2-container select2-container-multi select2">${tags}</a> --%>
						    </td>						   
						 </tr>
					</table>	 	
	 	</div>
	 	
	 	
	 	
	 	 </div><!-- fluid -->
	 	 	
	 
      </div>
     
		
		<div class="accordion" id="accordion2">
 

			  <!-- 2 HISTORIAL -->
			  <div class="accordion-group">
			    <div class="accordion-heading">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
			       <h4><i class="icon-time icon-large"></i>&nbsp;&nbsp;HISTORIAL Y SEGUIMIENTO (${cantidadRevisiones})</h4>
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
			  
			  
			  <!-- 3 LICITACIO¬ìN -->
			  <div class="accordion-group">
			    <div class="accordion-heading">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
			        <h4><i class="icon-wrench icon-large"></i>&nbsp;&nbsp;LICITACI”N (${cantidadLicitacion})</h4>
			      </a>			     
			    </div>
			    <div id="collapseTwo" class="accordion-body collapse">
			      <div class="accordion-inner">
			      
			      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sollicitudin rutrum lectus. 
			      Ut laoreet lorem dignissim ante tristique cursus. Phasellus ut ipsum malesuada neque tempor iaculis. 
			      Vestibulum pharetra tellus vitae tristique dapibus. Proin sed tortor rutrum, vulputate dui faucibus, sagittis justo. 
			      Sed varius non diam a placerat. Fusce vitae velit ac metus tincidunt vehicula. 
			      In tortor mauris, congue nec luctus vitae, suscipit in metus.
			      
			      <br><br>
			      
<!-- 			      <button id="reset-btn" class="btn btn-large btn-danger" style="margin-left:595px">Resetear valores</button> -->
							
					<table id="tbl-licitacion" class="table table-hover table-bordered table-striped">	
					
						 <tr>
						    <th>Obra:</th>
						    <td><a href="#" id="lic-obra" data-type="textarea">${obra}</a></td>						  
						 </tr>
						 <tr>
						    <th>N∞ de LicitaciÛn:</th>
						    <td><a href="#" id="lic-nroLicitacion" data-type="text">${nroLicitacion}</a>						  
						 </tr>
						 <tr>
						    <th>N∞ de Expediente:</th>
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
						    <th>Unidad de financiaciÛn:</th>
						    <td><a href="#" id="lic-unidadFinanciamiento" data-type="text">${unidadFinanciamiento}</a></td>		
						 </tr>
						 <tr>	
						    <th>Valor del pliego:</th>
						    <td>$ <a href="#" id="lic-valorPliego" data-type="number">${valorPliego}</a></td>		
						 </tr>						 <tr>
						    <th>Empresa constructora:</th>
						  	<td>
						    	RazÛn social: <a href="#" id="lic-empresaNombre" data-type="text">${empresaNombre}</a>
						    	<br>CUIT: <a href="#" id="lic-empresaCuit" data-type="text">${empresaCuit}</a>	
						    	<br>Email: <a href="#" id="lic-empresaEmail" data-type="email">${empresaEmail}</a>
						    </td>
						 </tr>
						 <tr>
						    <th>Representante tÈcnico:</th>
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
			       <h4><i class="icon-camera icon-large"></i>&nbsp;&nbsp;IM√ÅGENES Y VIDEOS (${cantidadArchivos})</h4>			   
			      </a>
			    </div>
			    <div id="collapseFive" class="accordion-body collapse">
			      <div class="accordion-inner">
			        Anim pariatur cliche...
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
			    	<div id="commentTextEditor" contenteditable="true"></div>
			   		<button style="float:right;margin-top:15px;margin-bottom:15px;" class="btn btn-primary">Comentar</button>			
			
							
				<table id="tblComments" class="table table-hover">
					<tr>
						<td>
							<div class="media">
								  <a class="pull-left thumbnail" href="#">
								    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
								  </a>
						 		 <div class="media-body">				    	
							    	<a href="#">jorgeW</a> | 12/05/13
							    	<p>Donec ante lectus, pharetra vel enim nec, egestas adipiscing eros. 
							    	Quisque suscipit lorem ac ipsum posuere, vitae interdum libero pellentesque. 
							    	Fusce faucibus dolor felis, in malesuada mauris dignissim vitae. 
							    	Pellentesque quis purus ullamcorper, vestibulum elit sit amet, ullamcorper risus. </p>	 
						  		</div>
							</div>						
						</td>
					</tr>
					<tr>
						<td>
							<div class="media">
								  <a class="pull-left thumbnail" href="#">
								    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
								  </a>
						 		 <div class="media-body">				    	
							    	<a href="#">002_albert</a> | 11/05/13
							    	<p>Donec ante lectus, pharetra vel enim nec, egestas adipiscing eros. 
							    	Quisque suscipit lorem ac ipsum posuere, vitae interdum libero pellentesque. 
							    	Fusce faucibus dolor felis, in malesuada mauris dignissim vitae. 
							    	Pellentesque quis purus ullamcorper, vestibulum elit sit amet, ullamcorper risus. </p>	 
						  		</div>
							</div>						
						</td>
					</tr>
				</table>
				
				<div class="pagination pagination-centered">
				  <ul>
				    <li><a href="#">¬´ Anterior</a></li>
				    <li><a href="#">1</a></li>
				    <li><a href="#">2</a></li>
				    <li><a href="#">3</a></li>
				    <li><a href="#">4</a></li>
				    <li><a href="#">5</a></li>
				    <li><a href="#">Siguiente ¬ª</a></li>
				  </ul>
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
				<tr>
					<td style="border-top:none">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">Sem√°foro no anda</h5></a>				    
						    <p style="font-size:11px">Reportado por: <a href="#">juan2013</a></p>
						     <span class="label label-warning">Abierto</span>
						  </div>
						</div>
					</td>				
				</tr>
				<tr>
					<td style="border-top:1px dashed #dddddd">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>
						  	<div class="media-body">
						    	<a href="#"><h5 class="media-heading">Hay basura tirada...</h5></a>			 
						    	<p style="font-size:11px">Reportado por: <a href="#">el_user_22</a></p>
						    	<span class="label label-important">Pendiente</span>
						  	</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="border-top:1px dashed #dddddd">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>
						  	<div class="media-body">
						    	<a href="#"><h5 class="media-heading">El alumbrado no...</h5></a>				    
						    	<p style="font-size:11px">Reportado por: <a href="#">MeitanteiConan</a></p>
						    	<span class="label label-important">Pendiente</span>
						  	</div>
						</div>
					</td>
				</tr>
			</table>		
		</div>
		  		
  		</div><!-- ROW FLUID -->
	</div><!-- CONTAINER FLUID -->
	
	
	
		
	
</div><!-- CONTENT -->