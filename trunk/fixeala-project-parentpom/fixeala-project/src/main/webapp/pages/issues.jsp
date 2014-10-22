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

	<div class="container-fluid">
	  	<div class="row-fluid" >
	   
		    <div class="span9">
		      <!--Body content-->
		     
		  	  <div id="issue-header" class="hero-unit" style="padding:20px; margin-bottom:15px">	  
		        <h3 style="display:inline">
		        	<a href="#" id="issue-title">${titulo}</a>&nbsp;<i class="icon-pencil editableField"></i></h3>
		        <p>${direccion}</p>       
		      </div>

			  <div class="row">
			  	<div class="row-fluid" style="margin-bottom: 30px;">
					 <div class="span4">  
						 <ul class="thumbnails">
					  	   		<li style="margin-left:0">
					  	   			<div id="mainPhoto">
							    		<c:if test="${cantidadContenidos gt 0}">
							    			<a data-lightbox="issue-lightbox2" class="thumbnail" href="${imageUrl}">							  	  			  	   		
												<img src="${imageUrl}" alt="${imageUrl}">	 
											</a>		
							    		</c:if>
							    		<c:if test="${cantidadContenidos eq 0}">
							    			<a data-lightbox="issue-lightbox2" class="thumbnail" href="resources/images/nopic.png" >							  	  			  	   		
												<img src="resources/images/nopic.png" alt="">	
											</a>
							    		</c:if>
						    		</div>		
					    			<br>
					    			<sec:authorize access="hasRole('ROLE_USER')">	
						    			<c:if test="${estado ne 'CERRADO' && estado ne 'ARCHIVADO'}">
											<div class="caption">
							    				<button id="btnAddFiles" href="#mdl-fileupload" data-toggle="modal" class="btn btn-default" style="font-size: 11px; text-transform: uppercase">
							    					<i class="icon-plus"></i>&nbsp;Cargar im&aacute;genes
							    				</button>
							    			</div>
										</c:if>
									</sec:authorize>
					    			
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
							    <td class="reporter"></td>						    		    
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
							    <td><a class="taglink" href="issues/search.html?type=status&value=${estado}" id="issue-status" data-type="text"><span class="label" style="background-color:${estadoCss}">${estado}</span></a>
							    <c:if test="${not empty esolucion}">
							   		<b>${resolucion}</b>
							    </c:if>
							    </td>						   
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
	 			 	<a href="issues/${id}/loadmore/update/2"></a>
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
		 	
		 	<sec:authorize access="hasRole('ROLE_USER')">	
    			<c:if test="${estado ne 'CERRADO' && estado ne 'ARCHIVADO'}">
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
				</c:if>
			</sec:authorize>
			<c:if test="${cantidadComentarios eq 0}">
					<h4 style="padding-bottom: 20px; margin-left: 15px;">No hay comentarios publicados.</h4>
			</c:if>
		    <c:if test="${cantidadComentarios gt 0}">
		    	<div class="row-fluid" style="margin-bottom: 30px;">		
			 		 <!-- infinite scroll -->
					 <div id="infinite-container-comments"></div>
					 <nav id="page-nav-comment" style="display: none;">
		 			 	<a href="issues/${id}/loadmore/comment/2"></a>
					 </nav>			 
				 	<center><a href="#" id="btn-more-comments" class="btn btn-default btn-more comment" style="display: none;">Mostrar m&aacute;s resultados</a></center>
		 		</div>
		    </c:if>
			
		</div>	
		
		<!-- 4 Reparacion -->							
		<div class="tab-pane fade" id="issueRepair">	
				
			<sec:authorize access="isAnonymous()">
				<c:if test="${infoReparacion eq 'Sin datos'}">			
					<h4 style="padding-bottom: 20px; margin-left: 15px;">No hay informaci&oacute;n cargada.</h4>
				</c:if>
			</sec:authorize>			
					
			<sec:authorize access="hasRole('ROLE_USER')">
				<c:if test="${estado ne 'CERRADO' && estado ne 'ARCHIVADO' && infoReparacion eq 'Sin datos'}">				
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
						
			<!-- logged -->
			<sec:authorize access="hasRole('ROLE_USER')">	
				<c:if test="${estado eq 'ABIERTO'}">	
					<!-- current logged user -->			
					<c:if test="${loggedUser ne usuario}">
						<!-- already sent verification request -->
						<c:if test="${!empty isVerifiedByUser}">						
							<c:if test="${isVerifiedByUser}">
								<button disabled id="btnVerifyIssue" data-toggle="modal" href="#mdl-verify" class="btn btn-success" style="width: 100%; margin-bottom: 20px; height: 46px; line-height: 46px;" title="Verificar"><h4>VERIFICACION ENVIADA</h4></button> 
							</c:if>
							<c:if test="${!isVerifiedByUser}">
								<button disabled id="btnVerifyIssue" data-toggle="modal" href="#mdl-verify" class="btn btn-danger" style="width: 100%; margin-bottom: 20px; height: 46px; line-height: 46px;" title="Verificar"><h4>RECHAZO ENVIADO</h4></button> 
							</c:if>						
						</c:if>
						<!-- NOT sent yet -->
						<c:if test="${empty isVerifiedByUser}">
							<button id="btnVerifyIssue" data-toggle="modal" href="#mdl-verify" class="btn btn-danger" style="width: 100%; margin-bottom: 20px; height: 46px; line-height: 46px;" title="Verificar"><h3>VERIFICAR</h3></button> 
						</c:if>
					</c:if>
					<div class="stats-container">
						<span>
							<i class="icon icon-ok-sign" style="color: #449D44;"></i>${posVerifications} / ${maxVerificationsAllowed} verificaciones
						</span>
						<span style="text-align: right; float: right">
							<i class="icon icon-remove-sign" style="color: #C9302C;"></i>${negVerifications} / ${maxRejectionsAllowed} rechazos
						</span>			
					</div>				
				</c:if>
			</sec:authorize>
			<!-- NOT logged -->
			<sec:authorize access="isAnonymous()">	
				<c:if test="${estado eq 'ABIERTO'}">
					<div class="alert" style="background: #B94A48; color: #FFF; border: none"><h3>SIN VERIFICAR</h3></div> 
					<div class="stats-container">
						<span>
							<i class="icon icon-ok-sign" style="color: #449D44;"></i>${posVerifications} / ${maxVerificationsAllowed} verificaciones
						</span>
						<span style="text-align: right; float: right">
							<i class="icon icon-remove-sign" style="color: #C9302C;"></i>${negVerifications} / ${maxRejectionsAllowed} rechazos
						</span>			
					</div>
				</c:if>
			</sec:authorize>
			
			<div class="tag" style="border-radius: 5px; text-align: center; color: #FFF; background: ${estadoCss}"><h3>&nbsp;${estado}</h3></div>
			
			<div id="issue-stats" class="stats-container">
				<div class="stats-box">
					<span class="text-small">votos</span><span id="voteCount" class="text-big pull-right">${cantidadVotos}</span>
				</div> 
