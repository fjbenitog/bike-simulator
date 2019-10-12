using Toybox.WatchUi;
using Toybox.Timer;
using ActivityValues;
using SoundAndVibration as SV;


class ActivityAlert {

	private var lastKm = 0;

    function checkAlert(){
    	var currentKm = ActivityValues.distance().toLong();
    	if(currentKm - lastKm == 1){
    		SV.playAlert();
    		lastKm = currentKm;
    		var timer = new Timer.Timer();
	    	timer.start(method(:removeAlertView),2000,false);
	    	WatchUi.pushView(new AlertView(), new AlertDelegate(), WatchUi.SLIDE_IMMEDIATE);
    	}

	}

	function removeAlertView(){
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
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