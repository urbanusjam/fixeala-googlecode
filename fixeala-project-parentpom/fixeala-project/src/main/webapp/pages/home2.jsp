<header>
	<div class="row">
	 	<div class="col-md-2 logo">fixeala&nbsp;<i class="fa fa-caret-right"></i></div>	 	 	
	 	<div class="col-md-3 pull-right login">
	 		<a href="#">Iniciar sesión</a>
	 			<i class="fa fa-arrows-h"></i> 
	 		<a href="#">Registrarse</a>
	 	</div>	 	
<!-- 	  	<div class="col-md-4 pull-right search">  	 -->
<!-- 	 		<div class="right-inner-addon"> -->
<!-- 	       		<i class="fa fa-search fa-1x"></i> -->
<!-- 	       		<input type="search" class="form-control"  placeholder="Buscar por ID, Estado, Título, Calle, Barrio, Ciudad, Provincia, Usuario..." /> -->
<!-- 	   		</div> -->
<!-- 	  	</div> -->
  	</div>
</header>



	<div id="container" class="row">
	
				<div class="col-md-5">
<!-- 			<div id="map-svg-canvas"></div> -->
				<p id="map_leaflet"></p>
				
				</div>
	
		<div class="col-md-6">	
		
			<div id="content">
					
					<ul id="myTab" class="nav nav-tabs">
                		<li class="active"><a href="#tab-resumen" data-toggle="tab"><i class="fa fa-check-circle"></i>Resumen</a></li>
                		<li><a class="tab-centro" href="#tab-data" data-toggle="tab"><i class="fa fa-plus"></i>Datos</a></li>
                		<li><a href="#tab-graph" data-toggle="tab"><i class="fa fa-bar-chart-o"></i>Gráfico</a></li>
              		</ul>
              
              <div id="myTabContent" class="tab-content">
              
                <div class="tab-pane fade active in" id="tab-resumen">
                
                <br>
                
<!--                   <h3>En la <strong>República Argentina</strong> hay...</h3> -->

 						<h3>De <span class="selectedProvince">ARGENTINA</span>...</h3>
				
					<br>
					
					<table class="table table-resumen">					
							<tr>
								<td><h2><strong>26.731</strong><br><small>reclamos</small><span class="important">publicados</span></h2></td>
								<td><h2>11.421<small><span class="solved">resueltos</span></small></h2></td>
								<td><h2>7.788<small><span class="inprogress">en progreso</span></small></h2></td>	
								<td><h2>4.451<small><span class="open">abiertos</span></small></h2></td>						
							</tr>												
							<tr>	
								<td></td>			
								<td><h2>2.674<small><span class="acknowledged">admitidos</span></small></h2></td>
								<td><h2>332<small><span class="closed">cerrados</span></small></h2></td>							
								<td colspan="3"><h2>65<small><span class="open">reabiertos</span></small></h2></td>
							</tr>	
					</table>
					
                 </div>
                 
                 
                <div class="tab-pane fade" id="tab-data">
                  <h3>Total Argentina</h3>
                  <div class="row-fluid">
                    <div class="span6">
                      <p>Población</p>
                      <h2><span data-bind="text: poblacionTotalStr">40.592.484</span></h2>      
                    </div>
                    <div class="span6">
                      <p>Superficie</p>
                      <h2 class="superficie"><span data-bind="text: superficieTotalStr">2.448.627</span> Km²</h2>
                    </div>
                  </div>
                  <hr>
                  <h3><span data-bind="text: percentageTotal">0%</span> de Argentina seleccionado</h3>
                  <div class="row-fluid">
                    <div class="span6">
                      <p>Población</p>
                      <h2><span data-bind="text: cantSelectedStr">0</span></h2>
                      
                    </div>
                    <div class="span6">
                      <p>Superficie Ocupada</p>
                      <h2 class="superficie"><span data-bind="text: supSelectedStr">0</span> Km²</h2>
                    </div>
                  </div> 

                  <div class="row-fluid">
                    <div class="span6">
                      <p>Porcentaje de superficie Ocupada</p>
                      <h2 class="porcentaje"><span data-bind="text: percentageSupSelected">0%</span></h2>
                    </div>
                    <div class="span6">
                      <p>Habitantes por Km²</p>
                      <h2 class="porcentaje"><span data-bind="text: densidadSelected">0</span></h2>
                    </div>
                  </div> 

                  <a data-toggle="modal" href="#ayuda" class="btn btn-primary btn-lg"><i class="glyphicon glyphicon-info-sign"></i> Observaciones</a>

                </div>
                
                

                <div class="tab-pane fade" id="tab-graph">
                  <div class="row-fluid">
                    <div class="span12">
                      <h3>Grafiquito</h3>
                      <div id="graph-container">
                      </div>
                    </div>
                  </div>
                 </div>

              </div>
					<br><br>
					
<!-- 					<div class="btn-group btn-group-lg"> -->
<!-- 					  <button type="button" class="btn btn-link"><i class="fa fa-sort-amount-asc"></i>Ascendente</button> -->
<!-- 					  <button type="button" class="btn btn-link"><i class="fa fa-sort-amount-desc"></i>Descendente</button> -->
<!-- 					  <button type="button" class="btn btn-link"><i class="fa fa-sort-alpha-asc"></i>Alfabéticamente </button> -->
<!-- 					</div> -->
				
					
					

				<!-- <div id="map_canvas"></div> -->
						
			</div>
		</div>
		

		<ul class="floating-tab-menu">
			<li>
				<a href="#"  >
					<i class="fa fa-map-marker fa-3x"></i><span class="aaa">NUEVO RECLAMO</span>
				</a>	
			</li>			
			<li>
				<a href="#">
					<i class="fa fa-tasks fa-3x"></i><span>DATASETS</span>
				</a>
			</li>
			<li>
				<a href="#">
					<i class="fa fa-users fa-3x"></i><span>VECINOS</span>
				</a>
			</li>
			<li>
				<a href="#">
					<i class="fa fa-mobile fa-3x"></i><span>APLICACIÓN MOVIL</span>
				</a>
			</li>
			<li>
				<a href="#">
					<i class="fa fa-info fa-3x"></i><span>ACERCA DE</span>
				</a>
			</li>
		</ul>
				
	</div> 

			



<footer>Copyright © 2014 &nbsp;&ndash;&nbsp; <a href="#">UrbanusJam!</a> &nbsp;&ndash;&nbsp; Todos los derechos reservados.</footer>