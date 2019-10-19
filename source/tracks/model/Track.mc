class Track{

	var id;
	var name;
	var profile;
	var drawPoints;
	var maxPoint;
	var altitude;
	
	
	function initialize(id_,name_,profile_,altitude_) {
		id = id_;
        name = name_;
        profile = profile_;
        altitude = altitude_;
        
        drawPoints = new [profile_.size()];
        var previousPoint = 0;
        maxPoint = 0;
        for(var i = 0 ; i < drawPoints.size() ; i++){
        	previousPoint = previousPoint + profile[i];
        	drawPoints[i] = previousPoint;
        	if(maxPoint < previousPoint){
        		maxPoint = previousPoint;
        	}
        }
    }
}