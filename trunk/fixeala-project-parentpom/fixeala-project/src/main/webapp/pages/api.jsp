<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link type="text/css" href="${pageContext.request.contextPath}/resources/css/docs.css" rel="stylesheet">


<div id="content">
		
		<!-- API REST -->
	    <div class="page-header">
    	 	<h3><i class="icon-bullseye"></i>&nbsp;&nbsp;REST API</h3>    	 	
    	</div>    	
    	
    	<div class="row">
    	
    	<div class="span3 bs-docs-sidebar">    	
	    	<ul id="nav-bar" class="nav nav-list bs-docs-sidenav affix">
	    		<li class="nav-header">Rutas</li>
	    		<li class="active"><a href="#rutas-categoria">Categorías</a></li>
	    		<li><a href="#rutas-grupos">Grupos</a></li>
	    		<li><a href="#rutas-recursos">Recursos</a></li>
	    		<li><a href="#rutas-query">Query</a></li>
	    		<li class="nav-header">Tipos de Respuesta</li>
	    		<li><a href="#respuestas-parcial">Parcial</a></li>
	    		<li class="nav-header">Entidades</li>
	    		<li><a href="#entidades-categoria">Categoría</a></li>
	    		<li><a href="#entidades-grupo">Grupo</a></li>
	    		<li><a href="#entidades-recurso">Recurso</a></li>
	    	</ul>    	
    	</div>
    	
    	<div class="span7"><section id="introduccion"><p>La organización de las rutas es horizontal, no sigue una estructura 
