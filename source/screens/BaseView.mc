using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math;
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
    	if(Activity.starting > 0){
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
			var size = min(dc.getWidth(),dc.getHeight())/2;
			
			dc.fillPolygon(
			[
				[(dc.getWidth() - size)/2, (dc.getHeight()-size)/2],
				[(dc.getWidth() + size)/2, dc.getHeight()/2],
				[(dc.getWidth() - size)/2, (dc.getHeight() + size)/2],
			]);
			dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
			dc.fillPolygon(
			[
				[(dc.getWidth()- size)/2 + 5, (dc.getHeight()-size)/2+ 8],
				[(dc.getWidth() + size)/2 - 10, dc.getHeight()/2],
				[(dc.getWidth() - size)/2 + 5, (dc.getHeight() + size)/2 - 8],
			]);
			Activity.starting = Activity.starting - 1;
		}else if(Activity.starting < 0){
			Activity.starting = 0;
		}
    
    }
    
    private function drawStoppingIcon(dc){
    	if(Activity.stopping>0){
    		var size = min(dc.getWidth(),dc.getHeight())/2;
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
			dc.fillRectangle((dc.getWidth() - size)/2, (dc.getHeight()-size)/2, size, size);
			dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
			dc.fillRectangle((dc.getWidth() - size)/2 + 5, (dc.getHeight()-size)/2 + 5, size - 10, size -10);
			Activity.stopping = Activity.stopping - 1;
		}else if(Activity.stopping < 0){
			Activity.stopping = 0;
		}
    
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function min(val1, val2){
		if(val1>val2){
			return val2;
		}else{
			return val1;
		}
    }
    
    
}


