	<script type="text/javascript">   
	
	

		$(document).ready(function(){
			
			var currentPage = 1,
	        currentXHR;	
			var $container = $('#infinite-container');
			var $containerUsers = $('#infinite-container-users');
			
			var titleLimit = 40;
			var descLimit = 150;
			var dummyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mattis fringilla nisl sed elementum. Maecenas congue aliquet lacinia. Sed diam ante, consectetur at imperdiet tristique, tincidunt vitae magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed vitae vestibulum orci, ut cursus libero. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam in lorem at sapien accumsan consequat ut eu purus. "
			
			/** Load first page of issues **/
			
			var issueJson = '${jsonIssues}';
			var issuesArray = JSON.parse(issueJson);	
			
			var usersJson = '${jsonUsers}';
			var usersArray = JSON.parse(usersJson);	
			
			/* LOAD FIRST PAGE */
			loadFirstPage(issuesArray, usersArray);
			
			
			function cropText(value, limit){
				var cropped = '';
				if(value.length > limit)
					cropped = value.substr(0, limit) + '...';
                else 
                	cropped = value;	
				
				return cropped;
			}
			
			function renderToHtml(element, type){
				
				var html = '';
					
				if(type == "ISSUE"){
					
					imgNum = Math.floor(Math.random() * 10);  //entre 0 y 9
					
					var html = 	'<div class="brick">'
	        			+ 			'<p class="top">'
						+				'<span class="id-char pull-left"><b>#</b></span>'
						+ 				'<span class="date-box pull-right">'
						+ 					'<span class="id pull-left">' +element.id+ '</span>'
						+ 					'<span class="date pull-right">' +element.date+ '</span>'
						+				'</span>'
						+ 			'</p>'
						+ 			'<a class="thumbnail" href="resources/images/samples/image' +imgNum+ '.jpg">'
						+    			'<img class="media-object" src="resources/images/samples/image' +imgNum+ '.jpg">'
						+  			'</a>'	
						+   		'<a class="title" href="' +element.url+ '">' +cropText(element.title, titleLimit)+ '</a>'	
						+			'<p class="address"><span class="city">' +element.city+ '</span>, <span class="province">' +element.province+ '</span></p>'
						+           '<p class="desc">' +cropText(dummyText, descLimit)+ '</p>'
						+ 			'<span class="status '+element.css+'">' +element.status+ '</span>'
						+   '</div>';
				}
				
				else if(type == "USER"){
					
					imgNum = 9
					
					var html = 	'<div class="brick-user">'
						+   		'<a class="username" href="' +element.url+ '">' +element.username+ '</a>'	
						+ 			'<a class="thumbnail" href="resources/images/samples/image' +imgNum+ '.jpg">'
						+    			'<img class="media-object" src="resources/images/samples/image' +imgNum+ '.jpg">'
						+  			'</a>'	
						+			'<p class="address">De <span class="city">' +element.city+ '</span>, <span class="province">' +element.province+ '</span></p>'
						+			'<p class="bottom">'
						+ 					'Registrado el <span >' +element.registration+ '</span>'
						+ 			'</p>'
						+ 			'<p class="stats">'
						+ 					'<span class="counter label label-info"><i class="icon icon-map-marker icon-small"></i><span class="numIssues">' +element.reportedIssues+ '</span></span>'
						+ 					'<span class="counter label label-default"><i class="icon icon-comments-alt icon-small"></i><span class="numComments">' +element.postedComments+ '</span></span>'
						+ 					'<span class="counter label label-success"><i class="icon icon-ok icon-small"></i><span class="numFixes">' +element.fixedIssues+ '</span></span>'
						+ 			'</p>'
					
						+   '</div>';
				}
				
				return html;
				
			}
			
			function loadFirstPage(issuesArray, usersArray){
				 if(issuesArray.length > 0){
	            	var html =  [];	
	            	$.each( issuesArray, function( i, value ) {
	            		var imgNum = Math.floor(Math.random() * 10);  //entre 0 y 9
	            		var item = renderToHtml(value, "ISSUE");
		        		html.push(item);
		        	});
	            	$container.append(html);
		         }
				 
				 if(usersArray.length > 0){
	            	var html =  [];	
	            	$.each( usersArray, function( i, value ) {
	            		var imgNum = Math.floor(Math.random() * 10);  //entre 0 y 9
	            		var item = renderToHtml(value, "USER");
		        		html.push(item);
		        	});
	            	$containerUsers.append(html);
			     }
			}
			
           
          
            //http://isotope.metafizzy.co/sorting.html
  			$container.imagesLoaded( function(){                
                $container.isotope({
                    itemSelector : '.brick',   
                    sortBy: 'original-order',
                    getSortData : {
                        title    : '.title',
                        id       : '.id parseInt',
                        status   : '.status',
                        province : '.province' 
                    },
                    masonry : {
                    	isFitWidth : true
                    }
                });
            });
  			
  			// sort items on button click
  			$('#sorts  > .btn').on( 'click',  function() {
  				var sortByValue = $(this).attr('data-sort-by');
  			  	$container.isotope({ sortBy: sortByValue });
  			 	$(this).addClass("active").siblings().removeClass("active");
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
  		            speed: 'slow',
  		        }  		      
			 }, function (newElements) {
			 		var html = '';
 			 		$.each( newElements, function( i, value ) {
 			 			 html += renderToHtml(value);
 			        });
					 	
 			 		var $html = $( html );

	 			    $html.imagesLoaded(function(){
	 				$html.animate({ opacity: 1 });
	 				$container.append( $html ).isotope( 'appended', $html );
		 		});
              });
 
	   
			/*
			$(window).scroll(function(){				
				
				if($(window).scrollTop() == $(document).height() - $(window).height()){
				        	
		    		if (currentXHR) {
		                return;
		         	}
				    	
				    $('div#infinite-scroll-loader').show();				        	
				        	
				  	currentXHR = $.ajax({
				        url: "./loadmore/" + currentPage,
				        type: 'GET',					            
				        success: function(data){			
				        	
				        	var dataArray = JSON.parse(data);					        							        
				            if(dataArray.length > 0){	
				            	
				            	var html =  [];	
				            	
				            	$.each( dataArray, function( i, value ) {
					        		var item = ""					        		
					        			+ "<div class='brick'>"
										+	"<div class='media'>"
										+ 		"<a class='pull-left thumbnail' href='#'>"
										+    		"<img class='media-object' src='${pageContext.request.contextPath}/resources/images/nopic64.png'>"
										+  		"</a>"				
										+  	"<div class='media-body'>"
										+    	"<a href='#'><h5 class='media-heading'>" +value.title+ "</h5></a>"		
										+    "<p style='font-size:11px'>" +value.date+ " en <a href='#'>" +value.city+ ", " +value.province+ "</a><br></p>"
										+ "</div></div></div><br>";
								
					        		html.push(item);
					        	});
				            								            		
				                $("#brickContainer").append(html);
// 				                $("#brickContainer").append(currentPage + "--------------------------------------------------");								            	
				            	$('div#infinite-scroll-container').hide();
				            }						            
				            else{  
				            	$('#infinite-scroll-message').html("<center>No hay m&aacute;s resultados para mostrar.</center>");	
				            	$('div#infinite-scroll-container').hide();
				            }					            
				            currentPage++;
				      	},
				      	complete: function() {
		                    currentXHR = null;
		                }
			      	});					      
				}
			});
			*/
			
			
			
			var flag = 0;
			/****** BOOTSTRAP WIZARD ******/
			
			function enableDisableDraggableMarker(marker, tabIndex){
				
				if(marker != null){
					if(tabIndex==0)
						marker.setOptions({draggable:true});			
					else
						marker.setOptions({draggable:false});			
				}
			
			}
			
			
					 
			$("#tags").select2({				
				placeholder: 'Seleccione una etiqueta...',
				maximumSelectionSize: 5,
				tags: ${allTags},
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
			
			//init limit conter
			var elemTitle = $(".titleCounter");
			var elemDesc = $(".descCounter");
			$(".formTitle").limiter(80, elemTitle);
			$(".formDescription").limiter(600, elemDesc);
			
			 function emptyFields(){
	        	  return $("#address").val() == "" 
	        	  			&& $("#locality").val() == ""
	        	  			&& $("#administrative_area_level_1").val() == ""
	        	  			&& $("#formTitle").val() == ""
	        	  			&& $("#formDescription").val() == ""
	        	  			&& $("#tags").val() == "";
	          }
	          
	 
			 var timesClicked = 0;
		
			 
			 $( '#btnIssue' ).bind( 'click', function( event ) {
		
				 isAnimating = true;
	           
// 				  timesClicked++;
// 				   if ( timesClicked >= 3 ) {
// 				     $( this ).unbind( event );
// 				   }
	
	              
	            	//open form
	            	if( isFormOpen ){
	            	
	            		if(!emptyFields()){
	            			
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
	                  			toggleIssueForm();       
	                 		}        		
	            		}
	            		
	            	}
	            	//closed form
	            	else{
	            		
	            		if( $(this).hasClass('btn-success') ){
	                		$(this).removeClass('btn-success').addClass('btn-danger').html("<i class=\"icon-remove-sign icon-large\"></i>&nbsp;&nbsp;&nbsp;CANCELAR RECLAMO");
	                		toggleIssueForm();   
	                	} 
	            	
	            	}
	           
	            });//btnIssue
	           
	            function toggleIssueForm(){
	            	
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
	  				     		
	            }
	            
	        
	            
	            $("#file_upload_1").uploadify({	    
	            	debug : false,
	                swf           : './resources/images/uploadify.swf',
	                uploader      : 'http://localhost:8080/fixeala/handleFileUpload.html',	         
				    fileObjName :  'file',
   					method   : 'post',
   					width : 170,
   					height: 30,
					auto :  true,
					method   : 'post',
// 					buttonClass : 'btn-default',
					buttonText : '<i class="icon-upload icon-large"></i>&nbsp;&nbsp;Seleccionar archivo',
				    multi           : false,
 					fileTypeExts        : '*.jpg;*.jpeg;*.png',
	                removeCompleted : false,
	                removeTimeout   : false,
// 	                uploadLimit: 1,
	                queueSizeLimit: 1,
	                onUploadError : function(file, errorCode, errorMsg, errorString) {
	                	$('span.data').text(' - Error');
	                    bootbox.alert("No se pudo cargar el archivo. Intente de nuevo o publique el reclamo sin el adjunto.");
	                },
	                onUploadComplete : function(file) {
	                	$('span.data').text(' - Completo');
	                },
	                onCancel : function(file) {
	                	$('span.data').text(' - Cancelado');
	                },
	                onClearQueue : function(queueItemCount) {
	                	$('span.data').text(' - Cancelado');
	                }
	            
	            });
	            
	            
	            
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
	  	 			    } ,
		 		 		errorPlacement: function (error, element) {
		 		            $(element).addClass("error");
		  		        }
				});
	            
	            initWiz();
				
				//disable next button on first tab
				if( $(".tab-pane#tab1").hasClass('active') ){
					$(".pager li.next").addClass('disabled');
				}
							
				function initWiz(){
					
					 $('#rootwizard').bootstrapWizard({
						
						onPrevious: function(tab, navigation, index){	
							enableDisableDraggableMarker(initMarker, index);
				  		},				
				  		
						onNext: function(tab, navigation, index) {					
						
							var $valid = $("#issueWizard").valid();
				  			
							if(!$valid) {		  			
				  				$issueValidator.focusInvalid();
				  				return false;
				  			}
				  			
				  			enableDisableDraggableMarker(initMarker, index);
				  		
				  			//first tab
				  			if(index == 1){				  				
				  				var $next =  $(".pager li.next");
				  				if( $next.hasClass('next disabled') ){			  				
				  					return false;
				  				}			  				
				  			}			  		
						
						}, //onNext
						onTabShow: function(tab, navigation, index){
							
							var $total = navigation.find('li').length;
							var $current = index+1;
							var $percent = ($current/$total) * 100;
//		 					$('#rootwizard').find('.bar').css({width:$percent+'%'});
							
							// If it's the last tab then hide the last button and show the finish instead
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
//		 					alert('on tab click disabled');
							return false;
						} //onTabClick
					});
					 
					 return $('#rootwizard');
					
				}//initWiz
				 
				$('#rootwizard .finish').click(function() {
					if( $("#tags").val() == ""){
						bootbox.alert("Debe especificar al menos una categor&iacute;a.");						
					}
					
					else{
						
						var location = initMarker.location;
						
						var $form = $("#issueWizard");
						console.log($form.serialize());
						
						
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
									   "&title=" + title + "&description=" + description + "&tags=" + tags;
									
						$.ajax({ 
						 		url: "./reportIssue.html", 		
						 		type: "POST",					 	
						 		data : formData,	
						 		success : function(alertStatus){					 		
						 			if(alertStatus.result){
						 				
						 				blockIssueForm();	 	
						 				
						 				bootbox.alert(alertStatus.message, function() {					 					
						 								 					
					 						loadMarkers(map);
					 						initMarker.setMap(null);
					 						map.setCenter(location);
					 						
					 						$('#btnIssue').removeClass('btn-danger').addClass('btn-success').html("<i class=\"icon-map-marker icon-large\"></i>&nbsp;&nbsp;&nbsp;PUBLICAR RECLAMO");
					 						
					 						toggleIssueForm();
					 					
						 					
						 				});		
						 				
						 				setTimeout(function(){   	
					 						unBlockIssueForm();	   
					 					}, 2000);
			 	    				}
			 	    				else{	 	    			
			 	    					bootbox.alert(alertStatus.message);	 	    										 	    					
			 	    				}  
						 			
						 		},
						 		error: function(jqXHR, exception) {
					                   if (jqXHR.status === 0) {
					                       alert('Not connect.\n Verify Network.');
					                   } else if (jqXHR.status == 404) {
					                       alert('Requested page not found. [404]');
					                   } else if (jqXHR.status == 500) {
					                       alert('Internal Server Error [500].');
					                   } else if (exception === 'parsererror') {
					                       alert('Requested JSON parse failed.');
					                   } else if (exception === 'timeout') {
					                       alert('Time out error.');
					                   } else if (exception === 'abort') {
					                       alert('Ajax request aborted.');
					                   } else {
					                       alert('Uncaught Error.\n' + jqXHR.responseText);
					                   }
					               }
						 	
						 	});//ajax
						
						
						
					}
					return false;
				});//rootwizard
			
		});
	</script>
	
	<div id="content">
	
		<div id="searchBar" class="row-fluid">
		  	<div class="span8">
				<div class="input-append">
					<input id="search" type="text" data-link="./autocomplete" data-provide="typeahead" placeholder="Busc&aacute; reclamos por ID, Estado, T&iacute;tulo o Direcci&oacute;n">				
				</div>
			</div>		
			<div class="span3 pull-right" style="width:336px; border: 0px solid #000">	
				<button id="btnIssue" class="btn btn-success" data-toggle="button"> 
					<i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;&nbsp;PUBLICAR RECLAMO
				</button>
			</div>		
		</div>	

		<!-- ROW 1 -->
		<div class="row-fluid" style="height:472px;">
		<div class="container">
		
  				<select id="cbxProvincias" name="cbxProvincias" onchange="findProvincia(value);return false" onfocus="">              	
					<option value="BA">Buenos Aires</option>
					<option value="CF">Capital Federal</option>
					<option value="CT">Catamarca</option>
					<option value="CC">Chaco</option>
					<option value="CH">Chubut</option>
					<option value="CD">C&oacute;rdoba</option>					
					<option value="CR">Corrientes</option>
					<option value="ER">Entre R&iacute;os</option>
					<option value="FO">Formosa</option>
					<option value="JY">Jujuy</option>
					<option value="LP">La Pampa</option>				
					<option value="LR">La Rioja</option>		
					<option value="MZ">Mendoza</option>
					<option value="MN">Misiones</option>
					<option value="NQ">Neuqu&eacute;n</option>					
					<option value="RN">R&iacute;o Negro</option>
					<option value="SA">Salta</option>					
					<option value="SJ">San Juan</option>
					<option value="SL">San Luis</option>				
					<option value="SC">Santa Cruz</option>		
					<option value="SF">Santa Fe</option>					
					<option value="SE">Santiago del Estero</option>
					<option value="TF">Tierra del Fuego</option>
					<option value="TM">Tucum&aacute;n</option>					
		  		</select>
		  		
		  		<div id="mapFormContainer" style="position:absolute;  width:1180px; height:472px; border: 0px solid #000; padding: 0; margin-top: 0;"> 
		  		
		  			<!-- MAP -->
			  		<div id="map_canvas"></div>	
	
					<!-- ISSUE FORM -->
					<div id="issueFormWizard">					
						<form id="issueWizard"  method="POST" class="form-issue form-horizontal form-inline">
							
							<!-- begin BOOTSTRAP WIZARD -->					
							<div id="rootwizard" style="margin-top:10px;">
								<ul>
								  	<li><a href="#tab1" data-toggle="tab">1. UBICACI&Oacute;N</a></li>
									<li><a href="#tab2" data-toggle="tab">2. DATOS</a></li>
									<li><a href="#tab3" data-toggle="tab">3. ARCHIVO</a></li>
								</ul>
								<hr>		
								<div class="tab-content">
								 	<!-- TAB 1 -->
								    <div class="tab-pane" id="tab1">
								     	<input type="hidden" id="latitude" name="latitude"  />
										<input type="hidden" id="longitude" name="longitude" />											
										
										<div class="form-group">
											<label>Direcci&oacute;n (calle y altura) *</label>
											<input type="text" class="form-control" name="address" id="address" placeholder="Tipee y seleccione una direcci&oacute;n..." required>
		  								</div>			
		
										<div class="form-group">
											<label>Barrio (opcional)</label>
											<input type="text" id="neighborhood" name="neighborhood"/>	
										</div>
										
										<div class="form-group">
											<label>Ciudad *</label>
											<input type="text" id="locality" name="city" disabled="disabled" required/>		
										</div>
										
										<div class="form-group">
											<label>Provincia *</label>
											<input type="text" id="administrative_area_level_1" name="province" disabled="disabled" required>	
										</div>																													
								    </div>
								    
								    <!-- TAB 2 -->
								    <div class="tab-pane" id="tab2">
								    	<div class="form-group" style="margin-bottom: 40px;">
								    		<label>T&iacute;tulo *</label>
											<input type="text" id="formTitle" class="formTitle" name="formTitle" required>	
											<small><span class="pull-left">S&oacute;lo letras, n&uacute;meros, acentos y espacios.</span><span class="titleCounter pull-right"></span></small>
										</div>
										<div class="form-group">
											<label>Descripci&oacute;n *</label>
											<textarea rows="5" id="formDescription"  class="formDescription" name="formDescription"></textarea>	
											<small><span class="pull-left">Sin comillas simples o dobles.</span><span class="descCounter pull-right"></span></small>
										</div>												      	
								    </div>
								    
								     <!-- TAB 3 -->
									<div class="tab-pane" id="tab3">							
										<label>Categor&iacute;a *</label>
			   							<input type="hidden" id="tags" name="tags" style="width:300px" class="input-xlarge" required/>								
										<label>Foto (opcional)</label>
										
