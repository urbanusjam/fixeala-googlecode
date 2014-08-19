$(function() {
	 
	  var clientId = 'f64d4441566d507';
//	  var token = '63dd097afcc618396f50690d5b331a4bca28b9c6';

		 var extractToken = function(hash) {
          var match = hash.match(/access_token=(\w+)/);
          return !!match && match[1];
        };
 
       
        var $post = $('.post');
        var $msg = $('.hidden');
        var $img = $('img');
 
        $post.click(function() {
          localStorage.doUpload = true;
          localStorage.imageBase64 = $img.attr('src').replace(/.*,/, '');
        });
 
         var token = extractToken(document.location.hash);

        
         if (token && JSON.parse(localStorage.doUpload)) {
     
          localStorage.doUpload = false;
          $post.hide();
          $msg.show();
 
          $.ajax({
            url: 'https://api.imgur.com/3/image',
            method: 'POST',
            headers: {
              Authorization: 'Bearer ' + '63dd097afcc618396f50690d5b331a4bca28b9c6',
              Accept: 'application/json'
            },
            data: {
              image: localStorage.imageBase64,
              type: 'base64'
            },
            success: function(result) {
              var id = result.data.id;
              window.location = 'https://imgur.com/gallery/' + id;
            }
          });
        }


	});