<%-- 				<div class="stats-box"><span class="text-small">visitas</span><span class="text-big pull-right">${cantidadVisitas}</span></div> --%>
				<div class="stats-box"><span class="text-small">comentarios</span><span class="text-big pull-right">${cantidadComentarios}</span></div>
				<div id="watchers" class="stats-box">					
					<span class="text-small">seguidores</span>
					<span class="text-big pull-right">
						<a href="#mdl-followers" id="followers-list" data-toggle="modal"><span id="numFollowers">${cantidadObservadores}</span></a>
					</span> 
				</div>
			</div>
			
			<div class="stats-container">
				&Uacute;ltima actualizaci&oacute;n: <span class="pull-right"><b>${fechaUltimaActualizacion}</b></span>
			</div>			
					
			<div id="issue-stats-actions">	
				<sec:authorize access="hasRole('ROLE_USER')">	
					<c:if test="${estado ne 'CERRADO' && estado ne 'ARCHIVADO'}">	
						<div class="stats-container">
							<span id="votes">
								<button id="vote-up" class="btn btn-warning" title="¡Vot&aacute; para que este reclamo se resuelva!"><i class="icon-thumbs-up "></i></button>
		<!-- 					<button id="vote-down" class="btn btn-danger" title="Voto negativo"><i class="icon-thumbs-down "></i></button> -->
							</span>	
							<button id="btn-edit" class="btn btn-primary" title="Editar"><i class="icon-pencil icon-large"></i></button>	
							<button id="btn-update" class="btn btn-inverse" title="Guardar cambios"><i class="icon-save icon-large"></i></button>						
							<span class="pull-right">
								<c:if test="${isUserWatching}">
									<button id="btn-unwatch-issue" class="btn btn-info">@ Siguiendo</button>
								</c:if>
								<c:if test="${!isUserWatching}">
									<button id="btn-watch-issue" class="btn pull-right">@ Seguir</button>
								</c:if>
							</span>						
						</div>	
					</c:if>	
				</sec:authorize>					
			</div>
			
			<div id="userIssueActions">
				<sec:authorize access="hasRole('ROLE_USER')">				
					<c:if test="${estado ne 'CERRADO' && estado ne 'ARCHIVADO'}">
						<c:if test="${estado eq 'ADMITIDO' || estado eq 'REABIERTO' || estado eq 'EN PROGRESO'}">
							<div class="stats-container">							
								<div id="btn-status" data-toggle="modal">			
									<button class="btn btn-success" title="Resolver"><i class="icon-ok icon-large"></i> RESOLVER</button>
								</div>
							</div>		
						</c:if>
						<c:if test="${estado eq 'RESUELTO'}">
							<div class="stats-container">	
								<div id="btn-status" data-toggle="modal">			
									<button class="btn btn-danger" title="Reabrir"><i class="icon-rotate-right icon-large"></i> REABRIR</button>
								</div>
							</div>
						</c:if>												
					</c:if>
				</sec:authorize>	
			</div>

		   <div class="page-header issue">
    	   		<h4><i class="icon-globe icon-large"></i>&nbsp;&nbsp;Vista en el mapa</h4>    	 	
    	   </div>     	   
		  
		   <!-- MINI MAP -->	
		   <div id="mini_map"></div>
		   
		   <div class="page-header issue">
    	   		<h4><i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;Reclamos cercanos</h4>    	 	
    	   </div>    
		      
	      	<table id="tblNearbyIssues" class="table table-hover">
	      		<tbody></tbody>
			</table>		
		</div>
		  		
  		</div><!-- ROW FLUID -->
	</div><!-- CONTAINER FLUID -->
	
	
	
	<div id="mdl-verify" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>	
			<h4>&iquest;El reclamo cumple con estas condiciones?</h4>
	  	</div>
		<div class="modal-body">		
			<ul class="list">
				<li>Es CORRECTO
					<ul class="sublist">
						<li>Ubicaci&oacute;n geogr&aacute;fica exacta (direcci&oacute;n, altura, ciudad, provincia).</li>						
						<li>Problema REAL descripta en el T&iacute;tulo y la Descripci&oacute;n.</li>
						<li>Consistencia entre texto e im&aacute;genes adjuntadas (si las hay).</li>
						<li>Buena redacci&oacute;n. Sin faltas de ortograf&iacute;a y gram&aacute;tica que impidan o dificulten la comprensi&oacute;n de la informaci&oacute;n publicada.</li>
					</ul>
				</li>
				<li>Está COMPLETO
					<ul class="sublist">
						<li>Obligatorios: t&iacute;tulo, descripci&oacute;n, categor&iacute;as (tags).</li>
						<li>Opcionales: barrio, im&aacute;genes.</li>
					</ul>
				</li>
				<li>Es PERTINENTE
					<ul class="sublist">
						<li>Constituye un <u>RECLAMO BARRIAL</u> circunscripto a los l&iacute;mites de la Rep&uacute;blica Argentina.</li>
					</ul>
				</li>
				<li>Es ACTUAL</li>
			</ul>		
		</div>
		<div class="modal-footer"> 			
			<button id="btn-verify" class="btn btn-info pull-left" aria-hidden="true" onclick="fxlIssueController.verifyOrRejectIssue('Verificar');">
			    <i class="icon-ok icon-large"></i>&nbsp;&nbsp;S&Iacute;
			</button>	  			 		  		
	  		<button id="btn-reject" class="btn btn-danger" aria-hidden="true" onclick="fxlIssueController.verifyOrRejectIssue('Rechazar');">
		    	<i class="icon-minus-sign icon-large"></i>&nbsp;&nbsp;NO
		    </button>	 
