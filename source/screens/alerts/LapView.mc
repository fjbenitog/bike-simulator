using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;
using Toybox.Timer;

class LapView extends WatchUi.View {
	
	var lapNumber;
	var speedLap;
	var distanceLap;
	private var alertTimer;
	
    function initialize(lapNumber_,speedLap_,distanceLap_) {
        View.initialize();
        lapNumber = lapNumber_;
        speedLap = speedLap_;
        distanceLap = distanceLap_;
    }

        // Load your resources here
    function onLayout(dc) {
    	alertTimer = new Timer.Timer();
    	alertTimer.start(method(:removeAlertView),2000,false);
    }
    
    function removeAlertView(){
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	}

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	WatchUi.View.onUpdate(dc);
    	var rowHeight= dc.getHeight()/ 8;
    	dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.Graphics.COLOR_TRANSPARENT);
    	dc.drawText(dc.getWidth()/2, rowHeight, Graphics.FONT_SYSTEM_NUMBER_MEDIUM,
    		 lapNumber, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.Graphics.COLOR_TRANSPARENT);
    	dc.drawText(dc.getWidth()/2, rowHeight*4, Graphics.FONT_SYSTEM_NUMBER_HOT,
    		 speedLap, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		 dc.drawText(dc.getWidth()/2, rowHeight*7, Graphics.FONT_SYSTEM_NUMBER_MEDIUM,
    		 distanceLap, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    	
    }
    
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	if(alertTimer!=null){
    		alertTimer.stop();
    	}
    }
    
}


