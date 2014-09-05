<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title><tiles:insertAttribute name="title" ignore="true" /></title>	

  	<script type="text/javascript" src="http://maps.google.com/maps/api/js?libraries=geometry,places&components=country:ar&language=ES&sensor=false"></script>
	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.jsonp-2.4.0.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-ui-1.10.3.custom.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.mockjax.js"></script> 
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-migrate-1.1.0.js"></script>

    <!-- FIXEALA -->	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.global.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.map.js"></script>	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.issue.editable.js"></script>
  	  	    
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.geocomplete.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/json/json.min.js"></script>	

  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-editable.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-datetimepicker.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-datetimepicker.es.js"></script>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-rowlink.js"></script> --%>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-lightbox.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-tags.js"></script> 
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-contextmenu.js"></script> 
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-fileupload.js"></script>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-wysiwyg.js"></script>  --%>
<%--   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/2.3.2/bootstrap-paginator.min.js"></script>  --%>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootbox.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/bootstrap-filestyle-1.0.6.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/select2-3.5.1/select2.js"></script>

<%-- 	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/typeahead.js"></script>  --%>
<%-- 	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/bootstrap/hogan-2.0.0.js"></script>  --%>
		
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.hotkeys.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.dataTables.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.dataTables.columnFilter.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.dataTables.rowReordering.js"></script>

  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/tmpl.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/load-image.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/canvas-to-blob.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.blueimp-gallery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.iframe-transport.js"></script>	
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload.js"></script>	
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-process.js"></script>  
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-image.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-video.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-validate.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/fileupload/jquery.fileupload-ui.js"></script>

  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/lightbox/lightbox-2.6.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/lightbox/modernizr.custom.js"></script> 	
  	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/markerclusterer.js"></script>	
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/markermanager.js"></script>	

  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/masonry/masonry.pkgd.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/masonry/infinitescroll.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/masonry/imagesloaded.pkgd.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/masonry/isotope.pkgd.js"></script>

  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.validate.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.blockUI.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.tooltipster.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.shorten.1.0.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.bootstrap.wizard.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/moment.min.js"></script>

  	<link type="text/css" href="http://fonts.googleapis.com/css?family=Oxygen:400,300,700|Lato:400,900|Graduate:400,900" rel="stylesheet">
  	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/DT_bootstrap.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap.css" rel="stylesheet">   
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-combined.min.css" rel="stylesheet"> 
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-editable.css" rel="stylesheet"> 
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-sortable.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-rowlink.css" rel="stylesheet"> 
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-responsive.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-fileupload.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-lightbox.css" rel="stylesheet">   
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-datetimepicker.min.css" rel="stylesheet">  
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap/2.3.2/bootstrap-tags.css" rel="stylesheet">  
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/select2-3.5.1/select2.css" rel="stylesheet">   
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/select2-3.5.1/select2-bootstrap.css" rel="stylesheet">   
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/font-awesome/3.2.1/font-awesome.css" rel="stylesheet">

	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.fileupload-ui.css" rel="stylesheet">
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.fileupload.css" rel="stylesheet">	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.dataTables.css" rel="stylesheet">	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/blueimp-gallery.min.css" rel="stylesheet">	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/lightbox.css" rel="stylesheet">	
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/tooltipster.css" rel="stylesheet">		
	<link type="text/css" href="${pageContext.request.contextPath}/resources/css/style2.css" rel="stylesheet">


	<script type="text/javascript">
      
		$(document).ready(function(){
			
			fxlGlobalController.initNavTooltip();
			fxlGlobalController.initFeedback();
			window.localStorage.clear();
			
		});	

	</script>

</head>

<body data-spy="scroll" data-target=".bs-docs-sidebar">

	<!-- feedback button -->
	<div class="feedback">
    	<span><a id="feedbackLink" href="#" title="¡Tu opinión cuenta!" style="cursor: pointer;"><i class="icon-bolt"></i>Feedback</a></span>
    </div>

<!--<section class="wrapper"> -->
 
	  <tiles:insertAttribute name="header" />
	  
	  <tiles:insertAttribute name="body" />  
	  
	  <tiles:insertAttribute name="footer" />
  
<!--</section>  -->


	<!-- feedback form -->
	<div id="mdl-feedback" class="modal hide fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>	
			<h4>Ayudanos a mejorar la plataforma FIXEALA</h4>
	  	</div>
		<div class="modal-body">
		
			<div class="control-group">  			
       			<label class="control-label">Asunto</label>
       			<div class="controls">
       				<select id="cbxAsuntoFeedback" style="width:265px;">
       					<option value="bug" selected>BUG / FALLA</option>
       					<option value="idea">IDEA / PROPUESTA</option>     
       					<option value="sugerencia">SUGERENCIA</option>           				
       					<option value="ayuda">AYUDA / DUDA</option>
       					<option value="otro">OTRO</option>
       				</select>		
       			</div>
   			</div>   
   			<div class="control-group">
		        <label class="control-label" for="emailFeedback">Tu email (opcional)</label>
		        <div class="controls">
		        	<input type="email" id="emailFeedback" name="emailFeedback" class="form-control" style="width:250px;" />
		        </div>
		    </div> 			
		    <div class="control-group">
		        <label class="control-label" for="msgFeedback">Mensaje</label>
		        <div class="controls">
		        	<textarea id="msgFeedback" name="msgFeedback" class="form-control" style="width:520px; height: 100px; padding-right: 5px;" required ></textarea>
		        </div>
		    </div>
		
		</div>
		<div class="modal-footer"> 		
			<button id="btnSendFeedback" class="btn btn-info" aria-hidden="true" disabled>
		    	<i class="icon-ok icon-large"></i>&nbsp;&nbsp;&nbsp;Enviar
		    </button>		 		  		
	  		<button class="btn" data-dismiss="modal" aria-hidden="true">
		    	<i class="icon-remove icon-large"></i>&nbsp;&nbsp;&nbsp;Cancelar
		    </button>	 
	  	</div>
	</div>
	<!-- end feedback form -->  
</body>
</html>