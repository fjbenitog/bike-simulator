using Toybox.WatchUi;
using Toybox.ActivityRecording;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.Timer;
using Toybox.Activity;
using Toybox.Attention;

var session = null;
var seconds = 0; 
var myTimer = null;

class ProfileTrackView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	myTimer = new Timer.Timer();
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
        
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_MEDIUM, seconds.format("%02d"), Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}

class ProfileTrackDelegate extends WatchUi.BehaviorDelegate {


 	function initialize() {
        BehaviorDelegate.initialize();
    }


	function onMenu() {

    }

    function onKey(evt) {
    }
    
    function calculateTime(){
    	seconds = Activity.getActivityInfo().timerTime/1000;
    	System.println("Activity Info - Time:"+seconds);
    	WatchUi.requestUpdate();
    }
    
	function onSelect() {
		
	   	if (Toybox has :ActivityRecording) {                          // check device for activity recording
	       if ((session == null) || (session.isRecording() == false)) {
	       		
				myTimer.start(method(:calculateTime),1000,true); 
				
	           session = ActivityRecording.createSession({          // set up recording session
	                 :name=>"Bike Indoor Simulator",                              // set session name
	                 :sport=>ActivityRecording.SPORT_CYCLING,       // set sport type
	                 :subSport=>ActivityRecording.SUB_SPORT_INDOOR_CYCLING // set sub sport type
	           });
	           session.start();
	           if(Attention has :playTone){
					Attention.playTone(Attention.TONE_START);
				}
				if (Attention has :vibrate) {
				    var vibeData =
				    [
				        new Attention.VibeProfile(50, 500), // On for two seconds
				    ];
				    Attention.vibrate(vibeData);
				}	                                              // call start session
	       }
	       else if ((session != null) && session.isRecording()) {

	           session.stop();                                      // stop the session
	           session.discard();// discard the session
	           myTimer.stop();                                      
	           session = null;                                      // set session control variable to null
	           	if(Attention has :playTone){
					Attention.playTone(Attention.TONE_STOP);
				}
				if (Attention has :vibrate) {
				    var vibeData =
				    [
				        new Attention.VibeProfile(50, 500), // On for two seconds
				    ];
				    Attention.vibrate(vibeData);
				}
	       }
	   }
	   return true;                                                 // return true for onSelect function
	}
	
	function onBack() {
		System.println("Back");
		if(session!=null && session.isRecording()){
			return true;
		}
	}
   
    
}