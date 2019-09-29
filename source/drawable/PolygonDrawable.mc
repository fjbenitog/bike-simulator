using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class PolygonDrawable {


	private var maxSize = 60;
    
    function draw(dc,polygon) {
    	if(polygon !=null){
    		if(polygon.size() <= maxSize){
    			dc.fillPolygon(polygon);
    		}else{
    			
    			var cleanPolygon =  polygon.slice(0, -2);
    			var y = polygon.slice(-1, null)[0][1];
    			
    			var processedPoints = 0;
    			
    			while(processedPoints<cleanPolygon.size()){
    				var finalInterval = processedPoints+maxSize;
    				var initialInterval = processedPoints -1 ;
    				if(finalInterval>cleanPolygon.size()){
    					finalInterval = cleanPolygon.size();
    				}
    				if(initialInterval<0){
    				
    					initialInterval = 0;
    				}
    				var mainPoints = cleanPolygon.slice(initialInterval,finalInterval);
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