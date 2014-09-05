
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
								
           
           
            function clearForm(form) {
            	  // iterate over all of the inputs for the form
            	  // element that was passed in
            	  $(':input', form).each(function() {
            	    var type = this.type;
            	    var tag = this.tagName.toLowerCase(); // normalize case
            	    // it's ok to reset the value attr of text inputs,
            	    // password inputs, and textareas
            	    if (type == 'text' || type == 'password' || tag == 'textarea')
            	      this.value = "";
            	    // checkboxes and radios need to have their checked state cleared
            	    // but should *not* have their 'value' changed
            	    else if (type == 'checkbox' || type == 'radio')
            	      this.checked = false;
            	    // select elements need to have their 'selectedIndex' property set to -1
            	    // (this works for both single and multiple select elements)
            	    else if (tag == 'select')
            	      this.selectedIndex = -1;
            	  });
            };
			