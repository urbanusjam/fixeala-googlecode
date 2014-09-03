(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define(['underscore'], factory);
    } else {
        root.BackendUsersDataSource = factory();
    }
}(this, function () {
 
    var BackendUsersDataSource = function (options) {
        this._formatter = options.formatter;
        this._columns = options.columns;
        this._delay = options.delay || 0;
        this._data = options.data;
 
        var self = this;
 
        // all tricks are here, the rest are completely the same as StaticDataSource 
        // check every column
        $.each(this._columns, function(index, column) {
 
            // split column property by dot
            var pros = column.property.split('.');
 
            // if splited array length bigger than 1, we found column that point to a nested property
            if (pros.length > 1) {
 
                // here we give all data a 'flat' property
                $.each(self._data, function(index, row) {
 
                    // setup a tick start from 1 (the property name after the first dot)
                    var tick = 1;
                    // here we actually get the nested object
                    var result = row[pros[0]];
                    // loop through the nested object, until we hit null or undefined
                    while (result && tick < pros.length) {
                        result = result[pros[tick]];
                        tick++;
                    }
                    // set the value of 'flat' property
                    row[column.property] = result;
                });
            }
        });
    };
 
    BackendUsersDataSource.prototype = {
 
        columns: function () {
            return this._columns;
        },
 
        data: function (options, callback) {
            var self = this;
 
            setTimeout(function () {
                var data = $.extend(true, [], self._data);
                
                var url = getDomainUrl() + "users/" + '${profileUser}' + "/loadBackendUsers.html";
			 	 
			 	   $.ajax({
						url: url,
					 	dataType: 'json',
	               		type: 'POST', 
	               		data: "areaID=" + currentArea,
			            success: function(response) { 
                         
			            	var self = this;
			            	var data = response;
			            	var count = data.length;
			            
                           // here we give all data a 'flat' property
                           $.each(data, function (index, row) {
                           	$("#tblBackendUsers tbody tr").attr('id', data[0].id);
                           });
                           
			            	 // SORTING
			                if (options.sortProperty) {
			                    data = _.sortBy(data, options.sortProperty);
			                    if (options.sortDirection === 'desc') data.reverse();
			                }
				            	 
							callback({ data: data, start: 0, end: 0, count: count, pages: 0, page: 0 });
                          						            	 
			            },				           
			            error: function(jqXHR, exception){
			            	errorHandler (jqXHR, exception);
			            }
        		});
 
                // SEARCHING
                if (options.search) {
                    data = _.filter(data, function (item) {
                        var match = false;
 
                        _.each(item, function (prop) {
                            if (_.isString(prop) || _.isFinite(prop)) {
                                if (prop.toString().toLowerCase().indexOf(options.search.toLowerCase()) !== -1) match = true;
                            }
                        });
 
                        return match;
                    });
                }
 
                // FILTERING
                if (options.filter) {
                    data = _.filter(data, function (item) {
                        switch(options.filter.value) {
                            case 'lt5m':
                                if(item.population < 5000000) return true;
                                break;
                            case 'gte5m':
                                if(item.population >= 5000000) return true;
                                break;
                            default:
                                return true;
                                break;
                        }
                    });
                }
 
                var count = data.length;
 
                // SORTING
                if (options.sortProperty) {
                    data = _.sortBy(data, options.sortProperty);
                    if (options.sortDirection === 'desc') data.reverse();
                }
 
                // PAGING
                var startIndex = options.pageIndex * options.pageSize;
                var endIndex = startIndex + options.pageSize;
                var end = (endIndex > count) ? count : endIndex;
                var pages = Math.ceil(count / options.pageSize);
                var page = options.pageIndex + 1;
                var start = startIndex + 1;
 
                data = data.slice(startIndex, endIndex);
 
                if (self._formatter) self._formatter(data);
 
                callback({ data: data, start: start, end: end, count: count, pages: pages, page: page });
 
            }, this._delay)
        }
    };
 
    return BackendUsersDataSource;
}));
 

 
    // INITIALIZING THE DATAGRID
    var dataSource = new BackendUsersDataSource({
    	columns: [{
    		
    	 	label: 'Usuario',
            property: 'user.username',
            sortable: true,
            sortProperty: 'username'
    	},
    	{    
			label: 'Rol',
            property: 'roles',
            sortable: true,
            sortProperty: 'rol.authority'  
		},
		{		                	 	
    	 	label: 'Nombre',
            property: 'nombre',
            sortable: true,
            sortProperty: 'nombre'
		},
		{	
            label: 'Apellido',
            property: 'apellido',
            sortable: true,
            sortProperty: 'apellido' 
		},
		{	
            label: 'Ultimo acceso',
            property: 'lastLogin',
            sortable: true,
            sortProperty: 'lastLogin'            				         		
		},
		{
			label: 'Estado',
            property: 'status',
            sortable: true,
            sortProperty: 'status'
		}],		
        delay: 250
    });
 
    $('#tblBackendUsers').datagrid({
        dataSource: dataSource,
        stretchHeight: true
    });