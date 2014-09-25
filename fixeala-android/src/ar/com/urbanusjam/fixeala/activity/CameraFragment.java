package ar.com.urbanusjam.fixeala.activity;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import android.content.Intent;
import android.hardware.SensorManager;
import android.location.LocationListener;
import android.net.Uri;
import android.widget.Toast;
import ar.com.urbansujam.fixeala.utils.urllauncher.ARchitectUrlLauncherCamActivity;
import ar.com.urbanusjam.android.R;

import com.wikitude.architect.ArchitectView.ArchitectUrlListener;
import com.wikitude.architect.ArchitectView.SensorAccuracyChangeListener;

public class CameraFragment extends AbstractArchitectCamFragmentV4 {
	
	/**
	 * last time the calibration toast was shown, this avoids too many toast shown when compass needs calibration
	 */
	private long lastCalibrationToastShownTimeMillis = System.currentTimeMillis();
	
//	@Override
//	public View onCreateView(LayoutInflater inflater, ViewGroup container,
//           Bundle savedInstanceState) {
//	 
//		View rootView = inflater.inflate(R.layout.activity_camera, container, false);
//		
//		return rootView;
//	}
	
	@Override
	public String getARchitectWorldPath() {
//		try {
//			final String decodedUrl = URLDecoder.decode(getActivity().getIntent().getExtras().getString(ARchitectUrlLauncherCamActivity.ARCHITECT_ACTIVITY_EXTRA_KEY_URL), "UTF-8");
//			return decodedUrl;
//		} catch (UnsupportedEncodingException e) {
//			Toast.makeText(this.getActivity(), "Unexpected Exception: " + e.getMessage(), Toast.LENGTH_LONG).show();
//			e.printStackTrace();
//		return "samples/3_Point$Of$Interest_1_Poi$At$Location/index.html";
//		return "samples/4_Obtain$Poi$Data_2_From$Local$Resource/index.html";
//		return "samples/4_Obtain$Poi$Data_3_From$Webservice/index.html";
		return "samples/5_Browsing$Pois_5_Native$Detail$Screen/index.html";
//			return null;
//		}
	}

	@Override
	public int getContentViewId() {
		return R.layout.activity_camera;
	}

	@Override
	public int getArchitectViewId() {
		return R.id.architectView;
	}
	
	@Override
	public String getWikitudeSDKLicenseKey() {
		return WikitudeSDKConstants.WIKITUDE_SDK_KEY;
	}
	

	@Override
	public SensorAccuracyChangeListener getSensorAccuracyListener() {
		return new SensorAccuracyChangeListener() {
			@Override
			public void onCompassAccuracyChanged( int accuracy ) {
				/* UNRELIABLE = 0, LOW = 1, MEDIUM = 2, HIGH = 3 */
				if ( accuracy < SensorManager.SENSOR_STATUS_ACCURACY_MEDIUM && getActivity() != null && !getActivity().isFinishing()  && System.currentTimeMillis() - CameraFragment.this.lastCalibrationToastShownTimeMillis > 5 * 1000) {
					Toast.makeText( getActivity(), R.string.compass_accuracy_low, Toast.LENGTH_LONG ).show();
				}
			}
		};
	}

	@Override
	public ArchitectUrlListener getUrlListener() {
		return new ArchitectUrlListener() {
			
			@Override
			// fetch e.g. document.location = "architectsdk://markerselected?id=1";
			public boolean urlWasInvoked(String uriString) {
				Uri invokedUri = Uri.parse(uriString);
				if ("markerselected".equalsIgnoreCase(invokedUri.getHost())) {
						Intent poiDetailIntent = new Intent(getActivity(), IssueDetailActivity.class);
						poiDetailIntent.putExtra(IssueDetailActivity.EXTRAS_KEY_POI_ID, String.valueOf(invokedUri.getQueryParameter("id")) );
						poiDetailIntent.putExtra(IssueDetailActivity.EXTRAS_KEY_POI_TITILE, String.valueOf(invokedUri.getQueryParameter("title")) );
						poiDetailIntent.putExtra(IssueDetailActivity.EXTRAS_KEY_POI_DESCR, String.valueOf(invokedUri.getQueryParameter("description")) );
						startActivity(poiDetailIntent);
						return true;
				}
				return false;
			}
		};
	}

	@Override
	public ILocationProvider getLocationProvider(final LocationListener locationListener) {
		return new LocationProvider(this.getActivity(), locationListener);
	}
	
}