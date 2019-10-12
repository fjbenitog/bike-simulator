using SoundAndVibration as SV;
using Toybox.Timer;


module Activity{

	var starting = 0;
	var stopping = 0;
	
	class Record{
		var activityRefreshTimer;
		var session;
		var levelField;
	   	var trackField;
	   	var percentageField;
	   	var activityAlert = new ActivityAlert();
	   	
	   	var lapNumber = 0;
	   	var lastDistance = 0;
	   	var lastTime = 0;
	   	var stopTimer = null;
	   	
	   	private const LEVEL_FIELD_ID = 0;
		private const TRACK_FIELD_ID = 1;
		private const PERCENTAGE_FIELD_ID = 2;
		private const ACTIVITY_NANE = "Bike Indoor Simulator";
		
		function initialize(){
		    activityRefreshTimer = new Timer.Timer();
        	activityRefreshTimer.start(method(:refreshValues),1000,true); 
			Sensor.setEnabledSensors(
	        	[
	        		Sensor.SENSOR_HEARTRATE,
	        		Sensor.SENSOR_BIKESPEED,
	        		Sensor.SENSOR_BIKECADENCE,
	        	]);
		}
		
		function handle(){
			if (Toybox has :ActivityRecording ) {                          // check device for activity recording
		       if (session == null) {
		           	session = ActivityRecording.createSession({          // set up recording session
		                 :name		=> 	ACTIVITY_NANE,                              // set session name
		                 :sport		=> 	ActivityRecording.SPORT_CYCLING,       // set sport type
		                 :subSport	=>	ActivityRecording.SUB_SPORT_INDOOR_CYCLING // set sub sport type
		           	});
	    		levelField = session.createField("level",LEVEL_FIELD_ID,FitContributor.DATA_TYPE_STRING,
	    				{ :mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"",:count => 2 });	
	       		trackField = session.createField("track",TRACK_FIELD_ID,FitContributor.DATA_TYPE_STRING, 
	       				{ :mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"",:count => 24 });
	       		percentageField = session.createField("percentage",PERCENTAGE_FIELD_ID,FitContributor.DATA_TYPE_SINT32, 
	       				{ :mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"%" });
	          	startingTimer();
		       }
		       else if (isRecording()) {
		       		stoppingTimer();
		       }else if(!isRecording() ){ 
		       		startingTimer();
		       }
		       refreshValues();
		   }
		}
		
		function isRecording(){
			return session!=null && session.isRecording();
		}
		
		function isSessionStart(){
			var start = session!=null;
			return start;
		}
		
		function release(){
			activityRefreshTimer.stop();
	    	if(Sensor has :unregisterSensorDataListener){
				Sensor.unregisterSensorDataListener();
			}
    	}
    	
    	function discard(){
	    	var result = false;
	    	if(session!=null){
	    		session.discard();// discard the session
	    	}
	    	session = null;
	    	release();
	    	return result;
	    }
    
	    function save(){
			var level = Properties.level().format("%u");
			levelField.setData(level);
			trackField.setData(DataTracks.getActiveTrack().name);
	    	var result = session.save();// save the session
	    	session = null;
	    	release();
	    	return result;
	    }
	    
	    function lap(){
	    	if(isSessionStart()){
	    		session.addLap();
	    		var totalDistance = ActivityValues.distance();
	    		var totalTime = ActivityValues.time();
	    		var distanceLap = totalDistance - lastDistance;
	    		var timeLap = 3600*(totalTime/1000) - lastTime;
//	    		System.println("Distance Total:"+totalDistance);
//	    		System.println("Distance Lap:"+distanceLap);
//	    		System.println("Time Lap:"+timeLap);
	    		
	    		var speedLap = distanceLap/timeLap;
//    			System.println("speedLap Lap:"+speedLap);
	    		lapNumber++;
	    		lastDistance = totalDistance;
	    		lastTime = totalTime;
	    		activityAlert.lapAlert(lapNumber,ActivityValues.printSpeed(speedLap),ActivityValues.printDistance(distanceLap));
	    	}
	    }
	    
	    private function calculateSpeed(){
	    }
	    
	    function refreshValues(){
    		try {
				activityAlert.checkAlert();	
				if(percentageField!=null){
					percentageField.setData(ActivityValues.percentage());
				}
				WatchUi.requestUpdate();
			} catch (e instanceof Lang.Exception) {
				WatchUi.requestUpdate();
			}
	    	
    	}
    	
	    
		 private function startingTimer(){
		 	stopping = 0;
			starting = 2;
		    session.start();
		    SV.playStart();
		}
		
		private function stoppingTimer(){
			starting = 0;
			stopping = 2;
			fireStopMenu();
	       	session.stop();  
	       	SV.playStop(); 
		}
		
		private function fireStopMenu(){
			if(stopTimer!=null){
				stopTimer.stop();
			}
			stopTimer = new Timer.Timer();
		    stopTimer.start(method(:pushStopMenu),1500,false);
		}
		
		function pushStopMenu(){
			if(!isRecording()){
				var stopMenu = new Rez.Menus.StopMenu();
				var title = ActivityValues.calculateShortTime()+" - "+ActivityValues.calculateDistance();
				stopMenu.setTitle(title);
				WatchUi.pushView(stopMenu, new StopMenuDelegate(self), WatchUi.SLIDE_IMMEDIATE);
			 }
		}
	}
	
	
}