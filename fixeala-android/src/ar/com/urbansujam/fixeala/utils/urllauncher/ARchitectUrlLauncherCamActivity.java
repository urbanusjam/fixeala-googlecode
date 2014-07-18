package ar.com.urbansujam.fixeala.utils.urllauncher;

import android.graphics.Color;
import android.media.AudioManager;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTransaction;
import android.view.Window;
import android.view.WindowManager;
import ar.com.urbanusjam.android.R;
import ar.com.urbanusjam.fixeala.activity.CameraFragment;



/**
 * Demo Implementation of a fragment use of the Wikitude ARchitectView.
 *
 */
public class ARchitectUrlLauncherCamActivity extends FragmentActivity {
	
	public static final String ARCHITECT_ACTIVITY_EXTRA_KEY_URL = "url2load";

	@Override
	protected void onCreate( final Bundle icicle ) {
		super.onCreate( icicle );

		this.requestWindowFeature( Window.FEATURE_NO_TITLE );
		this.getWindow().setFlags( WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN );
		this.setVolumeControlStream( AudioManager.STREAM_MUSIC );

		this.setContentView( R.layout.activity_camera );

		this.findViewById( R.id.frame_container ).setBackgroundColor( Color.BLACK );
		
//		if ( icicle == null ) {
//			/* start transaction to set required fragments */
//			final FragmentTransaction fragmentTransaction = this.getSupportFragmentManager().beginTransaction();
//			fragmentTransaction.replace( R.id.mainFragment, new CameraFragment() );
//			/* commit transaction */
//			fragmentTransaction.commit();
//		}

	}
	

}