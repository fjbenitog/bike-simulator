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
    	var name = track.reversed ? track.name + " (Rev.)" : track.name;

    	dc.drawText(dc.getWidth()/2, dc.getHeight()/4 + 35, Graphics.FONT_TINY, name, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    	drawableProfile.draw(dc);
    }
}