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
			WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
           	screenDelegate.discard();
            savingProgress(WatchUi.loadResource(Rez.Strings.discarding));
        }else if(item == :continu){
        	screenDelegate.handleActivityRecording();
        	return true;
        }else if(item == :save){
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        	screenDelegate.save();
        	savingProgress(WatchUi.loadResource(Rez.Strings.saving));
        }
        return false;
        
    }
    
    function savingProgress(message){
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    	var progressBar = new WatchUi.ProgressBar(
            message,
            null
        );
        WatchUi.pushView(
            progressBar,
            null,
            WatchUi.SLIDE_IMMEDIATE
        );
        
        var timer = new Timer.Timer();
	    timer.start(method(:backMainMenu),3000,false);
    }
    
    function backMainMenu(){
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
