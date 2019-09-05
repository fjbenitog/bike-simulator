using Toybox.Graphics;
using Toybox.Math;
using Toybox.WatchUi;
using Toybox.System;

class DrawableTrack extends WatchUi.Drawable {

	var track;
	var drawableProfile;
	
	function initialize(options) {
        Drawable.initialize(options);
        options.put(:scale, 3);
        options.put(:x, 2);
        track = options.get(:track);
        drawableProfile = new DrawableTrackProfile(options);
    }
    
    function draw(dc) {
    	dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_BLACK);
    	dc.drawText(dc.getWidth()/2, 10, Graphics.FONT_TINY, track.name, Graphics.TEXT_JUSTIFY_CENTER);
    	dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);
    	System.println("Width:"+dc.getWidth()+", Height:"+dc.getHeight());
    	drawableProfile.setY(dc.getHeight()- 20);
    	drawableProfile.draw(dc);
    }
}