var fxlHomeController = {
		
	issuesJson : null,
	
	usersJson : null,
	
	initHome : function(issues, users){
		
		//search
		fxlHomeController.initSearchBar();
		
		//fileupload button
		$("#file_upload").filestyle({
			buttonText: "Seleccionar",
			classIcon: "icon-plus"
		});
		
		//pagination
		fxlHomeController.issuesJson = issues;
		fxlHomeController.usersJson = users;
		fxlHomeController.initInfiniteScroll();
		
	},
		
	initSearchBar : function(){
		
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
		
	},

	/** ============================================================================================== **/
	/**                               I N F I N I T E   S C R O L L				    		           **/
	/** ============================================================================================== **/
	
	initInfiniteScroll : function(){
		
		var issuesArray = JSON.parse(fxlHomeController.issuesJson);	
		var votesArray = JSON.parse(fxlHomeController.issuesJson);		
		var usersArray = JSON.parse(fxlHomeController.usersJson);	
		
		votesArray.sort(fxlHomeController.sortByVotes);
		
		//config
		fxlHomeController.configIsotopeContainers();
		fxlHomeController.configIsotopeTabs();
		fxlHomeController.configIsotopeMoreBtn();
		fxlHomeController.configIsotopeSortBtn();

		//first page
		fxlHomeController.loadFirstPage(issuesArray, votesArray, usersArray);
		
	},
	
	sortByVotes : function(a, b){
		var aVote = a.totalVotes;
		var bVote = b.totalVotes; 
		return bVote - aVote;
	},
	
	loadFirstPage : function(issuesArray, votesArray, usersArray){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		 if(issuesArray.length > 0){
        	var html =  [];	
        	$.each( issuesArray, function( i, value ) {
        		var item = fxlHomeController.renderToHtml(value, "issue");
        		html.push(item);
        	});
        	$container.append(html);
         }
		 
		 if(votesArray.length > 0){
        	var html =  [];	
        	$.each( votesArray, function( i, value ) {
        		var item = fxlHomeController.renderToHtml(value, "issue");
        		html.push(item);
        	});
        	$containerVotes.append(html);
         }
		 
		 if(usersArray.length > 0){
        	var html =  [];	
        	$.each( usersArray, function( i, value ) {
        		var item = fxlHomeController.renderToHtml(value, "user");
        		html.push(item);
        	});
        	$containerUsers.append(html);
	     }
	},
	
	renderToHtml : function(element, type){
		
		var html = '';
		var imageUrl = '';
		var issueUrl = "issues/" + element.id;
		var userUrl = "users/" + element.username;
		var titleLimit = 40;
		var descLimit = 150;
		
		if(type == "issue"){
			
			if(element.url != null){	
				imageUrl = element.url;	
			}
			
			else{
				imageUrl = "resources/images/nopic.png";
			}
			
			html = 	'<div class="brick">'
    			+ 			'<p class="top">'
				+				'<span class="id-char pull-left"><b>#</b></span>'
				+ 				'<span class="date-box pull-right">'
				+ 					'<span class="id pull-left">' +element.id+ '</span>'
				+ 					'<span class="date pull-right">' +element.date+ '</span>'
				+				'</span>'
				+ 			'</p>'
				+ 			'<a class="thumbnail" href="'+imageUrl+'">'
				+    			'<img src="'+imageUrl+'">'
				+  			'</a>'	
				+   		'<a class="title" title="'+element.title+'" href="' +issueUrl+ '">' +fxlGlobalController.cropText(element.title, titleLimit)+ '</a>'	
				+			'<p class="address"><span class="city">' +element.city+ '</span>, <span class="province">' +element.province+ '</span></p>'
				+           '<p class="desc">' +fxlGlobalController.cropText(element.description, descLimit)+ '</p>'
				+ 			'<span class="status '+element.css+'">' +element.status+ '</span>'
				+ 			'<div class="inline-container">'
				+ 					'<div class="left"><i class="icon icon-thumbs-up icon-small"></i>' +element.totalVotes+ '</div>'
				+					'<div class="right"><i class="icon icon-eye-open icon-small"></i>' +element.totalViews+ '</div>'
				+ 					'<div class="center"><i class="icon icon-user icon-small"></i>' +element.totalFollowers+ '</div>'
				+ 			'</div>'		
				+   '</div>';
		}
		
		else if(type == "user"){
			
			if(element.profilePic != null){	
				imageUrl = element.profilePic;	
			}
			
			else{
				imageUrl = "resources/images/nopic.png";
			}
		
			html = 	'<div class="brick brick-user">'
				+   		'<a class="username" href="' +userUrl+ '">' +element.username+ '</a>'	
				+ 			'<a class="thumbnail" href="'+imageUrl+'">'
				+    			'<img src="'+imageUrl+'">'
				+  			'</a>'	
				+			'<p class="bottom">'
				+ 					'Registrado el <span >' +element.registration+ '</span>'
				+ 			'</p>'
				+ 			'<div class="inline-container">'
				+ 					'<div class="left"><i class="icon icon-map-marker icon-small"></i><span class="numIssues">' +element.reportedIssues+ '</div>'
				+ 					'<div class="right"><i class="icon icon-comments-alt icon-small"></i><span class="numComments">' +element.postedComments+ '</div>'
				+ 					'<div class="center"><i class="icon icon-ok icon-small"></i><span class="numFixes">' +element.fixedIssues+ '</div>'
				+ 			'</div>'						
				+   	'</div>';
		}
		
		return html;
		
	},
	
	configIsotopeContainers : function(){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		//issues
		$container.imagesLoaded( function(){                
	        $container.isotope({
	            itemSelector : '.brick',   
	            sortBy: 'original-order',
	            getSortData : {
	                title    : '.title',
	                id       : '.id parseInt',
	                status   : '.status',
	                province : '.province' 
	            }
	        });
	    });
		
		$container.infinitescroll({
			navSelector  	: "#page-nav",
			nextSelector 	: "#page-nav a",
			itemSelector 	: ".brick",  
			pixelsFromNavToBottom : "20",
			debug: true,
			dataType: 'json',
			appendCallback: false,
			loading: {
				finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
		        msgText: "<h4>Cargando reclamos...</h4>",
		        speed: 'slow'
		    }  		      
		 }, function (newElements) {
		 		var html = '';
		 		$.each( newElements, function( i, value ) {
		 			 html += renderToHtml(value, 'issue');
		        });
				 	
			 	var $newElems = $( html );

			    $newElems.imagesLoaded(function(){
					$newElems.animate({ opacity: 1 });
					$container.append( $newElems ).isotope( 'appended', $newElems );
			    });
	    });
		
		$container.infinitescroll('pause');
		 
		//votes
		$containerVotes.imagesLoaded( function(){                
	    	$containerVotes.isotope({
	        	itemSelector : '.brick'	                  
	    	});
	    });
		
		$containerVotes.infinitescroll({
			navSelector  	: "#page-nav-votes",
			nextSelector 	: "#page-nav-votes a",
			itemSelector 	: ".brick",  
			pixelsFromNavToBottom : "20",
			debug: true,
			dataType: 'json',
			appendCallback: false,
			loading: {
	            finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
	            msgText: "<h4>Cargando reclamos...</h4>",
	            speed: 'slow'
		    }  		      
		 }, function (newElements) {
		 		var html = '';
			 		$.each( newElements, function( i, value ) {
			 			 html += renderToHtml(value, 'issue');
			        });
				 	
			 		var $newElems = $( html );

				    $newElems.imagesLoaded(function(){
						$newElems.animate({ opacity: 1 });
						$containerVotes.append( $newElems ).isotope( 'appended', $newElems );
	 			});
				    
	    });
			
		$containerVotes.infinitescroll('pause');
		 
		//users
		$containerUsers.imagesLoaded( function(){   
	    	$containerUsers.isotope({
	        	itemSelector : '.brick',
	            sortBy: 'original-order',
	            sortAscending : false,
	            getSortData : {
	            	issues    : '.numIssues parseInt',
	                comments  : '.numComments parseInt',
	                fixes     : '.numFixes parseInt'
	            }
	        });
		});
		 
		$containerUsers.infinitescroll({
			navSelector  	: "#page-nav-user",
			nextSelector 	: "#page-nav-user a",
			itemSelector 	: ".brick",  
			pixelsFromNavToBottom : "20",
			debug: true,
			dataType: 'json',
			appendCallback: false,
			loading: {
	            finishedMsg: "<h4>No se encontraron m&aacute;s resultados.</h4>",
	            msgText: "<h4>Cargando usuarios...</h4>",
	            speed: 'slow',
		    }  		      
		 }, function (newElements) {
		 		var html = '';
		 		$.each( newElements, function( i, value ) {
		 			 html += renderToHtml(value, 'user');
		        });
				 	
		 		var $newElems = $( html );
		 		
			    $newElems.imagesLoaded(function(){
					$newElems.animate({ opacity: 1 });
					$containerUsers.append( $newElems ).isotope( 'appended', $newElems );
	 			});
	    });
					
		$containerUsers.infinitescroll('pause');
		
	},
	
	configIsotopeTabs : function(){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		//bootstrap tabs + multiple isotope instances = overlapping [FIXED] 
		// http://stackoverflow.com/questions/19214362/making-a-jquery-isotope-layout-initialize-inside-a-bootstrap-tab
		// https://github.com/metafizzy/isotope/issues/458
		
		$('.nav-tabs li').on('shown.bs.tab', function (e) {
			var clickedTab = $(this).find('a').attr('href');
		 	if(clickedTab == "#topUsers"){
			  	$containerUsers.isotope('layout');
		 	}
		 	if(clickedTab == "#hottestIssues"){
			  	$containerVotes.isotope('layout');
		 	}

		});
		
	},
	
	configIsotopeMoreBtn : function(){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		$(' .btn-more ').click(function(e){
			// call this whenever you want to retrieve the next page of content
		    // likely this would go in a click handler of some sort
		    e.preventDefault();
		
		    if( $(this).hasClass( 'issue' ) ){
				$container.infinitescroll('retrieve');
			    $('#page-nav').hide(); 
		   	}  
		    
		    else if( $(this).hasClass( 'vote' ) ){
		    	$containerVotes.infinitescroll('retrieve');
		    	$('#page-nav-votes').hide(); 
		    } 
		    
		    else{
		    	$containerUsers.infinitescroll('retrieve');
		        $('#page-nav-users').hide(); 
		    } 			  
		    return false;
		});
		
	},
	
	configIsotopeSortBtn : function(){
		
		var $container = $('#infinite-container');
		var $containerVotes = $('#infinite-container-votes');
		var $containerUsers = $('#infinite-container-users');
		
		// sort items on button click
		$('#sorts  > .btn').on( 'click',  function() {
			var sortByValue = $(this).attr('data-sort-by');
		  	$container.isotope({ sortBy: sortByValue });
		 	$(this).addClass("active").siblings().removeClass("active");
		});
		
		// sort items on button click
		$('#sorts-users  > .btn').on( 'click',  function() {
			var sortByValue = $(this).attr('data-sort-by');
		  	$containerUsers.isotope({ sortBy: sortByValue });
		 	$(this).addClass("active").siblings().removeClass("active");
		});
		
	}
	
		
}