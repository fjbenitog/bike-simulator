using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView1 extends DataFieldsView {

    function initialize() {
    	var fields = 
    	[
    		["DIST"		, :calculateDistance],
			["HR" 		, :calculateHeartRate],
			["SPEED"	, :calculateSpeed],
			["CADENCE"	, :calculateCadence]
		];
		
        DataFieldsView.initialize(fields);
    }
    
}