de directorios ya que la misión de la API es acceder a los datos 
de los recursos de forma simple. Es por eso que las rutas 
Categorías y Grupos fueron ideadas para navegar la API hasta encontrar
el recurso necesario, para luego utilizar sólo la ruta Recursos al obtener
la información deseada.</p><p>Toda consulta tiene un <code>máximo de 200 registros</code>. Esto es provisorio, ya que 
no tiene otras restricciones (como claves de acceso o API Keys para manejar
la cantidad de pedidos periodicos por usuario) y desconozco 
la cantidad de accesos y/o utilización que le pueden dar.</p><code>El estado de la API es ALPHA (experimental), no garantizo la totalidad 
ni la integridad de los datos.</code></section><section id="rutas-categoria"><h3>Categorías </h3><code class="lead text-success">GET</code> <code class="lead text-info">/api/categorias</code><a href="#respuestas-parcial"> <span class="text-warning"> [Respuesta Parcial]</span></a><blockquote><p>Devuelve un array con todas las categorías disponibles.</p></blockquote><code class="lead text-success">GET</code> <code class="lead text-info">/api/categorias/[nombre]</code><blockquote><p>Devuelve una entidad Categoria con sus Grupos.</p><p>El parámetro <code class="muted">nombre</code> debe tener sus espacios separados por <code class="muted">-</code></p><p>Ejemplo:  <code class="muted">/api/categorias/transporte-y-movilidad</code></p></blockquote></section><section id="rutas-grupos"><h3>Grupos</h3><code class="lead text-success">GET</code> <code class="lead text-info">/api/grupos</code><a href="#respuestas-parcial"> <span class="text-warning"> [Respuesta Parcial]</span></a><blockquote><p>Devuelve un array con todos los grupos disponibles.</p></blockquote><code class="lead text-success">GET</code> <code class="lead text-info">/api/grupos/[nombre]</code><blockquote><p>Devuelve una entidad Grupo con sus Recursos.</p><p>El parámetro <code class="muted">nombre</code> debe tener sus espacios separados por <code class="muted">-</code></p><p>Ejemplo:  <code class="muted">/api/grupos/bicicletas-publicas</code></p></blockquote></section><section id="rutas-recursos"><h3>Recursos</h3><code class="lead text-success">GET</code> <code class="lead text-info">/api/recursos</code><a href="#respuestas-parcial"> <span class="text-warning"> [Respuesta Parcial]</span></a><blockquote><p>Devuelve un array con todos los recursos disponibles.</p></blockquote><code class="lead text-success">GET</code> <code class="lead text-info">/api/recursos/[nombre]</code><blockquote><p>Devuelve una entidad Recurso con sus registros. </p><p>El parámetro <code class="muted">nombre</code> debe tener sus espacios separados por <code class="muted">-</code></p><p>Ejemplo:  <code class="muted">/api/recursos/recorridos-realizados-en-bicicleta  </code></p></blockquote></section><section id="rutas-query"><h3>Query <code class="warning"> 
(experimental)</code></h3><code class="lead text-success">GET</code> <code class="lead text-info">/api/recursos/[nombre]?[campo]=[valor]</code><blockquote><p>Devuelve una entidad Recurso con los registros encontrados por el query. </p><p>El parámetro <code class="muted">nombre</code> debe tener sus espacios separados por <code class="muted">-</code></p><p>Los parámetros  <code class="muted">campo</code> y <code class="muted">valor</code> varian dependiendo de los campos del recurso y se utilizan para 
realizar consultas sobre sus registros</p><p>Ejemplo:  <code class="muted">/api/recursos/recorridos-realizados-en-bicicleta?origen=catedral&amp;usuario=user1234  </code></p></blockquote></section><section id="respuestas-parcial"><h3>Respuestas Parciales </h3><p>Las respuestas Parciales  <b>SÓLO </b>devuelven la información de la entidad necesaria para su navegación.</p><p>Ejemplo de una respuesta parcial de un Grupo: </p><div class="docs-example"><pre><code class="json">{ 
  "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Bicicleterías en la Ciudad"</span></span>,
  "<span class="attribute">descripcion</span>": <span class="value"><span class="string">"Listado de bicicleterías de la Ciudad de Buenos Aires."</span></span>,
  "<span class="attribute">categoria</span>": <span class="value"><span class="string">"http://apicaba.com/api/categorias/transporte-y-movilidad"</span></span>,
  "<span class="attribute">uri</span>": <span class="value"><span class="string">"http://apicaba.com/api/grupos/bicicleterías-en-la-ciudad"</span>
</span>}</code></pre></div></section><section id="entidades-categoria"><h3>Categoría </h3><p>Conjunto de Grupos.</p><p>Posee la información necesaria para obtener el detalle de sus grupos.</p><div class="docs-fields"><dl class="dl-horizontal"><dt>nombre</dt><dd>Nombre de la Categoría</dd><dt>grupos</dt><dd>Array de entidades Grupo (parciales)</dd></dl></div><div class="docs-example"><pre><code class="json">{
  "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Transporte y Movilidad"</span></span>,
  "<span class="attribute">grupos</span>": <span class="value">[
    {
      "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Bicicletas Públicas"</span></span>,
      "<span class="attribute">descripcion</span>": <span class="value"><span class="string">"Información del sistema de transporte público de bicicletas."</span></span>,
      "<span class="attribute">categoria</span>": <span class="value"><span class="string">"transporte-y-movilidad"</span></span>,
      "<span class="attribute">uri</span>": <span class="value"><span class="string">"http://apicaba.com/api/grupos/bicicletas-públicas"</span>
    </span>},
    {
      "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Bicicleterías en la Ciudad"</span></span>,
      "<span class="attribute">descripcion</span>": <span class="value"><span class="string">"Listado de bicicleterías de la Ciudad de Buenos Aires."</span></span>,
      "<span class="attribute">categoria</span>": <span class="value"><span class="string">"transporte-y-movilidad"</span></span>,
      "<span class="attribute">uri</span>": <span class="value"><span class="string">"http://apicaba.com/api/grupos/bicicleterías-en-la-ciudad"</span>
    </span>}
  ]
</span>}</code></pre></div></section><section id="entidades-grupo"><h3>Grupo </h3><p>Conjunto de Recursos.</p><p>Posee la información necesaria para obtener el detalle de sus recursos, como así también su categoría.</p><div class="docs-fields"><dl class="dl-horizontal"><dt>nombre</dt><dd>Nombre del Grupo</dd><dt>descripcion</dt><dd>Breve descripción del Grupo</dd><dt>categoria</dt><dd>Entidad Categoria a la que pertenece el Grupo</dd><dt>recursos</dt><dd>Array de entidades Recurso (parciales)</dd></dl></div><div class="docs-example"><pre><code class="json">{
  "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Bicicleterías en la Ciudad"</span></span>,
  "<span class="attribute">descripcion</span>": <span class="value"><span class="string">"Listado de bicicleterías de la Ciudad de Buenos Aires."</span></span>,
  "<span class="attribute">categoria</span>": <span class="value">{
    "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Transporte y Movilidad"</span></span>,
    "<span class="attribute">uri</span>": <span class="value"><span class="string">"http://apicaba.com/api/categorias/transporte-y-movilidad"</span>
  </span>}</span>,
  "<span class="attribute">recursos</span>": <span class="value">[{
      "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Estaciones de Bicicletas"</span></span>,
      "<span class="attribute">descripcion</span>": <span class="value"><span class="string">"Nombre, ID, referencia geográfica, dirección, latitud y longitud."</span></span>,
      "<span class="attribute">uri</span>": <span class="value"><span class="string">"http://apicaba.com/api/recursos/estaciones-de-bicicletas"</span>
  </span>}]
</span>}</code></pre></div></section><section id="entidades-recurso"><h3>Recurso </h3><p>Un recurso es equivalente a un DataSet en BA Open Data.</p><p>Posee la información del DataSet y una pre-visualización de sus valores.</p><div class="docs-fields"><dl class="dl-horizontal"><dt>nombre</dt><dd>Nombre del Recurso/ DataSet</dd><dt>descripcion</dt><dd>Breve descripción del Recurso/ DataSet</dd><dt>grupo</dt><dd>Entidad Grupo a la que pertenece el Recurso/ DataSet</dd><dt>cantidad</dt><dd>Cantidad de datos disponibles en su totalidad</dd><dt>propiedades</dt><dd>Array de Propiedades que posee cada JSON en el DataSet, siendo:<dl class="dl-horizontal"><dt>nombre</dt><dd>Nombre del campo</dd><dt>tipo</dt><dd>Tipo de Dato de su valor (actualmente son todos String)</dd></dl></dd><dt>datos</dt><dd>Array de JSON (registros). Máximo 200 registros.</dd></dl></div><div class="docs-example"><pre><code class="json">{
  "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Estaciones de Bicicletas"</span></span>,
  "<span class="attribute">descripcion</span>": <span class="value"><span class="string">"Nombre, ID, referencia geográfica, dirección, latitud y longitud ..."</span></span>,
  "<span class="attribute">grupo</span>": <span class="value">{
    "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Bicicletas Públicas"</span></span>,
    "<span class="attribute">descripcion</span>": <span class="value"><span class="string">"Información del sistema de transporte público de bicicletas."</span></span>,
    "<span class="attribute">uri</span>": <span class="value"><span class="string">"http://apicaba.com/api/grupos/bicicletas-públicas"</span></span>,
    "<span class="attribute">categoria</span>": <span class="value">{ 
      "<span class="attribute">nombre</span>": <span class="value"><span class="string">"Transporte y Movilidad"</span></span>,
      "<span class="attribute">uri</span>": <span class="value"><span class="string">"http://apicaba.com/api/categorias/transporte-y-movilidad"</span>
    </span>}
  </span>}</span>,
  "<span class="attribute">cantidad</span>": <span class="value"><span class="number">28</span></span>,
  "<span class="attribute">propiedades</span>": <span class="value">[{
      "<span class="attribute">nombre</span>": <span class="value"><span class="string">"estacionId"</span></span>,
      "<span class="attribute">tipo</span>": <span class="value"><span class="string">"string"</span>
    </span>}, {
      "<span class="attribute">nombre</span>": <span class="value"><span class="string">"estacionNombre"</span></span>,
      "<span class="attribute">tipo</span>": <span class="value"><span class="string">"string"</span>
    </span>}, {
      "<span class="attribute">nombre</span>": <span class="value"><span class="string">"latitud"</span></span>,
      "<span class="attribute">tipo</span>": <span class="value"><span class="string">"string"</span>
    </span>}, {
      "<span class="attribute">nombre</span>": <span class="value"><span class="string">"longitud"</span></span>,
      "<span class="attribute">tipo</span>": <span class="value"><span class="string">"string"</span>
    </span>}]</span>,
  "<span class="attribute">datos</span>": <span class="value">[{
      "<span class="attribute">estacionId</span>": <span class="value"><span class="string">"3"</span></span>,
      "<span class="attribute">estacionNombre</span>": <span class="value"><span class="string">"RETIRO"</span></span>,
      "<span class="attribute">latitud</span>": <span class="value"><span class="string">"-34.592308"</span></span>,
      "<span class="attribute">longitud</span>": <span class="value"><span class="string">"-58.37501"</span>
    </span>}, {
      "<span class="attribute">estacionId</span>": <span class="value"><span class="string">"5"</span></span>,
      "<span class="attribute">estacionNombre</span>": <span class="value"><span class="string">"ADUANA"</span></span>,
      "<span class="attribute">latitud</span>": <span class="value"><span class="string">"-34.611365"</span></span>,
      "<span class="attribute">longitud</span>": <span class="value"><span class="string">"-58.369077"</span>
    </span>}, {
      "<span class="attribute">estacionId</span>": <span class="value"><span class="string">"6"</span></span>,
      "<span class="attribute">estacionNombre</span>": <span class="value"><span class="string">"DERECHO"</span></span>,
      "<span class="attribute">latitud</span>": <span class="value"><span class="string">"-34.583669"</span></span>,
      "<span class="attribute">longitud</span>": <span class="value"><span class="string">"-58.391243"</span>
    </span>}]
</span>}</code></pre></div></section></div>
    	
    	

		</div>
   	    
   		<!-- /API REST -->
</div>