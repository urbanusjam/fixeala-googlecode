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
		    		<li class="nav-header">Entidades</li>
		    		<li><a href="#entidades-issue">Reclamo</a></li>
		    		<li><a href="#entidades-history">Actualizaci&oacute;n</a></li>
		    		<li><a href="#entidades-repair">Reparaci&oacute;n</a></li>
		    		<li><a href="#entidades-image">Imagen</a></li>	
					<li class="nav-header">Manejo de Errores</li>
					<li><a href="#errores-basic">B&aacute;sico</a></li>
					<li><a href="#errores-example">Ejemplo</a></li>
					<li><a href="#errores-code">C&oacute;digos de Error</a></li>
		    	</ul>    	
	    	</div>
    	
	    	<div class="span8" style="border: 0px solid red;">
	    	
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
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos?usuario={username}</code>
					<blockquote>
						<p>Devuelve un array de entidades Reclamo filtrados por el nombre de usuario que los report&oacute;.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos?usuario=pedrito1988</code></p>
					</blockquote>		
					<code class="lead text-success">GET</code><code class="lead text-info">/api/reclamos?[campo]=[valor]</code>
					<blockquote>
						<p>Devuelve un array de entidades Reclamo con los registros encontrados por el query.</p>
						<p>Los par&aacute;metros <code class="muted">campo</code> y <code class="muted">valor</code> deben tener sus espacios separados por <code class="muted">-</code>.</p>
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
				
				<!-- endpoint reclamo -->
				<section id="entidades-basic">
					<h3>B&aacute;sica</h3>
					
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>campo</th><th>formato</th><th>descripci&oacute;n</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>data</td><td>mixto</td><td>null, boolean, integer o un objeto.</td>
							</tr>
							<tr>
								<td>success</td><td>boolean</td><td>determina si la consulta se ejecut&oacute; con &eacute;xito.</td>
							</tr>
							<tr>
								<td>status</td><td>integer</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
						</tbody>						
					</table>
					
					<div class="docs-example">
						<pre>
							<code class="json"></code>
						</pre>
					</div>
					
				</section>
					
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
								<td>id</td><td>integer</td><td>null, boolean, integer o un objeto.</td>
							</tr>
							<tr>
								<td>fecha</td><td>integer</td><td>determina si la consulta se ejecut&oacute; con &eacute;xito.</td>
							</tr>
							<tr>
								<td>titulo</td><td>string</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>descripcion</td><td>string</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>direccion</td><td>string</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>barrio</td><td>string</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>ciudad</td><td>string</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>provincia</td><td>string</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>latitud</td><td>float</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>longitud</td><td>float</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>estado</td><td>float</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>comentarios</td><td>integer</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>votos</td><td>integer</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>seguidores</td><td>integer</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
							<tr>
								<td>link</td><td>string</td><td>c&oacute;digo de estado del HTTP.</td>
							</tr>
						</tbody>						
					</table>
					
					
					<div class="docs-example">
						<pre>
							<code class="json"></code>
						</pre>
					</div>
				</section>
	    	
	    	
	    	</div>
    	
    	

		
   	    
   		<!-- /API REST -->
</div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/vendor.js"></script>	