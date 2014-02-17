<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF8">
	<title>Fixeala D3 + Google Maps</title>	

  	<script type="text/javascript" src="http://maps.google.com/maps/api/js?libraries=geometry,places&components=country:ar&language=ES&sensor=false"></script> 
  	
  	<link type="text/css" href="http://fonts.googleapis.com/css?family=Oxygen:400,300,700|Lato:400,900|Graduate:400,900" rel="stylesheet">
  	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.10.2.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/3.1.1/bootstrap-3.1.1.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/json/d3.min.js"></script>	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/json/topojson.v1.min.js"></script>	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/d3.fixeala.map.js"></script>  	
  	
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/map.js"></script> --%>
 	
  	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/3.1.1/bootstrap-3.1.1.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/font-awesome/4.0.3/font-awesome-4.0.3.css" rel="stylesheet">
  	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/d3.fixeala.css" rel="stylesheet">	
  	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/d3.home.css" rel="stylesheet">	
  	  		
</head>


<body>

  <tiles:insertAttribute name="body" />  

 
  
  
</body>

</html>