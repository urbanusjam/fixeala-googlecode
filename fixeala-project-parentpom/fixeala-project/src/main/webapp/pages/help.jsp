<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>

$(document).ready(function(){
	
	fileController.handleUpload();
	
});


</script>

<div id="content">
		
	    <div class="page-header">
    	 	<h3><i class="icon-question-sign"></i>&nbsp;&nbsp;Ayuda</h3>    	 	
    	</div>    	

   		<div class="row-fluid">
  
		  	<div class="span 7">
		 
				<input  type="file" id="files">
				<button id="btnUpload">SUBIR</button>
				
				<button id="btnDelete">BORRAR</button>
		    
		    </div>
		
		</div>

</div>
<script src="${pageContext.request.contextPath}/resources/js/fixeala/imgur.js"></script>