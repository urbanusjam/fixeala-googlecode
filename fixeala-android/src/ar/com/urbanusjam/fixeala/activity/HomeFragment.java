package ar.com.urbanusjam.fixeala.activity;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import ar.com.urbanusjam.android.R;

public class HomeFragment extends Fragment {
    
   public HomeFragment(){}
    
   @Override
   public View onCreateView(LayoutInflater inflater, ViewGroup container,
           Bundle savedInstanceState) {
 
       View rootView = inflater.inflate(R.layout.fragment_main, container, false);
         
       return rootView;
   }
}
