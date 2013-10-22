package ar.com.urbanusjam.services.mock;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

/**
 * TreeMap example code.
 */
public class MapUtil {
    public MapUtil() {
        super();
    }
 
    public static void main(String[] args) {
    	
    	
        
        
        //create an instance of TreeMap to Store Phone Number
       
        
        Map<String, Integer> testTreeMap=new HashMap<String, Integer>();
      testTreeMap.put("Sam", 6);
      testTreeMap.put("John", 8);
      testTreeMap.put("Sunny", 9);
      testTreeMap.put("Linda", 1);
      testTreeMap.put("Amit", 3);
      testTreeMap.put("Sheila", 0);
      testTreeMap.put("Lili", 44);

      System.out.println( MapUtil.sortByComparator(testTreeMap) );
        System.out.println( (sortByComparator(testTreeMap).entrySet()).iterator().next().getValue() );
        
     
        
//        Map<String, Integer> testTreeMap = new TreeMap<String, Integer>(Collections.reverseOrder());
// 
//        //Populate example map with values
//        testTreeMap.put("Sam", 6);
//        testTreeMap.put("John", 8);
//        testTreeMap.put("Sunny", 9);
//        testTreeMap.put("Linda", 1);
//        testTreeMap.put("Amit", 3);
//        testTreeMap.put("Sheila", 0);
//        testTreeMap.put("Lili", 44);
//        
//        Set<Map.Entry<String, Integer> >items = testTreeMap.entrySet();
//        Iterator<Map.Entry<String, Integer> > i = items.iterator();
//        while(i.hasNext()){
//        	System.out.println(i.next());
//        }
        
 
 
//        //headMap method usage
//        SortedMap headMapElements = ((TreeMap) testTreeMap).headMap("Linda") ;
//        System.out.println("Output of headMap method "); 
//        for (Map.Entry entry : headMapElements.entrySet()) {
//            System.out.println("Key = " + entry.getKey() + ", Value = " +
//                               entry.getValue());
//        }
// 
//        //tailMap method usage
//        SortedMap tailMapElements = ((TreeMap) testTreeMap).tailMap("Sheila") ;
//        System.out.println("Output of tailMap method "); 
//        for (Map.Entry entry : tailMapElements.entrySet()) {
//            System.out.println("Key = " + entry.getKey() + ", Value = " +
//                               entry.getValue());
//        }
// 
//        //subMap method usage
//        SortedMap subMapElements = ((TreeMap) testTreeMap).subMap("Amit","Sheila") ;
//        System.out.println("output of subMap method "); 
//        for (Map.Entry entry : subMapElements.entrySet()) {
//            System.out.println("Key = " + entry.getKey() + ", Value = " +
//                               entry.getValue());
//        }
 
    }
    
    public static Map<String,Integer> sortByComparator(Map<String,Integer> unsortMap) {

        List list = new LinkedList(unsortMap.entrySet());

        //sort list based on comparator
        Collections.sort(list, new Comparator() {
            public int compare(Object o1, Object o2) {
                return ((Comparable) ((Map.Entry) (o1)).getValue())
                        .compareTo(((Map.Entry) (o2)).getValue());
            }
        });

        //put sorted list into map again
        Map sortedMap = new LinkedHashMap();
        for (Iterator it = list.iterator(); it.hasNext();) {
            Map.Entry entry = (Map.Entry)it.next();
            sortedMap.put(entry.getKey(), entry.getValue());
        }
        return sortedMap;
    }   
}