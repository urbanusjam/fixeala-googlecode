<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">

.table-striped tbody tr.highlight td { 
    background-color: #A8D3E6;
}

th, td{font-size:12px;text-align:center !important;}


</style>

<div id="content">




	<script type="text/javascript">
	
	var rowId;
	var rowTitle;
	var selectedUser;
	
	
	function redirect(){
		var url = window.location.origin + '/'+ 'fixeala/issues/' + rowId + '.html';
		return window.location.href = url;
	}
	
	function assignUser(){
		var url = "http://localhost:8080/fixeala/issues/assignUser.html";
	    var data = 'selectedUser='+ selectedUser + '&issueID='+ rowId;
  
		$.ajax({
				url: url,
			 	dataType: 'text',
			 	data: data,
         		type: 'POST', 
	            success: function(response) { 
	            	$("#contextmenu-issue").hide();
	            	//$("#tblUserIssues").datagrid('reload');
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
	
	function updateStatus(status){
		    var url = "http://localhost:8080/fixeala/issues/updateIssueStatus.html";
		    var data = 'newStatus='+ status + '&issueID='+ rowId;
	     
			$.ajax({
					url: url,
				 	dataType: 'text',
				 	data: data,
             		type: 'POST', 
		            success: function(response) { 
		            	$("#tblUserIssues").datagrid('reload');
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
	
	$(function(){	
	
	
		$("#combo-users").select2({
	        placeholder: "Buscar usuario...",
	        minimumInputLength: 1,
	        multiple: true,
	        ajax: { 
	            url: "http://localhost:8080/fixeala/issues/getAvailableUsers/1.html",
	        	dataType: 'json',
	        	quietMillis: 100,
	            data: function (term) {
	                return {
	                    term: term
	                };
	            },
	            results: function (data) {
	              var results = [];
	              $.each(data, function(index, item){
	                results.push({
	                  id: item.id,
	                  text: item.nombre + " " + item.apellido + " (" + item.username + ")"
	                });
	              });
	              return {
	                  results: results
	              };
	            },
	            formatResult: function (item) { return item.nombre; },
                formatSelection: function (item) { return item.email; }

	   
	        } 
	    });
		
		$("#combo-users")
//         .on("change", function(e) { 
//         	alert("change "+JSON.stringify({val:e.val, added:e.added, removed:e.removed})); 
//         	})
        .on("select2-selecting", function(e) { 
        	selectedUser = e.val;
        	//alert("selecting val="+ e.val+" choice="+ JSON.stringify(e.choice));
        	})
					
			$('#tblUserIssues').on('click', 'tbody tr', function(event) {
			    $(this).addClass('highlight').siblings().removeClass('highlight');
			});
			
			
			$("#tblUserIssues").delegate("tr", "contextmenu", function(e) {
				$(this).each(function(){
					rowId = $(this).find("td").eq(0).html().trim(); 
					rowTitle = $(this).find("td").eq(2).html().trim(); 
				});
			});
 
			
			var myDataSource = function (options) {
				 this._formatter = options.formatter;
			     this._columns = options.columns;
			     this._data = options.data;
			 	 this._delay = options.delay || 0;
			};

			myDataSource.prototype = {

			        columns: function () {
			                return this._columns;
			        },

			        data: function (options, callback) {

			                var url = "http://localhost:8080/fixeala/users/" + '${profileUser}' + "/loadUserIssues.html";


								$.ajax({
										url: url,
									 	dataType: 'json',
		                             	type: 'GET', 
							            success: function(response) { 
							            	
							            	
							            	// Prepare data to return to Datagrid
			                                var data = response;
			                                var count = data.length;	
			                                
			                                // here we give all data a 'flat' property
			                                $.each(data, function (index, row) {
			                                	$("#tblUserIssues tbody tr").attr('id', data[0].id);
			                                });
			                              
											// SORTING
											if (options.sortProperty) {
												data = _.sortBy(data, options.sortProperty);
												if (options.sortDirection === 'desc') data.reverse();
											}
											
											// SEARCHING
// 							                if (options.search) {
// 							                  data = _.filter(data, function (item) {
// 							                    for (var prop in item) {
// 							                      if (!item.hasOwnProperty(prop)) continue;
// 							                      if (~item[prop].toString().toLowerCase().indexOf(options.search.toLowerCase())) return true;
// 							                    }
// 							                    return false;
// 							                  });
// 							                }
							            
							                
							                // PAGING
// 							                var startIndex = options.pageIndex * options.pageSize;
// 							                var endIndex = startIndex + options.pageSize;
// 							                var end = (endIndex > count) ? count : endIndex;
// 							                var pages = Math.ceil(count / options.pageSize);
// 							                var page = options.pageIndex + 1;
// 							                var start = startIndex + 1;
							                
// 							                data = data.slice(startIndex, endIndex);
							                
// 							                if (self._formatter) self._formatter(data);
							                
// 							                callback({ data: data, start: start, end: end, count: count, pages: pages, page: page });
											
				                          

											callback({ data: data, start: 0, end: 0, count: count, pages: 0, page: 0 });
							            		
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
			};
			
			$('#tblUserIssues').datagrid({ 
				
				dataSource: new myDataSource({

                    // Column definitions for Datagrid
                    columns: [{
                    		label: '#',
                            property: 'id',
                            sortable: true,
                            sortProperty: 'id'
                    },{
                    	 	label: 'Fecha',
                            property: 'date',
                            sortable: true,
                            sortProperty: 'date'
                    },{
	                	 	label: 'T�tulo',
	                        property: 'title',
	                        sortable: true,
	                        sortProperty: 'title'
                    },{
	                	 	label: 'Direcci�n',
	                        property: 'address',
	                        sortable: true,
	                        sortProperty: 'address'
                	},{
	                	 	label: 'Barrio',
	                        property: 'neighborhood',
	                        sortable: true,
	                        sortProperty: 'neighborhood'
                	},{
	                	 	label: 'Ciudad',
	                        property: 'city',
	                        sortable: true,
	                        sortProperty: 'city'
                	},{
	                	 	label: 'Provincia',
	                        property: 'province',
	                        sortable: true,
	                        sortProperty: 'province'
                	},{
	                	 	label: 'Usuario',
	                        property: 'username',
	                        sortable: true
                     
                	},{
	                	 	label: 'Estado',
	                        property: 'status',
	                        sortable: true,
	                        sortProperty: 'status'
                	}]

                   
            })
			});
			
			
			
			
		
// 		$('#tblUserIssues').dataTable({
// 				"bProcessing": true,
// 				"bServerSide": true,
// 				"bSortable": true,
// 				"aaSorting": [[ 7, "desc" ]],
// 				"sPaginationType": "bootstrap",
// 				"aoColumns" : [	 
// 				               	 { "sTitle" : "#", "mData" : "id"     },
// 				            	 { "sTitle" : "Fecha" , "mData" : "date",  
// 				            		 "fnRender": function ( data ) {
// 				                         var date = new Date(data.aData["date"]);
// 				                         date = date.getDate()+"/"+ (date.getMonth() + 1) +"/"+date.getFullYear();
// 				                         return "<div class= date>"+date+"<div>";
// 				                         }
// 				               	 },
// 				             	 { "sTitle" : "T�tulo" , "mData" : "title" },
// 				                 { "sTitle" : "Direcci�n" , "mData" : "address" },
// 				               	 { "sTitle" : "Barrio" , "mData" : "neighborhood" },
// 				               	 { "sTitle" : "Ciudad" , "mData" : "city" },
// 				               	 { "sTitle" : "Provincia" , "mData" : "province" },
// 				               	 { "sTitle" : "Usuario", "mData" : "user.username" },
// 				               	 { "sTitle" : "Estado" , "mData" : "status"}
				            	
// 			                  ],		  		
// 				"sAjaxSource": "http://localhost:8080/fixeala/users/" + '${profileUser}' + "/loadUserIssues.html",
// 				"fnServerData": function ( sSource, aoData, fnCallback ) {
// 			            $.ajax( {
// 			                "dataType": 'json',
// 			                "type": "GET",
// 			                "url": sSource,
// 			                "data": aoData,
// 			                "success": fnCallback
// 			            } );
// 			        }	  
// 			});
		
		});
	
	</script>

	    
	    
	 	<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	 	<!--------------------------- AUTHENTICATED USER ------------------------------------------------------------------------>
	 	
	    <sec:authorize access="isAuthenticated()">
	    
		    <div class="row">
	    	   	<div class="span4 pull-left" style="padding:10px;text-align:left;margin:0; border:0px solid #000">
	    	   		<c:if test="${ loggedMatchesProfile }">
	    	   			Bienvenid@, <b>${current_nombre} ${current_apellido}</b>
					    <br>
	    	   			<sec:authorize access="hasRole('ROLE_ADMIN')">
					  		<small>(Administrador)</small>
					  	</sec:authorize>
					  	<sec:authorize access="hasRole('ROLE_MANAGER')">
					  		<small>(Moderador)</small>
					  	</sec:authorize>
	    	   		</c:if>
					  
				</div>
				<div class="span4 pull-right" style="text-align:right;border:0px solid #000;">
				  <h3>${current_area}</h3>
				  <br>
				  <small>${current_ciudad}, ${current_provincia}</small>
				</div> 
			</div>
		
			<br>
	    
			<div class="container-fluid">
			  <div class="row-fluid">
			  
			    <!--Sidebar content-->
			    <div class="span2">
			      	<div class="span2" style="border-left:1px solid #ccc; margin-left:0;">
			              <ul id="dahsboard-nav" class="nav nav-list" style="width:170px;">
			              		<c:if test="${ loggedMatchesProfile }">
			              			<!-- MENU ADMIN -->
					              	<sec:authorize access="hasRole('ROLE_ADMIN')">
					              		<li class="nav-header">DASHBOARD</li>
						                <li class="active"><a href="#">Inicio</a></li>
						                <li><a href="#notifications" data-toggle="tab">Notificaciones</a></li>
						                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
						                <li><a href="#map" data-toggle="tab">Mapa</a></li>
						                <li><a href="#comments" data-toggle="tab">Comentarios</a></li>
						                <li><a href="#users" data-toggle="tab">Usuarios</a></li>
					              	</sec:authorize>
					              	
					              	<!-- MENU MANAGER -->
					              	<sec:authorize access="hasRole('ROLE_MANAGER')">
					              		<li class="nav-header">DASHBOARD</li>
						                <li class="active"><a href="#">Inicio</a></li>
						                <li><a href="#notifications" data-toggle="tab">Notificaciones</a></li>
						                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
						                <li><a href="#map" data-toggle="tab">Mapa</a></li>
						                <li><a href="#comments" data-toggle="tab">Comentarios</a></li>
					              	</sec:authorize>
					              	
					              	<!-- MENU USER -->
					              	<sec:authorize access="hasRole('ROLE_USER')">
						              		<li class="nav-header">DASHBOARD</li>
							                <li class="active"><a href="#">Inicio</a></li>
							                <li><a href="#notifications" data-toggle="tab">Notificaciones</a></li>
							                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
							                <li><a href="#comments" data-toggle="tab">Comentarios</a></li>
							                <li class="divider"></li>
							                <li class="nav-header">CUENTA</li>
							                <li><a href="#">Perfil</a></li>
							                <li><a href="#">Seguridad</a></li>
							                <li><a href="#">Desactivacion</a></li>
					              	</sec:authorize>
			              		</c:if>
			              		
			              		<c:if test="${ !loggedMatchesProfile }">
				              	 	<!-- MENU ADMIN / MAANGER -->
					              	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
					              		<li class="nav-header">DASHBOARD</li>
						                <li class="active"><a href="#">Inicio</a></li>
						                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
					              	</sec:authorize>
					              	
					              	<!-- MENU USER -->
					              	<sec:authorize access="hasRole('ROLE_USER')">
						              	<c:if test="${ !loggedMatchesProfile }">
						              		<li class="nav-header">DASHBOARD</li>
							                <li class="active"><a href="#">Inicio</a></li>
							                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
						              	</c:if>		
					              	</sec:authorize>
				              	</c:if>
			              </ul>
		            </div>
			    </div>
			    
			    <!--Body content-->
			    <div class="span10">
			    
			    <!-- TAB CONTENT -->
			    <div class="tab-content">
					
					
					<!-- TAB RECLAMOS -->
					<div class="tab-pane fade in active" id="issues">
					    	<div class="page-header">
					    	<h3>Reclamos</h3>
					    	</div>
					    	
					    	<ul class="nav nav-tabs">
						    	<li class="active"><a href="#issuesAsignados" data-toggle="tab">Asignados</a></li>
							</ul>
							
							
							<div class="tab-content">
								<div class="tab-pane fade in active" id="issuesAsignados">
								   	<table id="tblUserIssues" cellpadding="0" cellspacing="0" border="0"  data-toggle="context" data-target="#contextmenu-issue"
    								class="table table-striped table-bordered table-hover datagrid" data-provides="rowlink">
									<thead>
									</thead>
									<tbody>			
									</tbody>	
								</table>
								</div>
													
							</div>
							
							<!-- Context Menu -->
					    	<div id="contextmenu-issue" class="dropdown clearfix">
							    <ul id="ctxMenu" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
							      <li><a tabindex="-1" href="javascript:redirect();"><i class="icon-paper-clip"></i>&nbsp;&nbsp;Ver detalles</a></li>
							      <li><a tabindex="-1" href="#"><i class="icon-globe"></i>&nbsp;&nbsp;Ver en mapa</a></li>
							      <li class="divider"></li>
							      <li><a tabindex="-1" href="#assignUserModal" data-toggle="modal"><i class="icon-user"></i>&nbsp;&nbsp;Asignar a usuario</a></li>
							      <li class="divider" id="actionsDivider"></li>
						      	  <li><a tabindex="-1" href="#" onclick="updateStatus('ADMITIDO');"><i class="icon-thumbs-up-alt"></i>&nbsp;&nbsp;Admitir</a></li>
						      	  <li><a tabindex="-1" href="#" onclick="updateStatus('RESUELTO');"><i class="icon-ok"></i>&nbsp;&nbsp;Resolver</a></li>
						      	  <li><a tabindex="-1" href="#" onclick="updateStatus('CERRADO');"><i class="icon-lock"></i>&nbsp;&nbsp;Cerrar</a></li>
						      	  <li><a tabindex="-1" href="#" onclick="updateStatus('REABIERTO');"><i class="icon-folder-open-alt"></i>&nbsp;&nbsp;Reabrir</a></li>  
							    </ul>
	  						</div>
	  											    	
					    	<script>
							    	$(function() {
							    		
							    		  var $contextMenu = $("#contextmenu-issue");
							    		  
							    		  $("body").on("contextmenu", "#tblUserIssues tr", function(e) {
							    		  	$contextMenu.css({
								    		      display: "block",
								    		      left: e.pageX,
								    		      top: e.pageY
							    		    });
							    		    return false;
							    		  });
							    		  
							    		  $contextMenu.on("click", "a", function() {
							    		     $contextMenu.hide();
							    		  });
							    		  
							    		  $("body").on("click", function() {
								    		     $contextMenu.hide();
								    	  });
							    		  
							    	});
					    	</script>
					    	
					    </div>
					    <!-- fin TAB RECLAMOS -->
					    
					    
					    <!-- TAB MAPA -->
					    <div class="tab-pane fade" id="map">
					    	<div class="page-header">
					    		<h3>Mapa</h3>
					    	</div>
			         	</div>
			         	<!-- fin TAB MAPA -->
			         	
			         	
			         	<!-- TAB COMENTARIOS -->   
			         	<div class="tab-pane fade" id="comments">
			         		<div class="page-header">
					    		<h3>Comentarios</h3>
					    	</div>
					    	
					    	<ul class="nav nav-tabs">
						    	<li class="active"><a href="#commentsPublicados" data-toggle="tab">Publicados (1)</a></li>
							  	<li><a href="#commentsRecibidos" data-toggle="tab">Recibidos (1)</a></li>
							</ul>
							
							<div class="tab-content">
								<div class="tab-pane fade in active" id="commentsPublicados">
									<table class="table table-striped table-hover">
								    	<thead>
								    		<tr>
									   			<th>Fecha</th>
									   			<th>Descripción</th>
									   			<th>Nro. Reclamo</th>
								   			</tr>
								   		<tbody>
								   			<tr>
								   				<td>13/03/13 15:44</td>
								   				<td>El reclamo ha sido admitido. Se le ha asignado el Nº de trámite 98993/2.</td>
								   				<td><a href="#">2345</a></td>
								   			</tr>
								   		</tbody>
								   	</table>
								   	<div class="pagination pagination-right">
									  <ul>
									    <li><a href="#">&laquo; Anterior</a></li>
									    <li><a href="#">1</a></li>
									    <li><a href="#">2</a></li>
									    <li><a href="#">3</a></li>
									    <li><a href="#">4</a></li>
									    <li><a href="#">5</a></li>
									    <li><a href="#">Siguiente &raquo;</a></li>
									  </ul>
									</div>
								 </div>
								 <div class="tab-pane fade" id="commentsRecibidos">
									<table class="table table-striped table-hover">
								    	<thead>
								    		<tr>
									   			<th>Fecha</th>
									   			<th>Descripción</th>
									   			<th>Nro. Reclamo</th>
									   			<th>Usuario</th>
								   			</tr>
								   		<tbody>
								   			<tr>
								   				<td>14/05/13 09:33</td>
								   				<td>La vereda todavía no fue reparada.</td>
								   				<td><a href="#">7856</a></td>
								   				<td><a href="#">pedro77</a></td>
								   			</tr>
								   		</tbody>
								   	</table>
								 </div>
							</div>
					    </div>
					    <!-- fin TAB COMENTARIOS -->
					    	
					    	
					    <!-- TAB USUARIOS -->
					    <div class="tab-pane fade" id="users"> 	
			         		<div class="page-header">
					    		<h3>Usuarios</h3>
					    	</div>
					    	
					    	<table class="table table-striped table-hover user-table">
						    	<thead>
						    		<tr>
							    		<th width="200">Nombre de Usuario</th>
							    		<th>Rol</th>
							    		<th>Cargo</th>
							    		<th width="200">Área</th>
							    		<th>Sub-Área</th>
							    		<th>Estado</th>
						    		</tr>
						    	</thead>
						    	<tbody>
						    		<tr>
							    		<td>perezf</td>
							    		<td>EDITOR</td>
							    		<td>Responsable de Área</td>
							    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
							    		<td>-</td>
							    		<td><span class="label label-success">Activo</span></td>
						    		</tr>
						    		<tr>
							    		<td>camposm</td>
							    		<td>EDITOR</td>
							    		<td>Responsable de Sub-Área</td>
							    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
							    		<td>D. G. Limpieza (DGLIM)</td>
							    		<td><span class="label label-success">Activo</span></td>
						    		</tr>
						    		<tr>
							    		<td>muragliag</td>
							    		<td>EDITOR</td>
							    		<td>Responsable de Sub-Área</td>
							    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
							    		<td>D. G. Alumbrado (DGALUM)</td>
							    		<td><span class="label label-error">Inactivo</span></td>
						    		</tr>
						    	</tbody>
					    	</table>
					    	
					    	<br><br>
					    	<center>
						    	<button href="#userModal" type="button" data-toggle="modal" 
						    	class="btn btn-medium btn-warning" >
						    		<i class="icon-plus"></i>&nbsp;&nbsp;Nuevo usuario
						    	</button>
					    	</center>
					    	
					    	<!-- Context Menu -->
					    	<div id="contextmenu-user" class="dropdown clearfix">
							    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
							        <li><a tabindex="-1" href="#"><i class="icon-user"></i>&nbsp;&nbsp;Detalles</a></li>
											      <li><a tabindex="-1" href="#"><i class="icon-pencil"></i>&nbsp;&nbsp;Editar</a></li>
											      <li><a tabindex="-1" href="#"><i class="icon-trash"></i>&nbsp;&nbsp;Borrar</a></li>
											      <li class="divider"></li>
											      <li><a tabindex="-1" href="#"><i class="icon-lock"></i>&nbsp;&nbsp;Deshabilitar</a></li>
								      			  <li class="disabled"><a tabindex="-1" href="#"><i class="icon-unlock"></i>&nbsp;&nbsp;Habilitar</a></li>
							    </ul>
	  						</div>
					    	
					    	<script>
						    	$(function() {
						    		  
						    		  var $contextMenu = $("#contextmenu-user");
						    		  
						    		  $("body").on("contextmenu", "table.user-table tr", function(e) {
						    		    $contextMenu.css({
						    		      display: "block",
						    		      left: e.pageX,
						    		      top: e.pageY
						    		    });
						    		    
						    		    $("div#issueAssignment").text(
						    		    		
						    		    		'<h4>Reclamo #'+rowId+'</h4>' +
						    		    		'<p>'+rowTitle+'</p>'
										);
						    		    return false;
						    		  });
						    		  
						    		  $contextMenu.on("click", "a", function() {
						    		     $contextMenu.hide();
						    		  });
						    		  
						    		  $("body").on("click", function() {
							    		     $contextMenu.hide();
							    		  });
						    		  
						    		});
					    	</script>
			         	</div>
			         	<!-- tab END USUARIOS -->
			         		
			         				         		
			         		
		         		<!-- NOTIFICACIONES -->
		         		<div class="tab-pane fade" id="notifications"> 	
			         		<div class="page-header">
					    		<h3>Notificaciones</h3>
					    	</div>
					    	
					    	<table class="table table-hover offset1" style="width:700px;">
						    	<tr>
						    		<td style="border-top:none;"><i class="icon-map-marker"></i></td>
							    	<td style="border-top:none;width:500px">Nuevo reclamo <a href="#">#4455</a> pubicado por <a href="#">fulanito_11</a></td>
							    	<td style="border-top:none;"><i class="icon-time icon-grey"></i> hace 11 minutos</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-comments-alt"></i></td>
							    	<td>Nuevo comentario pubicado por <a href="#">fulanito_11</a></td>
							    	<td><i class="icon-time icon-grey"></i> hace 2 horas</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-ok"></i></td>
							    	<td>El reclamo <a href="#">#78657</a>fue <span class="label label-success">resuelto</span> por <a href="#">fulanito_11</a></td>
							    	<td><i class="icon-time icon-grey"></i> ayer</td>
							    <tr>
							    <tr>
						    		<td><i class="icon-map-marker"></i></td>
							    	<td>Nuevo reclamo <a href="#">#4344</a> publicado por <a href="#">GustavoF</a></td>
							    	<td><i class="icon-time icon-grey"></i> 16/10/2013</td>
							    <tr>
					    	</table>
				    	</div>
				    	<!-- end TAB NOTIFICACIONES -->
					   			         		
		         	</div>	
		         	<!-- fin tab content -->
				 
			    </div>
			  </div>
			</div><!-- container fluid -->
			
			
			
			<!-- Modal ASSIGN USER -->
			<div id="assignUserModal"class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-header">
			    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
			    <h3 id="myModalLabel">Asignaci�n de usuario</h3>
			  </div>
			  <div class="modal-body">
			    <form class="form-horizontal">
				  <fieldset>
					  <div class="control-group" id="issueAssignment">
						
					     </div>
				  	
				     <div class="control-group">
					    <label>Seleccione usuario:</label>
					    <div>
						    <input type="hidden" id="combo-users" style="width:300px" class="input-xlarge" />
					    </div>
				     </div>
				  </fieldset>
				</form>
			  </div>
			  <div class="modal-footer" style="margin-bottom:0">
			    <button class="btn btn-primary" onclick="assignUser();"><i class="icon-ok"></i>&nbsp;&nbsp;Asignar</button>
			    <button class="btn" data-dismiss="modal" aria-hidden="true"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
			  </div>
			</div>
			
			
			
			<!-- Modal NEW USER -->
			<div id="userModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-header">
			    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
			    <h3 id="myModalLabel">Registro de nuevo usuario</h3>
			  </div>
			  <div class="modal-body">
			    <form class="form-horizontal" onload="loadOfficials();">
				  <fieldset>
				  	 <div class="control-group">
					    <label class="control-label" for="inputPassword">Apellido y Nombre(s)</label>
					    <div class="controls">
					      <input type="text" id="inputPassword" placeholder="Nombre y Apellido">
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label" for="inputPassword">Usuario</label>
					    <div class="controls">
					      <input type="text" id="inputPassword" placeholder="Nombre de usuario">
					    </div>
				     </div>
					  <div class="control-group">
					  	<label class="control-label" for="inputEmail">Email</label>
					    <div class="controls">
					      <input type="text" id="inputEmail" placeholder="Email">
					    </div>
					  </div>
				      <div class="control-group">
					    <label class="control-label" for="inputPassword">Contrase�a</label>
					    <div class="controls">
					      <input type="password" id="inputPassword" placeholder="Contrase�a">
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label" for="inputPassword">Confirme contrase�a</label>
					    <div class="controls">
					      <input type="password" id="inputPassword" placeholder="Confirme contrase�a">
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label" for="inputPassword">Cargo</label>
					    <div class="controls">
					      <select class="span7">
					    	<option>Responsable de Area</option>
					    	<option>Asistente</option>
				    	  </select>
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label" for="inputPassword">Sub-Area</label>
					    <div class="controls">
						    <select class="span7">
						    	<option>S. S. de Administracion (SSADM)</option>
						    	<option>S. S. de Higiene Urbana (SSHU)</option>
						    	<option>D. G. Cementerios (CGCEM)</option>
						    	<option>D. G. Espacios Verdes (DGEV)</option>
						    	<option>D. G. Reciclado (DGREC)</option>
					    	</select>
					    </div>
				     </div>
				     <div class="control-group">
					    <label class="control-label" for="inputPassword">Rol</label>
					    <div class="controls">
					      <select class="span7">
					    	<option>Administrador</option>
					    	<option selected="selected">Editor</option>
					    	<option>Usuario</option>
				    	  </select>
					    </div>
				     </div>
				   <div class="control-group">
				       	<label class="control-label" for="inputPassword">Estado</label>
				      	<div class="controls">
					      	<label class="radio">
					        	<input type="radio" checked> Activo
					        </label>
					        <label class="radio" >
					        	<input type="radio"> Bloqueado
					    	</label>
				      </div>
				    </div>
				   
				  </fieldset>
				</form>
			  </div>
			  <div class="modal-footer" style="margin-bottom:0">
			    <button class="btn btn-primary"><i class="icon-ok"></i>&nbsp;&nbsp;Guardar</button>
			    <button class="btn" data-dismiss="modal" aria-hidden="true"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
			  </div>
			</div>
			
			
			
			
			
			
			
			
			
			
	    </sec:authorize>
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	 	<!--------------------------- ANONYMOUS USER ---------------------------------------------------------------------------->
	 	
	    <sec:authorize access="isAnonymous()">
	    
	    	<div class="row">
<!--     			<div class="span4 pull-left" style="padding:10px;text-align:left;margin:0; border:0px solid #000"> -->
	    			
<!-- 		  		</div> -->
		  		<div class="span4 pull-right" style="text-align:right;border:0px solid #000;">
				  	<!-- USERprofile -->
	    			<c:if test="${ profileRole eq 'ROLE_USER' }">
			  			<h3>${profileUser}</h3>
					  	<br>
					  	<small>${barrio}</small>
			  		</c:if>
			  		
			  		<!-- AREA profile -->
			  		<c:if test="${ profileRole eq 'ROLE_AREA' }">
			  			<h3>${current_area}</h3>
					  	<br>
					  	<small>${current_ciudad}, ${current_provincia}</small>
			  		</c:if>
				</div> 
			</div>
		
			<br>
	    
		<div class="container-fluid">
		  <div class="row-fluid">
		  
		     	<!--Sidebar content-->
			    <div class="span2">
			      	<div class="span2" style="border-left:1px solid #ccc; margin-left:0;">
			              <ul id="dahsboard-nav" class="nav nav-list" style="width:170px;">
				              		<li class="nav-header">DASHBOARD</li>
					                <li class="active"><a href="#">Inicio</a></li>
					                <li><a href="#issues" data-toggle="tab">Reclamos</a></li>
			              </ul>
		            </div>
			    </div>
		  
		    
		    <!--Body content-->
		    <div class="span10">
		    
		    <!-- TAB CONTENT -->
		    <div class="tab-content">
				
				
				<!-- TAB RECLAMOS -->
				<div class="tab-pane fade in active" id="issues">
				    	<div class="page-header">
				    	<h3>Reclamos ()</h3>
				    	</div>
				    	
				    	<ul class="nav nav-tabs">
					    	<li class="active"><a href="#issuesNuevos" data-toggle="tab">Todos</a></li>
<!-- 						  	<li><a href="#issuesAsignados" data-toggle="tab">Asignados (1)</a></li> -->
<!-- 						  	<li><a href="#issuesTodos" data-toggle="tab">Todos (4)</a></li> -->
						</ul>
						
						<div class="tab-content">
							<div class="tab-pane fade in active" id="issuesNuevos">
							   	<table id="tblUserIssues" cellpadding="0" cellspacing="0" border="0" 
    								class="table table-striped table-bordered table-hover datatable">
									<thead>
										<tr>				
											<th width="50">id</th>
											<th width="100">date</th>
											<th width="250">title</th>			
											<th width="200">address</th>
											<th width="150">neighborhood</th>
											<th width="150">city</th>
											<th width="150">province</th>
											<th>status</th>		
										</tr>
									</thead>
									<tbody>			
									</tbody>	
								</table>
							</div>
							
							<div class="tab-pane fade" id="issuesAsignados">
								<table class="table table-striped table-hover">
							    	<thead>
							    		<tr>
								   			<th>#</th>
								   			<th>Fecha</th>
								   			<th>Estado</th>
								   			<th>Título</th>
								   			<th>Dirección</th>
								   			<th>Barrio</th>
								   			<th>Usuario</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>2345</td>
							   				<td>19/06/13 11:09</td>
							   				<td>ABIERTO</td>
							   				<td><a href="#">Arreglo defectuoso de alcantarilla</a></td>
							   				<td>Av. de Mayo 434</td>
							   				<td>Monsetrrat</td>
							   				<td><a href="#">FerreroP</a></td>
							   			</tr>
							   		</tbody>
							   	</table>
							</div>
						
							<div class="tab-pane fade" id="issuesTodos">
								Todos los reclamos.
							</div>
						</div>
						
						<!-- Context Menu -->
				    	<div id="contextmenu-issue" class="dropdown clearfix">
						    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
						      <li><a tabindex="-1" href="#"><i class="icon-paper-clip"></i>&nbsp;&nbsp;Ver detalles</a></li>
						      <li><a tabindex="-1" href="#"><i class="icon-globe"></i>&nbsp;&nbsp;Ver en mapa</a></li>
						      <li class="divider"></li>
						      <li><a tabindex="-1" href="#"><i class="icon-user"></i>&nbsp;&nbsp;Asignar a usuario</a></li>
						      <li class="divider"></li>
						      <li><a tabindex="-1" href="#"><i class="icon-thumbs-up-alt"></i>&nbsp;&nbsp;Admitir</a></li>
						      <li><a tabindex="-1" href="#"><i class="icon-ok"></i>&nbsp;&nbsp;Resolver</a></li>
						      <li><a tabindex="-1" href="#"><i class="icon-lock"></i>&nbsp;&nbsp;Cerrar</a></li>
						      <li><a tabindex="-1" href="#"><i class="icon-folder-open-alt"></i>&nbsp;&nbsp;Reabrir</a></li>
						    </ul>
  						</div>
				    	
				    	<script>
					    	$(function() {
					    		  
					    		  var $contextMenu = $("#contextmenu-issue");
					    		  
					    		  $("body").on("contextmenu", "table.issueTable tr", function(e) {
					    		    $contextMenu.css({
					    		      display: "block",
					    		      left: e.pageX,
					    		      top: e.pageY
					    		    });
					    		    return false;
					    		  });
					    		  
					    		  $contextMenu.on("click", "a", function() {
					    		     $contextMenu.hide();
					    		  });
					    		  
					    		  $("body").on("click", function() {
						    		     $contextMenu.hide();
						    		  });
					    		  
					    		});
				    	</script>
				    	
				    </div>
				    <!-- fin TAB RECLAMOS -->
				    
				    
				    <!-- TAB MAPA -->
				    <div class="tab-pane fade" id="map">
				    	<div class="page-header">
				    		<h3>Mapa</h3>
				    	</div>
		         	</div>
		         	<!-- fin TAB MAPA -->
		         	
		         	
		         	<!-- TAB COMENTARIOS -->   
		         	<div class="tab-pane fade" id="comments">
		         		<div class="page-header">
				    		<h3>Comentarios</h3>
				    	</div>
				    	
				    	<ul class="nav nav-tabs">
					    	<li class="active"><a href="#commentsPublicados" data-toggle="tab">Publicados (1)</a></li>
						  	<li><a href="#commentsRecibidos" data-toggle="tab">Recibidos (1)</a></li>
						</ul>
						
						<div class="tab-content">
							<div class="tab-pane fade in active" id="commentsPublicados">
								<table class="table table-striped table-hover">
							    	<thead>
							    		<tr>
								   			<th>Fecha</th>
								   			<th>Descripción</th>
								   			<th>Nro. Reclamo</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>13/03/13 15:44</td>
							   				<td>El reclamo ha sido admitido. Se le ha asignado el Nº de trámite 98993/2.</td>
							   				<td><a href="#">2345</a></td>
							   			</tr>
							   		</tbody>
							   	</table>
							   	<div class="pagination pagination-right">
								  <ul>
								    <li><a href="#">&laquo; Anterior</a></li>
								    <li><a href="#">1</a></li>
								    <li><a href="#">2</a></li>
								    <li><a href="#">3</a></li>
								    <li><a href="#">4</a></li>
								    <li><a href="#">5</a></li>
								    <li><a href="#">Siguiente &raquo;</a></li>
								  </ul>
								</div>
							 </div>
							 <div class="tab-pane fade" id="commentsRecibidos">
								<table class="table table-striped table-hover">
							    	<thead>
							    		<tr>
								   			<th>Fecha</th>
								   			<th>Descripción</th>
								   			<th>Nro. Reclamo</th>
								   			<th>Usuario</th>
							   			</tr>
							   		<tbody>
							   			<tr>
							   				<td>14/05/13 09:33</td>
							   				<td>La vereda todavía no fue reparada.</td>
							   				<td><a href="#">7856</a></td>
							   				<td><a href="#">pedro77</a></td>
							   			</tr>
							   		</tbody>
							   	</table>
							 </div>
						</div>
				    </div>
				    <!-- fin TAB COMENTARIOS -->
				    	
				    	
				    <!-- TAB USUARIOS -->
				    <div class="tab-pane fade" id="users"> 	
		         		<div class="page-header">
				    		<h3>Usuarios</h3>
				    	</div>
				    	
				    	
				    	<!-- Modal -->
						<div id="userModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						  <div class="modal-header">
						    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
						    <h3 id="myModalLabel">Registro de nuevo usuario</h3>
						  </div>
						  <div class="modal-body">
						    <form class="form-horizontal">
							  <fieldset>
							  	 <div class="control-group">
								    <label class="control-label" for="inputPassword">Apellido y Nombre(s)</label>
								    <div class="controls">
								      <input type="text" id="inputPassword" placeholder="Nombre y Apellido">
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Usuario</label>
								    <div class="controls">
								      <input type="text" id="inputPassword" placeholder="Nombre de usuario">
								    </div>
							     </div>
								  <div class="control-group">
								  	<label class="control-label" for="inputEmail">Email</label>
								    <div class="controls">
								      <input type="text" id="inputEmail" placeholder="Email">
								    </div>
								  </div>
							      <div class="control-group">
								    <label class="control-label" for="inputPassword">Contrase�a</label>
								    <div class="controls">
								      <input type="password" id="inputPassword" placeholder="Contrase�a">
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Confirme contrase�a</label>
								    <div class="controls">
								      <input type="password" id="inputPassword" placeholder="Confirme contrase�a">
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Cargo</label>
								    <div class="controls">
								      <select class="span7">
								    	<option>Responsable de Area</option>
								    	<option>Asistente</option>
							    	  </select>
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Sub-Area</label>
								    <div class="controls">
									    <select class="span7">
									    	<option>S. S. de Administracion (SSADM)</option>
									    	<option>S. S. de Higiene Urbana (SSHU)</option>
									    	<option>D. G. Cementerios (CGCEM)</option>
									    	<option>D. G. Espacios Verdes (DGEV)</option>
									    	<option>D. G. Reciclado (DGREC)</option>
								    	</select>
								    </div>
							     </div>
							     <div class="control-group">
								    <label class="control-label" for="inputPassword">Rol</label>
								    <div class="controls">
								      <select class="span7">
								    	<option>Administrador</option>
								    	<option selected="selected">Editor</option>
								    	<option>Usuario</option>
							    	  </select>
								    </div>
							     </div>
							   <div class="control-group">
							       	<label class="control-label" for="inputPassword">Estado</label>
							      	<div class="controls">
								      	<label class="radio">
								        	<input type="radio" checked> Activo
								        </label>
								        <label class="radio" >
								        	<input type="radio"> Bloqueado
								    	</label>
							      </div>
							    </div>
							   
							  </fieldset>
							</form>
						  </div>
						  <div class="modal-footer" style="margin-bottom:0">
						    <button class="btn btn-primary"><i class="icon-ok"></i>&nbsp;&nbsp;Guardar</button>
						    <button class="btn" data-dismiss="modal" aria-hidden="true"><i class="icon-remove"></i>&nbsp;&nbsp;Cancelar</button>
						  </div>
						</div>
				    	
				    	
				    	<table class="table table-striped table-hover user-table">
					    	<thead>
					    		<tr>
						    		<th width="200">Nombre de Usuario</th>
						    		<th>Rol</th>
						    		<th>Cargo</th>
						    		<th width="200">Área</th>
						    		<th>Sub-Área</th>
						    		<th>Estado</th>
					    		</tr>
					    	</thead>
					    	<tbody>
					    		<tr>
						    		<td>perezf</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>-</td>
						    		<td><span class="label label-success">Activo</span></td>
					    		</tr>
					    		<tr>
						    		<td>camposm</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de Sub-Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>D. G. Limpieza (DGLIM)</td>
						    		<td><span class="label label-success">Activo</span></td>
					    		</tr>
					    		<tr>
						    		<td>muragliag</td>
						    		<td>EDITOR</td>
						    		<td>Responsable de Sub-Área</td>
						    		<td>Ministerio de Ambiente y Espacio Público (MAYEPGC)</td>
						    		<td>D. G. Alumbrado (DGALUM)</td>
						    		<td><span class="label label-error">Inactivo</span></td>
					    		</tr>
					    	</tbody>
				    	</table>
				    	
				    	<br><br>
				    	<center>
					    	<button href="#userModal" type="button" data-toggle="modal" 
					    	class="btn btn-medium btn-warning" >
					    		<i class="icon-plus"></i>&nbsp;&nbsp;Nuevo usuario
					    	</button>
				    	</center>
				    	
				    	<!-- Context Menu -->
				    	<div id="contextmenu-user" class="dropdown clearfix">
						    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
						        <li><a tabindex="-1" href="#"><i class="icon-user"></i>&nbsp;&nbsp;Detalles</a></li>
										      <li><a tabindex="-1" href="#"><i class="icon-pencil"></i>&nbsp;&nbsp;Editar</a></li>
										      <li><a tabindex="-1" href="#"><i class="icon-trash"></i>&nbsp;&nbsp;Borrar</a></li>
										      <li class="divider"></li>
										      <li><a tabindex="-1" href="#"><i class="icon-lock"></i>&nbsp;&nbsp;Deshabilitar</a></li>
							      			  <li class="disabled"><a tabindex="-1" href="#"><i class="icon-unlock"></i>&nbsp;&nbsp;Habilitar</a></li>
						    </ul>
  						</div>
				    	
				    	<script>
					    	$(function() {
					    		  
					    		  var $contextMenu = $("#contextmenu-user");
					    		  
					    		  $("body").on("contextmenu", "table.user-table tr", function(e) {
					    		    $contextMenu.css({
					    		      display: "block",
					    		      left: e.pageX,
					    		      top: e.pageY
					    		    });
					    		    return false;
					    		  });
					    		  
					    		  $contextMenu.on("click", "a", function() {
					    		     $contextMenu.hide();
					    		  });
					    		  
					    		  $("body").on("click", function() {
						    		     $contextMenu.hide();
						    		  });
					    		  
					    		});
				    	</script>
		         	</div>
		         	<!-- tab END USUARIOS -->
		         		
		         		
		         		
		         		<!-- ESTADI�STICAS -->
		         		
		         		
	         		<!-- NOTIFICACIONES -->
	         		<div class="tab-pane fade" id="notifications"> 	
		         		<div class="page-header">
				    		<h3>Notificaciones</h3>
				    	</div>
				    	
				    	<table class="table table-hover offset1" style="width:700px;">
					    	<tr>
					    		<td style="border-top:none;"><i class="icon-map-marker"></i></td>
						    	<td style="border-top:none;width:500px">Nuevo reclamo <a href="#">#4455</a> pubicado por <a href="#">fulanito_11</a></td>
						    	<td style="border-top:none;"><i class="icon-time icon-grey"></i> hace 11 minutos</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-comments-alt"></i></td>
						    	<td>Nuevo comentario pubicado por <a href="#">fulanito_11</a></td>
						    	<td><i class="icon-time icon-grey"></i> hace 2 horas</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-ok"></i></td>
						    	<td>El reclamo <a href="#">#78657</a>fue <span class="label label-success">resuelto</span> por <a href="#">fulanito_11</a></td>
						    	<td><i class="icon-time icon-grey"></i> ayer</td>
						    <tr>
						    <tr>
					    		<td><i class="icon-map-marker"></i></td>
						    	<td>Nuevo reclamo <a href="#">#4344</a> publicado por <a href="#">GustavoF</a></td>
						    	<td><i class="icon-time icon-grey"></i> 16/10/2013</td>
						    <tr>
				    	</table>
			    	</div>
				    	<!-- end TAB NOTIFICACIONES -->
					    	
			         		
			         		<!-- ACTIVIDAD -->
			         
							
							<!-- PERFIL -->
							
							
							<!-- CONTRASEÑA -->
							
							
							<!-- DESACTIVACION -->      		
			         		
		         	</div>	
		         	<!-- fin tab content -->
				 
			    </div>
			  </div>
			</div><!-- container fluid -->
	    
	    
	    </sec:authorize>
	    
	    
	    

	</div>
	<!-- /content -->  
	   
	  
<!-- 		<div id="dashboardTabContent" class="tab-content"> -->

<!-- 			<div class="tab-pane fade in active" id="profile"> -->
			
<!-- 			<div id="profileBox" class="span6 well">	 -->

<!-- 				Profile... -->
		
<!-- 			</div> -->

<!-- 			</div> -->
			
<!-- 			<div class="tab-pane fade in" id="account"> -->
			
<!-- 				<div id="accountBox" class="span6 well"> -->
										
<!--    						<div class="row" > -->
    					
<!--    								<div class="span6">    								 -->
<!--    									<form class="form-horizontal" id="uploadForm"> -->
<!--    										<fieldset>   									  									 -->
<!-- 		   									<legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Edición de cuenta</legend> -->
<!-- 		   									<div class="thumbnail"> -->
<%-- 												<img id="profilePic" src="${pageContext.request.contextPath}/resources/images/01-mario.jpg" alt=""  > --%>
<!-- 											</div> -->
		   								
<!-- 			   								<span class="btn fileinput-button"> -->
<!-- 					                   			<i class="icon-plus icon-white"></i>&nbsp;&nbsp; -->
<!-- 					                   			<span>Seleccionar archivo</span> -->
<!-- 			               					</span> -->
<!-- 										</fieldset> -->
								
<!-- 								  	 	<fieldset>								  	 					 -->
<!-- 											 <div class="input-prepend"> -->
<!-- 											 	<span class="add-on"><i class="icon-envelope"></i></span> -->
<%-- 											 	<input type="text" id="email" value="${email}" placeholder="Dirección de email" class="input-xlarge" >		 --%>
<!-- 											 	<label class="control-label" style="width:auto;float:right; text-align:left;margin-left:10px;line-height:30px;">(no será publicado)</label>												  -->
<!-- 											 </div>											 	 -->
<!-- 											 <div class="input-prepend"> -->
<!-- 											 	<span class="add-on"><i class="icon-home"></i></span> -->
<%-- 											 	<input type="text" id="barrio" value="${barrio}" placeholder="Barrio / Localidad" class="input-xlarge" > --%>
<!-- 											 	<label class="control-label" style="width:auto;float:right; text-align:left;margin-left:10px;line-height:30px;">(opcional)</label>			 -->
<!-- 											 </div>		 -->
<!-- 										 </fieldset> -->
<!-- 										 <fieldset>										 	 					  -->
<!-- 											 <button id="btnUpdateAccount" class="btn btn-primary">Actualizar datos</button>&nbsp;&nbsp; -->
<!-- 											 <button type="reset" class="btn">Cancelar</button> -->
<!-- 										</fieldset>								 -->
<!-- 									</form>									 -->
<!-- 								</div> -->
<!-- 								<div class="span6"> 			 -->
<!-- 									<form class="form-horizontal"> -->
<!-- 										<fieldset>	 -->
<!-- 										     <legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Cambio de contraseña</legend>	 		 -->
<!-- 											 <div class="input-prepend"> -->
<!-- 												 <span class="add-on"><i class="icon-lock"></i></span> -->
<!-- 												 <input type="password" id="currentPassword" placeholder="Contraseña actual" class="input-xlarge">		  			 -->
<!-- 											 </div> -->
											 
<!-- 											 <div class="input-prepend"> -->
<!-- 												 <span class="add-on"><i class="icon-lock"></i></span> -->
<!-- 												 <input type="password" id="newPassword" placeholder="Nueva contraseña" class="input-xlarge">		  			 -->
<!-- 											 </div> -->
											 
<!-- 											  <div class="input-prepend"> -->
<!-- 												 <span class="add-on"><i class="icon-lock"></i></span> -->
<!-- 												 <input type="password" id="newPasswordConfirmation" placeholder="Confirme nueva contraseña" class="input-xlarge">		  			 -->
<!-- 											 </div>								  								  			 -->
<!-- 							  			</fieldset> -->
<!-- 							  			<fieldset>										 	 					  -->
<!-- 											 <button id="btnUpdateAccount" class="btn btn-primary">Actualizar contraseña</button>&nbsp;&nbsp; -->
<!-- 											 <button type="reset" class="btn">Cancelar</button> -->
<!-- 										</fieldset> -->
<!-- 									</form> -->
<!-- 								</div> -->
							
<!-- 								<div class="span6"> 			 -->
<!-- 									<form id="closeAccountForm" class="form-horizontal"> -->
<!-- 										<fieldset>	 -->
<!-- 										     <legend><i class="icon-angle-right"></i>&nbsp;&nbsp;Desactivación de cuenta</legend>	 		 -->
<!-- 											 <div class="input-prepend"> -->
<!-- 												 <span class="add-on"><i class="icon-lock"></i></span> -->
<!-- 												 <input type="password" id="currentPassword" placeholder="Contraseña actual" class="input-xlarge">		  			 -->
<!-- 											 </div>																				 -->
<!-- 							  			</fieldset> -->
<!-- 							  			<fieldset>										 				  -->
<!-- 											 <button id="btnCloseAccount" class="btn btn-primary">Cerrar cuenta</button>&nbsp;&nbsp; -->
<!-- 											 <button type="reset" class="btn">Cancelar</button> -->
<!-- 										</fieldset> -->
<!-- 									</form> -->
<!-- 								</div>							 -->
<!-- 						</div> -->
			
<!-- 			 </div> -->
				
<!-- 			</div> -->
<!-- 		</div> -->
		<!-- /dashboardTabContent -->
		    
	