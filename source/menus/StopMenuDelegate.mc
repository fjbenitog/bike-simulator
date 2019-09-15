using Toybox.WatchUi;
using Toybox.System;

class StopMenuDelegate extends WatchUi.MenuInputDelegate {

	var screenDelegate;
	
    function initialize(screenDelegate_) {
        MenuInputDelegate.initialize();
        screenDelegate = screenDelegate_;
    }

    function onMenuItem(item) {
		if (item == :discard) {
		    screenDelegate.discard();
		
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }else if(item == :continu){
        	screenDelegate.handleActivityRecording();
        }else if(item == :save){
        	screenDelegate.save();
		
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
        
    }
}
