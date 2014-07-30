<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="content">
	<!-- Search -->
    <div class="page-header">
   	 	<h3><i class="icon-angle-right"></i>&nbsp;&nbsp;B&uacute;squeda de reclamos: "${tag.toLowerCase()}"</h3>    	 	
   	</div>     	
   	
   	<div class="container-fluid">
	  	<div class="row-fluid">
	  		<div class="row span7">
	  			<div class="issueList"></div>
	  		</div>		  		
	  		<div class="row span4 pull-right">
	  			<h4>Categor&iacute;a</h4>
	  			<hr>
	  			<div class="tagCloud"></div>		  			
	  			<br>
	  			<h4>Estado</h4>
	  			<hr>
	  			<div class="statusCloud"></div>
	  		</div>
	    </div>	
    </div>
</div>

<script type="text/javascript">
    	
   	$( document ).ready(function() {
   		
   		var tag = '${tag}';	
   		var issues = $.parseJSON('${issuesByTag}');	
   		var allTags = $.parseJSON('${allTags}');	
   		var allStatus = $.parseJSON('${allStatus}');	
   	
   		if(issues.length == 0){    		
   			$(".issueList").append( "<h1><small>No se encontraron resultados.</small></h1>" );
   		}
   		
   		else{
   			for(var i = 0; i < issues.length ; i++){
   	    		$(".issueList").append( "<article>" +
   	    			"<div class=\"row\" style=\"margin-bottom:20px;border-bottom:1px dashed #ccc;\">" +	    		
   			            "<header>" +
   			                "<span class=\""+issues[i].statusCss+"\">" +issues[i].status+ "</span>&nbsp;&raquo;&nbsp;<small>"+issues[i].date+"</small><h1><small><a href=\"" +mapController.getIssuePlainURL(issues[i].id, issues[i].title)+ "\" title=\" "+issues[i].title+ "\">"+issues[i].title+"</a></small></h1>" +
   			                "<p class=\"meta\"><small>" +
   			                    issues[i].address + "&nbsp;|&nbsp; Publicado por: <a href=\"" +mapController.getUserPlainURL(issues[i].user)+ "\">"+issues[i].user+"</a>" +
   			                "</small></p>"+
   			            "</header>"+
   	            		"<p>"+issues[i].description+"</p>" +
   	        			"</article>"+
   	        		"</div>");
   	    	}   			
   		}
   		   		
   		for(var i = 0; i < allTags.length ; i++){
   			$(".tagCloud").append( "<a class=\"tagLinkCloud\" href=\"" +allTags[i].url+ "\"><span style=\"padding: 10px; margin: 0 15px 10px 0;  font-size: 16px;\" class=\"label label-default\">" +allTags[i].label+ "</span></a>");
   		}
   		
   		for(var i = 0; i < allStatus.length ; i++){
   			$(".statusCloud").append( "<a class=\"statusLinkCloud\" href=\"" +allStatus[i].url+ "\"><span style=\"padding: 10px; margin: 0 15px 10px 0;  font-size: 16px;\" class=\""+allStatus[i].css+"\">" +allStatus[i].text+ "</span></a>");
   		}
   		
   	}); 
    		
</script>