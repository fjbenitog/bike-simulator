using Toybox.Lang;
using Toybox.Activity;
using Toybox.System;

module ActivityValues {

	var simulator = new Simulator.Calculator(Properties.gears(), Properties.power(), Properties.level());
	
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
		var activityTime = ActivityValues.toHMS(milis/1000);
		return activityTime.hours.format("%02d")+":"+
			activityTime.minutes.format("%02d")+
			":"+activityTime.seconds.format("%02d");
    }
    
    function calculateShortTime(){
    	var milis = Activity.getActivityInfo().timerTime;
		var activityTime = ActivityValues.toHMS(milis/1000);
		return activityTime.hours.format("%02d")+":"+
			activityTime.minutes.format("%02d");
    }
    
    function distance(){
        var distance = Activity.getActivityInfo().elapsedDistance;
    	if(distance == null || distance<0){ 
    		distance = 0;
    	}
    	return distance/1000;
//    	return distance/10;
    }
    
    function calculateDistance(){
    	var activityDistance = distance();
    	return  Lang.format( "$1$",
    		[
        		distance().format("%02.2f")
    		]
		);
    }
    
    function speed(){
    	 var speed = Activity.getActivityInfo().currentSpeed;
    	if(speed == null || speed < 0) {
    		return 0;
    	}else{
    		return (3600*speed)/1000;
    	}
    }
    
    function calculateSpeed(){
    	var speed = speed();
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
    function calculatePercentage(){
    	return percentage().toString();
    }
    
    function calculateSimulatorValues(){
		var currentPercentage = ActivityValues.calculatePercentage();
	    var numericPercentage = 0;
	    if(!currentPercentage.equals("")) {
    		numericPercentage = currentPercentage.toNumber();
	    }
	    return simulator.calculate(numericPercentage);
    }
    
    
}





