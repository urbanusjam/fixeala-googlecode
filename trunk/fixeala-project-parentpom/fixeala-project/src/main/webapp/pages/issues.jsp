
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
		
			//toggle `popup` / `inline` mode
// 			$.fn.editable.defaults.mode = 'inline';	
			
			
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
// 			  $("#issue-barrio").editable({name: 'neighborhood', disabled: true});
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
				  rows: 5,
				  url: '/post', 			  
				  ajaxOptions: {
				        type: 'put'
				  },				
				  validate: function(value) {
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
					    if($.trim(value).length > 500) {
					        return 'La longitud m√°xima del campo es de 500 caracteres.';
					    }
				  }
			  	
			  });
			  
			  $('#issue-tags').editable({
				  	pk: 3,  
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
				  url: '/post',   
				  ajaxOptions: {
				        type: 'put'
				  },
				  validate: function(value) {
					    if($.trim(value) == '') {
					        return 'Este campo es requerido.';
					    }
					    if($.trim(value).length > 50) {
					        return 'La longitud m√°xima del campo es de 35caracteres.';
					    }
					}
			  });
			  
			  
			  /*******************************************/
			
			  
			  $("#obra").editable({				
				  type: 'textarea',
				  title: 'Ingrese una descripciÛn'						 
			  });
			  
			  $("#idLicitacion").editable({		
				  type: 'text'
							 
			  });
			  
			  $("#nroExpediente").editable({				
				  type: 'text'							 
			  });
			  
			  $("#valorPliego").editable({				
				  url: '/post'			 
			  });
			  
			  $("#unidadEjec").editable({				
				  url: '/post'			 
			  });
			  
			  $("#unidadFinanc").editable({				
				  url: '/post'			 
			  });
			  
			  $("#empresaNombre").editable({				
				  url: '/post'			 
			  });
			  
			  $("#empresaEmail").editable({				
				  url: '/post'			 
			  });
			  
			  $("#empresaCuit").editable({				
				  url: '/post'			 
			  });
			  
			  $("#representanteNombre").editable({				
				  url: '/post'			 
			  });
			  
			  $("#representanteTel").editable({				
				  url: '/post'			 
			  });
			
			  
			  $("#empresaEmail").editable({				
				  url: '/post'			 
			  });
			  
			  
			  $("#presupuestoInicio").editable({				
				  url: '/post'			 
			  });
			  
			  $("#presupuestoFin").editable({				
				  url: '/post'			 
			  });
			  
			 
			  
			  
			  $('#tipo').editable({
					value: 1,
					url:"/post",
			        source: [
			            {value: 1, text: 'P˙blica'},
			            {value: 2, text: 'Privada'},
			            {value: 2, text: 'ContrataciÛn directa'}
			        ]
			    });    
			  
			  $('#estadoObra').editable({
					value: 1,
					url:"/post",
			        source: [
			            {value: 1, text: 'En curso'},
			            {value: 2, text: 'Interrumpida'},
			            {value: 2, text: 'Finalizada'}
			        ]
			    });  
			  
			  
			  
			  $('#fechaEstInicio').editable({
				  	format: 'YYYY-MM-DD',    
			        viewformat: 'DD/MM/YYYY',    
			        template: 'D / MMMM / YYYY',    
			        combodate: {
			                minYear: 2000,
			                maxYear: 2015,
			                minuteStep: 1
			           }
			       
			    });
			  
			  $('#fechaEstFin').editable({
				 	format: 'YYYY-MM-DD',    
			        viewformat: 'DD/MM/YYYY',    
			        template: 'D / MMMM / YYYY',    
			        combodate: {
			                minYear: 2000,
			                maxYear: 2015,
			                minuteStep: 1
			           }
			    });
			  
			  $('#fechaRealInicio').editable({
				  	format: 'YYYY-MM-DD',    
			        viewformat: 'DD/MM/YYYY',    
			        template: 'D / MMMM / YYYY',    
			        combodate: {
			                minYear: 2000,
			                maxYear: 2015,
			                minuteStep: 1
			           }
			    });
			  
			  $('#fechaRealFin').editable({
				  	format: 'YYYY-MM-DD',    
			        viewformat: 'DD/MM/YYYY',    
			        template: 'D / MMMM / YYYY',    
			        combodate: {
			                minYear: 2000,
			                maxYear: 2015,
			                minuteStep: 1
			           }
			    });
			  
			  /*******************************************/
			  

			//ajax emulation
			  $.mockjax({
			      url: '/post',
			      responseTime: 500,
			      response: function(settings) {
			          console.log(settings);
			      }
			  }); 
			  
			
			  $( "#btn-add-licitacion" ).click( function() {
				  copyLicitacionDataToTable();
	   			});
			  
			  function copyLicitacionDataToTable(){
				  
			  		var obra = $("#lic-obra").val();
			  		var nroLicitacion = $("#lic-id").val();
			  		var nroExpediente = $("#lic-expediente").val();
			  		var tipo = $("#lic-tipo").val();
			  		
			  		var estadoObra = $("#lic-estado").val();
			  		var unidadExe = $("#lic-uni-exe").val();
			  		var unidadFin = $("#lic-uni-fin").val();
			  		var valorPliego = "$ " + $("#lic-pliego").val();
			  		
			  		var empresa = $("#lic-empresa-nombre").val() + "<br>" + $("#lic-empresa-cuit").val() + "<br>" + $("#lic-empresa-email").val();
			  		var represTecnico = $("#lic-repres-nombre").val() + "<br>" + $("#lic-repres-tel").val() + "<br>" + $("#lic-repres-email").val();
			  		
			  		var presupuestoInicial = "$ " + $("#lic-prespuesto-inicio").val();
			  		var presupuestoFinal = "$ " + $("#lic-prespuesto-fin").val();
			  		
			  		var fechaTmpInicio = $("#lic-fechaTemp-inicio").val();
			  		var fechaTmpFin = $("#lic-fechaTemp-fin").val();
			  		var fechaRealInicio = $("#lic-fechaReal-inicio").val();
			  		var fechaRealFin = $("#lic-fechaReal-fin").val();
			  		
			  		var data = [ obra, nroLicitacion, nroExpediente, tipo, unidadExe, unidadFin, valorPliego,
			  					   empresa, represTecnico, presupuestoInicial, presupuestoFinal, 
			  					   fechaTmpInicio, fechaTmpFin, fechaRealInicio, fechaRealFin, estadoObra ];
			  		
			  	
			  		var index = 0;
			  	
			  		$('#tbl-licitacion td').each(function(){			  		
			  			if( $(this).hasClass("dynamic-cell") ){
			  				if( index < data.length){				  			
					  		      $(this).append(data[index]);
					  		}
			  				index++;
			  			}						  
				  	});
			  	 
			  		setTimeout(function(){			  			
			  			$('.btnToggle').css("display", "none");
			  			$('#tbl-licitacion').css("display", "block");
			  			$('#mdl-licitacion').modal('hide');
			  			$('#tbl-licitacion-form').reset();
			  			
			  		}, 300);			  	
			  }
			
			
			  $('#btn-update').click(function() {
				  
				  bootbox.confirm("¬øDesea confirmar los cambios?", function(result){
					  
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
				<button class="btn btn-info"><i class="icon-edit icon-large"></i>&nbsp;&nbsp;&nbsp;Editar</button>			
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
						    <td><a href="#" id="issue-status">${estado}</a></td>						   
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
			       
<%-- 			       		<c:if test="${cantidadLicitacion eq 0}">			 --%>
<!-- 			       			<div class="btnToggle" style="margin:0 auto; padding:20px;height:60px;line-height:60px;text-align:center;"> -->
								
<!-- 								<a href="#mdl-licitacion" role="button" class="btn btn-large btn-primary" data-toggle="modal"> -->
<!-- 									<i class="icon-plus icon-large"></i>&nbsp;&nbsp;&nbsp;AGREGAR INFORMACI”N -->
<!-- 								</a>								 -->
<!-- 							</div> -->
<%-- 						</c:if> --%>

 
					<!-- MODAL LICIACION -->
					<div id="mdl-licitacion" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-header">
					    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
					    <h3 id="myModalLabel">LicitaciÛn de obra</h3>
					  </div>
					  <div class="modal-body">
					  	<!-- LICITACION FORM -->
		                <form id="licitacion-form">
		                
		                	<table id="tbl-licitacion-form" align="center">			  	
	   	   		  	   		 	<tbody>
	   	   		  	   		 		<tr>
										<td colspan="2">
											<label>Obra</label>
											<textarea id="lic-obra" name="lic-obra" rows="3" ></textarea>				               				
										</td>	
										<td>
											<label>Tipo</label>					  			
					               			<select id="lic-tipo" name="lic-tipo">								
												<option>P˙blica</option>
												<option>Privada</option>	
												<option>ContrataciÛn directa</option>		
											</select>
										</td>																
								  	</tr>
									<tr>
										<td>
											<label>N∞ de LicitaciÛn</label>
				               				<input type="text" id="lic-id" name="lic-id">
										</td>
										<td>
											<label>N∞ de Expediente</label>
			               					<input type="text" id="lic-expediente" name="lic-expediente">
										</td>	
								  		<td>
											<label>Estado de la obra</label>					  			
					               			<select id="lic-estado" name="lic-estado">								
												<option>En curso</option>
												<option>Interrumpida</option>	
												<option>Finalizada</option>		
											</select>
										</td>
								  	</tr>								  
								  	<tr>
										<td>
											<label>Unidad ejecutora</label>
			               					<input type="text" id="lic-uni-exe" name="lic-uni-exe">			               			
										</td>
										<td>
											<label>Unidad de financiaciÛn</label>
				               				<input type="text" id="lic-uni-fin" name="lic-uni-fin">
										</td>
										<td>
											<label>Valor del pliego (en pesos argentinos)</label>
				               				<input type="text" id="lic-pliego" name="lic-pliego">
										</td>
									</tr>
									<tr>									
										<td>
											<label>Empresa constructora</label>			               				
			               					<input type="text" id="lic-empresa-nombre" name="lic-empresa-nombre" placeholder="RazÛn Social">	
			               					<input type="text" id="lic-empresa-cuit" name="lic-empresa-cuit" placeholder="CUIT">	
			               					<input type="text" id="lic-empresa-email" name="lic-empresa-email" placeholder="Email">	
										</td>
										<td>
											<label>Representante tÈcnico</label>
			               					<input type="text" id="lic-repres-nombre" name="lic-repres-nombre" placeholder="Nombre y Apellido">	
			               					<input type="text" id="lic-repres-tel" name="lic-repres-tel" placeholder="TelÈfono">	
			               					<input type="text" id="lic-repres-email" name="lic-repres-email" placeholder="Email">	
										</td>
										<td>																			
											<label>Presupuesto (en pesos argentinos)</label>	
					               			<input type="text" id="lic-prespuesto-inicio" name="lic-prespuesto-inicio" placeholder="Adjudicado">				               		
					               			<input type="text" id="lic-prespuesto-fin" name="lic-prespuesto-fin" placeholder="Final">	
			               				</td>											
									</tr>																
									<tr>
										<td>		
											<label>Fecha estimada</label>			
							    	   		<input type="text" id="lic-fechaTemp-inicio" name="lic-fechaTemp-inicio" style="width:110px;" placeholder="Inicio"/>	
							    	   		&nbsp;- &nbsp;		    	   		
							    	   		<input type="text" id="lic-fechaTemp-fin" name="lic-fechaTemp-fin" style="width:110px;" placeholder="Fin"/>
										</td>									
										<td>
											<label>Fecha real</label>			   	
							    	   		<input type="text" id="lic-fechaReal-inicio" name="lic-fechaReal-inicio" style="width:110px;" placeholder="Inicio"/>	
							    	   		&nbsp;- &nbsp;		    	   		
							    	   		<input type="text" id="lic-fechaReal-fin" name="lic-fechaReal-fin" style="width:110px;" placeholder="Fin"/>
										</td>
									</tr>										
							  	</tbody>
					  		</table>
		                </form>
					  				
					  </div>
					  <div class="modal-footer">					   
					     <button id="btn-add-licitacion" class="btn btn-primary"><i class="icon-ok"></i>&nbsp;&nbsp;&nbsp;Confirmar</button>
					     <button class="btn" data-dismiss="modal"><i class="icon-remove"></i>&nbsp;&nbsp;&nbsp;Cancelar</button>
					  </div>
					</div>
							
					<table id="tbl-licitacion-form" align="center">			  	
	   	   		  	   		 	<tbody>
	   	   		  	   		 		<tr>
										<td colspan="2">
											<label>Obra</label>
											<a href="#" id="obra" data-type="textarea">${obra}</a>			               				
										</td>	
										<td>
											<label>Tipo</label>		
											<a href="#" id="tipo" data-type="select">${tipo}</a>			  			
										</td>																
								  	</tr>
									<tr>
										<td>
											<label>N∞ de LicitaciÛn</label>
				               				<a href="#" id="idLicitacion" data-type="text">${idLicitacion}</a>
										</td>
										<td>
											<label>N∞ de Expediente</label>
			               					<a href="#" id="nroExpediente">${nroExpediente}</a>
										</td>	
								  		<td>
											<label>Estado de la obra</label>					  			
					               			<a href="#" id="estadoObra" data-type="select">${estadoObra}</a>		
										</td>
								  	</tr>								  
								  	<tr>
										<td>
											<label>Unidad ejecutora</label>
			               					<a href="#" id="unidadEjec" data-type="text">Ministerio de PlanifiaciÛn</a>					               			
										</td>
										<td>
											<label>Unidad de financiaciÛn</label>
				               				<a href="#" id="unidadFinanc" data-type="text">Ministerio de Obras P˙blicas</a>			
										</td>
										<td>
											<label>Valor del pliego (en pesos argentinos)</label>
				               				<a href="#" id="valorPliego" data-type="number">34535656</a>			
										</td>
									</tr>
									<tr>									
										<td>
											<label>Empresa constructora</label>			               				
			               					<a href="#" id="empresaNombre" data-type="text">Una empresa ficticia SRL</a>
			               					<a href="#" id="empresaCuit" data-type="text">20-789-456-6</a>	
			               					<a href="#" id="empresaEmail" data-type="email">info@empresa.com</a>
										</td>
										<td>
											<label>Representante tÈcnico</label>
			               					<a href="#" id="representanteNombre" data-type="text">Fulgencio PÈrez</a>
			               					<a href="#" id="representanteTel" data-type="tel">011-4321-9900</a>	
			               					<a href="#" id="representanteEmail" data-type="email">fulgenciop@gmail.com</a>	
										</td>
										<td>																			
											<label>Presupuesto (en pesos argentinos)</label>	
					               			<a href="#" id="presupuestoInicio" data-type="number">12450888</a>				               		
					               			<a href="#" id="presupuestoFin" data-type="number">200123045</a>	
			               				</td>											
									</tr>																
									<tr>
										<td>		
											<label>Fecha estimada</label>	
											Inicio <a href="#" id="fechaEstInicio" data-type="combodate">10/05/2013</a>									    	 
							    	   		
							    	   		Fin <a href="#" id="fechaEstFin" data-type="combodate">21/09/2013</a>			
										</td>									
										<td>
											<label>Fecha real</label>			   	
							    	   		Inicio
							    	   		<a href="#" id="fechaRealInicio" data-type="combodate">11/06/2013</a>			
							    	   		fin    	   		
							    	   		<a href="#" id="fechaRealFin" data-type="combodate">30/12/2013</a>		
										</td>
									</tr>										
							  	</tbody>
					  		</table>		
							
<!-- 					<table id="tbl-licitacion" class="table table-hover table-bordered table-striped" style="display:none;" align="center">						 -->
<!-- 				       		<tr> -->
<!-- 							    <th>Obra:</th> -->
<%-- 							    <td class="dynamic-cell"><a href="#" id="obra">${obra}</a></td>						   --%>
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>N∞ LicitaciÛn:</th> -->
<%-- 							    <td class="dynamic-cell"><a href="#" id="idLic">${id}</a></td>								   --%>
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>N∞ Expediente:</th> -->
<%-- 							    <td class="dynamic-cell"><a href="#" id="nroExpediente">${nroExpediente}</a></td>								   --%>
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>Tipo de licitaciÛn:</th> -->
<!-- 							    <td class="dynamic-cell"></td>								   -->
<!-- 						 	</tr> -->
<!-- 				        	<tr> -->
<!-- 							    <th>Valor del pliego:</th> -->
<!-- 							    <td class="dynamic-cell"></td>								   -->
<!-- 						 	</tr>						 	 -->
<!-- 						 	<tr> -->
<!-- 							    <th>Empresa constructora:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						    -->
<!-- 						 	</tr>	 -->
<!-- 						 	<tr> -->
<!-- 							    <th>Unidad ejecutora:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						    -->
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>Representante t√©cnico:</th>							    -->
<!-- 							    <td class="dynamic-cell"></td>								   		   -->
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>Financiamiento:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						    -->
<!-- 						 	</tr>						 	 -->
<!-- 						 	<tr> -->
<!-- 							    <th>Presupuesto adjudicado:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						   -->
<!-- 						 	</tr>		 -->
<!-- 						 	<tr> -->
<!-- 							    <th>Presupuesto final:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						   -->
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>Fecha estimada de inicio:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						   -->
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>Fecha estimada de finalizaciÛn:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						   -->
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>Fecha real de inicio:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						   -->
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>Fecha real de finalizaciÛn:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						   -->
<!-- 						 	</tr> -->
<!-- 						 	<tr> -->
<!-- 							    <th>Estado de la obra:</th> -->
<!-- 							    <td class="dynamic-cell"></td>						   -->
<!-- 						 	</tr>	 -->
							 	
<!-- 					</table> -->
							
			       
			       		
<%-- 			       		<c:if test="${cantidadLicitacion gt 0}"> --%>
			       		
			       
				      
<%-- 						</c:if> --%>
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