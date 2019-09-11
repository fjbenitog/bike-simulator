using Toybox.Lang;
using Toybox.Activity;
using Toybox.System;

module ActivityValues {
	
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
	
	function toHMS(secs) {
		var hr = secs/3600;
		var min = (secs-(hr*3600))/60;
		var sec = secs%60;
		return new ActivityTime(hr,min,sec);
	}
	
	function calculateTime(){
    	var milis = Activity.getActivityInfo().timerTime;
    	System.println("Timer:"+milis);
		var activityTime = ActivityValues.toHMS(milis/1000);
		return activityTime.hours.format("%02d")+":"+
			activityTime.minutes.format("%02d")+
			":"+activityTime.seconds.format("%02d");
    }
    
    function calculateDistance(){
    	var distance = Activity.getActivityInfo().elapsedDistance;
    	if(distance == null || distance<0){ 
    		distance = 0;
    	}
    	System.println("Distance:"+distance);
//    	var activityDistance = distance/1000;
    	var activityDistance = distance/10;
    	return  Lang.format( "$1$",
    		[
        		activityDistance.format("%02.2f")
    		]
		);
    }
    
    function calculateSpeed(){
    	var speed = Activity.getActivityInfo().currentSpeed;
    	System.println("Speed:"+speed);
    	if(speed == null || speed < 0) {
    		return "";
    	}
    	var activitySpeed = (3600*speed)/1000;
    	return Lang.format( "$1$",
    		[
        		activitySpeed.format("%02d")
    		]
		);
    }
    
    function calculateAvgSpeed(){
    	var avgSpeed = Activity.getActivityInfo().averageSpeed;
    	System.println("Avg Speed:"+avgSpeed);
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
    	System.println("Heart Rate:"+heartRate);
    	return heartRate.toString();
    }
    
    function calculateCadence(){
    	var cadence = Activity.getActivityInfo().currentCadence;
    	if(cadence == null || cadence < 0) {
    		cadence = "";
    	}
    	System.println("Cadence:"+cadence);
    	return cadence.toString();
    }
    
    function calculatePercentage(){
    	return "";
    }
    
    
}





