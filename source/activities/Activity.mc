using SoundAndVibration as SV;
using Toybox.Timer;


module Activity{

	var heartRateActive 	= false;
	var bikeSpeedActive		= false;
	var bikeCadenceActive 	= false;
	
	class Record{
//		var activityRefreshTimer;
		var session;
		var levelField;
	   	var trackField;
	   	var percentageField;
	   	var altitudeField;
//	   	var activityAlert = new ActivityAlert(DataTracks.getActiveTrack().profile.size());
	   	
	   	var lapNumber = 0;
	   	var stopTimer = null;
	   	var lastAltitude;
//   		var zoomMode = false;
	   	
	   	private const LEVEL_FIELD_ID = 0;
		private const TRACK_FIELD_ID = 1;
		private const PERCENTAGE_FIELD_ID = 2;
		private const ALTITUDE_FIELD_ID = 3;
		private const ACTIVITY_NANE = "Bike Indoor Simulator";
		
		function initialize(){
//		    activityRefreshTimer = new Timer.Timer();
//        	activityRefreshTimer.start(method(:refreshValues),1000,true); 
			Sensor.setEnabledSensors(
	        	[
	        		Sensor.SENSOR_HEARTRATE,
	        		Sensor.SENSOR_BIKESPEED,
	        		Sensor.SENSOR_BIKECADENCE,
	        	]);
	        Sensor.enableSensorEvents(method(:onSensor));
		}
		
		function onSensor(sensorInfo) {
	    	if(sensorInfo.heartRate!=null && sensorInfo.heartRate>0){
	    		heartRateActive = true;
	    	}else{
	    		heartRateActive = false;
	    	}
	    	if(sensorInfo.speed!=null && sensorInfo.speed>0){
	    		bikeSpeedActive = true;
	    	}else{
	    		bikeSpeedActive = false;
	    	}
	    	if(sensorInfo.cadence!=null && sensorInfo.cadence>0){
	    		bikeCadenceActive = true;
	    	}else{
	    		bikeCadenceActive = false;
	    	}
		}
		
//		function setZoomMode(zoomMode_){
//			zoomMode = zoomMode_;
//		}
		
		function handle(){
			if (Toybox has :ActivityRecording ) {                          // check device for activity recording
		       if (session == null) {
		           	session = ActivityRecording.createSession({          // set up recording session
		                 :name		=> 	ACTIVITY_NANE,                              // set session name
		                 :sport		=> 	ActivityRecording.SPORT_CYCLING,       // set sport type
		                 :subSport	=>	ActivityRecording.SUB_SPORT_INDOOR_CYCLING // set sub sport type
		           	});
		    		levelField = session.createField("level",LEVEL_FIELD_ID,FitContributor.DATA_TYPE_STRING,
		    				{ :mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"Level", :count=>2 });	
		       		trackField = session.createField("track",TRACK_FIELD_ID,FitContributor.DATA_TYPE_STRING, 
		       				{ :mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"Track",:count=>32});
		       		percentageField = session.createField("percentage",PERCENTAGE_FIELD_ID,FitContributor.DATA_TYPE_SINT32, 
		       				{ :mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"%" });
		       		altitudeField = session.createField("altitude",ALTITUDE_FIELD_ID,FitContributor.DATA_TYPE_UINT32, 
		       				{ :mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"m" });
		          	startingTimer();
		       }
		       else if (isRecording()) {
		       		stoppingTimer();
		       }else if(!isRecording() ){ 
		       		startingTimer();
		       }
//		       refreshValues();
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
//			activityRefreshTimer.stop();
			ActivityValues.reset();
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
	    		var lapValues = ActivityValues.lap();
	    		lapNumber++;
	    		return {
	    					:lapNumber 		=> lapNumber,
	    					:distanceLap 	=> lapValues.get(:distanceLap), 
							:speedLap 		=> lapValues.get(:speedLap)
						};
//	    		activityAlert.lapAlert(lapNumber,lapValues.get(:speedLap),lapValues.get(:distanceLap));
	    	}else{
	    		return null;
	    	}
	    }
	    
//	    function refreshValues(){
//    		try {
//				var isAlert = activityAlert.checkAlert(!zoomMode);	
//				if(isAlert){
//					if(percentageField!=null){
//						percentageField.setData(ActivityValues.percentage());
//					}
//					if(altitudeField!=null){
//						altitudeField.setData(ActivityValues.calculateAltitude());
//					}
//				}
//				WatchUi.requestUpdate();
//			} catch (e instanceof Lang.Exception) {
//				WatchUi.requestUpdate();
//			}
//	    	
//    	}
    	
    	function collectData(){
    		if(percentageField!=null){
				percentageField.setData(ActivityValues.percentage());
			}
			if(altitudeField!=null){
				altitudeField.setData(ActivityValues.calculateAltitude());
			}
    	}
    	
	    
		 private function startingTimer(){
		    session.start();
		    SV.playStart();
		}
		
		private function stoppingTimer(){
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