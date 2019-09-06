using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.ActivityRecording;
using Toybox.Timer;

class ScreenDelegate extends WatchUi.BehaviorDelegate {

	var session;
	var activityRefreshTimer;

	function initialize(session_) {
        BehaviorDelegate.initialize();
        session = session_;
        activityRefreshTimer = new Timer.Timer();
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
			cleanValues();
    		session = null; 
    		WatchUi.requestUpdate();
    		return true;                                     // set session control variable to null
    	}
    }
    	
    function refreshValues(){
    	calculateActivityValues();
    	WatchUi.requestUpdate();
    }
    
    function calculateActivityValues(){
    }
    
    function cleanValues(){}
    
    function handleActivityRecording(){
		if (Toybox has :ActivityRecording) {                          // check device for activity recording
	       if (session == null) {
	           	session = ActivityRecording.createSession({          // set up recording session
	                 :name		=> 	ACTIVITY_NANE,                              // set session name
	                 :sport		=> 	ActivityRecording.SPORT_CYCLING,       // set sport type
	                 :subSport	=>	ActivityRecording.SUB_SPORT_INDOOR_CYCLING // set sub sport type
	           	});
	           	activityRefreshTimer.start(method(:refreshValues),1000,true); 
	           	session.start();
	           	playStart();	                                              // call start session
	       }
	       else if ((session != null) && session.isRecording()) {
	           	session.stop();  
	           	playStop(); 
	           	activityRefreshTimer.stop();                                // stop the session
	       }else if((session != null) && !session.isRecording()){
	       		activityRefreshTimer.start(method(:refreshValues),1000,true); 
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