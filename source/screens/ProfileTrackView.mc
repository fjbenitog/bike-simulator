using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;

class ProfileTrackView  extends BaseView {

	var activeTrack;
	var calculator;
	
    function initialize() {
        BaseView.initialize();
        activeTrack = DataTracks.getActiveTrack();
        calculator = new Simulator.Calculator(Properties.gears(), Properties.power(), Properties.level());
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        var drawableTrackProfile  = new DrawableTrackProfile({
        	:track 		=> activeTrack,
        	:width 		=> dc.getWidth() - 38, 
        	:height 	=> dc.getHeight()/2 - 10,
        	:y 			=> 3 * dc.getHeight()/4 ,
        	:x 			=> 22,
        	:padding	=> 10,
        	:font		=> Graphics.FONT_SYSTEM_TINY
        	});
        	
    	drawFields(dc);
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        drawableTrackProfile.draw(dc);
        
        BaseView.onUpdate(dc);
    }
    
    private function drawFields(dc){
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	dc.setPenWidth(2);
    	dc.drawLine(0, dc.getHeight()/4, dc.getWidth(), dc.getHeight()/4);
    	dc.drawLine(dc.getWidth()/2, 0, dc.getWidth()/2, dc.getHeight()/4);
		dc.setPenWidth(1);
		dc.drawText(dc.getWidth()/2 - 10, dc.getHeight()/4 - Graphics.getFontHeight(Graphics.FONT_SYSTEM_XTINY), 
			Graphics.FONT_SYSTEM_XTINY, "POWER", Graphics.TEXT_JUSTIFY_RIGHT);
		dc.drawText(dc.getWidth()/2 + 10, dc.getHeight()/4 - Graphics.getFontHeight(Graphics.FONT_SYSTEM_XTINY), 
			Graphics.FONT_SYSTEM_XTINY, "MAX GEAR", Graphics.TEXT_JUSTIFY_LEFT);
			
		if(ActivityValues.calculateDistance().toFloat()>0){
		    var result = ActivityValues.calculateSimulatorValues();
		    
		    dc.drawText(dc.getWidth()/2 - 10, dc.getHeight()/4 - Graphics.getFontHeight(Graphics.FONT_SYSTEM_XTINY)  - Graphics.getFontHeight(Graphics.FONT_NUMBER_MILD), 
				Graphics.FONT_NUMBER_MILD, result.power, Graphics.TEXT_JUSTIFY_RIGHT);
			dc.drawText(dc.getWidth()/2 + 10, dc.getHeight()/4 - Graphics.getFontHeight(Graphics.FONT_SYSTEM_XTINY)  - Graphics.getFontHeight(Graphics.FONT_NUMBER_MILD), 
			Graphics.FONT_NUMBER_MILD, result.gear, Graphics.TEXT_JUSTIFY_LEFT);
		}
    }
    
    
}
