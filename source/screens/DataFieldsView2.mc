using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView2 extends DataFieldsView {

    function initialize() {
    	var fields = 
    	[
    		["TIME" 		, :calculateTime],
    		["PERCENTAGE"	, :calculatePercentage],
			["SPEED AVG"	, :calculateAvgSpeed],
			["DISTANCE"		, :calculateDistance],

		];
		
        DataFieldsView.initialize(fields);
    }
    
}



