<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


   <style>
      .hidden {
        display: none;
      }
    </style>

<div id="content">
		
		<!-- Help -->
	    
	    <div class="page-header">
    	 	<h3><i class="icon-question-sign"></i>&nbsp;&nbsp;Ayuda</h3>    	 	
    	</div>    	
    	
<!--     	<div class="alert alert-info" style="width: 500px; margin: 0 auto; padding: 20px;">    	 -->
<!--     		<i class="icon-exclamation-sign icon-5x"></i> -->
<!--     		<br><br> -->
<!--     		<h3 style="text-transform: uppercase;">P&aacute;gina en construcci&oacute;n</h3> -->
<!--     	</div> -->
    	
    <div class="row-fluid">
			  
			<div class="span6" >
         <h2 id="imgur-upload">Uploading to imgur...</h2>
    	 <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==" alt="Red dot"> 
    <div>
      <a class="post" href="https://api.imgur.com/oauth2/authorize?response_type=token&client_id=f64d4441566d507">
        Post image to imgur
      </a>
    </div>
    
      <div class="hidden">
      <p>Posting to imgur...</p>
    </div>
    	
    	</div>
    	</div>
    	
    	   	    
   		<!-- /Help -->
</div>


 <script src="http://anthonyterrien.com/js/jquery.knob.js"></script>
 <script src="${pageContext.request.contextPath}/resources/js/fixeala/imgur.js"></script>