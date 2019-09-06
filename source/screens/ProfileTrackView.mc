using Toybox.WatchUi;
using Toybox.ActivityRecording;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.Timer;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Activity;
using Toybox.Attention;

var session = null;
var activityTime = "00:00:00"; 
var activityDistance  = "0.00 Kms";
var activitySpeed = "0 Kms/h";
var activityRefreshTimer = null;

const ACTIVITY_NANE = "Bike Indoor Simulator";

class ProfileTrackView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	activityRefreshTimer = new Timer.Timer();
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

class ProfileTrackDelegate extends WatchUi.BehaviorDelegate {


 	function initialize() {
        BehaviorDelegate.initialize();
    }


	function onMenu() {

    }

    function onKey(evt) {
    }	
    
    function calculateActivityValues(){
    	caculateActivityTime();
    	var distance = Activity.getActivityInfo().elapsedDistance;
    	System.println("Distance:"+distance);
    	activityDistance = Lang.format( "$1$ Kms",
    		[
        		(distance/1000).format("%02.2f")
    		]
		);
    	var speed = Activity.getActivityInfo().currentSpeed;
    	System.println("Speed:"+speed);
    	activitySpeed = Lang.format( "$1$ Kms/h",
    		[
        		((3600*speed)/1000).format("%02d")
    		]
		);
    	WatchUi.requestUpdate();
    }
    
    function onSelect() {
		handleActivityRecording();
		return true;
	}
	
	function onBack() {
		System.println("OnBack");
		if(session!=null && session.isRecording()){
			return true;
		}else if(session!=null && !session.isRecording()){
			session.discard();// discard the session
    		session = null;                                      // set session control variable to null
    		activityTime = "00:00:00"; 
    		activityDistance  = "0.00 Kms";
			activitySpeed = "0 Kms/h";
    		WatchUi.requestUpdate();
    		return true;
		}
	}
    
    function caculateActivityTime(){
    	var milis = Activity.getActivityInfo().timerTime;
    	System.println("Timer:"+milis);
    	var activityMoment = new Time.Moment(milis/1000);

		var activityGregorian = Gregorian.info(activityMoment,Time.FORMAT_MEDIUM);
		activityTime = Lang.format(
    		"$1$:$2$:$3$",
    		[
        		activityGregorian.hour.format("%02d"),
        		activityGregorian.min.format("%02d"),
        		activityGregorian.sec.format("%02d"),
    		]
		);
    }
	
	function handleActivityRecording(){
		if (Toybox has :ActivityRecording) {                          // check device for activity recording
	       if (session == null) {
				activityRefreshTimer.start(method(:calculateActivityValues),1000,true); 
	           	session = ActivityRecording.createSession({          // set up recording session
	                 :name		=> 	ACTIVITY_NANE,                              // set session name
	                 :sport		=> 	ActivityRecording.SPORT_CYCLING,       // set sport type
	                 :subSport	=>	ActivityRecording.SUB_SPORT_INDOOR_CYCLING // set sub sport type
	           	});
	           	session.start();
	           	playStart();	                                              // call start session
	       }
	       else if ((session != null) && session.isRecording()) {
	           	session.stop();  
	           	activityRefreshTimer.stop();  
	           	calculateActivityValues(); 	          
	           	playStop();                                // stop the session
	       }else if((session != null) && !session.isRecording()){
	       		activityRefreshTimer.start(method(:calculateActivityValues),1000,true); 
	       		session.start();
	           	playStart();
	       }
	   }
	}


	
	function playTone(tone){
		if(Attention has :playTone){
			Attention.playTone(tone);
		}
	}
	
	function vibrate(){
		if (Attention has :vibrate) {
			var vibeData =
				[
					new Attention.VibeProfile(50, 500)
				];
			Attention.vibrate(vibeData);
		}	
	}
	
	function playStart(){
		playTone(Attention.TONE_START);
		vibrate();
	}
	
	function playStop(){
		playTone(Attention.TONE_STOP);
		vibrate();
	}
   
    
}