using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView1 extends DataFieldsView {

    function initialize() {
    	var fields = 
    	[
    		[WatchUi.loadResource(Rez.Strings.speed)		, :calculateSpeed],
			[WatchUi.loadResource(Rez.Strings.heartRate) 	, :calculateHeartRate],
			[WatchUi.loadResource(Rez.Strings.cadence)		, :calculateCadence],
			[WatchUi.loadResource(Rez.Strings.distance)		, :calculateDistance],
		];
		
        DataFieldsView.initialize(fields);
    }
    
}



