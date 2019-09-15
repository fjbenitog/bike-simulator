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
        	:track 	=> activeTrack,
        	:width 	=> 175, 
        	:height => 118,
        	:y 		=> dc.getHeight()-50,
        	:x 		=> 22
        	});
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        drawableTrackProfile.draw(dc);
        if(ActivityValues.calculateDistance().toFloat()>0){
	        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
	        var message = "Power: $1$ - Max Gear: $2$";
	        var currentPercentage = ActivityValues.calculatePercentage();
	        var numericPercentage = 0;
	        if(!currentPercentage.equals("")) {
	        	numericPercentage = currentPercentage.toNumber();
	        }
	        var result = calculator.calculate(numericPercentage);
	        dc.drawText(dc.getWidth()/2, 30, Graphics.FONT_XTINY, Lang.format(message, [result.power, result.gear]), Graphics.TEXT_JUSTIFY_CENTER);
        }
        BaseView.onUpdate(dc);
    }
    
    
}
