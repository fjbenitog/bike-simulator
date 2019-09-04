using Toybox.Graphics;
using Toybox.WatchUi;

class TrackFactory extends WatchUi.PickerFactory{

	var tracks;

 	function initialize(tracks_) {
 	    PickerFactory.initialize();
 		tracks = tracks_;
 	}
 	
 	function getIndex(value) {
        for(var i = 0; i < tracks.size(); ++i) {
        	if(tracks[i].name == value.name){
        		return i;
        	}
        }
        return 0;
    }
 	
    function getSize() {
        return tracks.size();
    }

    function getValue(index) {
        return tracks[index];
    }

    function getDrawable(index, selected) {
        return new DrawableTrack(tracks[index],{});
    }
}