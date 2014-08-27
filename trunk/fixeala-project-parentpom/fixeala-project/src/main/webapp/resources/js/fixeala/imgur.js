var fileController = {
		
		uploadCallback : function(fileData, filename){
			issueFileData = new Object();
			issueFileData.response = fileData;
			issueFileData.filename = filename;

//			console.log(fileData);
//			return fileData;
		},
		
		simpleUpload : function(file, filename, callback) {
			mapController.blockIssueForm();	 	
	        var fd = new FormData();
	        fd.append("image", file); 
	        
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "https://api.imgur.com/3/image.json", false); //synchronous req 
	        xhr.ontimeout = function () {
	            console.error("The request for " + url + " timed out.");
	        };
	        xhr.onload = function() {
	        	console.log('--- imgur processing ---');
//	        	if (xhr.status === 200) {
	        		 callback(xhr.responseText, filename);
	        		 mapController.unBlockIssueForm();	 	
//	        	}
	        }
	        xhr.onerror = function (xhr) {
//	        	callback(xhr.statusText, null);
	        	console.error(xhr.statusText);
	        };
	        xhr.setRequestHeader('Authorization', 'Client-ID f64d4441566d507'); 
	        xhr.send(fd);
	    
		},
		
		handleUserPicUpload : function(file, loggeduser){
		
			blockPage('html');

			console.log('--- the file ---');

	        if (!file || !file.type.match(/image.*/)){
	        	bootbox.alert("Debe seleccionar un archivo de imagen");
	        	return;
	        } 

	        var fd = new FormData();
	        fd.append("image", file); 
	        
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "https://api.imgur.com/3/image.json"); 
	        xhr.onload = function() {

	        	var result = JSON.parse(xhr.responseText);
	        	
	        	var success = result.success;
	        	var statusCode = result.status;
	        	
	        	var imgurFileID = result.data.id;
	        	var deletehash = result.data.deletehash;

	        	//upload OK
	        	if(success && statusCode == '200'){
	        		
	        		console.log("--- imgur upload OK ---");
	        		
	        		var fileData = JSON.stringify(result.data);
	        		var filename = file.name;
	        		
	    			$.ajax({
	    			    url: './'+loggeduser+'/uploadUserPic',
	    		 		type: 'POST',	
	    		 		dataType: 'json',
	    		 		data: 'fileData=' + fileData + '&filename=' + filename,
	    		        success: function(data){	
	    		 
	    		        	if(data.status){
	    		        		unBlockPage('html');
	    		        		console.log("--- db upload OK ---");
	    		        		
	    		        		setTimeout(function(){
	    		        			 location.reload();
	    		        		}, 700);
	    		        		
	    		        	}
	    		        	else{
	    		        		console.log("--- imgur upload ERROR ---");
	    		        		//delete imgur file
	    		        		fileController.deleteImage(deletehash);
	    		        		bootbox.alert('No se puedo guardar el archivo.');
	    		        	}
	    				},
	    				error: function (xhr) {
	    					console.log("--- ajax upload ERROR ---");
	    					fileController.deleteImage(deletehash);
	    			    	bootbox.alert('No se pudo guardar el archivo.');		
	    			    }
	    			});
	        	}
	        		
	        }
	        
	        xhr.setRequestHeader('Authorization', 'Client-ID f64d4441566d507'); 
	        xhr.send(fd);
			
		},

		uploadImgur : function(file) {
			alert('aaa');
			
			if (!file || !file.type.match(/image.*/)){
	        	bootbox.alert("Debe seleccionar un archivo de imagen");
	        	return;
		    } 

	        var fd = new FormData();
	        fd.append("image", file); 
	        
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "https://api.imgur.com/3/image.json", false); 
	        xhr.onload = function() {

	        	var result = JSON.parse(xhr.responseText);
	        	console.log(result);
	        	var success = result.success;
	        	var statusCode = result.status;
	        	
	        	var imgurFileID = result.data.id;
	        	var deletehash = result.data.deletehash;
	        
	        	if(success && statusCode == '200'){
	        		var id = result.data.id;
//	             	window.location = 'https://imgur.com/gallery/' + id;
	        		fileController.saveFile(result.data, file.name, deletehash);
	             	
	        	}
	        }
	        xhr.setRequestHeader('Authorization', 'Client-ID f64d4441566d507'); 
	        xhr.send(fd);
	    
		},
		
		saveFile : function(file, filename, deletehash) {
			  
			var issueID = '';
			var fileData = JSON.stringify(file);
			  
			$.ajax({
			    url: './uploadFiles',
		 		type: 'POST',			
		 		dataType: 'json',	
		 		data: 'issueID=' + issueID + '&fileData=' + fileData + '&filename=' + filename,
		        success: function(data){	
		        	console.log(data);
		        	if(data.status){
		        		unBlockPage('html');
		        		console.log("--- db upload OK ---");
		        		
		        		setTimeout(function(){
		        			 location.reload();
		        		}, 700);
		        		
		        	}
		        	else{
		        		console.log("--- imgur upload ERROR ---");
		        		//delete imgur file
		        		fileController.deleteImage(deletehash);
		        		bootbox.alert('No se puedo guardar el archivo.');
		        	}
				},
				error: function (xhr) {
					console.log("--- ajax upload ERROR ---");
					fileController.deleteImage(deletehash);
			    	bootbox.alert('No se pudo guardar el archivo.');		
			    }
			});
				
	    },
		
		deleteImage : function(deleteHash) {
	    	var fd = new FormData();
	        var xhr = new XMLHttpRequest();
	        xhr.open("DELETE", "https://api.imgur.com/3/image/" + deleteHash);
	        xhr.onload = function() {
	        	console.log("--- imgur delete ---");
	        	console.log(JSON.parse(xhr.responseText).data);
	        }
	        xhr.setRequestHeader('Authorization', 'Client-ID f64d4441566d507');
	        xhr.send(fd);
		},
		
		deleteMultipleImages : function(images) {
			console.log("--- stating imgur delete ---");
			
			for(var i = 0; i < images.length ; i++){
				
				var fd = new FormData();
		        var xhr = new XMLHttpRequest();
		        xhr.open("DELETE", "https://api.imgur.com/3/image/" + images[i].deletehash);
		        xhr.onload = function() {
		        	console.log("--- imgur delete ---");
		        	console.log(JSON.parse(xhr.responseText).data);
		        }
		        xhr.setRequestHeader('Authorization', 'Client-ID f64d4441566d507');
		        xhr.send(fd);
				
			}
	    	
		}
		
		
		
		
		
}


 
