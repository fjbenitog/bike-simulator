using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;

class StopMenuDelegate extends WatchUi.MenuInputDelegate {

	var record;
	
    function initialize(record_) {
        MenuInputDelegate.initialize();
        record = record_;
    }

    function onMenuItem(item) {
		if (item == :discard) {
			WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
           	record.discard();
            savingProgress(WatchUi.loadResource(Rez.Strings.discarding));
        }else if(item == :continu){
        	record.handle();
        	return true;
        }else if(item == :save){
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        	record.save();
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
