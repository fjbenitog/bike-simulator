using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.ActivityRecording;
using Toybox.Timer;
using ActivityValues;

class ScreenDelegate extends WatchUi.BehaviorDelegate {

	private const ACTIVITY_NANE = "Bike Indoor Simulator";
	
	var session;
	var index;
	var activityRefreshTimer;

	function initialize(index_) {
        BehaviorDelegate.initialize();
        index = index_;
        activityRefreshTimer = new Timer.Timer();
    }
    
    function onNextPage() {
        index = (index + 1) % 2;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_LEFT);
    }

    function onPreviousPage() {
        index = index - 1;
        if (index < 0) {
            index = 1;
        }
        index = index % 2;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_RIGHT);
    }
    
    function onKey(evt) {
        var key = evt.getKey();
        if (WatchUi.KEY_DOWN == key) {
            onNextPage();
        } else if (WatchUi.KEY_UP == key) {
            onPreviousPage();
        }
    }

    function getView(index) {
        var view;

        if (0 == index) {
            view = new ProfileTrackView();
        } else{
            view = new DataFieldsView();
        }

        return view;
    }

    function onSelect() {
		handleActivityRecording();
		return true;
	}
	
	function onBack() {
		if(session!=null && session.isRecording()){
			return true;
		}else if(session!=null && !session.isRecording()){
			session.discard();// discard the session
    		session = null; 
    		cleanValues();
    		return true;                                     // set session control variable to null
    	}
    	return false;
    }
    	
    function refreshValues(){
    	ActivityValues.calculateValues();
    	WatchUi.requestUpdate();
    }
    
    private function cleanValues(){
    	ActivityValues.cleanValues();
    	WatchUi.requestUpdate();
    }
    
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
					new Attention.VibeProfile(50, 250)
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