<!-- 		    <button class="btn btn-default" data-dismiss="modal" aria-hidden="true"> -->
<!-- 		    	<i class="icon-remove icon-large"></i>&nbsp;&nbsp;Cancelar -->
<!-- 		    </button>	  -->
	  	</div>
	</div>
	
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
	
	<div id="mdl-fileupload" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="fileUploadLabel" aria-hidden="true">
	  	<div class="modal-header">
	    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>		    	
	    	<h4 id="fileUploadLabel"> 
		    	Gesti&oacute;n de archivos
	    	</h4>
	  	</div>
	  	<form id="multiplefileupload" enctype="multipart/form-data" >
 			<!-- modal body -->
 			<div class="modal-body">   		
	   			<div class="alert alert-success" style="height:30px; line-height:30px; font-size:13px;"> 
	 				<i class="icon-info-sign"></i>&nbsp; Hay <b><span class="cantidadContenidos">${cantidadContenidos}</span></b> archivo(s) subido(s). <b>M&aacute;ximo:</b> 5 archivos.
				</div>   			
	   			<table id="tbl-fileupload" role="presentation" class="table table-hover">    			
	  	   		  	   	<tbody class="files">   	   		  	   	
	  	   		  	   		<c:forEach items="${contenidos}" var="contenido">	
							<tr id="${contenido.fileID}">
			    	   			<td width="100">					    	   			
				    	   			<span class="preview thumbnail" style="max-height:60px; text-align: center">
				                    	<a style="width:100px; height:60px; " href="#" title="{%=contenido.filename%}">
											<img style="max-width:100px; max-height:60px;" src="${contenido.link}">
										</a>
	          						</span>
								</td>		
								<td>
									${contenido.filenameShort}
							 	</td>								
								<td>
								${contenido.displaySize}
									
							 	</td>
							 	<td width="100" class="centered">
								 	<a href="#" class="btn btn-default btn-small btn-file-delete">
								 		<i class="icon-trash icon-large" title="Eliminar archivo"></i>
								 	</a>							 		
							 	</td>						
		    	   			</tr>
						</c:forEach>
		    	   	</tbody>
				</table> 
			</div>
			<!-- modal footer -->
		  	<div class="modal-footer">  
		  		<c:if test="${cantidadContenidos eq 5}">
			  		<span class="btn btn-danger fileinput-button disabled">
		                   <i class="icon-plus"></i>
		                   <span>Seleccionar archivos</span>
		                   <input type="file" name="files[]" disabled>
		            </span>
		  		</c:if>	  			  		
		  		<c:if test="${cantidadContenidos lt 5}">
			  		<span class="btn btn-danger fileinput-button">
		                   <i class="icon-plus"></i>
		                   <span>Seleccionar archivos</span>
		                   <input type="file" id="files" name="files[]" accept="image/*" onchange="javascript:fxlIssueController.upload();">
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
		    	Detalle de la reparaci&oacute;n del reclamo
	    	</h4>
	  	</div>
	  	<!-- modal body -->
  		<div class="modal-body">
	  		<div class="row-fluid">
	  			<div class="span6">
	  				<label>Obra / Proyecto</label>					    
		    	   	<textarea id="obra" name="obra"></textarea>	
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
	         			<input type="text" id="plazo" name="plazo"/>	
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
					<input type="text" id="fechaEstimadaInicio" name="fechaEstimadaInicio" class="repairDate" placeholder="dd/mm/aaaa"/>
	 			</div>	  				
	 			<div class="span4">	  
 					<label>Fecha estimada de finalizaci&oacute;n</label>			
					<input type="text" id="fechaEstimadaFin" name="fechaEstimadaFin"  class="repairDate" placeholder="dd/mm/aaaa"/>
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
					<input type="text" id="fechaRealInicio" name="fechaRealInicio"  class="repairDate" placeholder="dd/mm/aaaa"/>
	  			</div>	  		
	  			<div class="span4">	  
	  				<label>Fecha real de finalizaci&oacute;n</label>	
					<input type="text" id="fechaRealFin" name="fechaRealFin" class="repairDate" placeholder="dd/mm/aaaa"/>
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
	  		<button id="btn-save-repair" class="btn btn-info" aria-hidden="true">
		    	<i class="icon-ok icon-large"></i>Guardar
		    </button>  			  	
	  		<button class="btn" data-dismiss="modal" aria-hidden="true">
		    	<i class="icon-remove icon-large"></i>Cancelar
		    </button>	
	  	</div>
	  	</form>
	</div>	
