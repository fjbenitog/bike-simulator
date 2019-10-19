using Toybox.WatchUi;
using Toybox.Timer;
using ActivityValues;
using SoundAndVibration as SV;


class ActivityAlert {

	private var lastKm = 0;
	private var trackLenght;
	
	function initialize(trackLenght_){
		trackLenght = trackLenght_;
	}

    function checkAlert(show){
    	var currentKm = ActivityValues.distance().toLong();
    	if(currentKm - lastKm == 1 && currentKm<=trackLenght){
    		lastKm = currentKm;
    		if(show == true){
	    		SV.playAlert();
		    	WatchUi.pushView(new AlertView(), new AlertDelegate(), WatchUi.SLIDE_IMMEDIATE);
	    	}
	    	return true;
    	}
    	return false;

	}
	
	
	function lapAlert(lap,speedLap,distanceLap){
		SV.playLap();
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