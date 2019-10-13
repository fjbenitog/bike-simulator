using Toybox.Lang;
using Toybox.Activity;
using Toybox.System;

module ActivityValues {

	var simulator = new Simulator.Calculator(Properties.gears(), Properties.power(), Properties.level());
	var lastDistance = 0;
	var lastTime = 0;

	class ActivityTime {
	
		var hours;
		var minutes;
		var seconds;
		
		function initialize(hours_, minutes_, seconds_){
			hours = hours_;
			minutes = minutes_;
			seconds = seconds_;
		}
		
	}
	
	function reset(){
		lastDistance = 0;
		lastTime = 0;
	}
	
	function lap(){
		var totalDistance = ActivityValues.distance();
		var totalTime = ActivityValues.time();
		var distanceLap = totalDistance - ActivityValues.lastDistance;
		var timeLap = totalTime - ActivityValues.lastTime;
		
		var speedLap = distanceLap/(3600*timeLap/1000);
		ActivityValues.lastDistance = totalDistance;
		ActivityValues.lastTime = totalTime;
		return {:distanceLap => printDistance(distanceLap), 
				:speedLap => printSpeed(speedLap)};
	}
	
	function distanceLap(){
		var totalDistance = ActivityValues.distance();
		return totalDistance - ActivityValues.lastDistance; 
	}
	
	function calculateDistanceLap(){
		return printDistance(distanceLap());
	}
	
	function timeLap(){
		var totalTime = ActivityValues.time();
		return totalTime - ActivityValues.lastTime;
	}
	
	function calculateTimeLap(){
		var timeLap = timeLap();
		return printTime(timeLap);
	}
	
	function calculateSpeedLap(){
		var time = timeLap();
		if(time == 0){
			return printSpeed(0);
		}else{
			return printSpeed(distanceLap()/(3600*time));
		}
	}
	
	function toHMS(secs) {
		var hr = secs/3600;
		var min = (secs-(hr*3600))/60;
		var sec = secs%60;
		return new ActivityTime(hr,min,sec);
	}
	
	function time(){
		return Activity.getActivityInfo().timerTime;
	}
	
	function printTime(time){
		var activityTime = ActivityValues.toHMS(time/1000);
		return activityTime.hours.format("%02d")+":"+
			activityTime.minutes.format("%02d")+
			":"+activityTime.seconds.format("%02d");
	}
	
	function calculateTime(){
		return printTime(time());
    }
    
    function calculateShortTime(){
    	var milis = time();
		var activityTime = ActivityValues.toHMS(milis/1000);
		return activityTime.hours.format("%02d")+":"+
			activityTime.minutes.format("%02d");
    }
    
    function meterDistance(){
    	var distance = Activity.getActivityInfo().elapsedDistance;
    	if(distance == null || distance<0){ 
    		distance = 0;
    	}
    	return distance;
    }
    
    function distance(){
    	return meterDistance()/50;
    }
    
    function printDistance(distance){
    	return  Lang.format( "$1$",
    		[
        		distance.format("%02.2f")
    		]
		);
    }
    
    function calculateDistance(){
    	return printDistance(distance());
    }
    
    function speed(){
    	var speed = Activity.getActivityInfo().currentSpeed;
    	if(speed == null || speed < 0) {
    		return 0;
    	}else{
    		return (3600*speed)/1000;
		}
    }
    
    function printSpeed(speed){
    	if(speed==0){
    		return "";
		}else{
    		return Lang.format( "$1$",
	    		[
	        		speed().format("%02d")
	    		]
			);
		}
    }
    
    function calculateSpeed(){
    	return printSpeed(speed());
    }
    
    function calculateAvgSpeed(){
    	var avgSpeed = Activity.getActivityInfo().averageSpeed;
    	if(avgSpeed == null || avgSpeed < 0) {
    		return "";
    	}

    	var activityAvgSpeed = (3600*avgSpeed)/1000;
    	return Lang.format( "$1$",
    		[
        		activityAvgSpeed.format("%02d")
    		]
		);
    }
    
    function calculateHeartRate(){
    	var heartRate = Activity.getActivityInfo().currentHeartRate;
    	if(heartRate == null || heartRate < 0) {
    		heartRate = "";
    	}
    	return heartRate.toString();
    }
    
    function calculateCadence(){
    	var cadence = Activity.getActivityInfo().currentCadence;
    	if(cadence == null || cadence < 0) {
    		cadence = "";
    	}
    	return cadence.toString();
    }
    function percentage(){
    	var distance = calculateDistance().toFloat();
    	var profile = DataTracks.getActiveTrack().profile;
    	if(distance <=0 || distance>profile.size()-1){
    		return 0;
    	}else{
    		return profile[distance.toNumber()];
		}
    }
    
    function calculateAltitude(){
    	var distance = distance().toNumber();
    	var currentTrack = DataTracks.getActiveTrack();
    	var baseAltitude = currentTrack.altitude;
    	var profile = DataTracks.getActiveTrack().profile;
    	
    	if(distance <=0 ){
    		return baseAltitude;
    	}else{
    		var altitude = baseAltitude;
    		var index = distance;
    		if(distance>currentTrack.profile.size()-1){
    			index = currentTrack.profile.size();
    		}
    		for(var i = 0 ; i<index; i++){
    			altitude = altitude + (10*profile[i]);
    		}
    		return altitude.toLong();
    	}
    	
    }
    function calculatePercentage(){
    	return percentage().toString();
    }
    
    function calculateSimulatorValues(){
	    return simulator.calculate(percentage());
    }
    
    
}





