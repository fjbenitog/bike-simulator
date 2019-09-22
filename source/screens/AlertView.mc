using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class AlertView extends WatchUi.View {
	
    function initialize() {
        View.initialize();
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
    	WatchUi.View.onUpdate(dc);
    	var result = ActivityValues.calculateSimulatorValues();
    	var heightFont = Graphics.getFontHeight(Graphics.FONT_SYSTEM_MEDIUM);
		var heightNumberFont = Graphics.getFontHeight(Graphics.FONT_NUMBER_MEDIUM);
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.Graphics.COLOR_TRANSPARENT);
    	dc.drawText(dc.getWidth()/2, dc.getHeight()/8, Graphics.FONT_SYSTEM_MEDIUM, "POWER:", Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(dc.getWidth()/2, dc.getHeight()/8 + heightFont,
    		 Graphics.FONT_NUMBER_MEDIUM, result.power, Graphics.TEXT_JUSTIFY_CENTER);
    		 
    	dc.drawText(dc.getWidth()/2, dc.getHeight()/8 + heightFont + heightNumberFont, Graphics.FONT_SYSTEM_MEDIUM, "MAX GEAR:", Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(dc.getWidth()/2, dc.getHeight()/8 + heightNumberFont + 2 * heightFont,
    		 Graphics.FONT_NUMBER_MEDIUM, result.gear, Graphics.TEXT_JUSTIFY_CENTER);
 
    }
    
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
}


