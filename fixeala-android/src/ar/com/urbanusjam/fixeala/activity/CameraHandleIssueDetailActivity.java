package ar.com.urbanusjam.fixeala.activity;

import android.content.Intent;
import android.net.Uri;

import com.wikitude.architect.ArchitectView.ArchitectUrlListener;

public class CameraHandleIssueDetailActivity extends CameraActivity{
	
	@Override
	public ArchitectUrlListener getUrlListener() {
		return new ArchitectUrlListener() {
			
			@Override
			// fetch e.g. document.location = "architectsdk://markerselected?id=1";
			public boolean urlWasInvoked(String uriString) {
				Uri invokedUri = Uri.parse(uriString);
				if ("markerselected".equalsIgnoreCase(invokedUri.getHost())) {
						final Intent poiDetailIntent = new Intent(CameraHandleIssueDetailActivity.this, IssueDetailActivity.class);
						poiDetailIntent.putExtra(IssueDetailActivity.EXTRAS_KEY_POI_ID, String.valueOf(invokedUri.getQueryParameter("id")) );
						poiDetailIntent.putExtra(IssueDetailActivity.EXTRAS_KEY_POI_TITILE, String.valueOf(invokedUri.getQueryParameter("title")) );
						poiDetailIntent.putExtra(IssueDetailActivity.EXTRAS_KEY_POI_DESCR, String.valueOf(invokedUri.getQueryParameter("description")) );
						CameraHandleIssueDetailActivity.this.startActivity(poiDetailIntent);
						return true;
				}
				return false;
			}
		};
	}

}
