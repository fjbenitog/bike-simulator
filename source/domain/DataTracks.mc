module DataTracks{

	var profile1 	= [4,5,0,5 ,4 ,5 ,2 ,3 ,6 ,4 ,6	,3 ,10,11,9	,10,7 ,5 ,10 ,4];
	var drawPoints1 = [4,9,9,14,18,23,25,28,34,38,44,47,57,68,77,87,94,99,109,113];
	var maxPoint1 	= 113;
	var profile2 = [0,1,3,0,0,-2,-1,-1,0,1,1,1,-2,0,0,0,0,0,
					4,5,0,5,4,5,2,3,6,4,-4,-6,-3,-3,-5,-4,0,-5,-4,
					0,0,0,0,
					6,3,10,11,9,10,7,5,10,4,
					-4,-10,-5,-7,-10,-9,-11,-10,-3,-6,
					0];
						
	var Tracks = [new Track("Covatilla",profile1,drawPoints1,maxPoint1,{}),new Track("Track 2",profile2,drawPoints1,maxPoint1,{})];
}	