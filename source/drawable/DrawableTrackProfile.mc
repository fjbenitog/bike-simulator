using Toybox.Graphics;
using Toybox.Math;
using Toybox.WatchUi;
using Toybox.System;

class DrawableTrackProfile extends WatchUi.Drawable {

	private var drawPoints;
	private var maxPoint;
	private const base = 20;
	var x = 0;
	var y = 0;
	var width =  System.getDeviceSettings().screenWidth - 1;
	var height;
	var padding = 0;
	var font = Graphics.FONT_XTINY;
	var zoom = false;

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
       	if(height == 0){
			height = y;
		}
        var padding_ = options.get(:padding);
        if(padding_ != null) {
            padding = padding_;
        }
        var font_ = options.get(:font);
        if(font_ != null) {
            font = font_;
        }
	}
	
	function setY(y_){
		y = y_;
	}
	
	function draw(dc) {
		
		var totalDistance =  drawPoints.size();
		var calculatedPointsAndDistance = selectPoints(ActivityValues.distance());
		var virtualdrawPoints = calculatedPointsAndDistance[0];
		var currentDistance = calculatedPointsAndDistance[1];
		var startKm = calculatedPointsAndDistance[2];
		var initPoint = calculatedPointsAndDistance[3];
	

		//Calculate scales to redimension Profile
		var distance = virtualdrawPoints.size();
		var rate = width.toDouble() / (distance+1);
		var scale = height.toDouble() / (maxPoint +base);
		

		//Draw border and populate polygon for profile
		var cursor = calculateCursorAndDrawProfile(rate,scale,virtualdrawPoints,currentDistance,startKm,initPoint,dc);
    	
    	drawCursor(cursor,dc);
    	
		if(zoom){
	    	dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_TRANSPARENT);
			dc.drawText(x + width/2, y + padding/2, Graphics.FONT_SYSTEM_TINY, "Z:[ " + ActivityValues.calculateDistance() + "/" +totalDistance + " Kms ]", Graphics.TEXT_JUSTIFY_CENTER);
			
    	}else{
    		dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_TRANSPARENT);
			dc.drawText(x + width/2, y + padding, font, distance + " Kms", Graphics.TEXT_JUSTIFY_CENTER);
    	}
    	
    	
	}
	
	private function calculateCursorAndDrawProfile(rate,scale,virtualdrawPoints,currentDistance,startKm,initPoint,dc){
		var cursor = null;
		var prevXPoint = null;
		var prevYPoint = null; 
		var firstXPoint = null;
		var firstYPoint = null; 
		var kmMark = calculateKmMark(virtualdrawPoints.size()+1) ;
		var lineWidth = 2;
		for(var i = 0; i <= virtualdrawPoints.size(); ++i) {
			var xPoint = x + (i * rate).toNumber() + lineWidth;
			var yPoint = calculateY(i,virtualdrawPoints,scale,initPoint);
			if(i < currentDistance){ 
				cursor = [xPoint, yPoint];
			}
			if(i==0){
				firstXPoint = xPoint;
				firstYPoint = yPoint;
			}
			if(i>0){
				dc.setPenWidth(1);
				if(i > currentDistance){ 
					dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
				}else{
					dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
				}
				dc.fillPolygon([
									[prevXPoint	, prevYPoint-1],
									[xPoint		, yPoint-1	],
									[xPoint		, y			],
									[prevXPoint	, y			]
								]);
				dc.setPenWidth(2);
				dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
				dc.drawLine(prevXPoint, prevYPoint, xPoint, yPoint);
			}
			prevXPoint = xPoint;
			prevYPoint = yPoint;
			
			if(((startKm + i)%kmMark).toLong() == 0){
				dc.setPenWidth(2);
				dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		    	dc.drawLine(xPoint,y+1,xPoint,y+4);
			}

    	}
    	dc.setPenWidth(lineWidth);
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.drawLine(prevXPoint, prevYPoint, prevXPoint, y);
		dc.drawLine(prevXPoint, y, firstXPoint, y);
		dc.drawLine(firstXPoint, y, firstXPoint, firstYPoint);
		dc.setPenWidth(1);
    	return cursor;
	}
	
	
	private function calculateY(i,virtualdrawPoints,scale,initPoint){
		if(i==0 && initPoint == null){
			return y - (base * scale);
		}else if(i==0 && initPoint != null){
			return y - ((initPoint + base) * scale).toNumber();
		}
		else{
			return y - ((virtualdrawPoints[i-1] + base) * scale).toNumber();
		}
	
	}
	
	private function calculateKmMark(size){
		if(zoom){
			return 2;
		}else{
			return (size/4);
		}
	}
	
	private function drawCursor(cursor,dc){
    	if(cursor!=null){
	    	dc.setColor(Graphics.COLOR_BLUE, Graphics.Graphics.COLOR_TRANSPARENT);
	    	dc.fillCircle(cursor[0], cursor[1], 3);
	    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
	    	dc.fillCircle(cursor[0], cursor[1], 2);
	    }
	}
	
	private function selectPoints(currentDistance){
		var virtualDistance = currentDistance;
		if(zoom){
			var zoomDistance = 5;
			var startPoint = currentDistance.toLong() - zoomDistance;
			var endPoint = currentDistance.toLong() + zoomDistance;
			var initPoint = null;
			if(startPoint<0){
				startPoint = 0;
				endPoint = 2 * zoomDistance;
			}else{
				virtualDistance = zoomDistance+0.1;
				
			}
			if(endPoint > drawPoints.size()){
				virtualDistance = zoomDistance+0.1 + (endPoint - drawPoints.size());
				endPoint = drawPoints.size();
				startPoint = drawPoints.size() - 2*zoomDistance;
				
			}
			if((startPoint-1)>0){
				initPoint = drawPoints[(startPoint-1).toNumber()];
			}
			return [drawPoints.slice(startPoint, endPoint),virtualDistance,startPoint.toLong(),initPoint];
		}else{
			return [drawPoints,virtualDistance,0,null];
		}
	}
	
	function changeZoom(){
		zoom = !zoom;
		return zoom;
	}
	
	function resetZoom(){
		zoom = false;
		return zoom;
	}
	
}
