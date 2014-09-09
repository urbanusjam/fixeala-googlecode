<!-- <div id="content"> -->
<!-- 	<div class="row" style="text-align:center; margin-top:200px;"> -->
<!-- 		<div class="alert alert-error fxl-alert-message"> -->
<!-- 			<h2>P&aacute;gina no encontrada</h2> -->
<!-- 		   Ups, no pudimos encontrar la p&aacute;gina que solicitaste. -->
<!-- 		</div>		 -->
<!-- 		<br><br>		 -->
<%-- 		<a href="${pageContext.request.contextPath}/index.html">Volver a la p&aacute;gina de Inicio</a>		 --%>
<!-- 	</div> -->
<!-- </div> -->


<div id="content">
	<div class="row" style="text-align:center; margin-top:200px;">
		<div class="alert alert-error fxl-alert-message">
			<h2>${messageTitle}</h2>
		   ${message}
		</div>		
		<br><br>		
		<a href="${pageContext.request.contextPath}/index.html">Volver a la p&aacute;gina de Inicio</a>		
	</div>
</div>