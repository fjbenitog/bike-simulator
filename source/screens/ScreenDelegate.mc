using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.ActivityRecording;
using Toybox.Timer;
using ActivityValues;
using Toybox.Sensor;

protected var startingActivity = false;

class ScreenDelegate extends WatchUi.BehaviorDelegate {

	private const ACTIVITY_NANE = "Bike Indoor Simulator";
	
	private const numSreens = 3;
	
	var session;
	var index;
	var activityRefreshTimer;

	function initialize(index_) {
        BehaviorDelegate.initialize();
        index = index_;
        activityRefreshTimer = new Timer.Timer();
        activityRefreshTimer.start(method(:refreshValues),1000,true); 
        Sensor.setEnabledSensors(
        	[
        		Sensor.SENSOR_HEARTRATE,
        		Sensor.SENSOR_BIKESPEED,
        		Sensor.SENSOR_BIKECADENCE
        	]);
    }
    
    
    function onNextPage() {
        index = (index + 1) % numSreens;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_LEFT);
    }

    function onPreviousPage() {
        index = index - 1;
        if (index < 0) {
            index = numSreens-1;
        }
        index = index % numSreens;
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
        } else if(1 == index){
            view = new DataFieldsView1();
        }else {
        	view = new DataFieldsView2();
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
    		refreshValues();
    		return true;                  
    	}else{  	
    		release();
    		return false;
    	}

    }
    	
    function release(){
    	activityRefreshTimer.stop();
    	if(Sensor has :unregisterSensorDataListener){
			Sensor.unregisterSensorDataListener();
		}
    }
    
    function refreshValues(){
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
	           	startingActivity = true;
	           	session.start();
	           	playStart();	
	           	var startTimer = new Timer.Timer();
	           	startTimer.start(method(:cleanActivityValues),750,false);                                              // call start session
	       }
	       else if ((session != null) && session.isRecording()) {
	           	session.stop();  
	           	playStop();                                // stop the session
	       }else if((session != null) && !session.isRecording()){ 
	       		session.start();
	           	playStart();
	       }
	       refreshValues();
	   }
	}
	
	function cleanActivityValues(){
		startingActivity = false;
		System.println("Reset Activity Values");
		refreshValues();
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