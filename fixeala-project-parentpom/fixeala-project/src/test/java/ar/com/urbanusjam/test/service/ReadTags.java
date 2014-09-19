package ar.com.urbanusjam.test.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Arrays;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.jpa.dao.impl.TagDAOImpl;

public class ReadTags {
	
	
	
	private static Comparator<String> ALPHABETICAL_ORDER = new Comparator<String>() {
	    public int compare(String str1, String str2) {
	        int res = String.CASE_INSENSITIVE_ORDER.compare(str1, str2);
	        if (res == 0) {
	            res = str1.compareTo(str2);
	        }
	        return res;
	    }
	};

	
	
	 public static void main(String[] args) throws IOException {
		    // TODO code application logic here

		    // // read KeyWestTemp.txt
		 	TagDAO tagDAO = new TagDAOImpl();
		    // create token1
		    String token1 = "";

		    // for-each loop for calculating heat index of May - October

		    // create Scanner inFile1
		    Scanner inFile1 = new Scanner(new File("/Users/cora/Documents/fixeala.tags.txt")).useDelimiter("\n *");
		    
		    List<String> temps = new LinkedList<String>();

		    // while loop
		    while (inFile1.hasNext()) {
		      // find next line
		      token1 = inFile1.next();
		      temps.add(token1);
		    }
		    
		    inFile1.close();

		    String[] tempsArray = temps.toArray(new String[0]);
		    
		    Arrays.sort(tempsArray);
		    
		    StringBuilder builder = new StringBuilder();
		  
		    for (String tagname : tempsArray) {
		    	tagname = tagname.replaceAll("(\\r|\\n)", "");
		    	builder.append("INSERT INTO tag (tagname) VALUES ('" +tagname+ "');");
		    	builder.append("\n");
		      System.out.println(builder);
		    }
		    
//		    PrintStream out = new PrintStream(new FileOutputStream("D:\\fixeala.tags.sql"));
		    PrintStream out = new PrintStream(new FileOutputStream("/Users/cora/Documents/fixeala.tags.sql"));
		    out.print(builder);
		    
		    
		  }

}
