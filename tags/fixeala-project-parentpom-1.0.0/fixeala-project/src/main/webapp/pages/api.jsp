<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	section {  padding-top: 60px; }
	.table td { font-weight: normal; }
	blockquote { margin: 20px 0 40px 0; }
	blockquote p { font-size: 13px; padding: 5px 0 5px 0; }	
	h3 { display: block; padding-bottom: 10px; }	
	.muted { color: #333; }	
	code.lead { margin-right: 10px; }
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
						<p>El formato de los par&aacute;metros <code class="muted">desde</code> y <code class="muted">hasta</code> es <code class="muted">yyyyMMdd</code>.</p>
						<p>Ejemplo:  <code class="muted">/api/reclamos?desde=20140604&hasta=20140822</code></p>
					</blockquote>	
				</section>
				
				<!-- entidad info -->
				<section id="entidades-info">
					<h3>Informaci&oacute;n General</h3>					
					<p>Esta secci&oacute;n de la documentaci&oacute;n detalla las respuestas de datos devueltas por los endpoints de la API.</p>
					
					<br>
					
					<h4>Formatos</h4>					
					<p>Actualmente la API FIXEALA suporta los formatos JSON y XML.</p>
				</section>
					
				<!-- entidad base -->
				<section id="entidades-basic">
					<h3>B&aacute;sico</h3>
					
					<p>A continuaci&oacute;n se detalla la estructura base de la respuesta que devuelve cada endpoint de la API FIXEALA	.</p>
					
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
						<pre><code class=" javascript">{
    <span class="string">"data"</span>    : <span class="comment">/* mixto */</span>,
    <span class="string">"success"</span> : <span class="literal">true</span>, <span class="comment">//la consulta fue exitosa</span>
    <span class="string">"status"</span>  : <span class="number">200</span>   <span class="comment">//http status code</span>
}</code></pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre><code class=" xml"><span class="tag">&lt;<span class="title">data</span><span class="attribute"> success=<span class="value">"1"</span></span><span class="attribute"> status=<span class="value">"200"</span></span>&gt;</span><span class="tag">&lt;/<span class="title">data</span>&gt;</span></code></pre>
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
								<td>fecha</td><td>integer</td><td>fecha de publicaci&oacute;n del reclamo - formato <code class="muted">yyyyMMdd</code></td>
							</tr>
							<tr>
								<td>informante</td><td>string</td><td>nombre del usuario que public&oacute; el reclamo</td>
							</tr>
							<tr>
								<td>titulo</td><td>string</td><td>t&iacute;tulo del reclamo</td>
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
						<pre><code class=" javascript">{
    <span class="string">"data"</span>: {
        <span class="string">"id"</span>: <span class="string">12345</span>,
        <span class="string">"fecha"</span>: <span class="number">20140605</span>,
        <span class="string">"informante"</span>: <span class="string">"yo_el_reportero"</span>,
        <span class="string">"titulo"</span>: <span class="string">"Luces quemadas en toda la cuadra"</span>,
        <span class="string">"descripcion"</span>: <span class="string">"No hay luz desde hace una semana. Los postes est&aacute;n muy deteriorados."</span>,
        <span class="string">"direccion"</span>: <span class="string">"Fitz Roy 1902-2000"</span>,
        <span class="string">"barrio"</span>: <span class="literal">null</span>,
        <span class="string">"ciudad"</span>: <span class="string">"Ciudad Aut&oacute;noma de Buenos Aires"</span>,
        <span class="string">"provincia"</span>: <span class="string">"Buenos Aires"</span>,
        <span class="string">"latitud"</span>: <span class="number">-34.5818</span>,
        <span class="string">"longitud"</span>: <span class="number">-58.4344</span>,
        <span class="string">"estado"</span>: <span class="string">"abierto"</span>,
        <span class="string">"comentarios"</span>: <span class="number">11</span>,
        <span class="string">"votos"</span>: <span class="number">2</span>,
        <span class="string">"seguidores"</span>: <span class="number">1</span>,
        <span class="string">"link"</span>: <span class="string">"http://www.fixeala.com.ar/issues/12345"</span>      
    },
    <span class="string">"success"</span>: <span class="literal">true</span>,
    <span class="string">"status"</span>: <span class="number">200</span>
}</code></pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre><code class=" xml">
<span class="tag">&lt;<span class="title">data</span><span class="attribute"> success=<span class="value">"1"</span></span><span class="attribute"> status=<span class="value">"200"</span></span>&gt;</span>
    <span class="tag">&lt;<span class="title">id</span>&gt;</span>12345<span class="tag">&lt;/<span class="title">id</span>&gt;</span>
    <span class="tag">&lt;<span class="title">fecha</span>&gt;</span>20140605<span class="tag">&lt;/<span class="title">fecha</span>&gt;</span>
    <span class="tag">&lt;<span class="title">informante</span>&gt;</span>yo_el_reportero<span class="tag">&lt;/<span class="title">informante</span>&gt;</span>
    <span class="tag">&lt;<span class="title">titulo</span>&gt;</span>Luces quemadas en toda la cuadra<span class="tag">&lt;/<span class="title">titulo</span>&gt;</span>
    <span class="tag">&lt;<span class="title">descripcion</span>&gt;</span>No hay luz desde hace una semana. Los postes est&aacute;n muy deteriorados.<span class="tag">&lt;/<span class="title">descripcion</span>&gt;</span>
    <span class="tag">&lt;<span class="title">direccion</span>&gt;</span>Fitz Roy 1902-2000<span class="tag">&lt;/<span class="title">direccion</span>&gt;</span>
    <span class="tag">&lt;<span class="title">barrio</span>/&gt;</span>
    <span class="tag">&lt;<span class="title">ciudad</span>&gt;</span>Ciudad Aut&oacute;noma de Buenos Aires<span class="tag">&lt;/<span class="title">ciudad</span>&gt;</span>
    <span class="tag">&lt;<span class="title">provincia</span>&gt;</span>Buenos Aires<span class="tag">&lt;/<span class="title">provincia</span>&gt;</span>
    <span class="tag">&lt;<span class="title">latitud</span>&gt;</span>-34.5818<span class="tag">&lt;/<span class="title">latitud</span>&gt;</span>
    <span class="tag">&lt;<span class="title">longitud</span>&gt;</span>-58.4344<span class="tag">&lt;/<span class="title">longitud</span>&gt;</span>
    <span class="tag">&lt;<span class="title">estado</span>&gt;</span>abierto<span class="tag">&lt;/<span class="title">estado</span>&gt;</span>
    <span class="tag">&lt;<span class="title">comentarios</span>&gt;</span>11<span class="tag">&lt;/<span class="title">comentarios</span>&gt;</span>
    <span class="tag">&lt;<span class="title">votos</span>&gt;</span>2<span class="tag">&lt;/<span class="title">votos</span>&gt;</span>
    <span class="tag">&lt;<span class="title">seguidores</span>&gt;</span>1<span class="tag">&lt;/<span class="title">seguidores</span>&gt;</span>
    <span class="tag">&lt;<span class="title">link</span>&gt;</span>http://www.fixeala.com.ar/issues/12345<span class="tag">&lt;/<span class="title">link</span>&gt;</span>
<span class="tag">&lt;/<span class="title">data</span>&gt;</span>
</code></pre>
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
								<td>reclamo</td><td>integer</td><td>n&uacute;mero del reclamo al cual est&aacute; asociada la entidad</td>
							</tr>
							<tr>
								<td>usuario</td><td>string</td><td>nombre de usuario que actualiz&oacute; el reclamo</td>
							</tr>
							<tr>
								<td>fecha</td><td>string</td><td>fecha de la actualizaci&oacute;n - formato <code class="muted">yyyyMMdd</code></td>
							</tr>							
							<tr>
								<td>motivo</td><td>string</td><td>motivo por el cual se modific&oacute; el reclamo</td>
							</tr>							
							<tr>
								<td>estado</td><td>string</td><td>estado del reclamo tras la modificaci&oacute;n</td>
							</tr>
							<tr>
								<td>resolucion</td><td>string</td><td>tipo de resoluci&oacute;n adoptada (solucionado, duplicado, incompleto, inv&aacute;lido)</td>
							</tr>
							<tr>
								<td>observaciones</td><td>string</td><td>informaci&oacute;n adicional, opcional</td>
							</tr>
						</tbody>						
					</table>
					
					<br>
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre><code class=" javascript">{
    <span class="string">"data"</span>: {
        <span class="string">"reclamo"</span>: <span class="number">12345</span>,
        <span class="string">"usuario"</span>: <span class="string">"miguelito_88"</span>,
        <span class="string">"fecha"</span>: <span class="number">20140712</span>,
        <span class="string">"motivo"</span>: <span class="string">resolvi&oacute; el reclamo</span>,
        <span class="string">"estado"</span>: <span class="string">"resuelto"</span>,
        <span class="string">"resolucion"</span>: <span class="string">"solucionado"</span>,
        <span class="string">"observaciones"</span>: <span class="string">"Vino AySA y arregl&oacute; todo."</span>       
    },
    <span class="string">"success"</span>: <span class="literal">true</span>,
    <span class="string">"status"</span>: <span class="number">200</span>
}</code></pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre><code class=" xml">
<span class="tag">&lt;<span class="title">data</span><span class="attribute"> success=<span class="value">"1"</span></span><span class="attribute"> status=<span class="value">"200"</span></span>&gt;</span>
    <span class="tag">&lt;<span class="title">id</span>&gt;</span>2<span class="tag">&lt;/<span class="title">id</span>&gt;</span>
    <span class="tag">&lt;<span class="title">reclamo</span>&gt;</span>12345<span class="tag">&lt;/<span class="title">reclamo</span>&gt;</span>
    <span class="tag">&lt;<span class="title">usuario</span>&gt;</span>miguelito_88<span class="tag">&lt;/<span class="title">usuario</span>&gt;</span>
    <span class="tag">&lt;<span class="title">fecha</span>&gt;</span>20140712<span class="tag">&lt;/<span class="title">fecha</span>&gt;</span>
    <span class="tag">&lt;<span class="title">motivo</span>&gt;</span>resolvi&oacute; el reclamo<span class="tag">&lt;/<span class="title">motivo</span>&gt;</span>
    <span class="tag">&lt;<span class="title">estado</span>&gt;</span>resuelto<span class="tag">&lt;/<span class="title">estado</span>&gt;</span>
    <span class="tag">&lt;<span class="title">resolucion</span>&gt;</span>solucionado<span class="tag">&lt;/<span class="title">resolucion</span>&gt;</span>
    <span class="tag">&lt;<span class="title">observaciones</span>&gt;</span>Vino AySA y arregl&oacute; todo.<span class="tag">&lt;/<span class="title">observaciones</span>&gt;</span>
<span class="tag">&lt;/<span class="title">data</span>&gt;</span>
</code></pre>
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
								<td>reclamo</td><td>integer</td><td>n&uacute;mero del reclamo al cual est&aacute; asociada la entidad</td>
							</tr>
							<tr>
								<td>obra</td><td>string</td><td>nombre o descripci&oacute;n del proyecto</td>
							</tr>							
							<tr>
								<td>nro_licitacion</td><td>string</td><td>n&uacute;mero identificador de la convocatoria a licitaci&oacute;n</td>
							</tr>
							<tr>
								<td>nro_expediente</td><td>string</td><td>n&uacute;mero de expediente asociado al n&uacute;mero de licitaci&oacute;n</td>
							</tr>							
							<tr>
								<td>plazo</td><td>integer</td><td>plazo estimado de la obra en meses</td>
							</tr>
							<tr>
								<td>unidad_ejecutora</td><td>string</td><td>&aacute;rea de gobierno nacional, provincial, etc. a cargo del proyecto</td>
							</tr>
							<tr>
								<td>unidad_financiamiento</td><td>string</td><td>&aacute;rea de gobierno nacional, provincial, etc. que financia el proyecto</td>
							</tr>
							<tr>
								<td>contratista_nombre</td><td>string</td><td>nombre de la empresa contratada para realizar la reparaci&oacute;n</td>
							</tr>
							<tr>
								<td>contratista_cuit</td><td>integer</td><td>n&uacute;mero de CUIT de la empresa contratada para realizar la reparaci&oacute;n</td>
							</tr>
							<tr>
								<td>tecnico_nombre</td><td>string</td><td>nombre del representante t&eacute;cnico de la empresa contratada</td>
							</tr>
							<tr>
								<td>tecnico_matricula</td><td>string</td><td>n&uacute;mero de matr&iacute;cula del representante t&eacute;cnico de la empresa contratada</td>
							</tr>
							<tr>
								<td>presupuesto_adjudicacion</td><td>number</td><td>presupuesto estimado total de la obra</td>
							</tr>
							<tr>
								<td>presupuesto_final</td><td>number</td><td>presupuesto real total de la obra finalizada</td>
							</tr>
							<tr>
								<td>fecha_estimada_inicio</td><td>integer</td><td>fecha estimada de inicio de la obra - formato <code class="muted">yyyyMMdd</code></td>
							</tr>
							<tr>
								<td>fecha_estimada_fin</td><td>integer</td><td>fecha estimada de finalizaci&oacute;n de la obra - formato <code class="muted">yyyyMMdd</code></td>
							</tr>
							<tr>
								<td>fecha_real_inicio</td><td>integer</td><td>fecha real de inicio de la obra - formato <code class="muted">yyyyMMdd</code></td>
							</tr>
							<tr>
								<td>fecha_real_fin</td><td>integer</td><td>fecha real de finalizaci&oacute;n de la obra - formato <code class="muted">yyyyMMdd</code></td>
							</tr>
							<tr>
								<td>estado</td><td>string</td><td>estado actual de la obra</td>
							</tr>
							<tr>
								<td>observaciones</td><td>string</td><td>informaci&oacute;n adicional sobre la reparaci&oacute;</td>
							</tr>
						</tbody>						
					</table>
					
					<br>
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre><code class=" javascript">{
    <span class="string">"data"</span>: {
        <span class="string">"reclamo"</span>: <span class="number">12345</span>,
        <span class="string">"obra"</span>: <span class="string">"Ampliaci&oacute;n de la Terminal de &Oacute;mnibus"</span>,
        <span class="string">"nro_licitacion"</span>: <span class="string">"3145/14"</span>,
        <span class="string">"nro_expediente"</span>: <span class="string">"99/14"</span>,
        <span class="string">"plazo"</span>: <span class="number">6</span>,
        <span class="string">"unidad_ejecutora"</span>: <span class="string">"Secretar&iacute;a de Obras y Servicios P&uacute;blicos"</span>,
        <span class="string">"unidad_financiamiento"</span>: <span class="literal">null</span>,        
        <span class="string">"contratista_nombre"</span>: <span class="string">"Mi Empresa Construcciones S.R.L"</span>,   
        <span class="string">"contratista_cuit"</span>: <span class="number">2912345699</span>,
        <span class="string">"tecnico_nombre"</span>: <span class="string">"Ing. Roberto A. Ochoa"</span>,
        <span class="string">"tecnico_matricula"</span>: <span class="string">"27.109 CPAU"</span>,
        <span class="string">"presupuesto_adjudicacion"</span>: <span class="number">521050.96</span>,
        <span class="string">"presupuesto_final"</span>: <span class="literal">null</span>,   
        <span class="string">"fecha_estimada_inicio"</span>: <span class="number">"20140901"</span>,
        <span class="string">"fecha_estimada_fin"</span>: <span class="literal">null</span>,   
        <span class="string">"fecha_real_inicio"</span>: <span class="literal">null</span>,   
        <span class="string">"fecha_real_fin"</span>: <span class="literal">null</span>,   
        <span class="string">"estado"</span>: <span class="string">"Sin iniciar"</span>,
        <span class="string">"observaciones"</span>: <span class="literal">null</span>
    },
    <span class="string">"success"</span>: <span class="literal">true</span>,
    <span class="string">"status"</span>: <span class="number">200</span>
}</code></pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre><code class=" xml">
<span class="tag">&lt;<span class="title">data</span><span class="attribute"> success=<span class="value">"1"</span></span><span class="attribute"> status=<span class="value">"200"</span></span>&gt;</span>
    <span class="tag">&lt;<span class="title">id</span>&gt;</span>1<span class="tag">&lt;/<span class="title">id</span>&gt;</span>
    <span class="tag">&lt;<span class="title">reclamo</span>&gt;</span>12345<span class="tag">&lt;/<span class="title">reclamo</span>&gt;</span>
    <span class="tag">&lt;<span class="title">obra</span>&gt;</span>Ampliaci&oacute;n de la Terminal de &Oacute;mnibus<span class="tag">&lt;/<span class="title">obra</span>&gt;</span>
    <span class="tag">&lt;<span class="title">nro_licitacion</span>&gt;</span>3145/14<span class="tag">&lt;/<span class="title">nro_licitacion</span>&gt;</span>
    <span class="tag">&lt;<span class="title">nro_expediente</span>&gt;</span>"99/14<span class="tag">&lt;/<span class="title">nro_expediente</span>&gt;</span>
    <span class="tag">&lt;<span class="title">unidad_ejecutora</span>&gt;</span>Secretar&iacute;a de Obras y Servicios P&uacute;blicos<span class="tag">&lt;/<span class="title">unidad_ejecutora</span>&gt;</span>
    <span class="tag">&lt;<span class="title">unidad_financiamiento</span>/&gt;</span>
    <span class="tag">&lt;<span class="title">contratista_nombre</span>&gt;</span>Mi Empresa Construcciones S.R.L<span class="tag">&lt;/<span class="title">contratista_nombre</span>&gt;</span>
    <span class="tag">&lt;<span class="title">contratista_cuit</span>&gt;</span>2912345699<span class="tag">&lt;/<span class="title">contratista_cuit</span>&gt;</span>  
    <span class="tag">&lt;<span class="title">tecnico_nombre</span>&gt;</span>Ing. Roberto A. Ochoa<span class="tag">&lt;/<span class="title">tecnico_nombre</span>&gt;</span>
    <span class="tag">&lt;<span class="title">tecnico_matricula</span>&gt;</span>27.109 CPAU<span class="tag">&lt;/<span class="title">tecnico_matricula</span>&gt;</span>  
    <span class="tag">&lt;<span class="title">presupuesto_adjudicacion</span>&gt;</span>521050.96<span class="tag">&lt;/<span class="title">presupuesto_adjudicacion</span>&gt;</span>  
    <span class="tag">&lt;<span class="title">presupuesto_final</span>/&gt;</span>
    <span class="tag">&lt;<span class="title">fecha_estimada_inicio</span>&gt;</span>521916<span class="tag">&lt;/<span class="title">fecha_estimada_inicio</span>&gt;</span>  
    <span class="tag">&lt;<span class="title">fecha_estimada_fin</span>/&gt;</span>
    <span class="tag">&lt;<span class="title">fecha_real_inicio</span>/&gt;</span>
    <span class="tag">&lt;<span class="title">fecha_real_fin</span>/&gt;</span>
    <span class="tag">&lt;<span class="title">estado</span>&gt;</span>Sin iniciar<span class="tag">&lt;/<span class="title">estado</span>&gt;</span>  
    <span class="tag">&lt;<span class="title">observaciones</span>/&gt;</span>
<span class="tag">&lt;/<span class="title">data</span>&gt;</span>
</code></pre>
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
								<td>reclamo</td><td>integer</td><td>n&uacute;mero del reclamo al cual est&aacute; asociada la entidad</td>
							</tr>
							<tr>
								<td>tipo</td><td>string</td><td>tipo MIME (image/jpeg, image/png, etc.)</td>
							</tr>
							<tr>
								<td>nombre</td><td>string</td><td>nombre del archivo original</td>
							</tr>
							<tr>
								<td>orden</td><td>integer</td><td>orden en el que se muestra la imagen en el sitio FIXEALA</td>
							</tr>
							<tr>
								<td>fecha</td><td>integer</td><td>fecha de publicaci&oacute;n - formato <code class="muted">yyyyMMdd</code></td>
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
						<pre><code class=" javascript">{
    <span class="string">"data"</span>: {
        <span class="string">"id"</span>: <span class="string">"SbBGk"</span>,
        <span class="string">"reclamo"</span>: <span class="number">12345</span>,
        <span class="string">"tipo"</span>: <span class="string">"image/png"</span>,
        <span class="string">"nombre"</span>: <span class="string">"bache_01.png"</span>,
        <span class="string">"orden"</span>: <span class="number">3</span>,
        <span class="string">"fecha"</span>: <span class="number">20141205121422</span>,
        <span class="string">"ancho"</span>: <span class="number">1920</span>,
        <span class="string">"alto"</span>: <span class="number">1080</span>,        
        <span class="string">"tamano"</span>: <span class="number">521916</span>,      
        <span class="string">"link"</span>: <span class="string">"http://i.imgur.com/SbBGk.jpg"</span>,
    },
    <span class="string">"success"</span>: <span class="literal">true</span>,
    <span class="string">"status"</span>: <span class="number">200</span>
}</code></pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre><code class=" xml">
<span class="tag">&lt;<span class="title">data</span><span class="attribute"> success=<span class="value">"1"</span></span><span class="attribute"> status=<span class="value">"200"</span></span>&gt;</span>
    <span class="tag">&lt;<span class="title">id</span>&gt;</span>SbBGk<span class="tag">&lt;/<span class="title">id</span>&gt;</span>
    <span class="tag">&lt;<span class="title">reclamo</span>&gt;</span>12345<span class="tag">&lt;/<span class="title">reclamo</span>&gt;</span>
    <span class="tag">&lt;<span class="title">tipo</span>&gt;</span>image/png<span class="tag">&lt;/<span class="title">tipo</span>&gt;</span>
    <span class="tag">&lt;<span class="title">nombre</span>&gt;</span>bache_01.png<span class="tag">&lt;/<span class="title">nombre</span>&gt;</span>
    <span class="tag">&lt;<span class="title">orden</span>&gt;</span>3<span class="tag">&lt;/<span class="title">orden</span>&gt;</span>
    <span class="tag">&lt;<span class="title">fecha</span>&gt;</span>false<span class="tag">&lt;/<span class="title">fecha</span>&gt;</span>
    <span class="tag">&lt;<span class="title">ancho</span>&gt;</span>1920<span class="tag">&lt;/<span class="title">ancho</span>&gt;</span>
    <span class="tag">&lt;<span class="title">alto</span>&gt;</span>1080<span class="tag">&lt;/<span class="title">alto</span>&gt;</span>
    <span class="tag">&lt;<span class="title">tamano</span>&gt;</span>521916<span class="tag">&lt;/<span class="title">size</span>&gt;</span>  
    <span class="tag">&lt;<span class="title">link</span>&gt;</span>http://i.imgur.com/SbBGk.jpg<span class="tag">&lt;/<span class="title">link</span>&gt;</span>
<span class="tag">&lt;/<span class="title">data</span>&gt;</span>
</code></pre>
					</div>										
				</section>
				
				<!-- entidad imagen -->
				<section id="errores-example">
					<h3>Ejemplo de Error</h3>	
					
					<h4>Respuesta JSON</h4>		
					<div class="docs-example">
						<pre><code class=" javascript">{
    <span class="string">"data"</span>: {
        <span class="string">"error"</span>: <span class="string">"El recurso solicitado no existe"</span>,
        <span class="string">"request"</span>: <span class="string">"/reclamos/122.json"</span>,
        <span class="string">"method"</span>: <span class="string">"GET"</span>,
    },
    <span class="string">"success"</span>: <span class="literal">false</span>,
    <span class="string">"status"</span>: <span class="number">404</span>
}</code></pre>
					</div>
					
					<br>
					
					<h4>Respuesta XML</h4>		
					<div class="docs-example">
						<pre><code class=" xml"><span class="tag">&lt;<span class="title">data</span>&gt;</span>
    <span class="tag">&lt;<span class="title">error</span>&gt;</span>El recurso solicitado no existe<span class="tag">&lt;/<span class="title">error</span>&gt;</span>
    <span class="tag">&lt;<span class="title">request</span>&gt;</span>/reclamos/122.xml<span class="tag">&lt;/<span class="title">request</span>&gt;</span>
    <span class="tag">&lt;<span class="title">method</span>&gt;</span>GET<span class="tag">&lt;/<span class="title">method</span>&gt;</span>
<span class="tag">&lt;/<span class="title">data</span>&gt;</span>
<span class="tag">&lt;<span class="title">success</span>&gt;</span>false<span class="tag">&lt;/<span class="title">success</span>&gt;</span>
<span class="tag">&lt;<span class="title">status</span>&gt;</span>404<span class="tag">&lt;/<span class="title">status</span>&gt;</span></code></pre>
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
							<td>500</td><td>indica que se produjo un error interno inesperado, que algo del servicio de FIXEALA no funciona</td>
						</tr>
						
					</tbody>						
				</table>
			</section>  
	    	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){	
	$('.nav-list li').click(function(e) {
	    $('.nav-list li.active').removeClass('active');
	    var $this = $(this);
	    if (!$this.hasClass('active')) {
	        $this.addClass('active');
	    }
	});		
});	
</script>