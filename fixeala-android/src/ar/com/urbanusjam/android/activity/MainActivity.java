package ar.com.urbanusjam.android.activity;

import java.lang.reflect.Method;

import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.text.Html;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.method.LinkMovementMethod;
import android.text.util.Linkify;
import android.app.ActionBar.LayoutParams;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.ContextThemeWrapper;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.os.Build;
import ar.com.urbanusjam.android.R;

public class MainActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {        
        // Inflate the menu; this adds items to the action bar if it is present.
    	MenuInflater inflater = getMenuInflater();
    	inflater.inflate(R.menu.main_activity_actions, menu);
        return super.onCreateOptionsMenu(menu);
    }
    
    @Override
    public boolean onMenuOpened(int featureId, Menu menu)
    {
        if(featureId == Window.FEATURE_ACTION_BAR && menu != null){
            if(menu.getClass().getSimpleName().equals("MenuBuilder")){
                try{
                    Method m = menu.getClass().getDeclaredMethod(
                        "setOptionalIconsVisible", Boolean.TYPE);
                    m.setAccessible(true);
                    m.invoke(menu, true);
                }
                catch(NoSuchMethodException e){
//                    Log.e(TAG, "onMenuOpened", e);
                }
                catch(Exception e){
                    throw new RuntimeException(e);
                }
            }
        }
        return super.onMenuOpened(featureId, menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.

    	 // Handle presses on the action bar items
        switch (item.getItemId()) {
            case R.id.action_settings:
                showSettings();
                return true;
            case R.id.action_help:
            	showHelp();
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

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);
            return rootView;
        }
    }
    
   
    
    public void showSettings(){
    	Intent intent = new Intent(this, SettingsScreen.class);
    	startActivity(intent);
    }
    
    public void showHelp(){
    	Intent intent = new Intent(this, HelpScreen.class);
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
//    	new AlertDialog.Builder(this)
    	builder
    	.setTitle("Acerca de Fixeala")
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
