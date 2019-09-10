using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView extends WatchUi.View {

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
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(dc.getWidth()/2, dc.getHeight()/4, Graphics.FONT_SYSTEM_NUMBER_MILD, ActivityValues.formatTime(), Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_SYSTEM_NUMBER_MILD, ActivityValues.formatSpeed(), Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth()/2, 3 * dc.getHeight()/4, Graphics.FONT_SYSTEM_NUMBER_MILD, ActivityValues.formatDistance(), Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
}

class DataFieldsDelegate extends ScreenDelegate {

	function initialize(session_, index) {
        ScreenDelegate.initialize(session_, index);
    }
    
	
}

