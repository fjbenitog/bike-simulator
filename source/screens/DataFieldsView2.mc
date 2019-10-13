using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView2 extends DataFieldsView {

    function initialize() {
    	var fields = 
    	[
    		[WatchUi.loadResource(Rez.Strings.timeLap) 		, :calculateTimeLap],
    		[WatchUi.loadResource(Rez.Strings.percentage)	, :calculatePercentage],
			[WatchUi.loadResource(Rez.Strings.speedLap)		, :calculateSpeedLap],
			[WatchUi.loadResource(Rez.Strings.distanceLap)	, :calculateDistanceLap],

		];
		
        DataFieldsView.initialize(fields);
    }
    
}



