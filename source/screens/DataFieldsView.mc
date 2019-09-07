using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.Activity;

const ACTIVITY_NANE = "Bike Indoor Simulator";
var activityTime = "00:00:00"; 
var activityDistance  = "0.00 Kms";
var activitySpeed = "0 Kms/h";

class DataFieldsView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(dc.getWidth()/2, dc.getHeight()/4, Graphics.FONT_MEDIUM, activityTime, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_MEDIUM, activitySpeed, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth()/2, 3 * dc.getHeight()/4, Graphics.FONT_MEDIUM, activityDistance, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
}

class DataFieldsDelegate extends ScreenDelegate {

	function initialize(session_, index) {
        ScreenDelegate.initialize(session_, index);
    }
    
	function cleanValues(){
		activityTime = "00:00:00"; 
		activityDistance  = "0.00 Kms";
		activitySpeed = "0 Kms/h";
	}
    
    function calculateActivityValues(){
    	calculateActivityTime();
		calculateActivityDistance();
	    calculateActivitySpeed();
    }
    
    function calculateActivityTime(){
    	var milis = Activity.getActivityInfo().timerTime;
    	System.println("Timer:"+milis);
		activityTime = toHMS(milis/1000);
    }
    
    function calculateActivityDistance(){
    	var distance = Activity.getActivityInfo().elapsedDistance;
    	if(distance == null || distance<0){ 
    		distance = 0;
    	}
    	System.println("Distance:"+distance);
    	activityDistance = Lang.format( "$1$ Kms",
    		[
        		(distance/1000).toFloat().format("%02.2f")
    		]
		);
    }
    
    function calculateActivitySpeed(){
    	var speed = Activity.getActivityInfo().currentSpeed;
    	if(speed == null || speed < 0) {
    		speed = 0;
    	}
    	System.println("Speed:"+speed);
    	activitySpeed = Lang.format( "$1$ Kms/h",
    		[
        		((3600*speed)/1000).toNumber().format("%02d")
    		]
		);
    }
    
    function toHMS(secs) {
		var hr = secs/3600;
		var min = (secs-(hr*3600))/60;
		var sec = secs%60;
		return hr.format("%02d")+":"+min.format("%02d")+":"+sec.format("%02d");
	}
}

