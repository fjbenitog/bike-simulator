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
        calculateActivityTime();
		calculateActivityDistance();
	    calculateActivitySpeed();
    }
    
    function cleanValues(){
	    ActivityValues.activityTime = new ActivityValues.ActivityTime(0,0,0);
		ActivityValues.activityDistance = 0;
		ActivityValues.activitySpeed = 0;
    
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
	
	function calculateActivityTime(){
    	var milis = Activity.getActivityInfo().timerTime;
    	System.println("Timer:"+milis);
		ActivityValues.activityTime = toHMS(milis/1000);
    }
    
    function calculateActivityDistance(){
    	var distance = Activity.getActivityInfo().elapsedDistance;
    	if(distance == null || distance<0){ 
    		distance = 0;
    	}
    	System.println("Distance:"+distance);
    	ActivityValues.activityDistance = distance/1000;
    }
    
    function calculateActivitySpeed(){
    	var speed = Activity.getActivityInfo().currentSpeed;
    	if(speed == null || speed < 0) {
    		speed = 0;
    	}
    	System.println("Speed:"+speed);
    	ActivityValues.activitySpeed = (3600*speed)/1000;
    }
    
    function toHMS(secs) {
		var hr = secs/3600;
		var min = (secs-(hr*3600))/60;
		var sec = secs%60;
		return new ActivityValues.ActivityTime(hr,min,sec);
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