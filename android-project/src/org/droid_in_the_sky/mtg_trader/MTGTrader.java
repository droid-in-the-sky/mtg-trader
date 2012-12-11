package org.droid_in_the_sky.mtg_trader;

import org.libsdl.app.SDLActivity;
import android.os.*;

import android.view.WindowManager;
import android.content.pm.ActivityInfo;
import android.content.res.Configuration;

/*
 * A sample wrapper class that just calls SDLActivity
 */

public class MTGTrader extends SDLActivity {
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
    }
/*
    protected void onDestroy() {
        super.onDestroy();
        //android.os.Process.killProcess(android.os.Process.myPid());
    }
*/
    public void onConfigurationChanged (Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        android.os.Process.killProcess(android.os.Process.myPid());
        //setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
    }
}
