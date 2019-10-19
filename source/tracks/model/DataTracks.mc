using Toybox.Application;
using Toybox.System;
module DataTracks{
					
	var activeTrack = null;		
	function AllTracks(){
		return [	new Track(0,"La Covatilla",[4,5,0,5 ,4 ,5 ],850),
					new Track(1,"Hard",[0,1,3,0,0,-2,-1,-1,0,1,1,1,-2,0,0,0,0,0,4,5,0,5 ,4 ,5 ,2 ,3, 6, 4,-4,-6 ,-3,-3,-5,-4,0 ,-5,-4,
						0,0,0,0,6, 3 ,10,11,9 ,10,7 ,5,10 ,4 ,-4,-10,-5,-7,-10,-9,-11,-10,-3,-6,0],150),
					new Track(2,"Medium",[0,0,2,2,2,1,0,0,5,0,-3,3,-2,5,5,6,-6,-5,-5,2,-3,3,0,10,7,-7,2,4,3,2,5,5,2,5,6,7,6,6,6,7,5,-5,
						-7,-6,-6,-6,-7],600),
					new Track(3,"Morcuera - Canencia",[2,0,6,7,7,5,6,6,5,7,2,4,4,-10,-7,-7,-6,-9,-7,-6,-7,-6,-4,
						0,1,6,5,1,0,2,7,7,7,8,-5,-6,-7,-5,-4,-1,-5,-1,-1,-1,-1,-1,-2,-3,
						2,2,2,1,1,3,1,0,0,0,1,-1
						],1173),
					new Track(4,"Long",[2,0,6,7,7,5,6,6,5,7,2,4,4,-10,-7,-7,-6,-9,-7,-6,-7,-6,0,1,1,1,0,0,2,1,0,
						0,1,6,5,1,0,2,3,4,5,7,7,7,8,-5,-6,-7,-5,-4,-1,-5,-1,-1,-1,-1,-1,-2,-3,
						2,2,2,1,1,3,1,0,0,0,1,-1,0,0,1,1,-1,
						0,0,2,2,2,1,0,0,5,0,-3,3,-2,5,5,6,-6,-5,-5,2,-3,3,0,10,7,-7,2,4,3,2,5,5,2,5,6,7,6,6,6,7,5,-5,
						-7,-6,-6,-6,-7,1,2,3,2,1,1
						],350)
				 ];
	}		
	

    
    function getActiveTrack(){
    	if(activeTrack == null){
    		var tracks = AllTracks();
    		var active = Properties.activeTrack();
    		System.println("active:"+active);
    		activeTrack = tracks[active];
    	}
    	return activeTrack;
    }
    
    function setActiveTrack(track){
    	activeTrack = track;
    }
}	