<!-- fileupload templates -->
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
        	<td width="100" class="centered" colspan="2">				
            	{% if (!i && !o.options.autoUpload) { %}
                	<button class="btn btn-primary start" disabled>
                    	<i class="icon-upload"></i>
                	</button>
            	{% } %}				
            	{% if (!i) { %}				
                		<button class="btn btn-default cancel">
                    		<i class="icon-trash"></i>                    		
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
                
                    	<a style="width:100px; height:60px; " href="#" title="{%=file.name%}">
							<img style="max-width:100px; max-height:60px;" src="{%=file.url%}">
						</a>
  				
            	</span>
		</td>
        <td> 
            {% if (file.error) { %}
                <div><span class="label label-danger">Error</span> No se pudo guardar el archivo.</div>
			  {% } else { %}

			<span> {%=file.name%}</span>
			{% } %}
        </td>
		<td>
			<span class="size">{%=o.formatFileSize(file.size)%}</span>
		</td>       
        <td width="100" class="centered">
			 {% if (file.error) { %}
                		<button class="btn btn-default cancel">
                    		<i class="icon-trash"></i>                    		
                		</button>
             {% } else { %}

             <a href="#" class="btn btn-default btn-small btn-file-delete">
				<i class="icon-trash icon-large" title="Eliminar archivo"></i>
			 </a>

  			{% } %}
        </td>
    </tr>
{% } %}
</script>
</div><!-- content -->
<script type="text/javascript" src="resources/js/fixeala/fixeala.issue.js"></script>  
<script type="text/javascript" src="resources/js/fixeala/fixeala.file.js"></script>		
<script type="text/javascript">  

	$(document).ready(function(){		

		var issueID = '${id}';		
		var isVoted = '${isCurrentlyVoted}';
		var isVoteUp = '${isVoteUp}';		
		var latitud = '${latitud}';
   		var longitud = '${longitud}';
   		
		var userUrl = mapController.getUserURL('${usuario}');
		$('.reporter').html(userUrl);
	
		fxlIssueController.updatesJson = '${jsonUpdates}';
		fxlIssueController.commentsJson = '${jsonComments}';	
		fxlGlobalController.loggedUser = '${loggedUser}';
		
		fxlIssueController.updatedFields =  { "title": 0 , "desc": 0, "barrio": 0};			 
		fxlIssueController.oldFields = $.parseJSON('${oldFields}');			
		fxlIssueController.reporter = '${usuario}';
		
		if(fxlGlobalController.loggedUser != ""){
			 $('#btnAddFiles').show();
		}	
		
		bindRepairBtns();		
		fxlIssueController.tagList = '${allTags}';
   		fxlIssueController.initVote(isVoted, isVoteUp);
   		fxlIssueController.displayClosesIssues(latitud, longitud);
		fxlIssueController.initIssue(issueID);	
		
		mapController.initMiniMap(latitud, longitud, '${titulo}'); 
		
		//adds tab href to url + opens tab based on hash on page load:
		if (location.hash !== '') {
			$('a[href="' + location.hash + '"]').tab('show');
			
		}
		return $('a[data-toggle="tab"]').on('shown', function(e) {
	    	return location.hash = $(e.target).attr('href').substr(1);
	    });
				
	});
	
	function bindRepairBtns(){
		
		//add btn
		$('#btn-add-repair').live('click', function() {
			$('#btn-save-repair').prop('disabled',true);
			$('#mdl-repair').modal('show');
			$('#presupuestoAdjudicacion').val(0);
			$('#presupuestoFinal').val(0);
			$('#plazo').val(0);
		
		});
		
		//edit btn
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
		
	}
</script>