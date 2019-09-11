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
			width = dc.getWidth() - 1;
		}
		if(height == 0){
			height = y;
		}
		//Calculate scales to redimension Profile
		var distance = drawPoints.size();
		var pethWidth = 3;
		var rate = (width.toDouble()  - pethWidth) / distance;
		var scale = height.toDouble() / (maxPoint +base);
//		System.println("Rate:"+rate+", scale:"+scale+",distance:"+distance);
		
		var currentDistance = ActivityValues.calculateDistance().toNumber();
		//Draw border and populate polygon for profile
		var polygon = [];
		var currentPolygon = [];
		dc.setColor(Graphics.COLOR_WHITE, Graphics.Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(pethWidth);
		for(var i = 0; i < distance; ++i) {
			var xPoint = (i * rate).toNumber() + pethWidth;
			var yPoint = ((drawPoints[i] + base) * scale).toNumber();
			
			polygon.add([x + xPoint, y - yPoint]);
			if(currentDistance > i){ 
				currentPolygon.add([x + xPoint, y - yPoint]);
			}
		
			if(i>0){
				dc.drawLine(polygon[i-1][0], polygon[i-1][1], polygon[i][0], polygon[i][1]);
			}

    	}

	    var lastPoint = polygon[polygon.size() - 1];
	    var firstPoint = polygon[0];
	    
    	polygon.add([lastPoint[0] , y]);
    	dc.drawLine(lastPoint[0] - 1, lastPoint[1], lastPoint[0] - 1, y);   	
    	polygon.add([firstPoint[0], y]);
    	
    	if(currentPolygon.size()>0){
 			var currentLastPoint = currentPolygon[currentPolygon.size() - 1][0];
	    	currentPolygon.add([currentLastPoint, y]);
	    	currentPolygon.add([x + pethWidth, y]);
    	}
    	
    	dc.drawLine(lastPoint[0] - 1, y - 1, firstPoint[0] - 1, y -1);
    	dc.drawLine(firstPoint[0], y - 1, firstPoint[0], firstPoint[1] - 1);
    	
    	//Draw Fill Profile
    	dc.setPenWidth(1);
    	dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(polygon);
    	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(currentPolygon);

    	//Draw metric lines
		dc.setColor(Graphics.COLOR_WHITE, Graphics.Graphics.COLOR_TRANSPARENT);
    	var realWidth = polygon[polygon.size()-2][0]-polygon[polygon.size()-1][0];
    	dc.drawLine(x+realWidth/4,y+1,x+realWidth/4,y+4);
    	dc.drawLine(x+realWidth/2,y+1,x+realWidth/2,y+4);
    	dc.drawLine(x+3*realWidth/4,y+1,x+3*realWidth/4,y+4);
	
		dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.Graphics.COLOR_TRANSPARENT);
		dc.drawText(x + width/2, y, Graphics.FONT_XTINY, distance + " Kms", Graphics.TEXT_JUSTIFY_CENTER);
	}
}