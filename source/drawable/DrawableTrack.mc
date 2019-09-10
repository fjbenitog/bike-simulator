using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class DrawableTrack extends WatchUi.Drawable {

	var track;
	var drawableProfile;
	
	function initialize(options) {
        Drawable.initialize(options);
        options.put(:height, 50);
        track = options.get(:track);
        drawableProfile = new DrawableTrackProfile(options);
    }
    
    function draw(dc) {
    	dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
    	dc.drawText(dc.getWidth()/2, 10, Graphics.FONT_TINY, track.name, Graphics.TEXT_JUSTIFY_CENTER);
    	System.println("Width:"+dc.getWidth()+", Height:"+dc.getHeight());
    	drawableProfile.setY(dc.getHeight()- 20);
    	drawableProfile.draw(dc);
    }
}