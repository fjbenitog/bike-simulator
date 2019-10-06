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
	var width =  System.getDeviceSettings().screenWidth - 1;
	var height;
	var padding = 0;
	var font = Graphics.FONT_XTINY;
	var polygonDrawable = new PolygonDrawable();
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
	

		//Calculate scales to redimension Profile
		var distance = virtualdrawPoints.size();
		var pethWidth = 3;
		var rate = (width.toDouble()  - pethWidth) / distance;
		var scale = height.toDouble() / (maxPoint +base);
		

		//Draw border and populate polygon for profile
		var polygons = calculatePolygonsAndDrawLine(rate,scale,pethWidth,virtualdrawPoints,currentDistance,dc);
		var currentPolygon = polygons[0];
		var polygon = polygons[1];

		closePolygonAndDrawLines(polygon,dc);
		closePolygonAndDrawLines(currentPolygon,dc);
    	
    	//Draw Fill 
    	fillPolygon(polygon,Graphics.COLOR_ORANGE,dc);
    	fillPolygon(currentPolygon,Graphics.COLOR_RED,dc);
    	
    	drawCursor(currentPolygon,dc);
    	
		if(zoom){
	    	dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_TRANSPARENT);
			dc.drawText(x + width/2, y + padding/2, Graphics.FONT_SYSTEM_TINY, "Z:[ " + ActivityValues.calculateDistance() + "/" +totalDistance + " Kms ]", Graphics.TEXT_JUSTIFY_CENTER);
			
    	}else{
    		dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_TRANSPARENT);
			dc.drawText(x + width/2, y + padding, font, distance + " Kms", Graphics.TEXT_JUSTIFY_CENTER);
	    	var realWidth = polygon[polygon.size()-2][0]-polygon[polygon.size()-1][0];
	    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
	    	dc.drawLine(x+realWidth/4,y+1,x+realWidth/4,y+4);
	    	dc.drawLine(x+realWidth/2,y+1,x+realWidth/2,y+4);
	    	dc.drawLine(x+3*realWidth/4,y+1,x+3*realWidth/4,y+4);
    	}
    	
    	
	}
	
	private function calculatePolygonsAndDrawLine(rate,scale,pethWidth,virtualdrawPoints,currentDistance,dc){
		var polygon = [];
		var currentPolygon = [];
		var prevXPoint = null;
		var prevYPoint = null; 
		dc.setColor(Graphics.COLOR_WHITE, Graphics.Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(pethWidth);
		for(var i = 0; i < virtualdrawPoints.size(); ++i) {
			var xPoint = x + (i * rate).toNumber() + pethWidth + 1;
			var yPoint = y - ((virtualdrawPoints[i] + base) * scale).toNumber();
			if(i < currentDistance ){ 
				currentPolygon.add([xPoint, yPoint]);
			}
			if(i >= currentDistance - 1){
				polygon.add([xPoint, yPoint]);
			}
		
			if(i>0){
				dc.drawLine(prevXPoint, prevYPoint, xPoint, yPoint);
			}
			prevXPoint = xPoint;
			prevYPoint = yPoint;

    	}
    	return [currentPolygon,polygon];
	}
	
	private function closePolygonAndDrawLines(polygon,dc){
		if(polygon.size() > 0){
			dc.setPenWidth(1);
	    	var lastPoint = polygon[polygon.size() - 1];
	    	var firstPoint = polygon[0];
	    	polygon.add([lastPoint[0] , y]);
	    	polygon.add([firstPoint[0], y]);
	    	dc.drawLine(lastPoint[0], lastPoint[1], lastPoint[0], y);
	    	dc.drawLine(lastPoint[0], y, firstPoint[0], y);
	    	dc.setPenWidth(2);
	    	dc.drawLine(firstPoint[0], y, firstPoint[0], firstPoint[1]);
 			dc.setPenWidth(1);
    	}
	}
	
	private function fillPolygon(polygon,color,dc){
    	if(polygon.size() > 0){
			dc.setColor(color, Graphics.COLOR_TRANSPARENT);
			polygonDrawable.draw(dc,polygon);
 
		}
	}
	
	private function drawCursor(currentPolygon,dc){
    	if(currentPolygon.size() > 0){
	    	dc.setColor(Graphics.COLOR_BLUE, Graphics.Graphics.COLOR_TRANSPARENT);
	    	dc.fillCircle(currentPolygon[currentPolygon.size()-3][0], currentPolygon[currentPolygon.size()-3][1], 3);
	    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
	    	dc.fillCircle(currentPolygon[currentPolygon.size()-3][0], currentPolygon[currentPolygon.size()-3][1], 2);
	    }
	}
	
	private function selectPoints(currentDistance){
		var virtualDistance = currentDistance;
		if(zoom){
			var zoomDistance = 5;
			var startPoint = currentDistance - zoomDistance;
			var endPoint = currentDistance + zoomDistance;
			if(startPoint<0){
				startPoint = 0;
				endPoint = 2 * zoomDistance;
			}else{
				virtualDistance = zoomDistance;
			}
			if(endPoint > drawPoints.size()){
				virtualDistance = zoomDistance + (endPoint - drawPoints.size());
				endPoint = drawPoints.size();
				startPoint = drawPoints.size() - 2*zoomDistance;
				
			}
			
			return [drawPoints.slice(startPoint, endPoint),virtualDistance];
		}else{
			return [drawPoints,virtualDistance];
		}
	}
	
	function changeZoom(){
		zoom = !zoom;
	}
	
	function resetZoom(){
		zoom = false;
	}
}
