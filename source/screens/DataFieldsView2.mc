using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView2 extends DataFieldsView {

    function initialize() {
    	var fields = 
    	[
    		[WatchUi.loadResource(Rez.Strings.time) 		, :calculateTime],
    		[WatchUi.loadResource(Rez.Strings.percentage)	, :calculatePercentage],
			[WatchUi.loadResource(Rez.Strings.avgSpeed)		, :calculateAvgSpeed],
			[WatchUi.loadResource(Rez.Strings.distance)		, :calculateDistance],

		];
		
        DataFieldsView.initialize(fields);
    }
    
}



