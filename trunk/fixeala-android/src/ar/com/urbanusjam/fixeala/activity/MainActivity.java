package ar.com.urbanusjam.fixeala.activity;

import android.app.AlertDialog;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.text.Html;
import android.text.util.Linkify;
import android.view.ContextThemeWrapper;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.TextView;
import ar.com.urbanusjam.android.R;

public class MainActivity extends ActionBarActivity {
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
        	 // enabling action bar app icon and behaving it as toggle button
//            getActionBar().setDisplayHomeAsUpEnabled(true);
            
            getSupportActionBar().setHomeButtonEnabled(false);

        	// Create new fragment and transaction
        	 // Create new fragment and transaction
            Fragment cFragment = new CameraFragment();
            FragmentTransaction transaction = getFragmentManager().beginTransaction();

            // Replace whatever is in the fragment_container view with this fragment,
            // and add the transaction to the back stack
            transaction.add(R.id.fragment_container, cFragment);
            // Add this transaction to the back stack
            transaction.addToBackStack("cFragment");
            // Commit the transaction
            transaction.commit();
           
            
        }
        
    }
    
    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
    }
 
    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
    }

    /*** action bar ***/
    
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu items for use in the action bar
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main_activity_actions, menu);
        return super.onCreateOptionsMenu(menu);
    }
   
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
    	
    	// Handle presses on the action bar items
        switch (item.getItemId()) {
            case R.id.action_settings:
                showSettings();
                return true;
            case R.id.action_about:
                showAbout(getApplicationContext());
                return true;
            case R.id.action_quit:
            	quitApp();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
     
    }
    
    @Override
    public void onBackPressed() {
    	quitApp();
    	
    }
    
    public void showSettings(){
    	Intent intent = new Intent(this, SettingsActivity.class);
    	startActivity(intent);
    }
    
    public void showAbout(Context context){
        
    	final int PADDING = 30;
    	TextView emailLink = new TextView(MainActivity.this);
        emailLink.setAutoLinkMask(Linkify.ALL);
    	emailLink.setText(Html.fromHtml("Aplicaci&oacute;n desarrollada por <br><b>Cora Reyes Calens</b><br>para<br><b>URBANUS JAM!</b><br><br>www.fixeala.com.ar <br><br>Contacto: <br>coripel@gmail.com <br>urbanusjam@gmail.com <br><br>Copyright &copy; 2014"));
    	emailLink.setTextSize(18);
    	emailLink.setGravity(Gravity.CENTER);
    	emailLink.setIncludeFontPadding(true);
    	emailLink.setPadding(PADDING, PADDING, PADDING, PADDING);

    	AlertDialog.Builder builder = new AlertDialog.Builder(new ContextThemeWrapper(this, R.style.AlertDialogCustom));
    	
    	builder.setTitle("Acerca de Fixeala")
	        	.setView(emailLink)
	        	.setCancelable(false)      
	        	.setNegativeButton("Cerrar", null)
	        	.show();
    }
    
    public void quitApp(){
    	new AlertDialog.Builder(this)
        .setMessage(Html.fromHtml("&iquest;Desea cerrar la aplicaci&oacute;n?"))
        .setCancelable(false)
        .setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
                 MainActivity.this.finish();
            }
        })
        .setNegativeButton("Cancelar", null)
        .show();
    }

}
