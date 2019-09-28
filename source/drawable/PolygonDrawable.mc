using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class PolygonDrawable extends WatchUi.Drawable {

//TODO: There is some bug. Investigate
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
    			var subPolygons = ((polygon.size().toDouble()/(maxSize-1))+1).toNumber();
    			for(var i = 0 ; i < subPolygons ; i++){
    				var extra = cleanPolygon.slice((i*(maxSize-2)), (maxSize-2)+(i*(maxSize-2)));
    				var lastPoint = extra.slice(-1, null)[0];
    				var firstPoint = extra.slice(0, 1)[0];
    				extra.add([lastPoint[0],y]);
    				extra.add([firstPoint[0],y]);
    				dc.fillPolygon(extra);
    			}
    			var totalProcessed = (subPolygons*(maxSize-2))+1;
    			var remaining = cleanPolygon.size() - totalProcessed;
    			if(remaining>0){
	    			var extra = cleanPolygon.slice((subPolygons*(maxSize-2))-1, null);
					var lastPoint = extra.slice(-1, null)[0];
					var firstPoint = extra.slice(0, 1)[0];
					extra.add([lastPoint[0],y]);
					extra.add([firstPoint[0],y]);
					dc.fillPolygon(extra);
    			}
    		}
    	
    	}
    }
}