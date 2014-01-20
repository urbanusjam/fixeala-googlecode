/* Set the defaults for DataTables initialisation */
$.extend( true, $.fn.dataTable.defaults, {
	"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	"sPaginationType": "bootstrap",
	"oLanguage": {
   	    "sLengthMenu": "Mostrar _MENU_ resultados",
   	    "sZeroRecords": "No hay resultados para mostrar",
   	    "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ resultados",
   	    "sInfoEmpty": "Mostrando 0 a 0 de 0 resultados",
   	    "sInfoFiltered": "(filtrado de un total de _MAX_ resultados)",
   	    "sSearch": "Filtrar:",
   	    "sProcessing": "Procesando...",
   	    "sZeroRecords": "No se encontraron coincidencias",
   				"sEmptyTable": "No hay datos disponibles en la tabla",
   				"sLoadingRecords": "Cargando...",
   		"oPaginate": {
   			"sPrevious": "Anterior",
   			"sNext": "Siguiente"
   		},
   		"bSort": true
   		
	}

} );


/* Default class modification */
$.extend( $.fn.dataTableExt.oStdClasses, {
	"sWrapper": "dataTables_wrapper form-inline"
} );


/* API method to get paging information */
$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
{
	return {
		"iStart":         oSettings._iDisplayStart,
		"iEnd":           oSettings.fnDisplayEnd(),
		"iLength":        oSettings._iDisplayLength,
		"iTotal":         oSettings.fnRecordsTotal(),
		"iFilteredTotal": oSettings.fnRecordsDisplay(),
		"iPage":          oSettings._iDisplayLength === -1 ?
			0 : Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
		"iTotalPages":    oSettings._iDisplayLength === -1 ?
			0 : Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
	};
};


/* Bootstrap style pagination control */
$.extend( $.fn.dataTableExt.oPagination, {
	"bootstrap": {
		"fnInit": function( oSettings, nPaging, fnDraw ) {
			var oLang = oSettings.oLanguage.oPaginate;
			var fnClickHandler = function ( e ) {
				e.preventDefault();
				if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
					fnDraw( oSettings );
				}
			};

			$(nPaging).addClass('pagination').append(
				'<ul>'+
					'<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
					'<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
				'</ul>'
			);
			var els = $('a', nPaging);
			$(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
			$(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
		},

		"fnUpdate": function ( oSettings, fnDraw ) {
			var iListLength = 5;
			var oPaging = oSettings.oInstance.fnPagingInfo();
			var an = oSettings.aanFeatures.p;
			var i, ien, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

			if ( oPaging.iTotalPages < iListLength) {
				iStart = 1;
				iEnd = oPaging.iTotalPages;
			}
			else if ( oPaging.iPage <= iHalf ) {
				iStart = 1;
				iEnd = iListLength;
			} else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
				iStart = oPaging.iTotalPages - iListLength + 1;
				iEnd = oPaging.iTotalPages;
			} else {
				iStart = oPaging.iPage - iHalf + 1;
				iEnd = iStart + iListLength - 1;
			}

			for ( i=0, ien=an.length ; i<ien ; i++ ) {
				// Remove the middle elements
				$('li:gt(0)', an[i]).filter(':not(:last)').remove();

				// Add the new list items and their event handlers
				for ( j=iStart ; j<=iEnd ; j++ ) {
					sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
					$('<li '+sClass+'><a href="#">'+j+'</a></li>')
						.insertBefore( $('li:last', an[i])[0] )
						.bind('click', function (e) {
							e.preventDefault();
							oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
							fnDraw( oSettings );
						} );
				}

				// Add / remove disabled classes from the static elements
				if ( oPaging.iPage === 0 ) {
					$('li:first', an[i]).addClass('disabled');
				} else {
					$('li:first', an[i]).removeClass('disabled');
				}

				if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
					$('li:last', an[i]).addClass('disabled');
				} else {
					$('li:last', an[i]).removeClass('disabled');
				}
			}
		}
	}
} );


/*
 * TableTools Bootstrap compatibility
 * Required TableTools 2.1+
 */
if ( $.fn.DataTable.TableTools ) {
	// Set the classes that TableTools uses to something suitable for Bootstrap
	$.extend( true, $.fn.DataTable.TableTools.classes, {
		"container": "DTTT btn-group",
		"buttons": {
			"normal": "btn",
			"disabled": "disabled"
		},
		"collection": {
			"container": "DTTT_dropdown dropdown-menu",
			"buttons": {
				"normal": "",
				"disabled": "disabled"
			}
		},
		"print": {
			"info": "DTTT_print_info modal"
		},
		"select": {
			"row": "active"
		}
	} );

	// Have the collection use a bootstrap compatible dropdown
	$.extend( true, $.fn.DataTable.TableTools.DEFAULTS.oTags, {
		"collection": {
			"container": "ul",
			"button": "li",
			"liner": "a"
		}
	} );
}

jQuery.fn.dataTableExt.oSort['string-num-asc']  = function(x1,y1) {
    var x=x1;
    var y=y1;
    var pattern = /[0-9]+/g;
        var matches;
    if(x1.length !== 0) {
        matches = x1.match(pattern);
        x=matches[0];
    }
    if(y1.length !== 0) {
        matches = y1.match(pattern);
        y=matches[0];
    }  
    return ((x < y) ? -1 : ((x > y) ?  1 : 0));
     
};
 
jQuery.fn.dataTableExt.oSort['string-num-desc'] = function(x1,y1) {
     
    var x=x1;
    var y=y1;
    var pattern = /[0-9]+/g;
        var matches;
    if(x1.length !== 0) {
        matches = x1.match(pattern);
        x=matches[0];
    }
    if(y1.length !== 0) {
        matches = y1.match(pattern);
        y=matches[0];
    }
    $("#debug").html('x='+x+' y='+y);
    return ((x < y) ?  1 : ((x > y) ? -1 : 0));
     
};


