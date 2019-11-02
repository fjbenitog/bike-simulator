using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class DrawableDataFields extends WatchUi.Drawable {

		var title1;
		var title2;
		var title3;
		var title4;
		
		var field1;
		var field2;
		var field3;
		var field4;
		
		var marginTitle;
		var marginNumber;
		
		var titleFont;
		var numberFont;
		
	
	function initialize(options) {
		Drawable.initialize(options);
        title1 = loadValue(options,:title1,WatchUi.loadResource(Rez.Strings.speed));
        title2 = loadValue(options,:title2,WatchUi.loadResource(Rez.Strings.heartRate));
        title3 = loadValue(options,:title3,WatchUi.loadResource(Rez.Strings.cadence));
        title4 = loadValue(options,:title4,WatchUi.loadResource(Rez.Strings.distance));
        
        field1 = loadValue(options,:field1,:calculateSpeed);
        field2 = loadValue(options,:field2,:calculateHeartRate);
        field3 = loadValue(options,:field3,:calculateCadence);
        field4 = loadValue(options,:field4, :calculateDistance);
        
        marginTitle = loadValue(options,:fieldTitleMargin, 0);
        marginNumber = loadValue(options,:fieldNumberMargin, 0);
        
        titleFont = loadValue(options,:titleFont, Graphics.FONT_SYSTEM_TINY);
        numberFont = loadValue(options,:numberFont, Graphics.FONT_NUMBER_MEDIUM);
	}
	
	private function loadValue(options,key,defaultValue){
		var value = options.get(key);
	    return value != null ? value : defaultValue;
	}
	
	function draw(dc) {
		var height = dc.getHeight()/3;
		var width = dc.getWidth()/2;
		
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
		dc.clear();

		drawGrid(dc,width,height);
		
		drawField(dc,title1,field1,0	,0			,2 * width 	, height);
		drawField(dc,title2,field2,0	,height		,width 		, height);
		drawField(dc,title3,field3,width,height		,width 		, height);
		drawField(dc,title4,field4,0	,2 * height	,2 * width 	, height);

	}
	
	private function drawGrid(dc,width,height){
		dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(2);
		dc.drawLine(0		, height	, 2 * width , height);
		dc.drawLine(0		, 2*height	, 2 * width	, 2*height);
		dc.drawLine(width	, height	, width		, 2*height);
		dc.setPenWidth(1);
	}
	
	private function drawField(dc,name,value,x,y,width,height) {
		var v = new Lang.Method(ActivityValues, value); 
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(x + width/2, y + marginTitle, titleFont, name, Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(x + width/2, y + height - dc.getFontHeight(numberFont) - marginNumber, numberFont, v.invoke(), Graphics.TEXT_JUSTIFY_CENTER);
	}
}