<!-- 										<div class="fileupload fileupload-new" data-provides="fileupload" style="display:inline-block"> -->
<!-- 											<div class="fileupload-new thumbnail" style="width: 304px; height: 100px;"> -->
<%-- 												<img src="${pageContext.request.contextPath}/resources/images/nopic.png" /> --%>
<!-- 											</div> -->
<!-- 											<div class="fileupload-preview fileupload-exists thumbnail" style="height: 100px;min-width:300px;max-width: 200px; max-height: 100px; line-height: 20px;"></div> -->
<!-- 											<span class="btn fileinput-button"> -->
<!-- 										        <i class="icon-upload icon-large"></i>&nbsp;&nbsp; -->
<!-- 										        <span>Subir archivo</span>									         -->
<!-- 										        <input type="file" name="files[]" id="fileupload"> -->
<!-- 										    </span>									   -->
<!-- 										</div> -->

										<br><br>
										<center>
										<!-- uploadify -->	
										<input id="file_upload_1" name="file_upload_1" type="file" > 
											</center>
								    </div>
								    
								    <!-- BUTTONS -->
									<ul class="pager wizard" style="margin-top: 0; border: 0px solid blue;">
										<li class="previous"><a href="javascript:;"><i class="icon-long-arrow-left"></i>&nbsp;&nbsp;Anterior</a></li>
									  	<li class="next"><a href="javascript:;">Siguiente&nbsp;&nbsp;<i class="icon-long-arrow-right"></i></a></li>
									  	<li class="next finish" style="display:none;"><a href="javascript:;"><i class="icon-ok"></i>&nbsp;&nbsp;Publicar</a></li>
									</ul>
								</div>	
							</div>					
							<!-- end BOOTSTRAP WIZARD -->							
						</form>					
					</div><!-- issueFormWizard -->	
					
				</div><!-- mapFormContainer -->
	</div>
	</div>
	
	 <div class="clearfix"></div>
       		<!-- ROW 2 new -->
       	

	<div class="row" style="height:auto; margin:30px 0 30px 0; padding: 0">

		<ul class="nav nav-tabs">
			<li class="active"><a href="#latestIssues" data-toggle="tab">&Uacute;ltimos publicados</a></li>
			<li><a href="#hottestIssues" data-toggle="tab">M&aacute;s votados</a></li>
			<li><a href="#topUsers" data-toggle="tab">Ranking usuarios</a></li>
		</ul>							
														
		<div class="tab-content">	
		
			<!-- Recientes -->
			<div class="tab-pane fade in active" id="latestIssues">	
			
				<!-- sorting -->
				<span>Ordenar por: </span>
				<div id="sorts" class="btn-group">
	  				<button data-sort-by="original-order" class="btn btn-default active">Fecha</button>
	  				<button data-sort-by="status" class="btn btn-default">Estado</button>
					<button data-sort-by="title" class="btn btn-default">Titulo</button>
					<button data-sort-by="province" class="btn btn-default">Provincia</button>
	    			<button data-sort-by="id" class="btn btn-default">ID</button>
				</div>					
				
				<!-- infinite scroll -->
				<div id="infinite-container"></div>				
				<nav id="page-nav" style="display: none;">
  					<a href="loadmore/2"></a>
				</nav>
						
			</div>
			
			<div class="tab-pane fade" id="hottestIssues">		
			M&acute;s votados		
			</div>
			
			<div class="tab-pane fade" id="topUsers">		
			
				<!-- sorting -->
				<span>Ordenar por: </span>
				<div id="sorts-users" class="btn-group">
	  				<button data-sort-by="original-order" class="btn btn-default"><i class="icon icon-star"></i>Mejor reputaci&oacute;n</button>
	  				<button data-sort-by="issues" class="btn btn-default"><i class="icon icon-map-marker"></i>Publicaciones</button>
					<button data-sort-by="comments" class="btn btn-default"><i class="icon icon-comment-alt"></i>Comentarios</button>
					<button data-sort-by="fixes" class="btn btn-default"><i class="icon icon-ok"></i>Reclamos resueltos</button>
<!-- 				<button data-sort-by="votes" class="btn btn-default"><i class="icon icon-thumbs-up-alt"></i>Votos recibidos</button> -->
				</div>		
				
				<div id="infinite-container-users"></div>				
				<nav id="page-nav" style="display: none;">
  					<a href="loadmore/2"></a>
				</nav>	
			</div>
			
		</div>

      </div>
       <div class="clearfix"></div>
  
      
	</div><!-- /CONTENT -->
	