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

			resetLicitacionValues();
			
			//toggle `popup` / `inline` mode
			$.fn.editable.defaults.mode = 'popup';	
			
			//modify buttons style
			$.fn.editableform.buttons = 
			  '<button type="submit" class="btn btn-warning editable-submit"><i class="icon-ok icon-white"></i></button>' +
			  '<button type="button" class="btn editable-cancel"><i class="icon-remove"></i></button>';        
			
			  //enable / disable
// 			   $('#btn-edit').click(function() {
// 			       $('#tbl-issue .editable').editable('toggleDisabled');
// 			   }); 
			 
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
				  url: '/post',   
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
				  rows: 5,
				  url: '/post', 			  
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
			  
			  $('#issue-tags').editable({
				  	pk: 3,  
				  	mode: 'popup',	
					placement: 'right',
			        inputclass: 'input-large',
			        select2: {
			        	tags: ['alumbrado', 'asfalto', 'bache', 'pozo'],
			            tokenSeparators: [",", " "]
			        },
			        url: '/post',  				
					ajaxOptions: {
					    type: 'put'
					}  
			    }); 
			  
			  $("#issue-barrio").editable({
				  pk: 4,  
				  name: 'neighborhood', 	
				  mode: 'popup',	
				  placement: 'right',
				  url: '/post',   
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
			  
			  
			//---- CAMPOS LICITACION
			 
			
			  $("#obra").editable({	
				  placement:'right',
				  name: 'obra',
				  inputclass: 'licitacion-textarea',
				  validate: function(value) {
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
					    if($.trim(value).length > 600) {
					        return 'La longitud m√°xima del campo es de 600 caracteres.';
					    }
				  }
			  });
			  
			  $("#nroLicitacion").editable({
				
				  name: 'nroLicitacion',
				  url: '/post',
				  validate: function(value) {
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
				  }
			  });
			  
			  $("#nroExpediente").editable({	
				 
				  name: 'nroExpediente',
				  url: '/post',
				  validate: function(value) {
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
				  }
			  });
			  
			  $("#valorPliego").editable({	
				  name: 'valorPliego',
				  url: '/post',
				  validate: function(value) {
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
				  }
			  });
			  
			  $("#unidadEjecutora").editable({
				  name: 'unidadEjecutora',
				  url: '/post'			 
			  });
			  
			  $("#unidadFinanciamiento").editable({				
				  name: 'unidadFinanciamiento',
				  url: '/post'			 
			  });
			  
			  $("#empresaNombre").editable({	
				  name: 'empresaNombre',
				  url: '/post'			 
			  });
			  
			  $("#empresaCuit").editable({		
				  name: 'empresaCuit',
				  url: '/post'			 
			  });
			  
			  $("#empresaEmail").editable({	
				  name: 'empresaEmail',
				  url: '/post'			 
			  });
			  
			  $("#representanteNombre").editable({			
				  name: 'representanteNombre',
				  url: '/post'			 
			  });
			  
			  $("#representanteTel").editable({			
				  name: 'representanteTel',
				  url: '/post'			 
			  });
			  
			  $("#representanteEmail").editable({		
				  name: 'representanteEmail',
				  url: '/post'			 
			  });
			 
			  
			  $("#presupuestoAdjudicado").editable({	
				  name: 'presupuestoAdjudicado',
				  url: '/post'			 
			  });
			  
			  $("#presupuestoFinal").editable({	
				  name: 'presupuestoFinal',
				  url: '/post'			 
			  });
			  
			  $('#tipo').editable({
				  name: 'tipo',
				  value: 1,
			      source: [
						{value: 1, text: 'Indefinido'},
			            {value: 2, text: 'P˙blica'},
			            {value: 3, text: 'Privada'},
			            {value: 4, text: 'ContrataciÛn directa'}
			        ]
			    });    
			  
			  $('#estadoObra').editable({
				  name: 'estadoObra',
				  value: 1,
			      source: [
					    {value: 1, text: 'Sin iniciar'},
			            {value: 2, text: 'En curso'},
			            {value: 3, text: 'Interrumpida'},
			            {value: 4, text: 'Finalizada'}
			        ]
			  });  
			  
// 			  $('#fechaEstimadaInicio').editable({
// 				  name:'fechaEstimadaInicio',
// 				  mode: 'popup',
// 				  placement: 'top',
// 				  format: 'DD-MM-YYYY',    
// 			      viewformat: 'DD/MM/YYYY',    
// 			      template: 'D / MMMM / YYYY',    
// 			      combodate: {
// 			                minYear: 2000,
// 			                maxYear: 2015,
// 			                minuteStep: 1
// 			      }
// 			    });
			 
			  
// 			  $('#fechaEstimadaFin').editable({
// 				  name:'fechaEstimadaFin',
// 				  mode: 'popup',
// 				  placement: 'top',
// 				  format: 'DD-MM-YYYY',    
// 			      viewformat: 'DD/MM/YYYY',    
// 			      template: 'D / MMMM / YYYY',    
// 			      combodate: {
// 			                minYear: 2000,
// 			                maxYear: 2015,
// 			                minuteStep: 1
// 			      }
// 			    });
			  
// 			  $('#fechaRealInicio').editable({
// 				  name:'fechaRealInicio',	
// 				  mode: 'popup',
// 				  placement: 'top',
// 				  format: 'DD-MM-YYYY',    
// 			      viewformat: 'DD/MM/YYYY',    
// 			      template: 'D / MMMM / YYYY',    
// 			      combodate: {
// 			                minYear: 2000,
// 			                maxYear: 2015,
// 			                minuteStep: 1
// 			      }
// 			    });
			  
// 			  $('#fechaRealFin').editable({
// 				  name:'fechaRealFin',	
// 				  mode: 'popup',
// 				  placement: 'right',
// 				  format: 'DD-MM-YYYY',    
// 			      viewformat: 'DD/MM/YYYY',    
// 			      template: 'D / MMMM / YYYY',    
// 			      combodate: {
// 			                minYear: 2000,
// 			                maxYear: 2015,
// 			                minuteStep: 1
// 			      }
// 			    });
			  
			  
			  function resetLicitacionValues(){
				  
				  	 $('#obra').editable('setValue', null); 
				     $('#nroLicitacion').editable('setValue', null); 
				     $('#nroExpediente').editable('setValue', null); 
				     $('#valorPliego').editable('setValue', 0); 
				     $('#unidadEjecutora').editable('setValue', null); 
				     $('#unidadFinanciamiento').editable('setValue', null); 
				     $('#empresaNombre').editable('setValue', null); 
				     $('#empresaCuit').editable('setValue', null); 
				     $('#empresaEmail').editable('setValue', null); 
				     $('#representanteNombre').editable('setValue', null); 
				     $('#representanteTel').editable('setValue', null); 
				     $('#representanteEmail').editable('setValue', null); 
				     $('#presupuestoAdjudicado').editable('setValue', 0); 
				     $('#presupuestoFinal').editable('setValue', 0); 
				     $('#tipo').editable('setValue', 1); 
				     $('#estadoObra').editable('setValue', 1); 
// 				     $('#fechaEstimadaInicio').editable('setValue', null); 
// 				     $('#fechaEstimadaFin').editable('setValue', null); 
// 				     $('#fechaRealInicio').editable('setValue', null); 
// 				     $('#fechaRealFin').editable('setValue', null); 
				     
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
			<div id="btn-update" class="btn-group" style="float:right;">
				<button class="btn btn-success"><i class="icon-save icon-large"></i>&nbsp;&nbsp;&nbsp;Guardar</button>			
			</div>
			<div id="btn-edit" class="btn-group" style="float:right;">
				<button class="btn btn-info"><i class="icon-pencil icon-large"></i>&nbsp;&nbsp;&nbsp;Editar</button>			
			</div>			
			
			
	
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
						    	<a href="#" id="issue-tags" data-type="select2" class="select2-container select2-container-multi select2"></a>
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
			      
			       <button id="reset-btn" class="btn btn-primary">RESET</button>
							
					<table id="tbl-licitacion" class="table table-hover table-bordered table-striped">	
					
						 <tr>
						    <th>Obra:</th>
						    <td><a href="#" id="obra" data-type="textarea">${lic-obra}</a></td>						  
						 </tr>
						 <tr>
						    <th>N∞ de LicitaciÛn:</th>
						    <td><a href="#" id="nroLicitacion" data-type="text">${lic-id}</a>						  
						 </tr>
						 <tr>
						    <th>N∞ de Expediente:</th>
						    <td><a href="#" id="nroExpediente" data-type="text">${lic-expediente}</a></td>						  
						 </tr>
						 <tr>
						    <th>Estado de la obra:</th>
						    <td><a href="#" id="estadoObra" data-type="select">${lic-estado}</a></td>						  
						 </tr>
						 <tr>
						    <th>Tipo:</th>
						    <td><a href="#" id="tipo" data-type="select" >${lic-tipo}</a>	</td>						  
						 </tr>
						 <tr>
						 	<th>Unidad ejecutora:</th>
						    <td><a href="#" id="unidadEjecutora" data-type="text">${lic-uni-exe}</a>		</td>
						 </tr>	
						 <tr>	
						    <th>Unidad de financiaciÛn:</th>
						    <td><a href="#" id="unidadFinanciamiento" data-type="text">${lic-uni-fin}</a>	</td>		
						 </tr>
						 <tr>	
						    <th>Valor del pliego:</th>
						    <td>$ <a href="#" id="valorPliego" data-type="number">${lic-pliego}</a></td>		
						 </tr>						 <tr>
						    <th>Empresa constructora:</th>
						    <td>
						    	<a href="#" id="representanteNombre" data-type="text">${lic-representante-nombre}</a>
						    	<br><a href="#" id="representanteTel" data-type="tel">${lic-representante-tel}</a>
						    	<br><a href="#" id="representanteEmail" data-type="email">${lic-representante-email}</a>	
						    </td>						  
						 </tr>
						 <tr>
						    <th>Representante tÈcnico:</th>
						    <td>
						    	<a href="#" id="empresaNombre" data-type="text">${lic-empresa-nombre}</a>
						    	<br><a href="#" id="empresaCuit" data-type="text">${lic-empresa-cuit}</a>	
						    	<br><a href="#" id="empresaEmail" data-type="email">${lic-empresa-email}</a>
						    </td>						  
						 </tr>
						 <tr>
						    <th>Presupuesto Adjudicado:</th>
						    <td>
						    	$ <a href="#" id="presupuestoAdjudicado" data-type="number">${lic-presup-ini}</a>
						    </td>
						 </tr>
						 <tr>	
						    <th>Presupuesto Final:</th>
						    <td>
						    	$ <a href="#" id="presupuestoFinal" data-type="number">${lic-presup-fin}</a>
						    </td>					  
						 </tr>
<!-- 						 <tr> -->
<!-- 						    <th>Fechas estimadas:</th> -->
<!-- 						    <td> -->
<%-- 						    	<a href="#" id="fechaEstimadaInicio" data-type="combodate">${lic-fechaTemp-ini}</a> --%>
<!-- 												&mdash; -->
<%-- 												<a href="#" id="fechaEstimadaFin" data-type="combodate">${lic-fechaTemp-fin}</a> --%>
<!-- 						    </td>	 -->
<!-- 						 </tr> -->
<!-- 						 <tr> -->
<!-- 						    <th>Fechas reales:</th> -->
<!-- 						    <td> -->
<%-- 						    	<a href="#" id="fechaRealInicio" data-type="combodate">${lic-fechaReal-ini}</a>	 --%>
<!-- 												&mdash; -->
<%-- 												<a href="#" id="fechaRealFin" data-type="combodate">${lic-fechaReal-fin}</a>	 --%>
<!-- 						    </td>					   -->
<!-- 						 </tr> -->
					
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