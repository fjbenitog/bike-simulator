using Toybox.WatchUi;
using Toybox.System;

class BikeSimulatorDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }


	function onMenu() {
        return startApp();
    }

    function onKey(evt) {
        var key = evt.getKey();
        if (WatchUi.KEY_START == key || WatchUi.KEY_ENTER == key) {
            return onSelect();
        }
        return false;
    }
    
    function onSelect() {
        return startApp();
    }
   
    
    function startApp(){
		WatchUi.pushView(new TrackPicker(), new TrackPickerDelegate(), WatchUi.SLIDE_LEFT);
		return true;
    }

}