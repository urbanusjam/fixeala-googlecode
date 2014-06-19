var userActionsController = {
		
		
		enableUserActions :  function(){
		    	
		    	  $('#userIssueActions').find("#btn-edit").bind('click', userActionsController.enableDisableFields);
				  $('#userIssueActions').find("#btn-update").bind('click', userActionsController.editIssueFields);
//				  $('#userIssueActions').find("#btn-status").bind('click', userActionsController.editIssueStatus);
		    	
		    },
		    
		  
		   
				
		enableDisableFields : function(){
				
				if( $('#btn-update').is(":disabled") == true ){		    	
					$('#btn-update').attr('disabled', false);
		    	}
		    	else{
		    		$('#btn-update').attr('disabled', true);			       
			    }
				   
				   $('#issue-title').editable('toggleDisabled');
			       $('#issue-barrio').editable('toggleDisabled');
			       $('#issue-desc').editable('toggleDisabled');
			       $('#issue-tags').editable('toggleDisabled');
			       
			       var iconTags =  $('#edit-tags');
			       var iconEditable = $('.editableField');
			       
			       if(iconEditable.is(':visible')){
			    	   $('.editableField').hide();
			       }
			       else{
			    	   $('.editableField').show();
			       }
			       
			      
			       if(iconTags.is(':visible')){
			    	   $('#edit-tags').hide();
			    	   
			       }
			       else{
			    	   $('#edit-tags').show();		    	  
			       }
			},
			
			
			//UPDATE ISSUE FIELDS
			 editIssueFields :  function(){
				  
				
				 				  
				  bootbox.confirm("&iquest;Desea confirmar los cambios?", function(result){
					 
					  if(result){
						  
						  $('#tbl-issue .editable, #issue-header .editable').editable('submit', {
							  
						       url: './updateIssue.html', 
						      data:   {fields: JSON.stringify(updatedFields)}, //additional data
					
						     
						       ajaxOptions: {
						           dataType: 'json'
						       },  				       
						       success: function(data) {	
						    	  
						    	   
						    	   if(data.result){		
						    		   bootbox.alert(data.message); 
						    		  
						    			setTimeout(function () {	
						    				var url = getIssueURL(issueID, newTitle, 'plain');						    				
							    			window.location.href= url;	
						    			}, 1000);		
						    	   }						    	   
						    	   else{
						    		   bootbox.alert(data.message);		
						    	   }						    	
						       },
						       error: function (response) {
						           console.log(response);
						       }

						   });//editable 
						  
					  }
			
					   
				  });//bootbox   
				},
			  
			  
			  	//UPDATE ISSUE STATUS
			editIssueStatus : function(){
			  		
					var label = $("#btn-status").find('button').attr('title').trim();
								
					bootbox.confirm("&iquest;Confirma que desea <b>"+ label +" </b>el reclamo?", function(result){
						  if(result){
							  
							  var status = "";
								
								var title = '${titulo}';
								
								if(label == 'Resolver')
									status = 'RESUELTO';
								
								if(label == 'Reabrir')
									status = "REABIERTO";
								
								var data = 'issueID='+ issueID + '&newStatus='+ status;
								
								$.ajax({
			        			    url: "./updateIssueStatus.html",
							 		type: "POST",	
							 		data: data,
							 		dataType: "json",									 
							        success: function(data){		
							        	if(data.result){		
							        			bootbox.alert(data.message); 				        			
								    			setTimeout(function () {
								    				var url = getIssueURL(issueID, title, 'plain');
									    			window.location.href= url;	
								    			}, 2000);						    			

								    	   }
								    	   
								    	   else{
								    		   bootbox.alert(data.message);		
								    	   }
				            		}
			        			});
							  
						  }
					 });						  
				}
}