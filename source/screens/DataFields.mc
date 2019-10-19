using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

module DataFields{
	
	function createView1(){
		
    	var fields = 
    	[
    		[WatchUi.loadResource(Rez.Strings.speed)		, :calculateSpeed],
			[WatchUi.loadResource(Rez.Strings.heartRate) 	, :calculateHeartRate],
			[WatchUi.loadResource(Rez.Strings.cadence)		, :calculateCadence],
			[WatchUi.loadResource(Rez.Strings.distance)		, :calculateDistance],
		];
		
        return new DataFieldsView(fields);
    
	}
	
	function createView2(){
		var fields = 
    	[
    		[WatchUi.loadResource(Rez.Strings.timeLap) 		, :calculateTimeLap],
    		[WatchUi.loadResource(Rez.Strings.percentage)	, :calculatePercentage],
			[WatchUi.loadResource(Rez.Strings.speedLap)		, :calculateSpeedLap],
			[WatchUi.loadResource(Rez.Strings.distanceLap)	, :calculateDistanceLap],

		];
		
       return new DataFieldsView(fields);
	}
	
	function createView3(){
		var fields = 
    	[
    		[WatchUi.loadResource(Rez.Strings.time) 		, :calculateTime],
    		[WatchUi.loadResource(Rez.Strings.altitude)		, :calculateAltitude],
			[WatchUi.loadResource(Rez.Strings.avgSpeed)		, :calculateAvgSpeed],
			[WatchUi.loadResource(Rez.Strings.distance)		, :calculateDistance],

		];
		
        return new DataFieldsView(fields);
	}

	class DataFieldsView extends BaseView {
	
		var dataFields;
		
	    function initialize(fields) {
	        BaseView.initialize();
	        dataFields = new DrawableDataFields({:dataFields => fields});
	    }
	
	
	
	    // Update the view
	    function onUpdate(dc) {
	        // Call the parent onUpdate function to redraw the layout
	        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
			dc.clear();
			dataFields.draw(dc);
			BaseView.onUpdate(dc);
	    }
	
	
	    
	}
}


