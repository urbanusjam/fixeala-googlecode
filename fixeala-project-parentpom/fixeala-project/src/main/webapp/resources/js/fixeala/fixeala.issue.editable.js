var userActionsController = {
		
		
		enableUserActions :  function(){
					
			  $('#userIssueActions').show();
			  $('#issue-stats-actions').show();
	    	  $('#userIssueActions').find("#btn-edit").bind('click', userActionsController.enableDisableFields);
			  $('#userIssueActions').find("#btn-update").bind('click', userActionsController.editIssueFields);
			  $('#userIssueActions').find("#btn-status").bind('click', userActionsController.initStatusModal);
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
						       data:   { fields: JSON.stringify(updatedFields) }, //additional data
						       ajaxOptions: {
						           dataType: 'json'
						       },  				       
						       success: function(data) {
						    	   
						    	   if(data.result){		
						    		   bootbox.alert(data.message, function(){						    			 	
						    				var url = mapController.getIssuePlainURL(issueID);		
							    			window.location.href= url;	
						    		   }); 
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
				
				event.preventDefault();
				
					var label = $("#btn-status").find('button').attr('title').trim();					
					var resolution = $("#tipoResolucion :selected").text();
					var obs = $("#observacion").val();
			
					var status = "";
					
					if(label == 'Resolver')
						status = 'RESUELTO';
					
					if(label == 'Reabrir')
						status = "REABIERTO";
					
					var data = 'issueID='+ issueID + '&newStatus='+ status + '&resolution=' + resolution + '&obs=' + obs;
					
					$("#mdl-status").modal('hide');
					
				
					$.ajax({
	    			    url: "./updateIssueStatus.html",
				 		type: "POST",	
				 		data: data,
				 		dataType: "json",	
				 		beforeSend: function(){
				 			blockPage("html");
				 		},
				        success: function(data){		
				        	 unBlockPage("html");
				        	 
				        	if(data.result){
				        		setTimeout(function(){
			        				var url = mapController.getIssuePlainURL(issueID);
					    			window.location.href= url;	
				        		}, 1000);
	
					    	   }
					    	   
					    	   else{
					    		   
					    	    	setTimeout(function(){
					    	    		 bootbox.alert(data.message);	
					        		}, 1000);
					    		  	
					    	   }
	            		},
	            		complete: function() {
	            			 unBlockPage("html");
		                }
	    			});
			
				
			},
			
			//VERIFY OR REJECT
			verifyOrRejectIssue : function(label){
				
				event.preventDefault();
				
					var status = "";
					
					if(label == 'Verificar')
						status = 'VERIFICADO';
					
					if(label == 'Rechazar')
						status = "RECHAZADO";
					
					var data = 'issueID='+ issueID + '&newStatus='+ status + '&resolution=' + null + '&obs=' + null;
					
					$("#mdl-verify").modal('hide');
					
				
					$.ajax({
	    			    url: "./updateIssueStatus.html",
				 		type: "POST",	
				 		data: data,
				 		dataType: "json",	
				 		beforeSend: function(){
				 			blockPage("html");
				 		},
				        success: function(data){		
				        	 unBlockPage("html");
				        	 
				        	if(data.result){
				        		setTimeout(function(){
			        				var url = mapController.getIssuePlainURL(issueID);
					    			window.location.href= url;	
				        		}, 1000);
	
					    	   }
					    	   
					    	   else{
					    		   
					    	    	setTimeout(function(){
					    	    		 bootbox.alert(data.message);	
					        		}, 1000);
					    		  	
					    	   }
	            		},
	            		complete: function() {
	            			 unBlockPage("html");
		                }
	    			});
			
				
			},
			
			setCurrentVote : function (isVoted, isVoteUp){
		
			    var $voteUp = $('#vote-up');
			    var $voteDown = $('#vote-down');
			 
			    if(isVoted == 'true'){
		    		
			    	if(isVoteUp == 'true'){
			    		$voteDown.removeClass('btn-danger').addClass('btn-default');
			    	}
			    	else{	
			    		$voteDown.removeClass('btn-success').addClass('btn-default');
			    	}
			    	
			    	$voteUp.prop('disabled', true);
		    		$voteDown.prop('disabled', true);
			    }
		    },
			
			initStatusModal : function(){
			
				statusLabel = $(this).find('button').attr('title').trim();
				var options = $("#tipoResolucion");
				
				options.empty();
				
				if(statusLabel == 'Resolver'){
					 options.append($("<option />").val("Solucionado").text("SOLUCIONADO"));
					 options.append($("<option />").val("Duplicado").text("DUPLICADO"));
					 options.append($("<option />").val("Incompleto").text("INCOMPLETO"));
					 options.append($("<option />").val("Invalido").text("INVALIDO"));
				}			
				
				else{
					 options.append($("<option />").val("No arreglado").text("NO ARREGLADO"));
					 options.append($("<option />").val("Hubo deterioro").text("HUBO DETERIORO"));
					 options.append($("<option />").val("Nueva informacion").text("NUEVA INFORMACION"));
				}
			
				$("#mdl-status").modal('show');
		},
		loadDetailModal : function(value){
			$("#mdl-detail .modal-body").html('<p>' +value+ '</p>');
			$("#mdl-detail").modal('show');
		}
}


