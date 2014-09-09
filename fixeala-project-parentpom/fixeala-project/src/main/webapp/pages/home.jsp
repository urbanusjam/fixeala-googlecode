<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="content">
	<!-- search bar -->
	<div id="searchBar" class="row-fluid" >
		<div class="span8">				
			<div class="input-append">
				<input id="search" type="text" data-link="./autocomplete" data-provide="typeahead" placeholder="Buscar reclamos por t&iacute;tulo, direcci&oacute;n, n&uacute;mero o estado...">				
			</div>			
		</div>			
		<div class="span3 pull-right" style="width:336px;">
			<button id="btnIssue" class="btn btn-success" data-toggle="button"> 
				<i class="icon-map-marker icon-large"></i>&nbsp;&nbsp;&nbsp;PUBLICAR RECLAMO
			</button>		
		</div>		
	</div>
	
	<!-- progress bar -->
	<div class="row-fluid" style="padding: 10px 0 10px 0; margin-bottom: 20px;  border: 1px solid #DDD;">

		<div class="span6 pull-left" style="border-right: 1px solid #DDD; margin:0;">			
			<center>
				<h4>&iexcl;Ya se verificaron ${verified} de ${totalIssues} reclamos!</h4>
				<div class="progress progress-striped active" style="width: 400px;">					
	  				<div class="bar" id="verifiedBar"></div>	  				
				</div>
				<p style="text-align: center;">Todav&iacute;a quedan ${notVerified} reclamos sin verificar</p>
			</center>
		</div>
		<div class="span6 pull-right" style=" border-left: 1px solid #DDD; margin:0;">			
			<center>
				<h4>&iexcl;Y se resolvieron ${resolved} de ${totalIssues} reclamos!</h4>
				<div class="progress progress-striped active" style="width: 400px;">					
	  				<div class="bar bar-success" id="resolvedBar"></div>	  				
				</div>
				<p style="text-align: center;">Todav&iacute;a quedan ${notResolved} reclamos sin resolver</p>
			</center>
		</div>
	</div>	
		
	<!-- ROW 1 -->
	<div class="row-fluid" style="height:472px;">

		<!-- combobox provinces -->
 		<select id="cbxProvincias" name="cbxProvincias" onchange="javascript:mapController.findProvince(value);" onfocus="">              	
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
	  	
	  	<!-- map container -->	
	  	<div id="mapFormContainer" style="position:absolute;  width:1180px; height:472px; padding: 0; margin-top: 0;"> 
	  		
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
									<small><span class="pull-left">S&oacute;lo letras, n&uacute;meros, acentos, espacios y comas.</span><span class="titleCounter pull-right"></span></small>
								</div>
								<div class="form-group">
									<label>Descripci&oacute;n *</label>
									<textarea rows="5" id="formDescription"  class="formDescription" name="formDescription"></textarea>	
									<small><span class="pull-left">Sin comillas simples o dobles.</span><span class="descCounter pull-right"></span></small>
								</div>												      	
						    </div>
						    
						     <!-- TAB 3 -->
							<div class="tab-pane" id="tab3">							
								<label>Categor&iacute;as *</label>
	   							<input type="hidden" id="tags" name="tags" style="margin-bottom: 20px;" required/>								
								
								<label>Foto (opcional)</label>										
								<input id="file_upload" name="file_upload" type="file" accept="image/*" 
								onchange="javascript:fileController.simpleUpload(this.files[0], this.files[0].name, fileController.uploadCallback);">
							
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
	
	<div class="clearfix"></div>
       		
	<!-- ROW 2 TABS -->
	<div class="row" style="height:auto; margin:30px 0 30px 0; padding: 0">
		<!-- tabs -->
		<ul class="nav nav-tabs">
			<li class="active"><a href="#latestIssues" data-toggle="tab"><i class="icon icon-tags icon-small"></i>&Uacute;ltimos publicados</a></li>
			<li><a href="#hottestIssues" data-toggle="tab"><i class="icon icon-thumbs-up icon-small"></i>M&aacute;s votados</a></li>
			<li><a href="#topUsers" data-toggle="tab"><i class="icon icon-user icon-small"></i>Ranking usuarios</a></li>
		</ul>							
		<!-- tabs content -->										
		<div class="tab-content">			
			<!-- tab 1 recent -->
			<div class="tab-pane fade in active" id="latestIssues">	
				<c:if test="${totalIssues eq 0}">
					<h4 style="padding-bottom: 20px; margin-left: 15px;">No hay reclamos publicados.</h4>
				</c:if>
				<c:if test="${totalIssues gt 0}">			
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
	  					<a href="loadmore/issue/2"></a>
					</nav>	
					<center><a href="#" class="btn btn-default btn-more vote">Mostrar m&aacute;s resultados</a></center>
				</c:if>
			</div>
			<!-- tab 2 popular -->
			<div class="tab-pane fade" id="hottestIssues">	
				<!-- infinite scroll -->
				<div id="infifxlIssueController.configIsotope();fxlIssueController.configIsotope();nite-container-votes"></div>				
				<nav id="page-nav-votes" style="display: none;">
  					<a href="loadmore/issue/2"></a>
				</nav>	
				<c:if test="${totalIssues eq 0}">
					<h4 style="padding-bottom: 20px; margin-left: 15px;">No hay reclamos publicados.</h4>
				</c:if>
				<c:if test="${totalIssues gt 0}">
					<center><a href="#" class="btn btn-default btn-more vote">Mostrar m&aacute;s resultados</a></center>
				</c:if>				
			</div>
			<!-- tab 3 user -->
			<div class="tab-pane fade" id="topUsers">
				<c:if test="${totalUsers eq 0}">
					<h4 style="padding-bottom: 20px; margin-left: 15px;">No hay reclamos publicados.</h4>
				</c:if>
				<c:if test="${totalUsers gt 0}">
					<!-- sorting -->
					<span>Ordenar por: </span>
					<div id="sorts-users" class="btn-group">
		  				<button data-sort-by="original-order" class="btn btn-default active"><i class="icon icon-star"></i>Mejor reputaci&oacute;n</button>
		  				<button data-sort-by="issues" class="btn btn-default"><i class="icon icon-map-marker"></i>Reclamos publicados</button>
						<button data-sort-by="fixes" class="btn btn-default"><i class="icon icon-ok"></i>Reclamos resueltos</button>
						<button data-sort-by="comments" class="btn btn-default"><i class="icon icon-comment-alt"></i>Comentarios</button>
					</div>						
					<div id="infinite-container-users"></div>					
					<nav id="page-nav-user" style="display: none;">
	  					<a href="loadmore/user/2"></a>
					</nav>	
					<center><a href="#" class="btn btn-default btn-more vote">Mostrar m&aacute;s resultados</a></center>
				</c:if>					
			</div>	
		</div>
	</div>	
    <div class="clearfix"></div> 
</div><!-- /CONTENT -->

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.home.js"></script>  	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.file.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fixeala/fixeala.map.js"></script>
<script type="text/javascript">   
	
	var issueFileData = null; //holds the (optional) attached file

	$(document).ready(function(){

		
		//data
		var issuesJson = '${jsonIssues}';
		var usersJson = '${jsonUsers}';
		
		//google maps
		mapController.loadGoogleMap();			
			
		//init
		fxlHomeController.initHome(issuesJson, usersJson);
		
		//progress bar
		loadProgressBar();
		
		//issue tags input		
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
		
	});
	
	function loadProgressBar(){
		//overall progress bar 
		var totalIssues = '${totalIssues}'; 
		var verifiedIssues = '${verified}'; 
		var resolvedIssues = '${resolved}'; 
		
		var verifiedProgress = (100 * verifiedIssues) / totalIssues;
		var resolvedProgress = (100 * resolvedIssues) / totalIssues;
		
		$('#verifiedBar').css('width', verifiedProgress);
		$('#resolvedBar').css('width', resolvedProgress);
		
	}		
</script>