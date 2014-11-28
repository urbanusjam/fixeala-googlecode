var fxlIssueController = {
		
	issueID : null,		
	updatesJson : null,		
	commentsJson : null,
	updatedFields : null,
	oldFields : null,
	reporter : null,
	tagList : null,
		
	initIssue : function(issueID){
		console.log('--- init ---');
		fxlIssueController.issueID = issueID;
		fxlIssueController.initXEditable();
		fxlIssueController.initInfiniteScroll();
		fxlIssueController.initRepairForm();		
		fxlIssueController.initComments();
		fxlIssueController.initImageUpload();
		fxlIssueController.initWatch();		
		fxlIssueController.initStatusUpdate();	
		fxlIssueController.enableUserActions();		
	},	
	
	
	/** ============================================================================================== **/
	/**                               X - E D I T A B L E				    		                   **/
	/** ============================================================================================== **/
	
	initXEditable : function(){
		console.log('--- xeditable ---');
		var updatedFields = fxlIssueController.updatedFields;
		var oldFields = fxlIssueController.oldFields;
		var allTags = JSON.parse(fxlIssueController.tagList);
			
		//default config
		$.fn.editable.defaults.mode = 'popup';	
		$.fn.editable.defaults.disabled = true;
		$.mockjaxSettings.responseTime = 300; 
		
		//modify buttons style
		$.fn.editableform.buttons = 
		  '<button type="submit" class="btn btn-warning editable-submit"><i class="icon-ok icon-white"></i></button>' +
		  '<button type="button" class="btn editable-cancel"><i class="icon-remove"></i></button>';     
		
		$('.editableField').hide();
		$('#btn-update').attr('disabled', true);
		$('#btn-edit').addClass('notClicked');	
		
		//--NON EDITABLE FIELDS	
		
		$("#issue-id").editable({name: 'id',  disabled: true});			  
		$("#issue-date").editable({name: 'creationDate', disabled: true});				  
		$("#issue-street").editable({name: 'address', disabled: true});		
		$("#issue-city").editable({name: 'city', disabled: true});			  
		$("#issue-province").editable({name: 'province', disabled: true});
		$("#issue-lat").editable({name: 'latitude', disabled: true});
	    $("#issue-lng").editable({name: 'longitude', disabled: true});
	    $("#issue-status").editable({name: 'status', disabled: true});
	    $("#issue-user").editable({name: 'username', disabled: true});	 
		  
		//--EDITABLE FIELDS		
	    
	    //title
		$("#issue-title").editable({
			  pk: 1,  
			  name: 'title', 
			  type: 'text',
			  mode: 'popup',
			  placement: 'right',
			  ajaxOptions: {
			        type: 'put'
			  },
			  validate: function(value) {
				  
					var pattern = /^\s*[a-zA-ZÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ0-9,\s]+\s*$/;
	
				    if($.trim(value) == '') {
				        return 'Campo obligatorio.';
				    }				    
				    if($.trim(value).length > 80) {
				        return 'La longitud m&aacute;xima del campo es de 80 caracteres.';
				    }
			  },
			  success: function(response, newValue) {	
	               newTitle =  newValue;
				   if(newValue != oldFields.title)
					   fxlIssueController.updatedFields.title = 1;
				   else
					   fxlIssueController.updatedFields.title = 0;
	          }			
		});

		//description
		$("#issue-desc").editable({ 		
			  pk: 2, 
			  name: 'description',
			  type: 'textarea', 
			  mode: 'popup',	
			  placement: 'right',
			  inputclass: 'issue-textarea',
			  ajaxOptions: {
			        type: 'put'
			  },				
			  validate: function(value) {
				  
					var pattern = /^[^'"]*$/;
					
				    if($.trim(value) == '') {
				        return 'Campo obligatorio.';
				    }
				    
				    if($.trim(value).length > 600) {
				        return 'La longitud m&aacute;xima del campo es de 600 caracteres.';
				    }
				    
				    if(!pattern.test(value)){
				    	return 'No se permiten comillas simples o dobles.';
				    }
			  },
			  success: function(response, newValue) {
				  if(newValue != oldFields.desc)
					   fxlIssueController.updatedFields.desc = 1;
				  else
					  fxlIssueController.updatedFields.desc = 0;			     
	          }			  	
		});
		  		
		//neighborhood  
		$("#issue-barrio").editable({
			  pk: 3,  
			  name: 'neighborhood', 	
			  mode: 'popup',	
			  placement: 'right',
			  emptytext: 'Ingresar barrio',
			  ajaxOptions: {
				  dataType: 'json'
			  },			
			  validate: function(value) {		
				  
				 	var pattern = /^\s*[a-zA-ZÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ0-9,\s]+\s*$/;
				  
				    if($.trim(value).length > 30) {
				        return 'La longitud m&aacute;xima del campo es de 30 caracteres.';
				    }
			  },
			  success: function(response, newValue) {
				  if(newValue != oldFields.barrio)
					  fxlIssueController.updatedFields.barrio = 1;
				  else
					  fxlIssueController.updatedFields.barrio = 0;			     
	          }
		});
		

		var results = [];
		//tags		
		$('#issue-tags').editable({				
			    pk: 22,
			 	name: 'tagsMap',				 
			    placement: 'top',      
			    emptytext: 'Ingresar categor&iacute;a',
			    mode: 'popup',	 
  				inputclass: 'input-large',
		        select2: {				
		        	tags: allTags,		        	
		            tokenSeparators: [",", " "],
		            id: function (item) {
		                return item.text;
		            },
		            multiple: true,	
		            minimumInputLength: 1,
		            maximumSelectionSize: 5,
		            formatSelectionTooBig: function (limit) {
		                return 'S&oacute;lo se permiten 5 etiquetas.';
		            },
		            formatInputTooShort : function() {  return 'Tipee al menos 1 caracter.';},
		            allowClear: true,		           
		        },
		        display: function(value) {
		        	if(value != null){
		        		var tags = new Array(value.length);
			        	
			            $.each(value,function(i){				            	
			            	var url = "issues/search.html?type=tag&value=" + $('<p>' + value[i] + '</p>').text();
			            	tags[i] = "<a class=\"taglink\" href=\"" + url + "\"><span class=\"label generic\">" + $('<p>' + value[i] + '</p>').text() + "</span></a>";
			            });
			            
			            $(this).html(tags.join(" "));
		        	}		        	
		        },						
		        ajaxOptions: {
			        type: 'put'
			    },
			    error: function(response, newValue) {
			        if(response.status === 500) {
			            return 'Error al cargar las etiquetas.';
			        } else {
			            return response.responseText;
			        }
			    }
		});
	},
	
	
	/** ============================================================================================== **/
	/**                               I N F I N I T E   S C R O L L				    		           **/
	/** ============================================================================================== **/
		
		
	initInfiniteScroll : function(){
		
		console.log('--- infinite scroll ---');
		
		var updatesArray = JSON.parse(fxlIssueController.updatesJson);
		var commentsArray = JSON.parse(fxlIssueController.commentsJson);
		
		if(updatesArray.length > 0){
			$('#btn-more-updates').show();
		}
		
		if(commentsArray.length > 0){
			$('#btn-more-comments').show();
		}
		
		fxlIssueController.loadFirstPage(updatesArray, commentsArray);
		fxlIssueController.configIsotope();
		
	},
		
	loadFirstPage : function(updatesArray, commentsArray){
		
		var $containerUpdates = $('#infinite-container-updates');
		var $containerComments = $('#infinite-container-comments');
		
		if(updatesArray.length > 0){
			var html =  [];	
			$.each( updatesArray, function( i, value ) {	            
        		var item = fxlIssueController.renderToHtml(value, "update");
        		html.push(item);
        	});
        	$containerUpdates.append(html);
        	
		}
		
		if(commentsArray.length > 0){
			var html =  [];
			$.each( commentsArray, function( i, value ) {	            
        		var item = fxlIssueController.renderToHtml(value, "comment");
        		html.push(item);
        	});
        	$containerComments.append(html);
		}
    
	},
	
	renderToHtml : function(element, type){
		
		var html = '';
		var userLink = mapController.getUserPlainURL(element.username);
		
		if(type == 'update'){
			
			var btnDisplay; 					
			var obs = element.obs;
			
			if(obs == null || obs == ''){
				btnDisplay =  'hide';
			}
			else{
				btnDisplay = 'show';
			}					
			
			html =  '<div class="brick-update">'
				+		'<span class="index">'+element.id+'</span>'		
				+		'<span class="date">'+element.date+'</span>'			    		
				+		'<span class="user">'
					+		'<a href="'+userLink+'">'+element.username+'</a>'
					+		'</span>'
			    +		'<span class="motive">'+element.motive+'</span>'
			    +		'<span class="obs">'					   
				+			'<button class="btn '+btnDisplay+'" onclick="fxlIssueController.loadDetailModal(\''+obs+'\')" data-toggle="modal">&raquo; Ver detalle</button>'
				+		'</span>'
				+ 	'</div>';
		}

		else{
			
			html = '<div class="brick-comment"><div class="media">'
				+		'<span class="pull-left">'
				+	  		'<img class="media-object thumbnail" src="${pageContext.request.contextPath}/resources/images/nopic.png">'
				+	 	'</span>'
				+	    '<div style="font-size:12px;margin-bottom:10px">'
				+	  		'<a href="#"><strong>'+element.username+'</strong></a><span class="pull-right" style="margin-right: 30px">'+element.date+'</span></div>'
				+	  '<div class="media-body" style="display:block">'		
				+     		'<p style="font-size:13px">'+element.message+'</p>'	 
				+	  '</div>'
				+	'</div></div>';
			
		}

		return html;
			
	},
	
	configIsotope : function(){
		
		var $containerUpdates = $('#infinite-container-updates');
		var $containerComments = $('#infinite-container-comments');
		
		/* updates */
		$containerUpdates.imagesLoaded( function(){                
            $containerUpdates.masonry({
                itemSelector : '.brick-update'
            });
        });
		
		$containerUpdates.infinitescroll({
			navSelector  	: "#page-nav-update",
			nextSelector 	: "#page-nav-update a",
			itemSelector 	: ".brick-update",  
			pixelsFromNavToBottom : "20",
			debug: true,
			dataType: 'json',
			appendCallback: false,
			loading: {
	            finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
	            msgText: "<h4>Cargando actualizaciones...</h4>",
	            speed: 'slow'
	        }  		      
		 }, function (newElements) {
		 		var html = '';
		 		$.each( newElements, function( i, element ) {
		 			 html += fxlIssueController.renderToHtml(element, 'update');
		        });
		 		var $newElems = $( html ).css({ opacity: 0 });
			 		
 			    $newElems.imagesLoaded(function(){
 					$newElems.animate({ opacity: 1 });
 					$containerUpdates.append( $newElems ).masonry( 'appended', $newElems );
	 			});
		});
  			
		$containerUpdates.infinitescroll('pause');
		
		/* comments */
		$containerComments.imagesLoaded( function(){                
            $containerComments.masonry({
                itemSelector : '.brick-comment'
            });
        });
		
		$containerComments.infinitescroll({
			navSelector  	: "#page-nav-comment",
			nextSelector 	: "#page-nav-comment a",
			itemSelector 	: ".brick-comment",  
			pixelsFromNavToBottom : "20",
			debug: true,
			dataType: 'json',
			appendCallback: false,
			loading: {
	            finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
	            msgText: "<h4>Cargando comentarios...</h4>",
	            speed: 'slow'
	        }  		      
		 }, function (newElements) {
		 		var html = '';
			 		$.each( newElements, function( i, element ) {
			 			 html += fxlIssueController.renderToHtml(element, 'comment');
			        });
				 	
			 		var $newElems = $( html ).css({ opacity: 0 });

 			    $newElems.imagesLoaded(function(){
 					$newElems.animate({ opacity: 1 });
 					$containerComments.append( $newElems ).masonry( 'appended', $newElems );
	 			});
		});
  			
		$containerComments.infinitescroll('pause');
		
		//tabs config
		$('.nav-tabs li').on('shown.bs.tab', function (e) {
			var clickedTab = $(this).find('a').attr('href');
		 	if(clickedTab == "#issueComments"){
			  	$containerComments.masonry('layout');
		 	}	
		 	else{
			  	$containerUpdates.masonry('layout');
		 	}	
		});
							
		//more btn
		$(' .btn-more ').click(function(e){
			
		     // call this whenever you want to retrieve the next page of content
		     // likely this would go in a click handler of some sort
		     e.preventDefault();
		    
		    if( $(this).hasClass( 'update' ) ){
		    	$containerUpdates.infinitescroll('retrieve');
			  	$('#page-nav-updates').hide(); 
		   	}  				
		    else{
		    	$containerComments.infinitescroll('retrieve');
		      	$('#page-nav-comments').hide(); 
		    }
		  
		    return false;
		});
		
	},
	
	
	/** ============================================================================================== **/
	/**                               I M A G E S				    		                           **/
	/** ============================================================================================== **/
	
	initImageUpload : function(){
		
		console.log('--- upload ---');
		
		$('#multiplefileupload').fileupload();
		
		$('#tbl-fileupload').on('click', '.btn-file-delete', function() {
			
			var issueID = fxlIssueController.issueID;
			var contenidoID = $(this).closest('tr').attr('id');					
			var data = 'issueID='+ issueID + '&fileID='+ contenidoID + '&userID='+ fxlGlobalController.loggedUser;
			
			bootbox.confirm("&iquest;Confirma que desea eliminar el archivo?", "Cancelar", "Eliminar", function(result){			  
				  if(result){
					  fxlIssueController.deleteImage(data, contenidoID);				  				  
				  }		
			});
		});
		
	},
	
    upload : function() {
    	
    	console.log('--- start uploading... ---');
    
    	var files = $('#files').get(0).files;
    	console.log('--- num. of files: ' +files.length+ ' ---' );
    	
    	var uploadCounter = 0;
    	var uploadsOK = [];    
    	
    	//call imgur api for each file
    	for(var i = 0; i < files.length ; i++){
    		
    		var selectedFile = files[i];	    		
	        var fd = new FormData();
	        fd.append("image", selectedFile); 
	        
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "https://api.imgur.com/3/image.json", false); 
	        xhr.onload = function() {

	        	var result = JSON.parse(xhr.responseText);
	        	console.log(result);
	        	
	        	var success = result.success;
	        	var statusCode = result.status;		        	
	        	
	        	if(success && statusCode == '200'){		        	
	        		var upload = new Object();			       
			    	upload.filedata =  result.data;
			    	upload.filename = selectedFile.name;
			    	upload.deletehash = result.data.deletehash;		        		
			    	
			    	uploadsOK.push(upload);		             	
	        	}
	        }
	        xhr.setRequestHeader('Authorization', 'Client-ID f64d4441566d507'); 
	        xhr.send(fd);
	        //end IMGUR
	        
	        console.log('--- resultado uploads ---')
	        console.log(uploadsOK);
    		
    	}//end call
        	
    	fxlIssueController.configFileUpload(uploadsOK);
			
	},
	
	configFileUpload : function(uploadsOK){
		
		var fileList =  JSON.stringify(uploadsOK);
    	
	    $('#multiplefileupload').fileupload({
	    	url: 'issues/'+fxlIssueController.issueID+'/uploadFiles',
		    type: "POST",
		    dataType: 'json',
			formData: [{ name: 'fileList', value: fileList }],
			sequentialUploads: true,
		    maxNumberOfFiles: 5,
			acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
			singleFileUploads: false,
			autoUpload: true,	
			disableImageResize: /Android(?!.*Chrome)|Opera/
			        .test(window.navigator && navigator.userAgent),				
	        previewMinWidth : 100,
	        previewMaxHeight : 60,	
			imageCrop: false						
			
	    }).bind('fileuploaddone', function(e, data){		    	
	    	console.log('--- fileupload plugin done ----');		
	    	var parsedResult = $.parseJSON(data.result.uploadedFiles);	
		    data.files = parsedResult;					    
		    fxlIssueController.updateFilesInfo(data.result.totalUploadedFiles);	
		    
		}).bind('fileprogressfail', function (e, data) {
			console.log("--- ajax upload ERROR ---");
			fileController.deleteMultipleImages(uploadsOK);
        	bootbox.alert('No se pudo guardar el archivo.');
        	
		}).bind('fileuploadfail', function (e, data) {
			console.log("--- ajax upload ERROR ---");
			fileController.deleteMultipleImages(uploadsOK);
        	bootbox.alert('No se pudo guardar el archivo.');			
		});
		
	},
    
    updateFilesInfo : function(numberOfFiles){
    	 
		if(numberOfFiles == 5){
			$(".modal-footer .fileinput-button").addClass("disabled");
			$(".modal-footer .fileinput-button > input").attr("disabled", true);
		}
		else if(numberOfFiles < 5){
			$(".modal-footer .fileinput-button").removeClass("disabled");
			$(".modal-footer .fileinput-button > input").attr("disabled", false);
		}

		$('.cantidadContenidos').fadeOut('slow', function(){ 
        		$(this).html(numberOfFiles).fadeIn('slow'); 		        	
        });	
		
		$('#issueFiles').load(location.href + '#issueFiles #lst-file-thumnails'); 
	},
	
	deleteImage : function(data, contenidoID){
		
		$.ajax({
		    url: 'issues/'+fxlIssueController.issueID+'/deleteFile',
	 		type: "POST",	
	 		data: data,							 
	        success: function(data){	        	
	        	if(data.status){							        		
	        		var deleteRow = $("#tbl-fileupload tr[id^='" + contenidoID +"']");												
		        	deleteRow.fadeOut('slow',function() {								        		
		        		deleteRow.remove();	
		        	});										        	
		        	fxlIssueController.updateFilesInfo(data.totalUploadedFiles);
	        	}							        	
	        	else{
	        		bootbox.alert(data.message);	
	        	}	
    		}	  
		});			
		
	},	
	
	
	/** ============================================================================================== **/
	/**                               C O M M E N T S				    		                       **/
	/** ============================================================================================== **/
	
	
	initComments : function(){
		
		console.log('--- comments ---');
		
		$('#comment-text').keyup(function(){
		      if($(this).val().length > 0){
		         $('#btn-comment').prop('disabled',false);
		      }else{
		         $('#btn-comment').prop('disabled',true);
		      }
		});
	  
		//bind btn
		$('#btn-comment').click(function() {		  				 	
			fxlGlobalController.blockPage('html');		  	
			var message = $("#comment-text").val();					
			var data = 'issueID='+ fxlIssueController.issueID + '&comment='+ message;			
			fxlIssueController.saveComment(data);
		});		
		
	},
	
	saveComment : function(data){
		
		$.ajax({
		    url: 'issues/'+fxlIssueController.issueID+'/addComment',
	 		type: "POST",	
	 		data: data,
	 		dataType: "json",									 
	        success: function(data){
	        	if(data.result){
	        		fxlGlobalController.unBlockPage('html');
	        		setTimeout(function(){
	        			window.location.reload();
	        		}, 1000); 
			    }					    	   
	    	    else{
	    	    	fxlGlobalController.unBlockPage('html');
	    	    	setTimeout(function(){
	        			bootbox.alert(data.message);	
	        		}, 1000);
	    	    }
	        }
		});
		
	},	
	
	
	/** ============================================================================================== **/
	/**                               R E P A I R   I N F O				    		                   **/
	/** ============================================================================================== **/
	
	
	initRepairForm : function(){
		
		console.log('--- repair ---');
		
		//bootstrap datepicker		
		var startDate = new Date();
		var fromEndDate = new Date();
		var toEndDate = new Date();

		toEndDate.setDate(toEndDate.getDate()+365);
		
		$('#fechaEstimadaInicio').datepicker({			    
			format: 'dd/mm/yyyy',
		    startDate: startDate,
		    language: 'es',		
		    autoclose: true
		}).on('changeDate', function(selected){
		        startDate = new Date(selected.date.valueOf());
		        startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
		        $('#fechaEstimadaFin').datepicker('setStartDate', startDate);
		}); 
		
		$('#fechaEstimadaFin').datepicker({			        
		    	format: 'dd/mm/yyyy',
		        startDate: startDate,
		        language: 'es',		
		        endDate: toEndDate,
		        autoclose: true
		}).on('changeDate', function(selected){
		        fromEndDate = new Date(selected.date.valueOf());
		        fromEndDate.setDate(fromEndDate.getDate(new Date(selected.date.valueOf())));
		        $('#fechaEstimadaInicio').datepicker('setEndDate', fromEndDate);
		});
		
		$('#fechaRealInicio').datepicker({			    
			format: 'dd/mm/yyyy',
			startDate: startDate,
		    language: 'es',		
		    autoclose: true
		}).on('changeDate', function(selected){
		        startDate = new Date(selected.date.valueOf());
		        startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
		        $('#fechaRealFin').datepicker('setStartDate', startDate);
		}); 
		
		$('#fechaRealFin').datepicker({			        
		    	format: 'dd/mm/yyyy',
		        startDate: startDate,
		        language: 'es',		
		        endDate: toEndDate,
		        autoclose: true
		}).on('changeDate', function(selected){
		        fromEndDate = new Date(selected.date.valueOf());
		        fromEndDate.setDate(fromEndDate.getDate(new Date(selected.date.valueOf())));
		        $('#fechaRealInicio').datepicker('setEndDate', fromEndDate);
		});
	    //http://www.bootply.com/74352
		//http://stackoverflow.com/questions/11933173/how-to-restrict-the-selectable-date-ranges-in-bootstrap-datepicker
		
		
		//validation
		$.validator.addMethod('money', function(value) {			     
	        return /^\d{0,4}(\.\d{0,2})?$/.test(value);
		},"S&oacute;lo n&uacute;meros positivos con hasta 2 decimales.");
    
	    $.validator.addMethod('integer', function (value) { 
	        return /^[0-9]+$/.test(value); 
	    }, 'S&oacute;lo n&uacute;meros positivos.');
    
	    $("#repairForm").validate({	
	    	
	    	rules: {
	    		
	            obra: {
	                required: true
	            },
	            plazo: {
	            	integer: true 
	            },
	            presupuestoAdjudicacion: {	
	            	money: true
	            },
	            presupuestoFinal: {	
	            	money: true
	            }
	        },
	        
	        messages: {
	        	
	        	obra: {
	        		required: 'Campo obligatorio.'
	        	}
	        
	        },
	    	
	    	submitHandler: function() {    	
	    		fxlIssueController.saveRepairInfo();
	    	}
	    	
	    });
    	   
	    $('#repairForm input, #repairForm textarea').on('keyup blur', function () { 
	        if ($(this).valid()) {                  
	        	 $('#btn-save-repair').prop('disabled',false);   
	        } else {
	        	  $('#btn-save-repair').prop('disabled',true); 
	        }
	    });
		  
	    //delete btn
		$('#btn-delete-repair').live('click', function(e) {				
			 bootbox.confirm("&iquest;Confirma que desea eliminar los datos?", function(result){
				  if(result){
					  fxlIssueController.deleteRepairInfo();						
				  }
			});
		});		
		
	},
	
	saveRepairInfo : function(){
		
		$.ajax({
		       url: 'issues/'+fxlIssueController.issueID+'/addRepairInfo', 
		       type: 'POST',
		       data: $('#repairForm').serialize(),
		       dataType: 'json',					       			       
		       success: function(data) {
		    	   if(data.result){					    		
		    		   window.location.reload();	
		    	   }						    	   
		    	   else{
		    		   bootbox.alert(data.message);		
		    	   }						    	
		       },
		       error: function (response) {
		    	   bootbox.alert('No se pudo guardar la informaci&oacute;n. Intente de nuevo.');		
		       },
		       complete: function(){
		    	   $('#mdl-repair').modal('hide');
		       }

		});	
		
		return false; 
		
	},
	
	deleteRepairInfo : function(){
		
		$.ajax({
		    url: 'issues/'+fxlIssueController.issueID+'/deleteRepairInfo',
	 		type: 'POST',			
	 		dataType: 'json',		
	        success: function(data){	
	        	if(data.result){
	        		window.location.reload();
	        	}
	        	else{
	        		bootbox.alert(data.message); 
	        	}
			},
			error: function (response) {
		    	   bootbox.alert('No se pudo eliminar la informaci&oacute;n. Intente de nuevo.');		
		    },
		    complete: function(){
		    	   $('#mdl-repair').modal('hide');
		    }
		});
		
		return false; 
		
	},
	

	/** ============================================================================================== **/
	/**                               V O T E				    		                               **/
	/** ============================================================================================== **/
	
	initVote : function(isVoted, isVoteUp){
		
		console.log('--- votes ---');
		
		fxlIssueController.setCurrentVote(isVoted, isVoteUp);
	    
	    $('#votes button').live('click', function(e) {
	    	
	    	var thumb = $(this).attr('id');
	    	var $voteUp = $('#vote-up');
			var $voteDown = $('#vote-down');				  
		    var voteUp = false;
		    var voteValue;
		    	
		    	if(thumb == 'vote-up'){
		    		voteValue = 1;
			    	voteUp = true;
		    	}			    		
		    	else
		    		voteValue =  -1;
		    	
		    	if(isVoted == 'true'){
		    		bootbox.alert("Ya ha votado por este reclamo.");	
		    	}
		    	
		    	else{ 					    	
			    	
			    	$.ajax({
	    			    url: 'issues/'+fxlIssueController.issueID+'/voteIssue',
				 		type: "POST",	
				 		data: '&vote=' + voteValue,							 
				        success: function(data){						        	
				        	if(data.result){
				        		
				        		if(voteUp){	
							    	$voteDown.removeClass('btn-danger').addClass('btn-default');
				        		}
				        		
				        		else{
				        			$voteDown.removeClass('btn-success').addClass('btn-default');
				        		}
				        			
				        		$voteUp.prop('disabled', true);
					    		$voteDown.prop('disabled', true);
				        		$('#voteCount').text(data.message); 
				        				
				        	}
				        	
				        	else{
				        		bootbox.alert(data.message);	
				        	}	
	            		}						  
	    			});
		    	
		    	}
	    });
		
	},
	
	
	/** ============================================================================================== **/
	/**                               W A T C H							                               **/
	/** ============================================================================================== **/
	
	
	initWatch : function(){
		
		console.log('--- watchers ---');
		
		var $watcherList = $('#followers-list');   
		var loader = '<button class="btn btn-default pull-right loader"><img src="'+fxlGlobalController.getDomainUrl()+'resources/images/loader6.gif" alt="Loading" height=15 width=15 /></button>';	  

		//show watchers
		$watcherList.live('click', function(){ 
			fxlIssueController.displayWatchers(fxlIssueController.issueID);
		});
		
		//watch
		$('#btn-watch-issue').live('click', function() {		    	
					
			if(fxlGlobalController.loggedUser == fxlIssueController.reporter){
				bootbox.alert("S&oacute;lo puede seguir reclamos publicados por otros usuarios.");
			}				
			else{					
				$(this).replaceWith(loader);
				fxlIssueController.watchIssue(fxlIssueController.issueID);	
			}			
		});

		//unwatch
	    $('#btn-unwatch-issue')
			.live('mouseover', function(){
	    		$(this).addClass('btn-inverse').text('CANCELAR SUSCRIPCIÓN');
	    	})
	    	.live('mouseleave', function(){
	    		$(this).removeClass('btn-inverse').text('SUSCRIPTO');  
	    	})
	    	.live('click', function() {	    		
	    		$(this).replaceWith(loader);
	    		fxlIssueController.unWatchIssue(fxlIssueController.issueID);		 					 				
	    	});
		
	},
		
	watchIssue : function(issueID){
		
		$.ajax({
		    url: 'issues/'+issueID+'/watch/',
	 		type: "POST",						 
	        success: function(data){
	        	if(data.result){	
	        		setTimeout(function(){		
	        			$('.loader').replaceWith('<button id="btn-unwatch-issue" class="btn pull-right">Suscripto</button>');	        		
	        			$('#numFollowers').text(data.message);
	 				}, 1000);
	        	}
	        	else{
	        		bootbox.alert(data.message);	
	        		$('.loader').replaceWith('<button id="btn-watch-issue" class="btn pull-right">@ Suscribirse</button>');
	        	}	
    		}						  
		});			
		
	},
	
	unWatchIssue : function(issueID){
		
		var $watcherList = $('#followers-list');   
		
		$.ajax({
		    url: 'issues/'+issueID+'/unwatch/',
	 		type: "POST",							 				 
	        success: function(data){							        	
	        	if(data.result){
	        		setTimeout(function(){
	        			$('.loader').replaceWith('<button id="btn-watch-issue" class="btn btn-default pull-right">@ Seguir</button>');
	        			$watcherList.text(data.message);	
	        		}, 1000);
	        	}
	        	else{
	        		bootbox.alert(data.message);	
	        		
	        	}	
    		}						  
		});				
		
	},
	
	displayWatchers : function(issueID){
		
		$.ajax({
     	   url: 'issues/'+issueID+'/displayIssueFollowers.html',
            type: 'POST',
            dataType: 'json',
            success: function(response){		
         	   
         	   if(response.length == 0 ){
         		   $('#mdl-followers .modal-body').text('No hay usuarios siguiendo este reclamo.');
         	   }
         	   
         	   else{
         		   		var followers = '';				             
					    $.each(response, function(i, follower){	
					    	followers += '<i class="icon-angle-right" style="margin-right: 5px;"></i>&nbsp;';
					    	followers += mapController.getUserURL(follower);
					    	followers += '<br>';
					    });
					    
	                   $('#mdl-followers .modal-body').html(followers);
	               
         	   }
         	   
         	    $('#mdl-followers').modal('show');	
            }
        });
		
	},
	
	initStatusUpdate : function(){
		
		console.log('--- status update ---');
		
		$("#btn-update-status").click(function(event){
			var statusForm =  $("#modalStatusForm");
			statusForm.validate();
			
			if(!statusForm.valid()){
				return false;
			}				
			else{
				fxlIssueController.editIssueStatus(event);
			}
			
		});			
		
		$('#invalid-container').hide();
		
		$("#tipoResolucion").change(function(){
			
			if( $(this).val() == "Invalido" ){
				var $options = $('#tipoInvalido');
				$options.append($("<option />").val("No es un reclamo").text("NO ES UN RECLAMO"));
				$options.append($("<option />").val("Ubicacion incorrecta").text("UBICACION INCORRECTA"));
				$options.append($("<option />").val("Informacion falsa").text("INFORMACION FALSA"));
				$options.append($("<option />").val("Datos personales").text("DATOS PERSONALES"));					
				$options.append($("<option />").val("Contenido ofensivo").text("CONTENIDO OFENSIVO"));
				 
				$('#invalid-container').show();
			}
			
			else{
				$('#invalid-container').hide();
			}
			
			
		});
		
	},
	
	displayClosesIssues : function(latitud, longitud){
		
		console.log('--- closest issues ---');
		
		var issueLocation = [];		
		issueLocation.id = fxlIssueController.issueID;
		issueLocation.latitude = latitud;
		issueLocation.longitude = longitud;		
		
		mapController.getClosestMarkersByIssue(issueLocation);	
	},
	
	enableUserActions : function(){
		
		console.log('--- user actions ---');
			
		$('#userIssueActions').show();
		$('#issue-stats-actions').show();
		$('#issue-stats-actions').find("#btn-edit").bind('click', fxlIssueController.enableDisableFields);
		$('#issue-stats-actions').find("#btn-update").bind('click', fxlIssueController.editIssueFields);
	  	$('#userIssueActions').find("#btn-status").bind('click', fxlIssueController.initStatusModal);
	  	
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
					  
				       url: 'issues/'+fxlIssueController.issueID+'/updateIssue.html', 
				       data:   { fields: JSON.stringify(fxlIssueController.updatedFields) }, //additional data
				       ajaxOptions: {
				           dataType: 'json'
				       },  				       
				       success: function(data) {				    	   
				    	   if(data.result){						    			 	
				    				var url = mapController.getIssuePlainURL(fxlIssueController.issueID);		
					    			window.location.href= url;	
				    	   }						    	   
				    	   else{
				    		   bootbox.alert(data.message);		
				    	   }						    	
				       },
				       error: function (response) {
				           console.log(response);
				       }
				   });				  
			  }			   
		  });//bootbox   
	},				
	
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
		
		var data = 'newStatus='+ status + '&resolution=' + resolution + '&obs=' + obs;
		
		$("#mdl-status").modal('hide');
		
	
		$.ajax({
			url: 'issues/'+fxlIssueController.issueID+'/updateIssueStatus',
	 		type: "POST",	
	 		data: data,
	 		dataType: "json",	
	 		beforeSend: function(){
	 			fxlGlobalController.blockPage("html");
	 		},
	        success: function(data){		
	        	fxlGlobalController.unBlockPage("html");
	        	 
	        	if(data.result){
	        		setTimeout(function(){
        				var url = mapController.getIssuePlainURL(fxlIssueController.issueID);
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
	        	fxlGlobalController.unBlockPage("html");
            }
		});	
		
	},
	
	/** ============================================================================================== **/
	/**                               V E R I F Y					                                   **/
	/** ============================================================================================== **/
	
	initVerifcation : function(){
		
		$("input[name='verify_ops']").change(function(){
		     		      
			var options = [];
			
			$.each($("input[name='verify_ops']:checked"), function(){            
				options.push($(this).val());
			});
		    
				
			if(options.length == 4){
				$('#btn-verify').prop('disabled', false);
				$('#btn-reject').prop('disabled', true);
			}
		  
			else{
				$('#btn-verify').prop('disabled', true);
				$('#btn-reject').prop('disabled', false);
			}			        	
		        
		 });	
	
	},	
	
	verifyOrRejectIssue : function(label){
		
		event.preventDefault();
		
		var status = "";
		
		if(label == 'Verificar')
			status = 'VERIFICADO';
		
		if(label == 'Rechazar')
			status = "RECHAZADO";
		
		var data = 'newStatus='+ status + '&resolution=' + null + '&obs=' + null;
		
		$("#mdl-verify").modal('hide');				
	
		$.ajax({
			url: 'issues/'+fxlIssueController.issueID+'/updateIssueStatus',
	 		type: "POST",	
	 		data: data,
	 		dataType: "json",	
	 		beforeSend: function(){
	 			fxlGlobalController.blockPage("html");
	 		},
	        success: function(data){		
	        	fxlGlobalController.unBlockPage("html");
	        	 
	        	if(data.result){
	        		setTimeout(function(){
        				var url = mapController.getIssuePlainURL(fxlIssueController.issueID);
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
	  			fxlGlobalController.unBlockPage("html");
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
	
};