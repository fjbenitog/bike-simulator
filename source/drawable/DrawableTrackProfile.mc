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
		var width = dc.getWidth();
		var distance = profile.size();
		
		if(width/distance>=1){
			var rate = (width/distance).toNumber();
			var previous = 10;
			for(var i = 0; i < profile.size(); ++i) {
				previous = previous+profile[i];
//				System.println("i:"+i+",previous:"+previous+", rate:"+rate);
        		dc.fillRectangle(x + rate*i,y - (previous/scale) , rate, previous/scale);
        	}
		}else{
			var rate = (distance/width).toNumber();
			var previous = 10;
			var acc = 0;
			var count = -1;
			for(var i = 0; i < profile.size(); ++i) {
				acc+=profile[i];
				var module_ = (i+1) % rate;
				if(module_ == 0){
					count++;
					previous = previous+acc;
//					System.println("i:"+i+",previous:"+previous+", rate:"+rate+ ", acc:"+acc+",count:"+count);
        			dc.fillRectangle(x + count,y - (previous/scale) , 1, previous/scale);
        			acc = 0;
				}
        	}
		}
		
		dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.Graphics.COLOR_TRANSPARENT);
		dc.drawText(dc.getWidth()/2, y, Graphics.FONT_XTINY, profile.size()+" Kms", Graphics.TEXT_JUSTIFY_CENTER);
	}
}