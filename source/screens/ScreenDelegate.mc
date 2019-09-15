using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.ActivityRecording;
using Toybox.Timer;
using ActivityValues;
using Toybox.Sensor;
using Toybox.Lang;

var startingActivity = false;
var stoppingActivity = false;

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

    private function getView(index) {
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
			pushStopMenu();
    		return true;                  
    	}
    	return false;

    }
    
    function discard(){
    	session.discard();// discard the session
    	session = null;
    	release();
    }
    
    function save(){
    	session.save();// save the session
    	session = null;
    	release();
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
	           	startingTimer();
	       }
	       else if ((session != null) && session.isRecording()) {
	       		stoppingTimer();
	       }else if((session != null) && !session.isRecording()){ 
	       		startingTimer();
	       }
	       refreshValues();
	   }
	}
	
	private function startingTimer(){
		startingActivity = true;
		fireTimer();
	    session.start();
	    playStart();
	}
	
	private function stoppingTimer(){
		stoppingActivity = true;
		fireTimer();
		fireStopMenu();
       	session.stop();  
       	playStop(); 
	}
	
	private function fireTimer(){
		var timer = new Timer.Timer();
	    timer.start(method(:cleanActivityValues),750,false);
	}
	
	private function fireStopMenu(){
		var timer = new Timer.Timer();
	    timer.start(method(:pushStopMenu),1500,false);
	}
	
	function cleanActivityValues(){
		startingActivity = false;
		stoppingActivity = false;
		refreshValues();
	}
	
	function pushStopMenu(){
		var stopMenu = new Rez.Menus.StopMenu();
		var title = Lang.format(WatchUi.loadResource(Rez.Strings.stopTitle),[ActivityValues.calculateTime(),ActivityValues.calculateDistance()]);
		stopMenu.setTitle(title);
		 WatchUi.pushView(stopMenu, new StopMenuDelegate(self), WatchUi.SLIDE_IMMEDIATE);
	}
    
    private function playingTone(tone){
		if(Attention has :playTone){
			Attention.playTone(tone);
		}
	}
	
	private function vibrating(){
		if (Attention has :vibrate) {
			var vibeData =
				[
					new Attention.VibeProfile(50, 250)
				];
			Attention.vibrate(vibeData);
		}	
	}
	
	private function playStart(){
		playingTone(Attention.TONE_START);
		vibrating();
	}
	
	private function playStop(){
		playingTone(Attention.TONE_STOP);
		vibrating();
	}
}