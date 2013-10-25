(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define(['underscore'], factory);
    } else {
        root.NestedDataSource = factory();
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
 
    NestedDataSource.prototype = {
 
        columns: function () {
            return this._columns;
        },
 
        data: function (options, callback) {
            var self = this;
 
            setTimeout(function () {
                var data = $.extend(true, [], self._data);
 
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
 
    return NestedDataSource;
}));
 
 
// usage
// say I have a "me" object:
//   {
//  	name: "JoeHetfield",
//  	age: 39,
//  	pet: {
//  		name: "Back Jack",
//  		age: 5
//  	}
//  }
// then I can use datagrid like this:
 
    // INITIALIZING THE DATAGRID
    var dataSource = new StaticDataSource({
        columns: [
            {
                property: 'name',
                label: 'My Name',
                sortable: true
            },
            {
                property: 'age',
                label: 'My Age',
                sortable: true
            },
            {
                property: 'pet.name',
                label: 'Pet Name',
                sortable: true
            },
            {
                property: 'pet.age',
                label: 'Pet Age',
                sortable: true
            }
        ],
        data: dataOfPersonAndTheirPet,
        delay: 250
    });
 
    $('#MyGrid').datagrid({
        dataSource: dataSource,
        stretchHeight: true
    });