<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="content">
    <div class="page-header">
   	 	<h3><i class="icon-cogs"></i>&nbsp;&nbsp;Widget Web</h3>    	 	
   	</div>  
   	<p>Es un peque&ntilde;o componente web f&aacute;cil de integrar a tu sitio o blog
   		que te permitir&aacute; mostrar informaci&oacute;n referente a los &uacute;ltimos reclamos cargados en la plataforma de FIXEALA 
   		con un m&iacute;nimo bloque de c&oacute;digo. 
   	</p>
   	<div class="row-fluid">	
		<div class="span7">
			<div class="page-header" style="text-align: left !important;"><h4>C&oacute;digo HTML y JavaScript</h4></div>
			<p>Para empezar a usar el widget, copi&aacute; el siguiente c&oacute;digo e insertalo en cualquier secci&oacute;n de tu p&aacute;gina web.</p>	
			<br>
			<div class="docs-example">
				<pre>
					<code id="widget-script"></code>
				</pre>
			</div>
		</div>
		<div class="span4 pull-right" style="text-align: center;">	
			<div class="page-header" style="text-align: left;"><h4>Previsualizaci&oacute;n</h4></div>				
			<iframe style="width:370px;border:none;" onload="resizeIframe(this)" src="${pageContext.request.contextPath}/widget-web.html"></iframe>
   		</div> 	   
	</div>
</div>
<script type="text/javascript">

	function resizeIframe(iframe) {
    	iframe.height = iframe.contentWindow.document.body.scrollHeight + "px";
  	}

	$(document).ready(function(){
		
		var snippet = '\n'
					+'<script type="text/javascript">'
					+ '\n\n'
					+ '  function resizeIframe(iframe) {'
					+ '\n'
					+ '  	iframe.height = iframe.contentWindow.document.body.scrollHeight + "px";'
					+ '\n'	
					+ '  }'
					+ '\n\n'
					+ '<\/script>'
					+ '\n'
					+ '\n'
					+ '<iframe style="border:none;" onload="resizeIframe(this)" src="http://localhost:8081/fixeala/widget-web.html">'
					+ '\n'
					+ '</iframe>';
			
		$("#widget-script").text(snippet);
		
	});

</script>