<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link type="text/css" href="${pageContext.request.contextPath}/resources/css/docs.css" rel="stylesheet">
<link type="text/css" href="${pageContext.request.contextPath}/resources/css/highlight.css" rel="stylesheet">


<script>


</script>
<style>

section {
  padding-top: 60px;
}
	.table td { font-weight: normal; }

	blockquote { margin: 20px 0 40px 0; }
	blockquote p { font-size: 13px; padding: 5px 0 5px 0; }
	
	h3 { display: block; padding-bottom: 10px; }
	
	.muted { color: #333; }
	
	code.lead { margin-right: 10px; }
/* 	.lead {font-size: 18px; } */

.bs-docs-sidenav > .active > a {
  position: relative;
  z-index: 2;
  padding: 9px 15px;
  border: 0;
  text-shadow: 0 1px 0 rgba(0,0,0,.15);
  -webkit-box-shadow: inset 1px 0 0 rgba(0,0,0,.1), inset -1px 0 0 rgba(0,0,0,.1);
     -moz-box-shadow: inset 1px 0 0 rgba(0,0,0,.1), inset -1px 0 0 rgba(0,0,0,.1);
          box-shadow: inset 1px 0 0 rgba(0,0,0,.1), inset -1px 0 0 rgba(0,0,0,.1);
}
</style>

<div id="content" style="border: 0px solid red">
		
		<!-- API REST -->
	    <div class="page-header">
    	 	<h3><i class="icon-bullseye"></i>&nbsp;&nbsp;REST API</h3>    	 	
    	</div>    	
    	
    	
	    	<div class="span3 bs-docs-sidebar">    	
		    	<ul id="nav-bar" class="nav nav-list bs-docs-sidenav affix-top" data-offset-top="120" data-spy="affix">
		    		<li class="nav-header">Rutas / Endpoints</li>
		    		<li class="active"><a href="#rutas-issue">Reclamos</a></li>		
		    		<li><a href="#rutas-history">Actualizaciones</a></li>			
		    		<li><a href="#rutas-repair">Reparaciones</a></li>			
		    		<li><a href="#rutas-image">Im&aacute;genes</a></li>			    		
		    		<li><a href="#rutas-query">Query</a></li>		    
		    		<li class="nav-header">Modelos de Datos</li>
		    		<li><a href="#entidades-info">Informaci&oacute;n General</a></li>
		    		<li><a href="#entidades-basic">B&aacute;sico</a></li>
		    		<li><a href="#entidades-issue">Reclamo</a></li>
		    		<li><a href="#entidades-history">Actualizaci&oacute;n</a></li>
		    		<li><a href="#entidades-repair">Reparaci&oacute;n</a></li>
		    		<li><a href="#entidades-image">Imagen</a></li>	
					<li class="nav-header">Manejo de Errores</li>					
					<li><a href="#errores-example">Ejemplo de Error</a></li>
					<li><a href="#errores-code">C&oacute;digos de Error</a></li>
		    	</ul>    	
	    	</div>
    	
	    	<div class="span8" style="border: 0px solid red; margin-bottom: 70px;">
	    	
	    		<!-- introduccion -->
<%-- 	    		<section id="introduccion"> --%>
<!-- 	    			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sed malesuada nulla. Fusce pretium, dui quis molestie fermentum, nunc quam placerat tortor, gravida euismod est tortor in ex. Suspendisse potenti. Cras ultrices turpis et tortor eleifend, at consectetur orci maximus. Nulla facilisi. Phasellus blandit finibus tortor, a accumsan dui. Sed malesuada mauris vel magna auctor, ac dignissim metus placerat. Donec sodales tortor id ligula placerat, at venenatis tortor fringilla.</p> -->
<%-- 	    			<code>El estado de la API es ALPHA (experimental), no garantizo la totalidad ni la integridad de los datos.</code> --%>
<%-- 				</section> --%>
				
				<!-- endpoint reclamo -->
				<section id="rutas-issue">
					<h3>Reclamos</h3>
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos</code>
					<blockquote>
						<p>Devuelve un array con todos los reclamos disponibles..</p>
						<p>Por default NO devuelve los que est&aacute;n en estado "Archivado".</p>
					</blockquote>
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos/{reclamoID}</code>
					<blockquote>
						<p>Devuelve una entidad Reclamo.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos/12345</code></p>
					</blockquote>
				</section>
				
				<!-- endpoint actualizacion -->
				<section id="rutas-history">
					<h3>Actualizaciones</h3>
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos/{reclamoID}/actualizaciones</code>
					<blockquote>
						<p>Devuelve una array con el historial de actualizaciones correspondiente al n&uacute;mero de reclamo provisto.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos/12345/actualizaciones</code></p>
					</blockquote>
				</section>
				
				<!-- endpoint reparacion -->
				<section id="rutas-repair">
					<h3>Reparaciones</h3>
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos/{reclamoID}/reparaciones</code>
					<blockquote>
						<p>Devuelve una entidad Reparaci&oacute;n correspondiente al n&uacute;mero de reclamo provisto.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos/12345/reparaciones</code></p>
					</blockquote>
				</section>
				
				<!-- endpoint imagenes -->
				<section id="rutas-image">
					<h3>Im&aacute;genes</h3>
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos/{reclamoID}/imagenes</code>
					<blockquote>
						<p>Devuelve una entidad Imagen correspondiente al n&uacute;mero de reclamo provisto.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos/12345/imagenes</code></p>
					</blockquote>
				</section>
				
				<!-- endpoint query -->
				<section id="rutas-query">
					<h3>Query</h3>
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos?[campo]=[valor]</code>
					<blockquote>
						<p>Devuelve un array de entidades Reclamo con los registros encontrados por el query.</p>
						<p>Los par&aacute;metros <code class="muted">campo</code> y <code class="muted">valor</code> deben tener sus espacios separados por <code class="muted">-</code>.</p>
					</blockquote>		
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos?usuario={username}</code>
					<blockquote>
						<p>Devuelve un array de entidades Reclamo filtrados por el nombre de usuario que los report&oacute;.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos?usuario=pedrito1988</code></p>
					</blockquote>
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos?provincia={provincia}&ciudad={ciudad}</code>
					<blockquote>
						<p>Devuelve un array de entidades Reclamo filtardos por Provincia y Ciudad.</p>
						<p>Los par&aacute;metros <code class="muted">provincia</code> y <code class="muted">ciudad</code> son opcionales pero al menos uno de ellos debe ser informado.
						<p>Ejemplo:  <code class="muted">/api/reclamos?provincia=la-pampa&ciudad=santa-rosa</code></p>
					</blockquote>						
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos?estado={estado1,estado2,estadoN}</code>
					<blockquote>
						<p>Devuelve un array de entidades Reclamo filtrados por Estado.</p>
						<p>Los valores posibles para el par&aacute;metro <code class="muted">estado</code> son: Abierto, Resuelto, Cerrado, Archivado y Reabierto.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos?estado=abierto,resuelto</code></p>
					</blockquote>	
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos?categoria={categoria1,categoria2,categoriaN}</code>
					<blockquote>
						<p>Devuelve un array de entidades Reclamo filtrados por Categor&iacute;a.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos?categoria=bache,alumbrado,residuos,mamposteria</code></p>
					</blockquote>	
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos?desde={fechaDesde}&hasta={fechaHasta}</code>
					<blockquote>
						<p>Devuelve un array de entidades Reclamo filtrados por Fecha de Publicaci&oacute;n.</p>
						<p>El formato de los par&aacute;metros <code class="muted">desde</code> y <code class="muted">hasta</code> es <code class="muted">DD-MM-AAAA</code>.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos?desde=14-06-2014&hasta=22-08-2014</code></p>
					</blockquote>	
				</section>
				
				<!-- entidad info -->
				<section id="entidades-info">
					<h3>Informaci&oacute;n General</h3>					
					<p>Esta secci&oacute;n de la documentaci&oacute;n detalla las respuestas de datos devueltas por los endpoints de la API.</p>
					
					<br>
					
					<h4>Formatos</h4>					
					<p>Actualmente la API Fixeala suporta los formatos JSON y XML.</p>
				</section>
					
				<!-- entidad base -->
				<section id="entidades-basic">
					<h3>B&aacute;sico</h3>
					
					<p>A continuaci&oacute;n se detalla la estructura base de la respuesta que devuelve cada endpoint de la API Fixeala.</p>
					
					<br>
					
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>campo</th><th>formato</th><th>descripci&oacute;n</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>data</td><td>mixto</td><td>devuelve null, un objeto o array de objetos (por ejemplo, un array de entidades Reclamo)</td>
							</tr>
							<tr>
								<td>success</td><td>boolean</td><td>determina si la consulta se ejecut&oacute; con &eacute;xito</td>
							</tr>
							<tr>
								<td>status</td><td>integer</td><td>c&oacute;digo de estado del HTTP (ver <a href="#errores-code">listado completo de errores</a>)</td>
							</tr>
						</tbody>						
					</table>
					
					<br>
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre>
							<code class="json"></code>
						</pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre>
							<code class="xml"></code>
						</pre>
					</div>					
				</section>
					
				<!-- entidad reclamo -->
				<section id="entidades-issue">
					<h3>Reclamo</h3>					
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>campo</th><th>formato</th><th>descripci&oacute;n</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>id</td><td>integer</td><td>null, boolean, integer o un objeto</td>
							</tr>
							<tr>
								<td>fecha</td><td>integer</td><td>determina si la consulta se ejecut&oacute; con &eacute;xito</td>
							</tr>
							<tr>
								<td>titulo</td><td>string</td><td>t&iaute;tulo del reclamo</td>
							</tr>
							<tr>
								<td>descripcion</td><td>string</td><td>descripci&oacute;n del reclamo</td>
							</tr>
							<tr>
								<td>direccion</td><td>string</td><td>calle y altura</td>
							</tr>
							<tr>
								<td>barrio</td><td>string</td><td>opcional</td>
							</tr>
							<tr>
								<td>ciudad</td><td>string</td><td>nombre de la ciudad donde se localiza el reclamo</td>
							</tr>
							<tr>
								<td>provincia</td><td>string</td><td>nombre de la provincia donde se localiza el reclamo</td>
							</tr>
							<tr>
								<td>latitud</td><td>float</td><td>coordenadas de latitud</td>
							</tr>
							<tr>
								<td>longitud</td><td>float</td><td>coordenadas de longitud</td>
							</tr>
							<tr>
								<td>estado</td><td>float</td><td>situaci&oacute;n actual del reclamo (abierto, resuelto, etc)</td>
							</tr>
							<tr>
								<td>comentarios</td><td>integer</td><td>cantidad de comentarios publicados en el reclamo</td>
							</tr>
							<tr>
								<td>votos</td><td>integer</td><td>cantidad de votos recibidos por parte de los usuarios</td>
							</tr>
							<tr>
								<td>seguidores</td><td>integer</td><td>cantidad de usuarios que siguen el reclamo</td>
							</tr>
							<tr>
								<td>link</td><td>string</td><td>url de acceso a la p&aacute;gina del reclamo</td>
							</tr>
						</tbody>						
					</table>
					
					<br>
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre>
							<code class="json"></code>
						</pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre>
							<code class="xml"></code>
						</pre>
					</div>
					
				</section>
				
				<!-- entidad actualizacion -->
				<section id="entidades-history">
					<h3>Actualizaci&oacute;n</h3>					
						
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>campo</th><th>formato</th><th>descripci&oacute;n</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>id</td><td>integer</td><td>identificador de la entidad</td>
							</tr>
							<tr>
								<td>id_reclamo</td><td>integer</td><td>n&uacute;mero del reclamo al cual est&aacute; asociada la entidad</td>
							</tr>
							<tr>
								<td>usuario</td><td>string</td><td>nombre de usuario que actualiz&oacute; el reclamo</td>
							</tr>
							<tr>
								<td>fecha</td><td>string</td><td>fecha de la actualizaci&oacute;n</td>
							</tr>							
							<tr>
								<td>motivo</td><td>string</td><td>motivo por el cual se modific&oacute; el reclamo</td>
							</tr>							
							<tr>
								<td>estado</td><td>string</td><td>estado del reclamo tras la modificaci&oacute;n</td>
							</tr>
							<tr>
								<td>resolution</td><td>string</td><td>tipo de resoluci&oacute;n adoptada (solucionado, duplicado, incompleto, inv&aacute;lido)</td>
							</tr>
							<tr>
								<td>observaciones</td><td>string</td><td>informaci&oacute;n adicional, opcional</td>
							</tr>
						</tbody>						
					</table>
					
					<br>
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre>
							<code class="json"></code>
						</pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre>
							<code class="xml"></code>
						</pre>
					</div>
										
				</section>
				
					<!-- entidad reparacion -->
				<section id="entidades-repair">
					<h3>Reparaci&oacute;n</h3>					
						
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>campo</th><th>formato</th><th>descripci&oacute;n</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>data</td><td>mixto</td><td>null, boolean, integer o un objeto</td>
							</tr>
							<tr>
								<td>id</td><td>integer</td><td>determina si la consulta se ejecut&oacute; con &eacute;xito</td>
							</tr>
							<tr>
								<td>id_reclamo</td><td>integer</td><td>determina si la consulta se ejecut&oacute; con &eacute;xito</td>
							</tr>
							<tr>
								<td>obra</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>							
							<tr>
								<td>nro_licitacion</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>nro_expediente</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>							
							<tr>
								<td>plazo</td><td>integer</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>unidad_ejecutora</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>unidad_financiamiento</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>contratista_nombre</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>contratista_cuit</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>tecnico_nombre</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>tecnico_matricula</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>presupuesto_adjudicacion</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>presupuesto_final</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>fecha_estimada_inicio</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>fecha_estimada_fin</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>fecha_real_inicio</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>fecha_real_fin</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>estado</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
							<tr>
								<td>observaciones</td><td>string</td><td>c&oacute;digo de estado del HTTP</td>
							</tr>
						</tbody>						
					</table>
					
					<br>
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre>
							<code class="json"></code>
						</pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre>
							<code class="xml"></code>
						</pre>
					</div>
										
				</section>
				
				<!-- entidad imagen -->
				<section id="entidades-image">
					<h3>Imagen</h3>					
						
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>campo</th><th>formato</th><th>descripci&oacute;n</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>id</td><td>string</td><td>el identificador de la imagen generado por el servicio de hosting IMGUR</td>
							</tr>
							<tr>
								<td>tipo</td><td>string</td><td>tipo MIME (image/jpeg, image/png, etc.)</td>
							</tr>
							<tr>
								<td>nombre</td><td>string</td><td>nombre del archivo original</td>
							</tr>
							<tr>
								<td>orden</td><td>integer</td><td>orden en el que se muestra la imagen en el sitio de fixeala</td>
							</tr>
							<tr>
								<td>fecha</td><td>integer</td><td>fecha de publicacion en fixeala</td>
							</tr>
							<tr>
								<td>ancho</td><td>integer</td><td>el ancho de la imagen en pixeles</td>
							</tr>
							<tr>
								<td>alto</td><td>integer</td><td>la altura de la imagen en pixeles</td>
							</tr>
							<tr>
								<td>tamano</td><td>integer</td><td>tama&ntilde;o de la imagen en bytes</td>
							</tr>							
							<tr>
								<td>link</td><td>integer</td><td>url directa a la imagen en IMGUR.com</td>
							</tr>
						</tbody>						
					</table>
					
					<br>
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre>
							<code class="json"></code>
						</pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre>
							<code class="xml"></code>
						</pre>
					</div>										
				</section>
				
				<!-- entidad imagen -->
				<section id="errores-example">
					<h3>Ejemplo de Error</h3>	
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre>
							<code class="json"></code>
						</pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre>
							<code class="xml"></code>
						</pre>
					</div>	
				</section>
				
				<!-- entidad imagen -->
				<section id="errores-code" style="border-bottom: none;">
					<h3>C&oacute;digos de Error</h3>	
					
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>c&oacute;digo</th><th>descripci&oacute;n</th>
							</tr>
						</thead>
						<tbody>							
							<tr>
								<td>200</td><td>la consulta se ejecut&oacute; con &eacute;xito y no se produjeron errores</td>
							</tr>
							<tr>
								<td>400</td><td>indica que hay uno o varios par&oacute;metros faltantes o que el valor de un par&oacute;metro est&aacute; fuera de los l&iacute;mites o es incorrecto.</td>
							</tr>
							<tr>
								<td>404</td><td>indica que el recurso solicitado no existe. Por ejemplo: solicitar un reclamo que no existe</td>
							</tr>
							<tr>
								<td>500</td><td>indica que se produjo un error interno inesperado, que algo del servicio de fixeala no funciona</td>
							</tr>
							
						</tbody>						
					</table>
				</section>
	    	
	    	
	    	</div>
    	
    	

		
   	    
   		<!-- /API REST -->
</div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/vendor.js"></script>	