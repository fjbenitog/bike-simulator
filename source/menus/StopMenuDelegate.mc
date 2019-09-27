using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;

class StopMenuDelegate extends WatchUi.MenuInputDelegate {

	var screenDelegate;
	
    function initialize(screenDelegate_) {
        MenuInputDelegate.initialize();
        screenDelegate = screenDelegate_;
    }

    function onMenuItem(item) {
		if (item == :discard) {
            savingProgress("Descartando");
            screenDelegate.discard();
        }else if(item == :continu){
        	screenDelegate.handleActivityRecording();
        }else if(item == :save){
        	savingProgress("Guardando");
        	screenDelegate.save();
        }
        
    }
    
    function savingProgress(message){
    	var progressBar = new WatchUi.ProgressBar(
            message,
            null
        );
        WatchUi.pushView(
            progressBar,
            null,
            WatchUi.SLIDE_DOWN
        );
        
        var timer = new Timer.Timer();
	    timer.start(method(:backMainMenu),1000,false);
    }
    
    function backMainMenu(){
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
