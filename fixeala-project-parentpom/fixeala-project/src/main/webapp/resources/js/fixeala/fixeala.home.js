var fxlHomeController = {
		
	initSearch : function(){
		
		var issueNames;
		var issueObjs;			
		 
		$('#search').typeahead({
			 	minLength: 3,
			    items: 5,
			    cache: false,
			    source: function(query, process){				    	
			    	 return $.ajax({
			             url: $('#search').data('link'),
			             type: 'GET',
			             data: { query: query },
			             dataType: 'json',
			             beforeSend: function() {
			                 //that.$element is a variable that stores the element the plugin was called on
			                 $('#search').addClass('loading');
			             },
			             success: function (data) {

							issueNames = [];
								issueObjs = {};				
			            	 
			            	 $.each( data, function ( i, item ) {				            		 
			            		issueNames.push(item.title);
			            		issueObjs[item.title] = item;
			            	 });

			                 return process(issueNames);
			             },
			             complete: function() {
			            	 $('#search').removeClass('loading');
			             }
			         });
			    },
			
		        matcher: function(item) {		        
		        	var issue = issueObjs[item];
		        	var query = this.query.toLowerCase();
		        	
		            return issue.id.toLowerCase().indexOf(query) != -1 
		            			|| issue.title.toLowerCase().indexOf(query) != -1 
		            			|| issue.status.toLowerCase().indexOf(query) != -1
		            			|| issue.address.toLowerCase().indexOf(query) != -1;		            	
		        },
			    updater: function(itemName) { 
			    	window.location.href = 'issues/' + issueObjs[ itemName ].id;  				
			    },
			    sorter: function(items) {
			    	console.log(items);
			        if (items.length == 0) {
			            var noResult = new Object();
			            items.push(noResult);
			        }
			    	return items;    
			    },
			    highlighter: function (item) {				    	

			    	 if( issueNames.indexOf(item) == -1 ) {				    		
			    		 return '<h4>No se encontraron resultados.</h4>';
			    	 }

			    	 else{
			    		 var issue = issueObjs[item];
			    		 var q  = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&amp;');
			    		
				    	   return ''
						       + "<div class='typeahead-container'>"
			                   + "<div class='typeahead-status'>"
			                   + 		"<p class='" +issue.css+ "'>" +issue.status+ "</p>"
			                   + "</div>"
			                   + "<div class='typeahead-content'>"
			                   + "<span class='typeahead-id'>&#35;" +highlightQuery(issue.id, q)+  "&nbsp;&nbsp;&rsaquo;&nbsp;&nbsp;" +issue.date+ "</span>"				                   
			                   + "<span class='typeahead-title'><strong>" + highlightQuery(item, q)+ "</strong></span>"
			                   + "<span class='typeahead-address'>" +highlightQuery(issue.address, q) + "</span>"
			                   + "</div></div>";	     
			    	 }  
			    	  
			    }				  
			});
		 
		 function highlightQuery(data, query){
			 return data.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
	               return '<span style="background-color:yellow; display: inline;">' + match + '</span>';
	         });
		 }
				
		 //Remove forced selection of first item
		 $.fn.typeahead.Constructor.prototype.render = function(items) {
		     var that = this;
		     items = $(items).map(function (i, item) {
		       i = $(that.options.item).attr('data-value', item);
		       i.find('a').html(that.highlighter(item));
		       return i[0];
		     });

		     this.$menu.html(items);
		     return this;
		};
					
		var options = {
                currentPage: 1
                , totalPages: 10
                , numberOfPages:3
                , size:'normal'
                , alignment:'center'
                , onPageChanged: function(e,oldPage,newPage){
                    $('.pag').text("Current page changed, old: "+oldPage+" new: "+newPage);
                }
              
        }
		
	}
	
		
}