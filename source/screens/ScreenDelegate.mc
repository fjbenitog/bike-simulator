using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.ActivityRecording;
using Toybox.Timer;

class ScreenDelegate extends WatchUi.BehaviorDelegate {

	var session;
	var index;
	var activityRefreshTimer;

	function initialize(session_, index_) {
        BehaviorDelegate.initialize();
        session = session_;
        index = index_;
        refreshValues();
        activityRefreshTimer = new Timer.Timer();
        if(session!= null && session.isRecording()){
        	activityRefreshTimer.start(method(:refreshValues),1000,true);
        }
    }
    
    function onNextPage() {
        index = (index + 1) % 2;
        activityRefreshTimer.stop();
        WatchUi.switchToView(getView(index), getDelegate(index), WatchUi.SLIDE_LEFT);
    }

    function onPreviousPage() {
        index = index - 1;
        if (index < 0) {
            index = 1;
        }
        index = index % 2;
        activityRefreshTimer.stop();
        WatchUi.switchToView(getView(index), getDelegate(index), WatchUi.SLIDE_RIGHT);
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

    function getDelegate(index) {
        var delegate;

        if (0 == index) {
            delegate = new ProfileTrackDelegate(session,index);
        } else{
            delegate = new DataFieldsDelegate(session,index);
        }

        return delegate;
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
    	return false;
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