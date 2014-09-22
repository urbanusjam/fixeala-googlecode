package ar.com.urbanusjam.fixeala.activity;

import android.content.Intent;
import android.os.Bundle;
import android.preference.PreferenceActivity;
import android.support.v4.app.NavUtils;
import android.view.MenuItem;

public class SettingsActivity extends PreferenceActivity {
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Display the fragment as the main content.
        getFragmentManager().beginTransaction()
                .replace(android.R.id.content, new SettingsFragment())
                .commit();
    }
	
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// go to previous screen when app icon in action bar is clicked
			//add this code for each activity X that needs to go to the main activity
		Intent intent = NavUtils.getParentActivityIntent(this); 
		intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP|Intent.FLAG_ACTIVITY_SINGLE_TOP); 
		NavUtils.navigateUpTo(this, intent);
		return true;
	}
	
	

}
