using Toybox.Graphics;
using Toybox.Math;
using Toybox.WatchUi;
using Toybox.System;

class DrawableTrackProfile extends WatchUi.Drawable {

	private var profile;
	var x = 0;
	var y = 0;
	var scale = 2;

	function initialize(options) {
	    Drawable.initialize(options);
        profile = options.get(:track).profile;
        var value = options.get(:x);
        if(value != null) {
            x = value;
        }
        var value2 = options.get(:y);
        if(value2 != null) {
            y = value2;
        }
        var value3 = options.get(:scale);
        if(value3 != null) {
            scale = value3;
        }
	}
	
	function setY(y_){
		y = y_;
	}
	
	function draw(dc) {
		var width = dc.getWidth()-1;
		var distance = profile.size();
		var polygon = [];
		
		if(width/distance>=1){
			var rate = (width/distance).toNumber();
			var previous = 10;

			for(var i = 0; i < profile.size(); ++i) {
				previous = previous+profile[i];
				polygon.add([x + rate*i, y - (previous/scale)]);
        	}
        	polygon.add([x + rate*(profile.size()-1), y ]);
        	polygon.add([x , y]);

        	
		}else{
			var rate = (distance/width).toNumber();
			var previous = 10;
			var acc = 0;
			var count = -1;
			for(var i = 0; i < profile.size(); ++i) {
				acc+=profile[i];
				var module_ = (i+1) % rate;
				if(module_ == 0 && count < width){
					count++;
					previous = previous+acc;
					polygon.add([x + count, y - (previous/scale)]);
        			acc = 0;
				}
        	}
        	polygon.add([x + count, y ]);
        	polygon.add([x , y]);
		}
		
    	dc.fillPolygon(polygon);
    	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.Graphics.COLOR_TRANSPARENT);
    	for(var i = 0; i < polygon.size()-1; ++i) {
    		dc.drawLine(polygon[i][0], polygon[i][1], polygon[i+1][0], polygon[i+1][1]);
    	}
    	dc.drawLine(polygon[polygon.size()-1][0], polygon[polygon.size()-1][1], polygon[0][0], polygon[0][1]);
    	var realWidth = polygon[polygon.size()-2][0]-polygon[polygon.size()-1][0];
    	System.println("realWidth:"+realWidth);
    	dc.drawLine(x,y,x,y+3);
    	dc.drawLine(realWidth/4,y,realWidth/4,y+3);
    	dc.drawLine(realWidth/2,y,realWidth/2,y+3);
    	dc.drawLine(3*realWidth/4,y,3*realWidth/4,y+3);
    	dc.drawLine(realWidth,y,realWidth,y+3);
	
		dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.Graphics.COLOR_TRANSPARENT);
		dc.drawText(dc.getWidth()/2, y, Graphics.FONT_XTINY, profile.size()+" Kms", Graphics.TEXT_JUSTIFY_CENTER);
	}
}