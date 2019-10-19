using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;

class StopMenuDelegate extends WatchUi.MenuInputDelegate {

	var discard;
	var continu;
	var save;
	var clean;
	
    function initialize(discard_,continu_,save_,clean_) {
        MenuInputDelegate.initialize();
        discard = discard_;
		continu = continu_;
		save = save_;
        clean = clean_;
    }

    function onMenuItem(item) {
		if (item == :discard) {
			clean.invoke();
			WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
//           	record.discard();
			discard.invoke();
            savingProgress(WatchUi.loadResource(Rez.Strings.discarding));
        }else if(item == :continu){
//        	record.handle();
        	continu.invoke();
        	return true;
        }else if(item == :save){
        	clean.invoke();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
//        	record.save();
			save.invoke();
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
