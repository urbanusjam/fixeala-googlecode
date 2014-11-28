<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF8">
	<title>Fixeala D3 + Google Maps</title>	
 	<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/">
	<!-- JS -->
  	<script type="text/javascript" src="resources/js/jquery/jquery-1.10.2.min.js"></script>
  	<script type="text/javascript" src="resources/js/bootstrap/3.1.1/bootstrap-3.1.1.js"></script>  
  	<script type="text/javascript" src="resources/js/json/topojson.v1.min.js"></script>	
  	<script type="text/javascript" src="resources/js/recaptcha_ajax.js"></script>	
  	<script type="text/javascript" src="resources/js/leaflet/0.7.2/leaflet-src.js"></script>  
  	<script type="text/javascript" src="resources/js/leaflet/0.7.2/leaflet.markercluster-src.js"></script>     	
  	<script type="text/javascript" src="resources/js/leaflet/0.7.2/leaflet.groupedlayercontrol.js"></script>     	
  	<script type="text/javascript" src="resources/js/leaflet/0.7.2/leaflet-d3-layer.js"></script>    
  	<script type="text/javascript" src="resources/js/d3/d3.min.js"></script>	 	  	
  	<script type="text/javascript" src="resources/js/d3/d3.fixeala.map.js"></script>  	
	<!-- CSS -->
  	<link type="text/css" href="http://fonts.googleapis.com/css?family=Oxygen:400,300,700|Lato:400,900|Graduate:400,900" rel="stylesheet">
	<link type="text/css" href="resources/css/bootstrap/3.1.1/bootstrap-3.1.1.css" rel="stylesheet">
	<link type="text/css" href="resources/css/font-awesome/4.0.3/font-awesome-4.0.3.css" rel="stylesheet">
  	<link type="text/css" href="resources/css/leaflet/0.7.2/leaflet.css" rel="stylesheet">	
  	<link type="text/css" href="resources/css/leaflet/0.7.2/leaflet.markercluster.css" rel="stylesheet">	
  	<link type="text/css" href="resources/css/leaflet/0.7.2/leaflet.markercluster-default.css" rel="stylesheet">	
  	<link type="text/css" href="resources/css/d3/d3.fixeala.css" rel="stylesheet">	
  	<link type="text/css" href="resources/css/d3/d3.home.css" rel="stylesheet">	
</head>
<body>
	<tiles:insertAttribute name="body" />  
</body>
</html>