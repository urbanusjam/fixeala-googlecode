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
	<link type="text/css" href="http://localhost:8080/fixeala/widget/css/font-awesome.css" rel="stylesheet"> 	
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
									<h1> ${totalIssues}
										<small><i class="icon icon-map-marker"></i>&nbsp; reclamos totales</small>
									</h1>
								</div>
							</center>
							<div class="middle-stat border">
								<h1>${totalOpen}</h1>
								<span>Abiertos</span>
							</div>
							<div class="middle-stat border">
								<h1>${totalReopened}</h1>
								<span style="text-transform: uppercase; display: block">Reabiertos</span>
							</div>
							<div class="middle-stat border">
								<h1>${totalResolved}</h1>
								<span>Resueltos</span>
							</div>
							<div class="middle-stat ">
								<h1>${totalClosed}</h1>
								<span style="text-transform: uppercase; display: block">Cerrados</span>
							</div>
							<center>
								<div class="bottom-stat">
									<span class="left">
										<h2> ${totalComments}
											<small><i class="icon icon-comments"></i>&nbsp; comentarios</small>
										</h2>
									</span>
									<span class="right">
										<h2> ${totalUsers}
											<small><i class="icon icon-user"></i>&nbsp; usuarios</small>
										</h2>
									</span>
								</div>
							</center>
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
	
	<script type="text/javascript" src="http://localhost:8080/fixeala/widget/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="http://localhost:8080/fixeala/widget/js/widget.js"></script> 
	<script type="text/javascript" src="http://localhost:8080/fixeala/widget/js/bootstrap.js"></script>
</body>
</html>