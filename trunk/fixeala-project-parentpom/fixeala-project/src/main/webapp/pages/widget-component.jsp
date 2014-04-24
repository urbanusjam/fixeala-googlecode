<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF8">
	<title>Fixeala Widget</title>	
	<link type="text/css" href="http://localhost:8080/fixeala/widget/css/widget.css" rel="stylesheet">  	
</head>
<body class="widget">
	<div class="widgetContainer">
		<div class="widgetHeader">
			&Uacute;ltimos reclamos	
			<a href="#" id="refreshWidget" title="Actualizar listado">
				<img alt="Actualizar listado de reclamos" width="20" height="20"
							src="http://localhost:8080/fixeala/widget/images/reload.png" />
			</a>
		</div>				
		<div class="widgetBody">			
			<div class="widgetIssues">	
				<c:if test="${numberOfIssues gt 0}">
					<c:forEach items="${issueList}" var="issue">							
						<div class="widgetRow">
							<span class="widgetRowTitle">
								<a href="#" onclick="redirectIssueURL('${issue.id}', '${issue.title}');">${issue.title}</a>
							</span>		
							<span class="widgetRowLocation">${issue.city} » ${issue.province}</span>	
							<span class="widgetRowDate">${issue.fechaFormateada}</span>							
						</div>
					</c:forEach>					
				</c:if>	
				<c:if test="${numberOfIssues eq 0}">	
					<div class="widgetError">					
						<p>${errorMessage}</p>		
					</div>
				</c:if>												
			</div>	
			<div class="widgetError" style="display: none">				
			</div>
		</div>					
		<div class="widgetFooter">						
			<div class="widgetLogo">
				<a href="http://localhost:8080/fixeala" target="_blank" title="Plataforma web para la resolución colaborativa de reclamos barriales  de la República Argentina.">
					<i>© <strong>Fixeala</strong></i>
				</a>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="http://localhost:8080/fixeala/widget/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="http://localhost:8080/fixeala/widget/js/widget.js"></script> 
</body>
</html>