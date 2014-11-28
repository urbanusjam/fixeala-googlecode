
			var gotoHashTab = function (customHash) {
		        var hash = customHash || location.hash;
		        var hashPieces = hash.split('?'),
		            activeTab = $('[href=' + hashPieces[0] + ']');
		       		activeTab && activeTab.tab('show');
	    	}
	 
		    // onready go to the tab requested in the page hash
		    gotoHashTab();
		 
		    // when the nav item is selected update the page hash
		    $('.nav a').on('shown', function (e) {
		        window.location.hash = e.target.hash;
		    })
		 
		    // when a link within a tab is clicked, go to the tab requested
		    $('.tab-pane a').click(function (event) {			    	
		        if (event.target.hash) {			       
		            gotoHashTab(event.target.hash);
		        }
		    });
		    
		   
 			function updateProgressBar(navItems, stepIndex){
 				var $total = navItems;		
 				var $current = stepIndex;			
 				var $percent = ($current/$total) * 100;
 				$('.bar').css({width:$percent+'%'});
 			}
				
			
			// initialize tooltipster on form input elements
		    $('#issueWizard input[type="text"], #issueWizard textarea').tooltipster({ 		    
		    	animation: 'fade',		
		    	delay: 200,
		    	interactive: true,
		    	timer: 2500,
		    	maxWidth: 230,
		        trigger: 'custom', // default is 'hover' which is no good here
		        onlyOne: false,    // allow multiple tips to be open at a time
		        position: 'right'  // display the tips to the right of the element
		    });
			
		
			
			//-------------------------------
            // Tag events
            //-------------------------------
            

             var eventTags = $('#eventTags');

             var addEvent = function(text) {
                 $('#events_container').append(text + '<br>');
             };
             eventTags.tagit({  
             	 autocomplete: {
             		 messages: {
             		        noResults: '',
             		        results: function() {}
             		    }
             	 },
             	tagSource: function(search, showChoices) {
             		var filter = search.term.toLowerCase();

             		$.ajax({ 
             			  url: getDomainUrl() + "loadTags.html",
 	            		  type: "GET",	
             			  success: function(data){
 		            		var choices = $.grep(data, function(element) {
 		            		// Only match autocomplete options that begin with the search term.
 		            		// (Case insensitive.)
 		            		return (element.toLowerCase().indexOf(filter) === 0);
 		            		});
 	            			showChoices(choices);
 	            		},
 	            		dataType: 'json'
             		});
             	},              
                 allowSpaces: true,
                 tagLimit: 5,
                 beforeTagAdded: function(evt, ui) {
                     if (!ui.duringInitialization) {
                         addEvent('beforeTagAdded: ' + eventTags.tagit('tagLabel', ui.tag));
                     }
                 },
                 afterTagAdded: function(evt, ui) {
                     if (!ui.duringInitialization) {
                         addEvent('afterTagAdded: ' + eventTags.tagit('tagLabel', ui.tag));
                     }
                 },
                 beforeTagRemoved: function(evt, ui) {
                     addEvent('beforeTagRemoved: ' + eventTags.tagit('tagLabel', ui.tag));
                 },
                 afterTagRemoved: function(evt, ui) {
                     addEvent('afterTagRemoved: ' + eventTags.tagit('tagLabel', ui.tag));
                 },
                 onTagClicked: function(evt, ui) {
                     addEvent('onTagClicked: ' + eventTags.tagit('tagLabel', ui.tag));
                 },
                 onTagExists: function(evt, ui) {
                     addEvent('onTagExists: ' + eventTags.tagit('tagLabel', ui.existingTag));
                 }
             });
								
             //Add to Favorites			
 	        $('#bookmarkme').click(function() {
 	            if (window.sidebar && window.sidebar.addPanel) { // Mozilla Firefox Bookmark
 	                window.sidebar.addPanel(document.title,window.location.href,'');
 	            } else if(window.external && ('AddFavorite' in window.external)) { // IE Favorite
 	                window.external.AddFavorite(location.href,document.title); 
 	            } else if(window.opera && window.print) { // Opera Hotlist
 	                this.title=document.title;
 	                return true;
 	            } else { // webkit - safari/chrome
 	            	bootbox.alert('Esta funci&oacute;n no est&aacute; disponible para los navegadores Chrome y Safari.<br>' + 
 	            					'Presione las teclas <b>' + (navigator.userAgent.toLowerCase().indexOf('mac') != - 1 ? 'Command/Cmd' : 'CTRL') + ' + D</b> para agregar la p&aacute;gina a Favoritos.');
 	                
 	            }
 	        });
 	        
 	       <!--       			<a id="bookmarkme" href="#" rel="sidebar" title="Agregar a Favoritos"><i class="icon-star"></i></a> -->
 	      <!--       			<a href="#" onclick="javascript:window.print();" title="Imprimir"><i class="icon-print"></i></a> -->
 	      
 	      
		//Prevents Jump When Tabs Are Clicked
		$('.nav-tabs li a').click( function(e) {
			history.pushState( null, null, $(this).attr('href') );
		});
		
		
		$('[data-toggle="popover"]').popover();
		$('body').on('click', function (e) {
		    $('[data-toggle="popover"]').each(function () {
		        //the 'is' for buttons that trigger popups
		        //the 'has' for icons within a button that triggers a popup
		        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
		            $(this).popover('hide');
		        }
		    });
		});
			