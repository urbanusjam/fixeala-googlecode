<div id="content">

	<script type="text/javascript">
	
		$(function () {
		    
			 $("#fileupload").uploadify({				 		
				 	'debug' : true,
				 	'swf'          : './resources/images/uploadify.swf',
				 	'uploader'         : 'upload',				
				 	'auto'              : true
			    });
		
		});

	</script>

    <input id="fileupload" name="fileupload" type="file" multiple="true">
  
</div>