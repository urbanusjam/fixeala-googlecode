
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
			$.fn.editable.defaults.mode = 'inline';	
			
			
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
					        return 'La longitud máxima del campo es de 500 caracteres.';
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
					        return 'La longitud máxima del campo es de 35caracteres.';
					    }
					}
			  });
			  
			  
			  /*******************************************/
			  
			  $("#lic-obra").editable({
				  pk: 5,  
				  name: 'lic-obra', 	
				  type: 'text',
				  url: '/post',   				  
				  ajaxOptions: {
				        type: 'json'
				  }				 
			  });
			  
			  $("#lic-id").editable({
				  pk: 6,  
				  name: 'lic-id', 		
				  type: 'text',
				  url: '/post',   
				  ajaxOptions: {
				        type: 'json'
				  }				 
			  });
			  
			  $("#lic-expediente").editable({
				  pk: 7,  
				  name: 'lic-expediente', 	
				  type: 'text',
				  url: '/post',   
				  ajaxOptions: {
				        type: 'put'
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
			
			
			  $('#btn-update').click(function() {
				  
				  bootbox.confirm("¿Desea confirmar los cambios?", function(result){
					  
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
	    			<div class="caption"><button class="btn btn-info"><i class="icon-camera"></i>&nbsp;&nbsp;&nbsp;más fotos y videos</button>	</div>
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
						    <th>Dirección:</th>
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
						    <th>Descripción:</th>
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
			  
			  
			  <!-- 3 LICITACIO“N -->
			  <div class="accordion-group">
			    <div class="accordion-heading">
			      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
			        <h4><i class="icon-wrench icon-large"></i>&nbsp;&nbsp;LICITACIÓN (${cantidadLicitacion})</h4>
			      </a>
			    </div>
			    <div id="collapseTwo" class="accordion-body collapse">
			      <div class="accordion-inner">
			       <div class="span8">  
				       <table id="tbl-licitacion" class="table table-hover table-bordered table-striped">
				       		<tr>
							    <td>Obra:</td>
							    <td><a href="#" id="obra">${lic-obra}</a></td>						  
						 	</tr>
						 	<tr>
							    <td>N° Licitación:</td>
							    <td><a href="#" id="lic-id">${lic-id}</a></td>						  
						 	</tr>
						 	<tr>
							    <td>N° Expediente:</td>
							    <td><a href="#" id="lic-expediente">${lic-expediente}</a></td>						  
						 	</tr>
				        	<tr>
							    <td>Valor del pliego:</td>
							    <td>$3.400,00 (pesos argentinos)</td>						  
						 	</tr>						 	
						 	<tr>
							    <td>Empresa constructora:</td>
							    <td>Fulanito Construcciones SRL</td>						   
						 	</tr>	
						 	<tr>
							    <td>Unidad ejecutora:</td>
							    <td>Ministerio de Ambiente y Espacio Público de la Ciudad Autónoma de Buenos Aires</td>						   
						 	</tr>
						 	<tr>
							    <td>Representante técnico:</td>							   
							     <td>Ing. Fulanito Alguien <br> ministerioaye@buenosaires.gob.ar <br> 4435-8888</td>								   		  
						 	</tr>
						 	<tr>
							    <td>Financiamiento:</td>
							    <td>Ministerio de Ambiente y Espacio Público de la Ciudad Autónoma de Buenos Aires</td>						   
						 	</tr>	
						 	
						 	<tr>
							    <td>Plazo de ejecución:</td>
							    <td>15 días</td>						  
						 	</tr>	
						 	<tr>
							    <td>Presupuesto adjudicado:</td>
							    <td><b>$23.344,00</b></td>						  
						 	</tr>		
						 	<tr>
							    <td>Presupuesto final:</td>
							    <td><b>-</b></td>						  
						 	</tr>
						 	<tr>
							    <td>Fecha estimada de finalización:</td>
							    <td><b>23/08/2013</b></td>						  
						 	</tr>
						 	<tr>
							    <td>Fecha real de finalización:</td>
							    <td><b>-</b></td>						  
						 	</tr>
						 	<tr>
							    <td>Estado de la obra:</td>
							    <td>EN CURSO</td>						  
						 	</tr>						 	
						</table>
						</div>
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
			       <h4><i class="icon-camera icon-large"></i>&nbsp;&nbsp;IMÁGENES Y VIDEOS (${cantidadArchivos})</h4>			   
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
			      
			     <!-- EDITOR TOOLBAR --> 
<!-- 			     <div class="btn-toolbar" data-role="editor-toolbar" data-target="#commentTextEditor"> -->
<!-- 				      <div class="btn-group"> -->
<!-- 				        <a class="btn dropdown-toggle" data-toggle="dropdown" title="" data-original-title="Font"><i class="icon-font"></i><b class="caret"></b></a> -->
<!-- 				          <ul class="dropdown-menu"> -->
<!-- 				          <li><a data-edit="fontName Serif" style="font-family:'Serif'">Serif</a></li><li><a data-edit="fontName Sans" style="font-family:'Sans'">Sans</a></li><li><a data-edit="fontName Arial" style="font-family:'Arial'">Arial</a></li><li><a data-edit="fontName Arial Black" style="font-family:'Arial Black'">Arial Black</a></li><li><a data-edit="fontName Courier" style="font-family:'Courier'">Courier</a></li><li><a data-edit="fontName Courier New" style="font-family:'Courier New'">Courier New</a></li><li><a data-edit="fontName Comic Sans MS" style="font-family:'Comic Sans MS'">Comic Sans MS</a></li><li><a data-edit="fontName Helvetica" style="font-family:'Helvetica'">Helvetica</a></li><li><a data-edit="fontName Impact" style="font-family:'Impact'">Impact</a></li><li><a data-edit="fontName Lucida Grande" style="font-family:'Lucida Grande'">Lucida Grande</a></li><li><a data-edit="fontName Lucida Sans" style="font-family:'Lucida Sans'">Lucida Sans</a></li><li><a data-edit="fontName Tahoma" style="font-family:'Tahoma'">Tahoma</a></li><li><a data-edit="fontName Times" style="font-family:'Times'">Times</a></li><li><a data-edit="fontName Times New Roman" style="font-family:'Times New Roman'">Times New Roman</a></li><li><a data-edit="fontName Verdana" style="font-family:'Verdana'">Verdana</a></li></ul> -->
<!-- 				        </div> -->
<!-- 				      <div class="btn-group"> -->
<!-- 				        <a class="btn dropdown-toggle" data-toggle="dropdown" title="" data-original-title="Font Size"><i class="icon-text-height"></i>&nbsp;<b class="caret"></b></a> -->
<!-- 				          <ul class="dropdown-menu"> -->
<!-- 				          <li><a data-edit="fontSize 5"><font size="5">Huge</font></a></li> -->
<!-- 				          <li><a data-edit="fontSize 3"><font size="3">Normal</font></a></li> -->
<!-- 				          <li><a data-edit="fontSize 1"><font size="1">Small</font></a></li> -->
<!-- 				          </ul> -->
<!-- 				      </div> -->
<!-- 				      <div class="btn-group"> -->
<!-- 				        <a class="btn" data-edit="bold" title="" data-original-title="Bold (Ctrl/Cmd+B)"><i class="icon-bold"></i></a> -->
<!-- 				        <a class="btn" data-edit="italic" title="" data-original-title="Italic (Ctrl/Cmd+I)"><i class="icon-italic"></i></a> -->
<!-- 				        <a class="btn" data-edit="strikethrough" title="" data-original-title="Strikethrough"><i class="icon-strikethrough"></i></a> -->
<!-- 				        <a class="btn" data-edit="underline" title="" data-original-title="Underline (Ctrl/Cmd+U)"><i class="icon-underline"></i></a> -->
<!-- 				      </div> -->
<!-- 				      <div class="btn-group"> -->
<!-- 				        <a class="btn" data-edit="insertunorderedlist" title="" data-original-title="Bullet list"><i class="icon-list-ul"></i></a> -->
<!-- 				        <a class="btn" data-edit="insertorderedlist" title="" data-original-title="Number list"><i class="icon-list-ol"></i></a> -->
<!-- 				        <a class="btn" data-edit="outdent" title="" data-original-title="Reduce indent (Shift+Tab)"><i class="icon-indent-left"></i></a> -->
<!-- 				        <a class="btn" data-edit="indent" title="" data-original-title="Indent (Tab)"><i class="icon-indent-right"></i></a> -->
<!-- 				      </div> -->
<!-- 				      <div class="btn-group"> -->
<!-- 				        <a class="btn btn-info" data-edit="justifyleft" title="" data-original-title="Align Left (Ctrl/Cmd+L)"><i class="icon-align-left"></i></a> -->
<!-- 				        <a class="btn" data-edit="justifycenter" title="" data-original-title="Center (Ctrl/Cmd+E)"><i class="icon-align-center"></i></a> -->
<!-- 				        <a class="btn" data-edit="justifyright" title="" data-original-title="Align Right (Ctrl/Cmd+R)"><i class="icon-align-right"></i></a> -->
<!-- 				        <a class="btn" data-edit="justifyfull" title="" data-original-title="Justify (Ctrl/Cmd+J)"><i class="icon-align-justify"></i></a> -->
<!-- 				      </div> -->
<!-- 				      <div class="btn-group"> -->
<!-- 						  <a class="btn dropdown-toggle" data-toggle="dropdown" title="" data-original-title="Hyperlink"><i class="icon-link"></i></a> -->
<!-- 						    <div class="dropdown-menu input-append"> -->
<!-- 							    <input class="span2" placeholder="URL" type="text" data-edit="createLink"> -->
<!-- 							    <button class="btn" type="button">Add</button> -->
<!-- 				        </div> -->
<!-- 				        <a class="btn" data-edit="unlink" title="" data-original-title="Remove Hyperlink"><i class="icon-cut"></i></a>	 -->
<!-- 	      			 </div>	      		 -->
	      
<!-- 			      <div class="btn-group"> -->
<!-- 			        <a class="btn" title="" id="pictureBtn" data-original-title="Insert picture (or just drag &amp; drop)"><i class="icon-picture"></i></a> -->
<!-- 			        <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage" style="opacity: 0; position: absolute; top: 0px; left: 0px; width: 37px; height: 30px;"> -->
<!-- 			      </div> -->
<!-- 			      <div class="btn-group"> -->
<!-- 			        <a class="btn" data-edit="undo" title="" data-original-title="Undo (Ctrl/Cmd+Z)"><i class="icon-undo"></i></a> -->
<!-- 			        <a class="btn" data-edit="redo" title="" data-original-title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a> -->
<!-- 			      </div>	  -->
<!-- 			    </div> -->
			    <!-- /EDITOR TOOLBAR -->
			     
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
				    <li><a href="#">« Anterior</a></li>
				    <li><a href="#">1</a></li>
				    <li><a href="#">2</a></li>
				    <li><a href="#">3</a></li>
				    <li><a href="#">4</a></li>
				    <li><a href="#">5</a></li>
				    <li><a href="#">Siguiente »</a></li>
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
						    <a href="#"><h5 class="media-heading">Semáforo no anda</h5></a>				    
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