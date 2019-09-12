using Toybox.Graphics;
using Toybox.WatchUi;

class TrackFactory extends WatchUi.PickerFactory{

	var tracks;

 	function initialize(tracks_) {
 	    PickerFactory.initialize();
 		tracks = tracks_;
 	}
 	
    function getSize() {
        return tracks.size();
    }

    function getValue(index) {
        return tracks[index];
    }

    function getDrawable(index, selected) {
        return new DrawableTrack({:track => tracks[index]});
    }
}