using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class PolygonDrawable extends WatchUi.Drawable {

	private var polygon;
	private var maxSize = 64;
	
	function initialize(options){
        Drawable.initialize(options);
        polygon = options.get(:polygon);
    }
    
    function draw(dc) {
    	if(polygon !=null){
    		if(polygon.size() <= maxSize){
    			dc.fillPolygon(polygon);
    		}else{
    			
    			var cleanPolygon =  polygon.slice(0, -2);
    			var y = polygon.slice(-1, null)[0][1];
    			
    			var processedPoints = 0;
    			var interval = maxSize - 2;
    			
    			while(processedPoints<cleanPolygon.size()){
    				var finalInterval = processedPoints+interval;
    				if(finalInterval>cleanPolygon.size()){
    					finalInterval = cleanPolygon.size();
    				}
    				var mainPoints = cleanPolygon.slice(processedPoints,finalInterval);
    				processedPoints = finalInterval;
    				var lastPoint = mainPoints.slice(-1, null)[0];
    				var firstPoint = mainPoints.slice(0, 1)[0];
    				mainPoints.add([lastPoint[0],y]);
    				mainPoints.add([firstPoint[0],y]);
    				dc.fillPolygon(mainPoints);
    			}

    		}
    	
    	}
    }
}