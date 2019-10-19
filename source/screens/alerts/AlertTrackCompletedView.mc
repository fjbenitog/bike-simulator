using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;
using Toybox.Timer;


class AlertTrackCompletedView extends WatchUi.View {
	
	private var alertTimer;
	private var action;
	
    function initialize(action_) {
        View.initialize();
        action = action_;
    }

    // Load your resources here
    function onLayout(dc) {
    	alertTimer = new Timer.Timer();
    	alertTimer.start(method(:removeAlertView),4000,false);
    }
    
    function removeAlertView(){
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		action.invoke();
	}

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	WatchUi.View.onUpdate(dc);
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
		dc.clear();
    	var heightFont = Graphics.getFontHeight(Graphics.FONT_SYSTEM_MEDIUM);
		var heightNumberFont = Graphics.getFontHeight(Graphics.FONT_NUMBER_MEDIUM);
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.Graphics.COLOR_TRANSPARENT);
    	dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_SYSTEM_LARGE,
    		 WatchUi.loadResource(Rez.Strings.trackCompleted), Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    		 
 
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


