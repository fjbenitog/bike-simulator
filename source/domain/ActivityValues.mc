using Toybox.Lang;

module ActivityValues {

	var activityTime = new ActivityTime(0,0,0);
	var activityDistance = 0;
	var activitySpeed = 0;
	
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
	
	function formatTime(){
		return activityTime.hours.format("%02d")+":"+
		activityTime.minutes.format("%02d")+
		":"+activityTime.seconds.format("%02d");
	}
	
	function formatDistance(){
		return  Lang.format( "$1$ Kms",
    		[
        		activityDistance.format("%02.2f")
    		]
		);
	}
	
	function formatSpeed(){
		return Lang.format( "$1$ Kms/h",
    		[
        		activitySpeed.format("%02d")
    		]
		);
	}
}





