var fxlHomeController = {
		
	issuesJson : null,
	
	usersJson : null,
	
	initHome : function(issues, users){
		
		//search
		fxlHomeController.initSearchBar();
		
		//fileupload button
		$("#file_upload").filestyle({
			buttonText: "Seleccionar",
			classIcon: "icon-plus"
		});
		
		//bootstrap wizard
		fxlHomeController.initIssueWizard();
		
		//pagination
		fxlHomeController.issuesJson = issues;
		fxlHomeController.usersJson = users;
		fxlHomeController.initInfiniteScroll();
		
	},
		
	initSearchBar : function(){
		
		var issueNames;
		var issueObjs;			
		 
		$('#search').typeahead({
			 	minLength: 3,
			    items: 5,
			    cache: false,
			    source: function(query, process){				    	
			    	 return $.ajax({
			             url: $('#search').data('link'),
			             type: 'GET',
			             data: { query: query },
			             dataType: 'json',
			             beforeSend: function() {
			                 //that.$element is a variable that stores the element the plugin was called on
			                 $('#search').addClass('loading');
			             },
			             success: function (data) {

							issueNames = [];
								issueObjs = {};				
			            	 
			            	 $.each( data, function ( i, item ) {				            		 
			            		issueNames.push(item.title);
			            		issueObjs[item.title] = item;
			            	 });

			                 return process(issueNames);
			             },
			             complete: function() {
			            	 $('#search').removeClass('loading');
			             }
			         });
			    },
			
		        matcher: function(item) {		        
		        	var issue = issueObjs[item];
		        	var query = this.query.toLowerCase();
		        	
		            return issue.id.toLowerCase().indexOf(query) != -1 
		            			|| issue.title.toLowerCase().indexOf(query) != -1 
		            			|| issue.status.toLowerCase().indexOf(query) != -1
		            			|| issue.address.toLowerCase().indexOf(query) != -1;		            	
		        },
			    updater: function(itemName) { 
			    	window.location.href = 'issues/' + issueObjs[ itemName ].id;  				
			    },
			    sorter: function(items) {
			    	console.log(items);
			        if (items.length == 0) {
			            var noResult = new Object();
			            items.push(noResult);
			        }
			    	return items;    
			    },
			    highlighter: function (item) {				    	

			    	 if( issueNames.indexOf(item) == -1 ) {				    		
			    		 return '<h4>No se encontraron resultados.</h4>';
			    	 }

			    	 else{
			    		 var issue = issueObjs[item];
			    		 var q  = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&amp;');
			    		
				    	   return ''
						       + "<div class='typeahead-container'>"
			                   + "<div class='typeahead-status'>"
			                   + 		"<p class='" +issue.css+ "'>" +issue.status+ "</p>"
			                   + "</div>"
			                   + "<div class='typeahead-content'>"
			                   + "<span class='typeahead-id'>&#35;" +highlightQuery(issue.id, q)+  "&nbsp;&nbsp;&rsaquo;&nbsp;&nbsp;" +issue.date+ "</span>"				                   
			                   + "<span class='typeahead-title'><strong>" + highlightQuery(item, q)+ "</strong></span>"
			                   + "<span class='typeahead-address'>" +highlightQuery(issue.address, q) + "</span>"
			                   + "</div></div>";	     
			    	 }  
			    	  
			    }				  
			});
		 
		 function highlightQuery(data, query){
			 return data.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
	               return '<span style="background-color:yellow; display: inline;">' + match + '</span>';
	         });
		 }
				
		 //Remove forced selection of first item
		 $.fn.typeahead.Constructor.prototype.render = function(items) {
		     var that = this;
		     items = $(items).map(function (i, item) {
		       i = $(that.options.item).attr('data-value', item);
		       i.find('a').html(that.highlighter(item));
		       return i[0];
		     });

		     this.$menu.html(items);
		     return this;
		};
					
		var options = {
                currentPage: 1
                , totalPages: 10
                , numberOfPages:3
                , size:'normal'
                , alignment:'center'
                , onPageChanged: function(e,oldPage,newPage){
                    $('.pag').text("Current page changed, old: "+oldPage+" new: "+newPage);
                }
              
        }
		
	},
	
	/** ============================================================================================== **/
	/**                               I S S U E   W I Z A R D			    		                   **/
	/** ============================================================================================== **/
	
	
	initIssueWizard : function(){
		
		//limit counter
		$.fn.extend( {
	        limiter: function(limit, elem) {
	            $(this).on("keyup focus", function() {
	                setCount(this, elem);
	            });
	            function setCount(src, elem) {
	                var chars = src.value.length;
	                if (chars > limit) {
	                    src.value = src.value.substr(0, limit);
	                    chars = limit;
	                }
	                elem.html( limit - chars + " / " + limit );
	            }
	            setCount($(this)[0], elem);
	        }
	    });
		
		//init limit counter
		var elemTitle = $(".titleCounter");
		var elemDesc = $(".descCounter");
		$(".formTitle").limiter(100, elemTitle);
		$(".formDescription").limiter(600, elemDesc);
		
		//disable next button on first tab
		if( $(".tab-pane#tab1").hasClass('active') ){
			$(".pager li.next").addClass('disabled');
		}
		
		
		
		fxlHomeController.bindIssueToggleBtn();
		
		
		
		fxlHomeController.configWizard();
		
		fxlHomeController.configWizardFinishBtn();
		
	},
	
	configWizardTags : function(allTags){
		
		$("#tags").select2({				
			placeholder: 'Seleccione una etiqueta...',
			maximumSelectionSize: 5,
//			tags: ${allTags},
			tags : allTags,
			multiple: true,			
			tokenSeparators: [",", " "],
		   	id: function (item) {
	            return item.text;
		   	},  		
			createSearchChoice:function(term, data) {
				  if ($(data).filter(function() {
				    return this.text.localeCompare(term)===0;
				  }).length!=0) {
					  //return {id:term, text:term};
					  return false;
				  }
				},
			formatNoMatches: function(term){ 
					return "No se encontraron resultados.";
			},		
			formatSelectionTooBig : function(term){ 
				return 'S&oacute;lo se permiten 5 etiquetas.'; 
			}
		});	
		
	},	 
		
	emptyFields : function(){
    	  return $("#address").val() == "" 
    	  			&& $("#locality").val() == ""
    	  			&& $("#administrative_area_level_1").val() == ""
    	  			&& $("#formTitle").val() == ""
    	  			&& $("#formDescription").val() == ""
    	  			&& $("#tags").val() == "";
    },      
	
    bindIssueToggleBtn : function(){
    	
    	$('#btnIssue').bind('click', function(event) {

    		isAnimating = true;
       
        	//open form
        	if( isFormOpen ){
        	
        		if(!fxlHomeController.emptyFields()){
        			
        			bootbox.confirm("Si cierra el formulario, se descartar&aacute; la informaci&oacute;n ingresada. &iquest;Desde continuar?", function(result){
            			if(result){
            				window.parent.location.reload();
            			}
            		});
        			
        		}
        		//empty form
        		else{             		
        		 	if( $(this).hasClass('btn-danger') ){  	            		 	
             			$(this).removeClass('btn-danger').addClass('btn-success').html("<i class=\"icon-map-marker icon-large\"></i>&nbsp;&nbsp;&nbsp;PUBLICAR RECLAMO");
             			fxlHomeController.toggleIssueForm();       
             		}        		
        		}
        		
        	}
        	//closed form
        	else{
        		
        		if( $(this).hasClass('btn-success') ){
            		$(this).removeClass('btn-success').addClass('btn-danger').html("<i class=\"icon-remove-sign icon-large\"></i>&nbsp;&nbsp;&nbsp;CANCELAR RECLAMO");
            		fxlHomeController.toggleIssueForm();   
            	} 
        	
        	}
       
        });//btnIssue
    	
    },	
       
	toggleIssueForm : function(){
    	
      	  var $issueBox = $("#issueFormWizard");  
      	  var duration = 1000;
      	  
      	  $issueBox.animate({
                width: "toggle",
                right:"338px",
                opacity: "toggle"                   
          }, duration, function(){ isAnimating = false; });

		  $("#map_canvas").animate({            		 
       		  width : parseInt($issueBox.css('width')) == 316 ?  1178 :  842                   		
          }, duration, function(){
        	  
        	  if( $issueBox.is(":hidden") )
        		  isFormOpen = false;
        	  else
        		  isFormOpen = true;
          });
			 
		  $("#cbxProvincias").animate({
           	      marginRight : parseInt($issueBox.css('width')) == 316 ? 115 : 451        
          }, duration);  				 
			     		
    },
    
    validateIssueForm : function(){
    	
    	 //sin caracteres especiales
		$.validator.addMethod("titleCheck",function(value){
			var pattern = /^\s*[a-zA-ZÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿñÑ0-9,\s]+\s*$/;
			return pattern.test(value);
		},  "Formato no v&aacute;lido.");
		
		//sin comillas simples o dobles
		$.validator.addMethod("descriptionCheck",function(value){
			var pattern = /^[^'"]*$/;
			return pattern.test(value);
		}, "Formato no v&aacute;lido.");
		
		var $issueValidator = $("#issueWizard").validate({	
			
			rules: {
	 			route: { required: true },	
	 			street_number: { required: true },
	 			city: { required: true },		
	 			province: { required: true },		
	 			formTitle: { required: true, titleCheck: true },				    
			    formDescription: { required: true, descriptionCheck: true } 				  
			},
		    messages: {
		    	  route: { required : 'Campo obligatorio.'},	
		    	  street_number: { required : 'Campo obligatorio.' },
		    	  city: { required : 'Campo obligatorio.' },	
		    	  province: { required : 'Campo obligatorio.' },
		    	  formTitle: { required : 'Campo obligatorio.'},
 					  formDescription: { required : 'Campo obligatorio.' }
			},
			
			highlight: function (element) { 
		        $(element).addClass("error"); 
		    },
    	
		    unhighlight: function (element) { 
		        $(element).removeClass("error"); 
		    },
		    
	 		errorPlacement: function (error, element) {
	            $(element).addClass("error");
	        }
		});
		
		return $issueValidator;
    	
    },
        		
	configWizard : function(){
		
		var $issueValidator = fxlHomeController.validateIssueForm();
		
		 $('#rootwizard').bootstrapWizard({
			
			onPrevious: function(tab, navigation, index){	
				fxlHomeController.enableDisableDraggableMarker(initMarker, index);
	  		},				
	  		
			onNext: function(tab, navigation, index) {					
			
				var $valid = $("#issueWizard").valid();
	  			
				if(!$valid) {		  			
	  				$issueValidator.focusInvalid();
	  				return false;
	  			}
	  			
	  			fxlHomeController.enableDisableDraggableMarker(initMarker, index);
	  		
	  			//first tab
	  			if(index == 1){				  				
	  				var $next =  $(".pager li.next");
	  				if( $next.hasClass('next disabled') ){			  				
	  					return false;
	  				}			  				
	  			}			  		
			
			},
			
			onTabShow: function(tab, navigation, index){
				
				var $total = navigation.find('li').length;
				var $current = index+1;
				
				// If it's the last tab, hide the last button and show the finish instead
				if($current >= $total) {
					$('#rootwizard').find('.pager .next').hide();
					$('#rootwizard').find('.pager .finish').show();
					$('#rootwizard').find('.pager .finish').removeClass('disabled');
					$('#rootwizard').find('.pager .finish').removeClass('btn');
				} else {
					$('#rootwizard').find('.pager .next').show();
					$('#rootwizard').find('.pager .finish').hide();
				}
				
			}, //onTabshow
			onTabClick: function(tab, navigation, index) {
				return false;
			}
		});
		 
		 return $('#rootwizard');
		
	},
	
	configWizardFinishBtn : function(){
		
		$('#rootwizard .finish').click(function() {
			
			if( $("#tags").val() == ""){
				bootbox.alert("Debe especificar al menos una categor&iacute;a.");						
			}
			
			else{
				
				//no file selected
				if(issueFileData == null){
					 fxlHomeController.saveIssue(null, null, null);
				}
				
				//selected file
				else{
					
					//upload file to imgur
					console.log(issueFileData);
					
					var result = JSON.parse(issueFileData.response);				
		        	var success = result.success;
		        	var statusCode = result.status;
		        	
		        	console.log(success + ' - ' + statusCode);
		        	
	        		//upload error
		        	if(!success && statusCode != '200'){
		        		bootbox.confirm("Hubo un error al cargar el archivo. &iquest;Desea continuar con la publicacion del reclamo?", function(result){
							  if(result){
								  fxlHomeController.saveIssue(null, null, null);
							  }
		        		});
		        	}
		        	
	        		//upload OK
	        		else if(success && statusCode == '200'){
	        		
		        		var imgurFileID = result.data.id;
			        	var deletehash = result.data.deletehash;
		        		
		        		//parameters
		        		var fileData = JSON.stringify(result.data);
		        		var filename = issueFileData.filename;
		        		
		        		//SAVE ISSUE
		        		fxlHomeController.saveIssue(fileData, filename, deletehash);
					
	        		}//else imgur ok					
				}
			}
			return false;
		});		
	},	
	
	enableDisableDraggableMarker : function(marker, tabIndex){
		if(marker != null){
			if(tabIndex==0)
				marker.setOptions({draggable:true});			
			else
				marker.setOptions({draggable:false});			
		}
	},
				
	saveIssue : function(fileData, filename, deletehash){
		
		//save issue
		var location = initMarker.location;
		
		var $form = $("#issueWizard");
		console.log($form.serialize());
		
		//parameters
		var lat = $("#latitude").val();
		var lng = $("#longitude").val();
		var address = $("#address").val();
		var neighborhood = $("#neighborhood").val();
		var city = $("#locality").val();
		var province = $("#administrative_area_level_1").val();
		var title = $("#formTitle").val();
		var description = $("#formDescription").val();
		var tags = $("#tags").val();
		
		var formData = "latitude=" + lat + "&longitude=" + lng + "&address=" + address + 
					   "&neighborhood=" + neighborhood + "&city=" + city + "&province=" + province + 
					   "&title=" + title + "&description=" + description + "&tags=" + tags + 
					   "&fileData=" + fileData + "&filename=" + filename;
					
		$.ajax({ 
		 		url: "./reportIssue.html", 		
		 		type: "POST",					 	
		 		data : formData,	
		 		success : function(alertStatus){
		 			
		 			if(alertStatus.result){
		 				
		 				mapController.blockIssueForm();	 	
		 				
		 				bootbox.alert(alertStatus.message, function() {	
		 					mapController.displayMarkers(map);
	 						initMarker.setMap(null);
	 						map.setCenter(location);
	 						$('#btnIssue').removeClass('btn-danger').addClass('btn-success').html("<i class=\"icon-map-marker icon-large\"></i>&nbsp;&nbsp;&nbsp;PUBLICAR RECLAMO");
	 						fxlHomeController.toggleIssueForm();
		 				});		
		 				
		 				setTimeout(function(){   	
		 					mapController.unBlockIssueForm();	   
	 					}, 2000);
    				}
		 			
    				else{	 	    			
    					if(deletehash != null){
    						fileController.deleteImage(deletehash);
    					}
    					bootbox.alert(alertStatus.message);	 	    										 	    					
    				}  
		 			
		 		},
		 		error: function(jqXHR, exception) {
		 			bootbox.alert('No se pudo publicar el reclamo.');	 	  
	            }
		 	
		});
	},
	
	
	/** ============================================================================================== **/
	/**                               I N F I N I T E   S C R O L L				    		           **/
	/** ============================================================================================== **/
	
	
	initInfiniteScroll : function(){
		
		var issuesArray = JSON.parse(fxlHomeController.issuesJson);	
		var votesArray = JSON.parse(fxlHomeController.issuesJson);		
		var usersArray = JSON.parse(fxlHomeController.usersJson);	
		
		votesArray.sort(fxlHomeController.sortByVotes);
		
		//config
		fxlHomeController.configIsotopeContainers();
		fxlHomeController.configIsotopeTabs();
		fxlHomeController.configIsotopeMoreBtn();
		fxlHomeController.configIsotopeSortBtn();

		//first page
		fxlHomeController.loadFirstPage(issuesArray, votesArray, usersArray);
		
	},
	
	sortByVotes : function(a, b){
		var aVote = a.totalVotes;
		var bVote = b.totalVotes; 
		return bVote - aVote;
	},
	
	loadFirstPage : function(issuesArray, votesArray, usersArray){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		 if(issuesArray.length > 0){
        	var html =  [];	
        	$.each( issuesArray, function( i, value ) {
        		var item = fxlHomeController.renderToHtml(value, "issue");
        		html.push(item);
        	});
        	$container.append(html);
         }
		 
		 if(votesArray.length > 0){
        	var html =  [];	
        	$.each( votesArray, function( i, value ) {
        		var item = fxlHomeController.renderToHtml(value, "issue");
        		html.push(item);
        	});
        	$containerVotes.append(html);
         }
		 
		 if(usersArray.length > 0){
        	var html =  [];	
        	$.each( usersArray, function( i, value ) {
        		var item = fxlHomeController.renderToHtml(value, "user");
        		html.push(item);
        	});
        	$containerUsers.append(html);
	     }
	},
	
	renderToHtml : function(element, type){
		
		var html = '';
		var imageUrl = '';
		var issueUrl = "issues/" + element.id;
		var userUrl = "users/" + element.username;
		var titleLimit = 40;
		var descLimit = 150;
		
		if(type == "issue"){
			
			if(element.url != null){	
				imageUrl = element.url;	
			}
			
			else{
				imageUrl = "resources/images/nopic.png";
			}
			
			html = 	'<div class="brick">'
    			+ 			'<p class="top">'
				+				'<span class="id-char pull-left"><b>#</b></span>'
				+ 				'<span class="date-box pull-right">'
				+ 					'<span class="id pull-left">' +element.id+ '</span>'
				+ 					'<span class="date pull-right">' +element.date+ '</span>'
				+				'</span>'
				+ 			'</p>'
				+ 			'<a class="thumbnail" href="'+imageUrl+'">'
				+    			'<img src="'+imageUrl+'">'
				+  			'</a>'	
				+   		'<a class="title" title="'+element.title+'" href="' +issueUrl+ '">' +fxlGlobalController.cropText(element.title, titleLimit)+ '</a>'	
				+			'<p class="address"><span class="city">' +element.city+ '</span>, <span class="province">' +element.province+ '</span></p>'
				+           '<p class="desc">' +fxlGlobalController.cropText(element.description, descLimit)+ '</p>'
				+ 			'<span class="status '+element.css+'">' +element.status+ '</span>'
				+ 			'<div class="inline-container">'
				+ 					'<div class="left"><i class="icon icon-thumbs-up icon-small"></i>' +element.totalVotes+ '</div>'
				+					'<div class="right"><i class="icon icon-eye-open icon-small"></i>' +element.totalViews+ '</div>'
				+ 					'<div class="center"><i class="icon icon-user icon-small"></i>' +element.totalFollowers+ '</div>'
				+ 			'</div>'		
				+   '</div>';
		}
		
		else if(type == "user"){
			
			if(element.profilePic != null){	
				imageUrl = element.profilePic;	
			}
			
			else{
				imageUrl = "resources/images/nopic.png";
			}
		
			html = 	'<div class="brick brick-user">'
				+   		'<a class="username" href="' +userUrl+ '">' +element.username+ '</a>'	
				+ 			'<a class="thumbnail" href="'+imageUrl+'">'
				+    			'<img src="'+imageUrl+'">'
				+  			'</a>'	
				+			'<p class="bottom">'
				+ 					'Registrado el <span >' +element.registration+ '</span>'
				+ 			'</p>'
				+ 			'<div class="inline-container">'
				+ 					'<div class="left"><i class="icon icon-map-marker icon-small"></i><span class="numIssues">' +element.reportedIssues+ '</div>'
				+ 					'<div class="right"><i class="icon icon-comments-alt icon-small"></i><span class="numComments">' +element.postedComments+ '</div>'
				+ 					'<div class="center"><i class="icon icon-ok icon-small"></i><span class="numFixes">' +element.fixedIssues+ '</div>'
				+ 			'</div>'						
				+   	'</div>';
		}
		
		return html;
		
	},
	
	configIsotopeContainers : function(){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		//issues
		$container.imagesLoaded( function(){                
	        $container.isotope({
	            itemSelector : '.brick',   
	            sortBy: 'original-order',
	            getSortData : {
	                title    : '.title',
	                id       : '.id parseInt',
	                status   : '.status',
	                province : '.province' 
	            }
	        });
	    });
		
		$container.infinitescroll({
			navSelector  	: "#page-nav",
			nextSelector 	: "#page-nav a",
			itemSelector 	: ".brick",  
			pixelsFromNavToBottom : "20",
			debug: true,
			dataType: 'json',
			appendCallback: false,
			loading: {
				finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
		        msgText: "<h4>Cargando reclamos...</h4>",
		        speed: 'slow'
		    }  		      
		 }, function (newElements) {
		 		var html = '';
		 		$.each( newElements, function( i, value ) {
		 			 html += renderToHtml(value, 'issue');
		        });
				 	
			 	var $newElems = $( html );

			    $newElems.imagesLoaded(function(){
					$newElems.animate({ opacity: 1 });
					$container.append( $newElems ).isotope( 'appended', $newElems );
			    });
	    });
		
		$container.infinitescroll('pause');
		 
		//votes
		$containerVotes.imagesLoaded( function(){                
	    	$containerVotes.isotope({
	        	itemSelector : '.brick'	                  
	    	});
	    });
		
		$containerVotes.infinitescroll({
			navSelector  	: "#page-nav-votes",
			nextSelector 	: "#page-nav-votes a",
			itemSelector 	: ".brick",  
			pixelsFromNavToBottom : "20",
			debug: true,
			dataType: 'json',
			appendCallback: false,
			loading: {
	            finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
	            msgText: "<h4>Cargando reclamos...</h4>",
	            speed: 'slow'
		    }  		      
		 }, function (newElements) {
		 		var html = '';
			 		$.each( newElements, function( i, value ) {
			 			 html += renderToHtml(value, 'issue');
			        });
				 	
			 		var $newElems = $( html );

				    $newElems.imagesLoaded(function(){
						$newElems.animate({ opacity: 1 });
						$containerVotes.append( $newElems ).isotope( 'appended', $newElems );
	 			});
				    
	    });
			
		$containerVotes.infinitescroll('pause');
		 
		//users
		$containerUsers.imagesLoaded( function(){   
	    	$containerUsers.isotope({
	        	itemSelector : '.brick',
	            sortBy: 'original-order',
	            sortAscending : false,
	            getSortData : {
	            	issues    : '.numIssues parseInt',
	                comments  : '.numComments parseInt',
	                fixes     : '.numFixes parseInt'
	            }
	        });
		});
		 
		$containerUsers.infinitescroll({
			navSelector  	: "#page-nav-user",
			nextSelector 	: "#page-nav-user a",
			itemSelector 	: ".brick",  
			pixelsFromNavToBottom : "20",
			debug: true,
			dataType: 'json',
			appendCallback: false,
			loading: {
	            finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
	            msgText: "<h4>Cargando usuarios...</h4>",
	            speed: 'slow',
		    }  		      
		 }, function (newElements) {
		 		var html = '';
		 		$.each( newElements, function( i, value ) {
		 			 html += renderToHtml(value, 'user');
		        });
				 	
		 		var $newElems = $( html );
		 		
			    $newElems.imagesLoaded(function(){
					$newElems.animate({ opacity: 1 });
					$containerUsers.append( $newElems ).isotope( 'appended', $newElems );
	 			});
	    });
					
		$containerUsers.infinitescroll('pause');
		
	},
	
	configIsotopeTabs : function(){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		//bootstrap tabs + multiple isotope instances = overlapping [FIXED] 
		// http://stackoverflow.com/questions/19214362/making-a-jquery-isotope-layout-initialize-inside-a-bootstrap-tab
		// https://github.com/metafizzy/isotope/issues/458
		
		$('.nav-tabs li').on('shown.bs.tab', function (e) {
			var clickedTab = $(this).find('a').attr('href');
		 	if(clickedTab == "#topUsers"){
			  	$containerUsers.isotope('layout');
		 	}
		 	if(clickedTab == "#hottestIssues"){
			  	$containerVotes.isotope('layout');
		 	}

		});
		
	},
	
	configIsotopeMoreBtn : function(){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		$(' .btn-more ').click(function(e){
			// call this whenever you want to retrieve the next page of content
		    // likely this would go in a click handler of some sort
		    e.preventDefault();
		
		    if( $(this).hasClass( 'issue' ) ){
				$container.infinitescroll('retrieve');
			    $('#page-nav').hide(); 
		   	}  
		    
		    else if( $(this).hasClass( 'vote' ) ){
		    	$containerVotes.infinitescroll('retrieve');
		    	$('#page-nav-votes').hide(); 
		    } 
		    
		    else{
		    	$containerUsers.infinitescroll('retrieve');
		        $('#page-nav-users').hide(); 
		    } 			  
		    return false;
		});
		
	},
	
	configIsotopeSortBtn : function(){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		// sort items on button click
		$('#sorts  > .btn').on( 'click',  function() {
			var sortByValue = $(this).attr('data-sort-by');
		  	$container.isotope({ sortBy: sortByValue });
		 	$(this).addClass("active").siblings().removeClass("active");
		});
		
		// sort items on button click
		$('#sorts-users  > .btn').on( 'click',  function() {
			var sortByValue = $(this).attr('data-sort-by');
		  	$containerUsers.isotope({ sortBy: sortByValue });
		 	$(this).addClass("active").siblings().removeClass("active");
		});
		
	}
	
		
};