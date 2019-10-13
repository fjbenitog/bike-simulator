using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView3 extends DataFieldsView {

    function initialize() {
    	var fields = 
    	[
    		[WatchUi.loadResource(Rez.Strings.time) 		, :calculateTime],
    		[WatchUi.loadResource(Rez.Strings.altitude)		, :calculateAltitude],
			[WatchUi.loadResource(Rez.Strings.avgSpeed)		, :calculateAvgSpeed],
			[WatchUi.loadResource(Rez.Strings.distance)		, :calculateDistance],

		];
		
        DataFieldsView.initialize(fields);
    }
    
}



