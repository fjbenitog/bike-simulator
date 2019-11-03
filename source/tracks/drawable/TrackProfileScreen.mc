using Toybox.Graphics;
using Toybox.Math;
using Toybox.WatchUi;
using Toybox.System;

class TrackProfileScreen extends WatchUi.Drawable {

	var drawableTrackProfile;
	var fontNumber = Graphics.FONT_NUMBER_MILD;
	var fontField = Graphics.FONT_SYSTEM_XTINY;
	var marginField = 0;
	var margingBottom = 0;

	function initialize(options) {
		Drawable.initialize(options);
		var fontNumber_ = options.get(:fontNumber);
        if(fontNumber_ != null) {
            fontNumber = fontNumber_;
        }
        var fontField_ = options.get(:fontField);
        if(fontField_ != null) {
            fontField = fontField_;
        }
        var marginField_ = options.get(:marginField);
        if(marginField_ != null) {
            marginField = marginField_;
        }
        var margingBottom_ = options.get(:margingBottom);
        if(margingBottom_ != null) {
            margingBottom = margingBottom_;
        }
        drawableTrackProfile  = new DrawableTrackProfile({
        	:width 		=> System.getDeviceSettings().screenWidth - 38, 
        	:height 	=> System.getDeviceSettings().screenHeight/2 - 10 - marginField - margingBottom,
        	:y 			=> 3 * System.getDeviceSettings().screenHeight/4 - margingBottom ,
        	:x 			=> 22,
        	:padding	=> 10,
        	:font		=> Graphics.FONT_SYSTEM_TINY
        	});
	}
	
	function draw(dc) {
	    drawFields(dc);
        drawableTrackProfile.draw(dc);
	}
	
	private function drawFields(dc){
		var base = dc.getHeight()/4 + marginField;
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	dc.setPenWidth(2);
    	dc.drawLine(0, base, dc.getWidth(), base);
    	dc.drawLine(dc.getWidth()/2, 0, dc.getWidth()/2, base);
		dc.setPenWidth(1);
		dc.drawText(dc.getWidth()/2 - 10, base - Graphics.getFontHeight(fontField), 
			fontField, WatchUi.loadResource(Rez.Strings.powerLabel).toUpper(), Graphics.TEXT_JUSTIFY_RIGHT);
		dc.drawText(dc.getWidth()/2 + 10, base - Graphics.getFontHeight(fontField), 
			fontField, WatchUi.loadResource(Rez.Strings.maxGear).toUpper(), Graphics.TEXT_JUSTIFY_LEFT);
			
		if(ActivityValues.distance()>0){
		    var result = ActivityValues.calculateSimulatorValues();
		    
		    dc.drawText(dc.getWidth()/2 - 10, base - Graphics.getFontHeight(fontField)  - Graphics.getFontHeight(fontNumber) - marginField/2, 
				fontNumber, result.power, Graphics.TEXT_JUSTIFY_RIGHT);
			dc.drawText(dc.getWidth()/2 + 10, base - Graphics.getFontHeight(fontField)  - Graphics.getFontHeight(fontNumber) - marginField/2, 
				fontNumber, result.gear, Graphics.TEXT_JUSTIFY_LEFT );
			
			dc.setColor(Graphics.COLOR_WHITE, Graphics.Graphics.COLOR_TRANSPARENT);
			dc.drawText(dc.getWidth()/2, dc.getHeight() - 15 , Graphics.FONT_TINY, ActivityValues.percentage() + "%", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
	
		}
    }
    
    function changeZoom(){
   		return drawableTrackProfile.changeZoom();
	}
    
    function resetZoom(){
		return drawableTrackProfile.resetZoom();
	}
	
	function isZoom(){
		return drawableTrackProfile.isZoom();
	}

}