using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class BaseView extends WatchUi.View {
	
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
    	drawStartingIcon(dc);
    	drawStoppingIcon(dc);
    }
    
    private function drawStartingIcon(dc){
    	if(startingActivity){
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
			dc.fillPolygon(
			[
				[dc.getWidth()/4, dc.getHeight()/4],
				[3*dc.getWidth()/4, dc.getHeight()/2],
				[dc.getWidth()/4, 3*dc.getHeight()/4],
			]);
			dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
			dc.fillPolygon(
			[
				[dc.getWidth()/4 + 5, dc.getHeight()/4 + 8],
				[3*dc.getWidth()/4 - 10, dc.getHeight()/2],
				[dc.getWidth()/4 + 5, 3*dc.getHeight()/4 - 8],
			]);
		
		}
    
    }
    
    private function drawStoppingIcon(dc){
    	if(stoppingActivity){
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
			dc.fillRectangle(dc.getWidth()/4, dc.getHeight()/4, dc.getWidth()/2, dc.getHeight()/2);
			dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
			dc.fillRectangle(dc.getWidth()/4 + 5, dc.getHeight()/4 + 5, dc.getWidth()/2 - 10, dc.getHeight()/2 -10);
		}
    
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
}


