
	<script type="text/javascript">    
		$(document).ready(function(){
			
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
		
			 
 			 $( "#btnIssue" ).bind( "click", function( event ) {
		
				 isAnimating = true;
	           
				  timesClicked++;
				   if ( timesClicked >= 3 ) {
				     $( this ).unbind( event );
				   }
	
	              
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
	                 			$(this).removeClass('btn-danger').addClass('btn-primary').html("<i class=\"icon-map-marker icon-large\"></i>&nbsp;&nbsp;&nbsp;PUBLICAR RECLAMO");
	                 			toggleIssueForm();       
	                 		}        		
	            		}
	            		
	            	}
	            	//closed form
	            	else{
	            		
	            		if( $(this).hasClass('btn-primary') ){
	                		$(this).removeClass('btn-primary').addClass('btn-danger').html("<i class=\"icon-remove-sign icon-large\"></i>&nbsp;&nbsp;&nbsp;CANCELAR RECLAMO");
	                		toggleIssueForm();   
	                	} 
	            	
	            	}
	           
	            });
	           
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
					 						
					 						$("#btnIssue").removeClass('btn-danger').addClass('btn-primary').html("<i class=\"icon-map-marker icon-large\"></i>&nbsp;&nbsp;&nbsp;PUBLICAR RECLAMO");
					 						
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
						 	
						 	});
						
						
						
					}
					return false;
				});
			
		});
	</script>
	
	<div id="content">
	
		<div id="searchBar" class="row-fluid">
		  	<div class="span8">
				<div class="input-append">
					<input id="search" type="text" placeholder="Buscar reclamos (ID, Estado, T&iacute;tulo, Direcci&oacute;n, Barrio, Ciudad o Provincia)" autocomplete="off">					
<!-- 			        <button id="btnSearch" class='btn add-on' style="width:70px;"> -->
<!-- 			            <i class="icon-search"></i> -->
<!-- 			        </button>			         -->
			        <button id="btnAdvancedSearch" class='btn add-on' title="B&uacute;squeda avanzada">
			            <i class="icon-angle-down"></i>
			        </button>  
				</div>
			</div>		
			<div class="span3 pull-right" style="width:336px; border: 0px solid #000">	
				<button id="btnIssue" class="btn btn-primary" data-toggle="button"> 
					<i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;&nbsp;PUBLICAR RECLAMO
				</button>
			</div>		
		</div>	
		
		<div id="searchFilters">
		Completar filtros de busqueda.
		</div>	
		
		
		
		<!-- ROW 1 -->
		
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
		<!-- 						<div id="bar" class="progress progress-striped active"> -->
		<!-- 						  <div class="bar"></div> -->
		<!-- 						</div> -->
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
				
				<div class="clearfix"></div>
				
				
	<!-- ROW 2 -->

		<!--Sidebar content-->
		<div class="row-fluid" style="height:auto;margin-top:30px;">
		
		 <div class="span3">
			<div class="page-header">
    	   		<h4><i class="icon-user icon-large"></i>&nbsp;&nbsp;Usuarios m&aacute;s activos</h4>    	 	
    	   </div>    
		      
	      	<table class="table table-hover">
				<tr>
					<td style="border-top:none">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">ariel_xyz</h5></a>				    
						    <p style="font-size:11px">1101 reclamos <br>
						    99 comentarios</p>			
						 				
						  </div>
						</div>
					</td>				
				</tr>	
				<tr>
					<td style="border-top:1px dashed #dddddd; border-bottom:1px dashed #dddddd">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">SuperUser</h5></a>				    
						    <p style="font-size:11px">977 reclamos <br>
						    142 comentarios</p>									 				
						  </div>
						</div>
					</td>				
				</tr>	
			</table>		
			<p style="text-align:center;"><a href="#" >ver m&aacute;s</a>	</p>	
		</div>
		
		<div class="span5">
		   <div class="page-header">
    	   		<h4><i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;&Uacute;ltimos reclamos</h4>    	 	
    	   </div>    
		      
	      	<table class="table table-hover">
				<tr>
					<td style="border-top:none">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">Ramas de �rbol tapan sem�foro</h5></a>		
						    <p style="font-size:11px">10/06/13 en <a href="#">Mendoza</a><br>
						    Reportado por: <a href="#">el_user_22</a>
						     </p>	
						  </div>
						</div>
					</td>				
				</tr>	
				<tr>
					<td style="border-top:1px dashed #dddddd; border-bottom:1px dashed #dddddd">
						<div class="media">
						  <a class="pull-left thumbnail" href="#">
						    <img class="media-object" src="${pageContext.request.contextPath}/resources/images/nopic64.png">
						  </a>				
						  <div class="media-body">
						    <a href="#"><h5 class="media-heading">Mamposter�a de edificio deteriorada</h5></a>		
						    <p style="font-size:11px">10/06/13 en <a href="#">Buenos Aires</a><br>
						    Reportado por: <a href="#">pablivo-clavo-un-clavito</a>
						     </p>	
						  </div>
						</div>
					</td>				
				</tr>
			</table>
			<p style="text-align:center;"><a href="#" >ver m&aacute;s</a>	</p>	
		</div>
		
		
		 
     </div>
      
	</div>
	</div><!-- /CONTENT -->