/* Table initialisation */
$(document).ready(function() {
	
	
	
	
	//TBL USERS
	$('#tblUsers').dataTable({
		"bProcessing": true,
		"bServerSide": true,	
		"aoColumns" : [	 
		               	 { "sTitle" : "USUARIO", "mData" : "username"     },
		                 { "sTitle" : "BARRIO" , "mData" : "neighborhood", "sDefaultContent": ""  }
	                  ],
//		"aoColumns" : [	 
//		               	 { "mDataProp" : "username" },
//		                 { "mDataProp" : "neighborhood", "sDefaultContent": "" }
//					  ],
		"sAjaxSource": "http://localhost:8080/fixeala/usuarios/loadUsers.html",
		"fnServerData": function ( sSource, aoData, fnCallback ) {
	            $.ajax( {
	                "dataType": 'json',
	                "type": "GET",
	                "url": sSource,
	                "data": aoData,
	                "success": fnCallback
	            } );
	            
	            console.log(aoData);
	        }	  
	});
	
	
	//TBL ISSUES
	$('#tblIssues').dataTable({
		"bProcessing": true,
		"bServerSide": true,
		"aoColumns" : [	 
		               	 { "sTitle" : "#", "mData" : "id" , "sType": "string-num" 
//		               		 , "mRender": function ( data, type, full ) {
//		               			 return '#' + data + ' in';
//		               		 } 
		               	 },
		             	 { "sTitle" : "TITULO" , "mData" : "title" },
		                 { "sTitle" : "DIRECCION" , "mData" : "address" },
		               	 { "sTitle" : "BARRIO" , "mData" : "neighborhood", "sDefaultContent": "" },
		               	 { "sTitle" : "CIUDAD" , "mData" : "city" },
		               	 { "sTitle" : "PROVINCIA" , "mData" : "province" },
		               	 { "sTitle" : "FECHA" , "mData" : "fechaFormateada" },
		               	 { "sTitle" : "USUARIO" , "mData" : "username" },
		               	 { "sTitle" : "ESTADO" , "mData" : "status" }
		            	
	                  ],		  		
		"sAjaxSource": "http://localhost:8080/fixeala/reclamos/loadIssues.html",
		"fnServerData": function ( sSource, aoData, fnCallback ) {
	            $.ajax( {
	                "dataType": 'json',
	                "type": "GET",
	                "url": sSource,
	                "data": aoData,
	                "success": fnCallback
	            } );
	        },
	    "aaSorting": [[ 0, "desc" ]] 
	});
	
	
	//TBL BACKEND USERS
	$('#tblBackendUsers').dataTable({
		"bProcessing": true,
		"bServerSide": true,
		"aoColumns" : [	 						
		               	 { "mData" : "id", "bVisible" : false },
		             	 { "sTitle" : "USUARIO" , "mData" : "username" },
		                 { "sTitle" : "ROL" , "mData" : "authorities" },
		               	 { "sTitle" : "NOMBRE" , "mData" : "nombre" },
		               	 { "sTitle" : "APELLIDO" , "mData" : "apellido" }, 	
		               	 { "sTitle" : "ULTIMO ACCESO" , "mData" : "lastLoginDate", "sType" : "date" },
		               	 { "sTitle" : "ESTADO" , "mData" : "accountStatus" }			            	
	                  ],		  		
		"sAjaxSource": "http://localhost:8080/fixeala/users/coripel/loadBackendUsers.html",
		"fnServerData": function ( sSource, aoData, fnCallback ) {				
			 	aoData.push({"name": "areaID", "value": "5"});				 	
	            $.ajax( {
	                "dataType": 'json',
	                "type": "POST",
	                "url": sSource,
	                "data": aoData,
	                "success": fnCallback      	              
	            } );
	        },
	        "fnRowCallback": function( nRow, aData, iDataIndex, iDisplayIndexFull  ) {
	            $(nRow).attr('id', aData.id);
	        },
	    "aaSorting": [[ 0, "desc" ]] 
	});
	
	
	//TBL ISSUES BY USER
	$('#tblUserIssues').dataTable({
		"bProcessing": true,
		"bServerSide": true,
		"aoColumns" : [	 						
		               	 { "sTitle" : "#" , "mData" : "id" },
		               	 { "sTitle" : "FECHA" , "mData" : "fechaFormateada" },
		               	 { "sTitle" : "TITULO" , "mData" : "title" },
		                 { "sTitle" : "DIRECCION" , "mData" : "address" },
		               	 { "sTitle" : "BARRIO" , "mData" : "neighborhood", "sDefaultContent": "" },
		               	 { "sTitle" : "CIUDAD" , "mData" : "city" },
		               	 { "sTitle" : "PROVINCIA" , "mData" : "province" },		   
		               	 { "sTitle" : "USUARIO" , "mData" : "username" },
		               	 { "sTitle" : "ESTADO" , "mData" : "status" }		            	
	                  ],		  		
		"sAjaxSource": "http://localhost:8080/fixeala/users/coripel/loadUserIssues.html",
		"fnServerData": function ( sSource, aoData, fnCallback ) {				
			 	aoData.push({"name": "areaID", "value": "5"});				 	
	            $.ajax( {
	                "dataType": 'json',
	                "type": "POST",
	                "url": sSource,
	                "data": aoData,
	                "success": fnCallback      	              
	            } );
	        },
	        "fnRowCallback": function( nRow, aData, iDataIndex, iDisplayIndexFull  ) {
	            $(nRow).attr('id', aData.id);
	        },
	    "aaSorting": [[ 0, "desc" ]] 
	});
	

} );