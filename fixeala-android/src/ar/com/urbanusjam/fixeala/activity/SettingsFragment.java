package ar.com.urbanusjam.fixeala.activity;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import ar.com.urbanusjam.android.R;

public class SettingsFragment extends Fragment {
    
   public SettingsFragment(){}
    
   @Override
   public View onCreateView(LayoutInflater inflater, ViewGroup container,
           Bundle savedInstanceState) {
 
       View rootView = inflater.inflate(R.layout.fragment_settings, container, false);
         
       return rootView;
   }
}
