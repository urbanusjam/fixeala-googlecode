package ar.com.urbanusjam.fixeala.activity;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;

import android.app.Fragment;
import android.app.FragmentManager;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.ActionBar;
import android.support.v4.app.ActionBarDrawerToggle;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.text.Html;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.method.LinkMovementMethod;
import android.text.util.Linkify;
import android.app.ActionBar.LayoutParams;
import android.app.AlertDialog;
import android.app.FragmentManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.os.Handler;
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
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.os.Build;
import ar.com.urbanusjam.android.R;
import ar.com.urbanusjam.fixeala.adapter.NavDrawerListAdapter;
import ar.com.urbanusjam.model.NavDrawerItem;

public class MainActivity extends ActionBarActivity {
	
	private DrawerLayout mDrawerLayout;
    private ListView mDrawerList;
    private ActionBarDrawerToggle mDrawerToggle;
 
    // nav drawer title
    private CharSequence mDrawerTitle;
 
    // used to store app title
    private CharSequence mTitle;
 
    // slide menu items
    private String[] navMenuTitles;
    private TypedArray navMenuIcons;
 
    private ArrayList<NavDrawerItem> navDrawerItems;
    private NavDrawerListAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
      
//        if (savedInstanceState == null) {
//            getSupportFragmentManager().beginTransaction()
//                    .add(R.id.container, new PlaceholderFragment())
//                    .commit();
//        }
        
        ///////////////////////////////////////////
        
        mTitle = mDrawerTitle = getTitle();
        
        // load slide menu items
        navMenuTitles = getResources().getStringArray(R.array.nav_drawer_items);
 
        // nav drawer icons from resources
        navMenuIcons = getResources()
                .obtainTypedArray(R.array.nav_drawer_icons);
 
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        mDrawerList = (ListView) findViewById(R.id.list_slidermenu);
 
        navDrawerItems = new ArrayList<NavDrawerItem>();
 
        // adding nav drawer items to array
      
        navDrawerItems.add(new NavDrawerItem(navMenuTitles[0], navMenuIcons.getResourceId(0, -1)));
        // Settings
        navDrawerItems.add(new NavDrawerItem(navMenuTitles[1], navMenuIcons.getResourceId(1, -1)));
        // Help
        navDrawerItems.add(new NavDrawerItem(navMenuTitles[2], navMenuIcons.getResourceId(2, -1)));
        // About
        navDrawerItems.add(new NavDrawerItem(navMenuTitles[3], navMenuIcons.getResourceId(3, -1)));
        // Exit
        navDrawerItems.add(new NavDrawerItem(navMenuTitles[4], navMenuIcons.getResourceId(4, -1)));        
        // Exit
        navDrawerItems.add(new NavDrawerItem(navMenuTitles[5], navMenuIcons.getResourceId(5, -1)));
 
        // Recycle the typed array
        navMenuIcons.recycle();
 
        mDrawerList.setOnItemClickListener(new SlideMenuClickListener());
 
        // setting the nav drawer list adapter
        adapter = new NavDrawerListAdapter(getApplicationContext(),
                navDrawerItems);
        mDrawerList.setAdapter(adapter);
 
        // enabling action bar app icon and behaving it as toggle button
        getActionBar().setDisplayHomeAsUpEnabled(true);
//        getActionBar().setHomeButtonEnabled(true);
 
        mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout,
                R.drawable.ic_navigation_drawer, //nav menu toggle icon
                R.string.app_name, // nav drawer open - description for accessibility
                R.string.app_name // nav drawer close - description for accessibility
        ) {
            public void onDrawerClosed(View view) {
                getActionBar().setTitle(mTitle);
                // calling onPrepareOptionsMenu() to show action bar icons
                invalidateOptionsMenu();
            }
 
            public void onDrawerOpened(View drawerView) {
            	
//            	String customTitle = (String) (mTitle.equals("Inicio") ? "Fixeala" : mTitle); 
            	
                getActionBar().setTitle(mDrawerTitle);
                // calling onPrepareOptionsMenu() to hide action bar icons
//                invalidateOptionsMenu();
            }
        };
        mDrawerLayout.setDrawerListener(mDrawerToggle);
 
        if (savedInstanceState == null) {
            // on first time display view for first nav item
            displayView(0);          
        }
        
        
    }
    
    /**
     * Slide menu item click listener
     * */
    private class SlideMenuClickListener implements
            ListView.OnItemClickListener {
        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position,
                long id) {
            // display view for selected nav drawer item	        	
            displayView(position);        
        }
    }
    
  
 
    /***
     * Called when invalidateOptionsMenu() is triggered
     */
    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        // if nav drawer is opened, hide the action items
        boolean drawerOpen = mDrawerLayout.isDrawerOpen(mDrawerList);
        menu.findItem(R.id.action_map).setVisible(!drawerOpen);
        return super.onPrepareOptionsMenu(menu); 
    }
    
    @Override
    public void setTitle(CharSequence title) {
        mTitle = title;
        getActionBar().setTitle(mTitle);
    }
 
    /**
     * When using the ActionBarDrawerToggle, you must call it during
     * onPostCreate() and onConfigurationChanged()...
     */
 
    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        // Sync the toggle state after onRestoreInstanceState has occurred.
        mDrawerToggle.syncState();
    }
 
    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        // Pass any configuration change to the drawer toggls
        mDrawerToggle.onConfigurationChanged(newConfig);
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
    
    /**
     * Diplaying fragment view for selected nav drawer list item
     * */
    private void displayView(final int position) {
    	
        // update the main content by replacing fragments
        Fragment fragment = null;
        switch (position) {
       
        
        case 0:
            fragment = new HomeFragment();
            break;
        case 1:
//        	  fragment = new CameraFragment();
        	mDrawerLayout.closeDrawer(mDrawerList);
        	

        	 
          	final FragmentTransaction fragmentTransaction = this.getSupportFragmentManager().beginTransaction();
               
               new Handler().postDelayed(new Runnable() {
                   @Override
                   public void run() {
//                       Fragment fragment = new CameraFragment();
//                       Bundle args = new Bundle();
//                       args.putInt(1, position);
//                       fragment.setArguments(args);

                 
         			fragmentTransaction.replace( R.id.frame_container, new CameraFragment() );
         			fragmentTransaction.commit();
                       // update selected item and title, then close the drawer
                       mDrawerList.setItemChecked(position, true);
                       mDrawerList.setSelection(position);

                       setTitle(navMenuTitles[position]);
                   }
               }, 200);
               
        
// 			final FragmentTransaction fragmentTransaction = this.getSupportFragmentManager().beginTransaction();
// 			fragmentTransaction.replace( R.id.frame_container, new CameraFragment() );
// 			/* commit transaction */
// 			fragmentTransaction.commit();
 		

        
			break;
        case 2:
            fragment = new SettingsFragment();
            break;
        case 3:
            fragment = new HelpFragment();
            break;
        case 4:       
	        showAbout(getApplicationContext());
	        break;
	    case 5:
	        quitApp();
	        break;
        default:
            break;
        }
        
        if (fragment != null ) {
            FragmentManager fragmentManager = getFragmentManager();
            fragmentManager.beginTransaction()
                    .replace(R.id.frame_container, fragment).commit();
 
            // update selected item and title, then close the drawer
            mDrawerList.setItemChecked(position, true);
            mDrawerList.setSelection(position);
            
//            String customTitle = (String) (navMenuTitles[position].equals("Inicio") ? "Fixeala" : navMenuTitles[position]);
            
            setTitle(navMenuTitles[position]);
            mDrawerLayout.closeDrawer(mDrawerList);
        } 
//            else {
//            // error in creating fragment
//            Log.e("MainActivity", "Error in creating fragment");
//        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.

    	 // Handle presses on the action bar items

        
     // toggle nav drawer on selecting action bar app icon/title
        if (mDrawerToggle.onOptionsItemSelected(item)) {
            return true;
        }
        // Handle action bar actions click
      switch (item.getItemId()) {
	
//	      case R.id.action_help:
//	      	showHelp();
//	          return true;
//	      case R.id.action_about:
//	          showAbout(getApplicationContext());
//	          return true;
//	      case R.id.action_map:
//	          quitApp();
//	          return true;
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
    
   public void showCamera(){
		Intent intent = new Intent(this, CameraActivity.class);
    	startActivity(intent);
   }
    
    public void showSettings(){
    	Intent intent = new Intent(this, SettingsActivity.class);
    	startActivity(intent);
    }
    
    public void showHelp(){
    	Intent intent = new Intent(this, HelpActivity.class);
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
