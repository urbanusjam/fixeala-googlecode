
	<script type="text/javascript">    
		$(document).ready(function(){
					 
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
	        	  			&& $("#administrative_area_level_1").val() == "";
	          }
	          
	 
			 var timesClicked = 0;
			
	      	 
			 $( "#btnIssue" ).bind( "click", function( event ) {
	            	
				  timesClicked++;
				   if ( timesClicked >= 3 ) {
				     $( this ).unbind( event );
				   }
		            
	              
	            	//open form
	            	if( parseInt($("#map_canvas").css('width')) == 842 ){
	            		
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
		          	  var duration = 300;
		          	  
		          	  $issueBox.animate({
		                    width: "toggle",
		                    right:"338px",
		                    opacity: "toggle"                   
		              }, duration, function(){ isAnimating = false; });
		
		  			  $("#map_canvas").animate({            		 
		           		  width : parseInt($issueBox.css('width')) == 316 ?  1178 :  842                   		
		              }, duration);
		  				 
		  			  $("#cbxProvincias").animate({
		  	           	      marginRight : parseInt($issueBox.css('width')) == 316 ? 115 : 451        
		  	          }, duration);  				 
	  				     		
	            }
			
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
											<small><span class="descCounter pull-right"></span></small>
										</div>												      	
								    </div>
								    
								     <!-- TAB 3 -->
									<div class="tab-pane" id="tab3">							
										<label>Categor&iacute;a *</label>
			   							<input type="hidden" id="tags" name="tags" style="width:300px" class="input-xlarge" required/>								
										<label>Foto (opcional)</label>
										<div class="fileupload fileupload-new" data-provides="fileupload" style="display:inline-block">
											<div class="fileupload-new thumbnail" style="width: 304px; height: 100px;">
												<img src="${pageContext.request.contextPath}/resources/images/nopic.png" />
											</div>
											<div class="fileupload-preview fileupload-exists thumbnail" style="height: 100px;min-width:300px;max-width: 200px; max-height: 100px; line-height: 20px;"></div>
											<span class="btn fileinput-button">
										        <i class="icon-upload icon-large"></i>&nbsp;&nbsp;
										        <span>Subir archivo</span>									        
										        <input type="file" name="files[]" id="fileupload">
										    </span>									  
										</div>		
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