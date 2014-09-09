<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF8">
	<title>Fixeala Widget</title>	
	<link type="text/css" href="${pageContext.request.contextPath}/widget/css/bootstrap.css" rel="stylesheet">  	
	<link type="text/css" href="${pageContext.request.contextPath}/widget/css/bootstrap-combined.min.css" rel="stylesheet">  	
	<link type="text/css" href="${pageContext.request.contextPath}/widget/css/bootstrap-responsive.css" rel="stylesheet">  	
	<link type="text/css" href="${pageContext.request.contextPath}/widget/css/widget.css" rel="stylesheet"> 
	<link type="text/css" href="${pageContext.request.contextPath}/widget/css/font-awesome.css" rel="stylesheet"> 	
</head>
<body class="widget">

	<div class="widget-container">
	
		<ul id="widget-tabs" class="nav nav-tabs">
			<li class="active"><a href="#recent" data-toggle="tab">Recientes</a></li>
			<li><a href="#stats" data-toggle="tab">Indicadores</a></li>		
		</ul>	
	
		<div class="widget-refresh">
			<a href="#" id="refreshWidget" title="Actualizar listado">
			Recargar
				<img alt="Actualizar listado de reclamos" width="20" height="20"
							src="${pageContext.request.contextPath}/widget/images/reload.png" />
			</a>
		</div>
		
		<!-- Widget Body -->
		<div class="widget-body">	
		
			<div class="tab-content">
				<!-- Tab 1 RECENT -->
				<div class="tab-pane fade in active" id="recent">	
						<c:if test="${totalIssues gt 0}">
							<c:forEach items="${issueList}" var="issue">							
								<div class="widget-row">
									<div class="title">
										<a href="#" title="${issue.title}" onclick="redirectIssueURL('${issue.id}', '${issue.title}');">${issue.title}</a>
									</div>		
									<div class="address">${issue.city} &raquo; ${issue.province}</div>	
									<div class="row">
										<span class="date">${issue.fechaFormateada}</span>
										<span class="inline-container">
											<span title="Votos totales"><i class="icon icon-thumbs-up icon-small"></i>${issue.totalVotes}</span>
											<span title="Comentarios"><i class="icon icon-comments-alt icon-small"></i>${issue.totalComments}</span>
											<span title="Seguidores"><i class="icon icon-eye-open icon-small"></i>${issue.totalFollowers}</span>
										</span>	
										<span class="status" style="background-color: ${issue.statusCss}">${issue.status}</span>								
									</div>	
								</div>
							</c:forEach>					
						</c:if>	
						<c:if test="${totalIssues eq 0}">	
							<div class="alert alert-danger widget-error">					
								${errorMessage}	
							</div>
						</c:if>	
					<div class="widget-error" style="display: none">				
					</div>				
				</div>		
		
				<!-- Tab 2 STATS -->	
				<div class="tab-pane fade" id="stats">	
				
					<c:if test="${totalIssues gt 0}">
						<div class="widget-stats">
							<center>
								<div class="top-stat">
									<h2> ${totalIssues}
										<small><i class="icon icon-map-marker"></i>&nbsp; reclamos totales</small>
									</h2>
								</div>
							</center>							
							<div class="middle-body">							
								<div class="middle-stat left">
									<h2>${totalOpen}</h2>
									<span>Abiertos</span>
								</div>
								<div class="middle-stat right">
									<h2>${totalVerified}</h2>
									<span>Verificados</span>
								</div>
								<div class="middle-stat left">
									<h2>${totalRejected}</h2>
									<span>Rechazados</span>
								</div>	
								<div class="middle-stat right">
									<h2>${totalInProgress}</h2>
									<span>En progreso</span>
								</div>						
								<div class="middle-stat left">
									<h2>${totalResolved}</h2>
									<span>Resueltos</span>
								</div>
								<div class="middle-stat right">
									<h2>${totalReopened}</h2>
									<span>Reabiertos</span>
								</div>
								<div class="middle-stat left">
									<h2>${totalClosed}</h2>
									<span>Cerrados</span>
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${totalIssues eq 0}">	
						<div class="alert alert-danger widget-error">					
							${errorMessage}	
						</div>
					</c:if>	
				</div>
			</div><!-- end TAB CONTENT -->
		</div><!-- end Widget Body -->	
		
		<!-- Widget Footer -->
		<div class="widget-footer">						
			<div class="logo">
				<a href="http://localhost:8080/fixeala" target="_blank" title="Fixeala - Tu plataforma colaborativa de reporte ciudadano">
					<i>&copy; <strong>FIXEALA</strong></i>
				</a>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/widget/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/widget/js/widget.js"></script> 
	<script type="text/javascript" src="${pageContext.request.contextPath}/widget/js/bootstrap.js"></script>
</body>
</html>