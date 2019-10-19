using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class DrawableTrack extends WatchUi.Drawable {

	var track;
	var drawableProfile;
	
	function initialize(options) {
        Drawable.initialize(options);
        track = options.get(:track);
        drawableProfile = new DrawableTrackProfile(options);
    }
    
    function draw(dc) {
    	dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
    	dc.drawText(dc.getWidth()/2, dc.getHeight()/4 + 35, Graphics.FONT_TINY, track.name, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    	drawableProfile.draw(dc);
    }
}