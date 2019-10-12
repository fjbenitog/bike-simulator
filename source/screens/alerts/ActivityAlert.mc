using Toybox.WatchUi;
using Toybox.Timer;
using ActivityValues;
using SoundAndVibration as SV;


class ActivityAlert {

	private var lastKm = 0;
	private var alertTimer;
	private var trackLenght;
	
	function initialize(trackLenght_){
		trackLenght = trackLenght_;
	}
	
	function removeAlertView(){
		alertTimer = null;
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	}

    function checkAlert(){
    	var currentKm = ActivityValues.distance().toLong();
    	if(currentKm - lastKm == 1 && currentKm<=trackLenght){
    		SV.playAlert();
    		lastKm = currentKm;
    		if(alertTimer!=null){
    			alertTimer.stop();
    			removeAlertView();
    		}
    		alertTimer = new Timer.Timer();
	    	alertTimer.start(method(:removeAlertView),2000,false);
	    	WatchUi.pushView(new AlertView(), new AlertDelegate(), WatchUi.SLIDE_IMMEDIATE);
    	}

	}
	
	
	function lapAlert(lap,speedLap,distanceLap){
		SV.playLap();
		if(alertTimer!=null){
			removeAlertView();
			alertTimer.stop();
    	}
		alertTimer = new Timer.Timer();
    	alertTimer.start(method(:removeAlertView),2000,false);
    	WatchUi.pushView(new LapView(lap,speedLap,distanceLap), new AlertDelegate(), WatchUi.SLIDE_IMMEDIATE);
	}


}

class AlertDelegate extends WatchUi.BehaviorDelegate {
	
	function initialize() {
        BehaviorDelegate.initialize();
    }
    
	function onBack() {
        return true;
    }
    
}