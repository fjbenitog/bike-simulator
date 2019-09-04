using Toybox.Graphics;
using Toybox.Math;
using Toybox.WatchUi;
using Toybox.System;

class DrawableTrack extends WatchUi.Drawable {

	var track;
	
	function initialize(track_,options) {
        Drawable.initialize(options);
        track = track_;
    }
    
    function draw(dc) {
    	dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_BLACK);
    	dc.drawText(dc.getWidth()/2, 10, Graphics.FONT_TINY, track.name, Graphics.TEXT_JUSTIFY_CENTER);
    	dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);
    	System.println("Width:"+dc.getWidth()+", Height:"+dc.getHeight());
    	for(var i = 0; i < track.profile.size(); ++i) {
        	dc.fillRectangle(i, (dc.getHeight()/2)-track.profile[i]+10 , 1, track.profile[i]+10);
        }
    }
}