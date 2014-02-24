<header>
	<div class="row">
<!-- 	 	<div class="col-md-2 logo">fixeala&nbsp;<i class="fa fa-caret-right"></i></div>	 	 	 -->
<!-- 	 	<div class="col-md-3 pull-right login"> -->
<!-- 	 		<a href="#">Iniciar sesión</a> -->
<!-- 	 			<i class="fa fa-arrows-h"></i>  -->
<!-- 	 		<a href="#">Registrarse</a> -->
<!-- 	 	</div>	 	 -->
<!-- 	  	<div class="col-md-4 pull-right search">  	 -->
<!-- 	 		<div class="right-inner-addon"> -->
<!-- 	       		<i class="fa fa-search fa-1x"></i> -->
<!-- 	       		<input type="search" class="form-control"  placeholder="Buscar por ID, Estado, Título, Calle, Barrio, Ciudad, Provincia, Usuario..." /> -->
<!-- 	   		</div> -->
<!-- 	  	</div> -->


  		<nav id="menu"  class="navbar navbar-default" role="navigation">
		  <div class="container-fluid">
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">		     
		      <a class="navbar-brand" href="#">fixeala<i class="fa fa-caret-right"></i></a>
		    </div>
		
		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		        <li class="active"><a href="#">Inicio</a></li>		       
		        <li><a href="#">Datasets</a></li>
		        <li><a href="#">Vecinos</a></li>
		        <li><a href="#">Aplicación Móvil</a></li>
		        <li><a href="#">Acerca de</a></li>		        
		      </ul>
		     
		<!--       <form class="navbar-form navbar-left" role="search"> -->
		<!--         <div class="form-group"> -->
		<!--           <input type="text" class="form-control" placeholder="Buscar reclamos por nro, titulo, estado, ciudad o provincia..."> -->
		<!--         </div> -->
		<!--         <button type="submit" class="btn btn-default">Submit</button> -->
		<!--       </form> -->
		      <ul id="user-menu" class="nav navbar-nav navbar-right">
		        <li><a href="#" data-toggle="modal" data-target="#loginModal">Iniciar sesión</a></li>
		        <li><a href="#" data-toggle="modal" data-target="#signupModal">Registrarse</a></li>		       
		      </ul>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
		
		<a href="https://github.com/urbanusjam">
			<img style="position: absolute; top: 0; right: 0; border: 0;" src="https://github-camo.global.ssl.fastly.net/652c5b9acfaddf3a9c326fa6bde407b87f7be0f4/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6f72616e67655f6666373630302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_orange_ff7600.png"></a>
  	</div>
</header>



	<div id="container" class="row">
	
		<div class="col-md-5">
<!-- 		<div id="map-svg-canvas"></div> -->
			<p id="map_leaflet"></p>		
		</div>
	
		<div class="col-md-5">			
			<div id="content">					
				<ul id="myTab" class="nav nav-pills">
               		<li class="active"><a href="#tab-resumen" data-toggle="tab"><i class="fa fa-file-o"></i>Resumen</a></li>
               		<li><a href="#tab-data" data-toggle="tab"><i class="fa fa-plus-square"></i>Datos</a></li>
               		<li><a href="#tab-graph" data-toggle="tab"><i class="fa fa-bar-chart-o"></i>Gráfico</a></li>
               		<li><a href="#tab-issue" data-toggle="tab"><i class="fa fa-map-marker"></i>Nuevo reclamo</a>
             		</ul>              
             		<div id="myTabContent" class="tab-content">              
               		<div class="tab-pane fade active in" id="tab-resumen">                
               			<br>
							<h3>De <span class="selectedProvince">ARGENTINA</span>...</h3>				
						<br>					
<!-- 							<table class="table table-resumen">					 -->
<!-- 									<tr> -->
<!-- 										<td><h2><strong>26.731</strong><br><small>reclamos</small><span class="important">publicados</span></h2></td> -->
<!-- 										<td><h2>11.421<small><span class="solved">resueltos</span></small></h2></td> -->
<!-- 										<td><h2>7.788<small><span class="inprogress">en progreso</span></small></h2></td>	 -->
<!-- 										<td><h2>4.451<small><span class="open">abiertos</span></small></h2></td>						 -->
<!-- 									</tr>												 -->
<!-- 									<tr>	 -->
<!-- 										<td></td>			 -->
<!-- 										<td><h2>2.674<small><span class="acknowledged">admitidos</span></small></h2></td> -->
<!-- 										<td><h2>332<small><span class="closed">cerrados</span></small></h2></td>							 -->
<!-- 										<td colspan="3"><h2>65<small><span class="open">reabiertos</span></small></h2></td> -->
<!-- 									</tr>	 -->
<!-- 							</table>				 -->
                		</div>                                  
               		<div class="tab-pane fade" id="tab-data">
               			
               			<br>                			
               			<h3>Más datos...</h3>		
               		
               		</div>                                
	                <div class="tab-pane fade" id="tab-graph">
	                	<br>                			
               			<h3>Grafiquito...</h3>	
	                </div>	
	                
	                 <div class="tab-pane fade" id="tab-issue">
	                	<br>                			
               			<h3>Nuevo reclamo...</h3>	
	                </div>		                
             	</div>    
			</div>
		</div>
	</div> 
	
	
	<!-- Modal LOGIN -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Iniciar sesión</h4>
	      </div>
	      <div class="modal-body">
	        
	      </div>
	      <div class="modal-footer">
	       	<button type="submit" id="btnLogin" class="btn btn-primary">Aceptar</button>      
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal SIGN UP -->
	<div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Registro de nuevo usuario</h4>
	      </div>
	      <div class="modal-body">
	        
	      </div>
	      <div class="modal-footer">
	       	<button type="submit" id="btnSignup" class="btn btn-primary">Crear cuenta</button>      
	       	<button type="reset" class="btn btn-default">Cancelar</button>      
	      </div>
	    </div>
	  </div>
	</div>

			



<footer>Copyright © 2014 &nbsp;&ndash;&nbsp; <a href="#">UrbanusJam!</a> &nbsp;&ndash;&nbsp; Todos los derechos reservados.</footer>