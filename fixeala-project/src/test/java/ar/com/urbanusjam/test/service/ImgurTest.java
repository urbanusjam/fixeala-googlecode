/**package ar.com.urbanusjam.test.service;

import java.util.Scanner;

import org.scribe.builder.ServiceBuilder;
import org.scribe.builder.api.ImgUrApi;
import org.scribe.model.OAuthRequest;
import org.scribe.model.Request;
import org.scribe.model.Response;
import org.scribe.model.Token;
import org.scribe.model.Verb;
import org.scribe.model.Verifier;
import org.scribe.oauth.OAuthService;



public class ImgurTest {
	
	private static final String PROTECTED_RESOURCE_URL = "https://api.imgur.com/3/account.json";
	
	

	
	private static void uploadImage(){
		
		String API_KEY = "f64d4441566d507";
		String API_SECRET = "f7e46de533ccf94b3456928a3a97f40cb2ede343";
		
		// Replace these with your own api key and secret (you'll need an read/write api key)
	   
	    OAuthService service = new ServiceBuilder().provider(ImgUrApi.class).apiKey(API_KEY).apiSecret(API_SECRET).build();
	    Scanner in = new Scanner(System.in);

	    System.out.println("=== ImgUr's OAuth Workflow ===");
	    System.out.println();

	    // Obtain the Request Token
	    System.out.println("Fetching the Request Token...");
	    
	    Token requestToken = service.getRequestToken();
	    System.out.println("Got the Request Token!");
	    System.out.println();

	    System.out.println("Now go and authorize Scribe here:");
	    String authorizationUrl = service.getAuthorizationUrl(requestToken);
	    System.out.println(authorizationUrl);
	    System.out.println("And paste the verifier here");
	    System.out.print(">>");
	    Verifier verifier = new Verifier(in.nextLine());
	    System.out.println();

	    // Trade the Request Token and Verfier for the Access Token
	    System.out.println("Trading the Request Token for an Access Token...");
	    Token accessToken = service.getAccessToken(requestToken, verifier);
	    System.out.println("Got the Access Token!");
	    System.out.println("(if your curious it looks like this: " + accessToken + " )");
	    System.out.println();

	    // Now let's go and ask for a protected resource!
	    System.out.println("Now we're going to access a protected resource...");
	    OAuthRequest request = new OAuthRequest(Verb.GET, PROTECTED_RESOURCE_URL);
	    service.signRequest(accessToken, request);
	    Response response = request.send();
	    System.out.println("Got it! Lets see what we found...");
	    System.out.println();
	    System.out.println(response.getBody());

	    System.out.println();
	    System.out.println("Thats it man! Go and build something awesome with Scribe! :)");
	    
	}
	
	public static void main(String[] args){
		
		uploadImage();
	}
	
	
}
**/