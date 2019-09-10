using Toybox.Graphics;
using Toybox.Math;
using Toybox.WatchUi;
using Toybox.System;

class DrawableTrackProfile extends WatchUi.Drawable {

	private var drawPoints;
	private var maxPoint;
	private const base = 10;
	var x = 0;
	var y = 0;
	var width;
	var height;

	function initialize(options) {
	    Drawable.initialize(options);
        drawPoints = options.get(:track).drawPoints;
        maxPoint = options.get(:track).maxPoint;
        var x_ = options.get(:x);
        if(x_ != null) {
            x = x_;
        }
        var y_ = options.get(:y);
        if(y_ != null) {
            y = y_;
        }
        var width_ = options.get(:width);
        if(width_ != null) {
            width = width_;
        }
        var height_ = options.get(:height);
        if(height_ != null) {
            height = height_;
        }
	}
	
	function setY(y_){
		y = y_;
	}
	
	function draw(dc) {
		if(width == 0){
			width = dc.getWidth();
		}
		if(height == 0){
			height = y;
		}
		var distance = drawPoints.size();
		var polygon = [];
		
		if(width/distance>=1){
			var rate = width.toDouble() / distance;
			var scale = height.toDouble() / (maxPoint +base);
			System.println("Rate:"+rate+", scale:"+scale);
			for(var i = 0; i < drawPoints.size(); ++i) {
				var xPoint = (i * rate).toNumber();
				var yPoint = ((drawPoints[i] + base) * scale).toNumber();
				
				polygon.add([x + xPoint, y - yPoint]);
        	}
        	polygon.add([x + ( (drawPoints.size() -1) * rate).toNumber(), y]);
        	polygon.add([x , y]);

        	
		}else{
//			var rate = (distance/width).toNumber();
//			var previous = 10;
//			var acc = 0;
//			var count = -1;
//			var scale = height / (maxPoint +base);
//			for(var i = 0; i < profile.size(); ++i) {
//				acc+=profile[i];
//				var module_ = (i+1) % rate;
//				if(module_ == 0 && count < width){
//					count++;
//					previous = previous+acc;
//					polygon.add([x + count, y - (previous/scale)]);
//        			acc = 0;
//				}
//        	}
//        	polygon.add([x + count, y ]);
//        	polygon.add([x , y]);
		}
		
    	dc.fillPolygon(polygon);
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.Graphics.COLOR_TRANSPARENT);
    	for(var i = 0; i < polygon.size()-1; ++i) {
    		dc.drawLine(polygon[i][0], polygon[i][1], polygon[i+1][0], polygon[i+1][1]);
    	}
    	dc.drawLine(polygon[polygon.size()-1][0], polygon[polygon.size()-1][1], polygon[0][0], polygon[0][1]);
    	
    	var realWidth = polygon[polygon.size()-2][0]-polygon[polygon.size()-1][0];
    	dc.drawLine(x+realWidth/4,y,x+realWidth/4,y+3);
    	dc.drawLine(x+realWidth/2,y,x+realWidth/2,y+3);
    	dc.drawLine(x+3*realWidth/4,y,x+3*realWidth/4,y+3);
	
		dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.Graphics.COLOR_TRANSPARENT);
		dc.drawText(x + width/2, y, Graphics.FONT_XTINY, drawPoints.size()+" Kms", Graphics.TEXT_JUSTIFY_CENTER);
	}
}