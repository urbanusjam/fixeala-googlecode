<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF8">
	<title>Fixeala Widget</title>	
	<link type="text/css" href="http://localhost:8080/fixeala/widget/css/bootstrap.css" rel="stylesheet">  	
	<link type="text/css" href="http://localhost:8080/fixeala/widget/css/bootstrap-combined.min.css" rel="stylesheet">  	
	<link type="text/css" href="http://localhost:8080/fixeala/widget/css/bootstrap-responsive.css" rel="stylesheet">  	
	<link type="text/css" href="http://localhost:8080/fixeala/widget/css/widget.css" rel="stylesheet">  	
</head>
<body class="widget">

	<div class="widget-container">
		
	
			<ul class="nav nav-tabs">
				<li class="active"><a href="#recent" data-toggle="tab">Recientes</a></li>
				<li><a href="#stats" data-toggle="tab">Indicadores</a></li>		
			</ul>	
		
					
			
		
			<div class="widget-refresh">
				<a href="#" id="refreshWidget" title="Actualizar listado">
				Recargar
					<img alt="Actualizar listado de reclamos" width="20" height="20"
								src="http://localhost:8080/fixeala/widget/images/reload.png" />
				</a>
			</div>
			<div class="widget-body">	
		
			<!-- Tab 1 RECENT -->
			<div class="tab-pane fade in active" id="recent">		
				
					<c:if test="${totalIssues gt 0}">
						<c:forEach items="${issueList}" var="issue">							
							<div class="widget-row">
								<span class="title">
									<a href="#" title="${issue.title}" onclick="redirectIssueURL('${issue.id}', '${issue.title}');">${issue.title}</a>
								</span>		
								<span class="address">${issue.city} &raquo; ${issue.province}</span>	
								<span class="row">
									<span class="date">${issue.fechaFormateada}</span>
									<span class="status" style="background-color: ${issue.statusCss}">${issue.status}</span>								
								</span>	
								<div class="inline-container">
									<div class="left"><i class="icon icon-map-marker icon-small"></i><span class="numIssues">${issue.totalVotes}</span></div>
<%-- 									<div class="right"><i class="icon icon-comments-alt icon-small"></i><span class="numComments">${issue.comentarios}</span></div> --%>
									<div class="center"><i class="icon icon-ok icon-small"></i><span class="numFixes">${issue.totalFollowers}</span></div>
								</div>				
							</div>
						</c:forEach>					
					</c:if>	
					<c:if test="${totalIssues eq 0}">	
						<div class="widget-error">					
							<p>${errorMessage}</p>		
						</div>
					</c:if>	
				<div class="widget-error" style="display: none">				
				</div>				
			</div>		
		
			<!-- Tab 2 STATS -->	
			<div class="tab-pane fade" id="stats">	
		
				Totales ${totalIssues}
				Totales ${totalOpen}
				Totales ${totalReopened}
				Totales ${totalResolved}
				Totales ${totalClosed}
				</div>
				<div class="widget-error" style="display: none">				
				</div>	
			
		</div>	
		
		<div class="widget-footer">						
			<div class="logo">
				<a href="http://localhost:8080/fixeala" target="_blank" title="Fixeala - Tu plataforma colaborativa de reporte ciudadano">
					<i>&copy; <strong>FIXEALA</strong></i>
				</a>
			</div>
		</div>
	</div>
	
<!-- 	<div class="widgetContainer"> -->
<!-- 		<div class="widgetHeader"> -->
<!-- 			&Uacute;ltimos reclamos	 -->
<!-- 			<a href="#" id="refreshWidget" title="Actualizar listado"> -->
<!-- 				<img alt="Actualizar listado de reclamos" width="20" height="20" -->
<!-- 							src="http://localhost:8080/fixeala/widget/images/reload.png" /> -->
<!-- 			</a> -->
<!-- 		</div>				 -->
<!-- 		<div class="widgetBody">			 -->
<!-- 			<div class="widgetIssues">	 -->
<%-- 				<c:if test="${totalIssues gt 0}"> --%>
<%-- 					<c:forEach items="${issueList}" var="issue">							 --%>
<!-- 						<div class="widgetRow"> -->
<!-- 							<span class="widgetRowTitle"> -->
<%-- 								<a href="#" title="${issue.title}" onclick="redirectIssueURL('${issue.id}', '${issue.title}');">${issue.title}</a> --%>
<!-- 							</span>		 -->
<%-- 							<span class="widgetRowLocation">${issue.city} &raquo; ${issue.province}</span>	 --%>
<%-- 							<span class="widgetRowDate">${issue.fechaFormateada}</span><span class="widgetRowStatus" style="background-color: ${issue.statusCss}">${issue.status}</span>						 --%>
<!-- 						</div> -->
<%-- 					</c:forEach>					 --%>
<%-- 				</c:if>	 --%>
<%-- 				<c:if test="${totalIssues eq 0}">	 --%>
<!-- 					<div class="widgetError">					 -->
<%-- 						<p>${errorMessage}</p>		 --%>
<!-- 					</div> -->
<%-- 				</c:if>												 --%>
<!-- 			</div>	 -->
<!-- 			<div class="widgetError" style="display: none">				 -->
<!-- 			</div> -->
<!-- 		</div>					 -->
<!-- 		<div class="widgetFooter">						 -->
<!-- 			<div class="widgetLogo"> -->
<!-- 				<a href="http://localhost:8080/fixeala" target="_blank" title="Plataforma web para la resolución colaborativa de reclamos barriales de la República Argentina."> -->
<!-- 					<i>&copy; <strong>FIXEALA</strong></i> -->
<!-- 				</a> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<script type="text/javascript" src="http://localhost:8080/fixeala/widget/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="http://localhost:8080/fixeala/widget/js/widget.js"></script> 
	<script type="text/javascript" src="http://localhost:8080/fixeala/widget/js/bootstrap.js"></script>
</body>
</html>