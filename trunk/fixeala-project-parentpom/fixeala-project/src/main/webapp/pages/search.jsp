<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="content">
	<!-- Search -->
    <div class="page-header">
   	 	<h3><i class="icon-angle-right"></i>&nbsp;&nbsp;B&uacute;squeda de reclamos: "${tag.toLowerCase()}"</h3>    	 	
   	</div>  
   	<div class="container-fluid">
	  	<div class="row-fluid">
	  		<div class="row span6">
	  			<div class="issueList"></div>
	  		</div>		  		
	  		<div class="row span5 pull-right">
	  			<h4>Estado</h4>
	  			<hr>	  			
	  			<div class="statusCloud"></div>
	  			<br>
	  			<h4>Categor&iacute;a</h4>
	  			<hr>
	  			<div class="tagCloud"></div>
	  		</div>
	    </div>	
    </div>
</div><!-- content -->
<script type="text/javascript">    	
	$(document).ready(function() {   		   		
   		var issues = $.parseJSON('${issuesByTag}');	
   		var allTags = $.parseJSON('${allTags}');	
   		var allStatus = $.parseJSON('${allStatus}');
   		fxlGlobalController.loadSearchTags(issues, allTags, allStatus);   	
	});     		
</script>