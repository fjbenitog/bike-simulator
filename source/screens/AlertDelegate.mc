using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.ActivityRecording;
using Toybox.Timer;
using ActivityValues;
using Toybox.Sensor;
using Toybox.Lang;



class AlertDelegate extends WatchUi.BehaviorDelegate {
	
	function initialize() {
        BehaviorDelegate.initialize();
    }
    
	function onBack() {
        return true;
    }
    
}