using Toybox.Graphics;
using Toybox.WatchUi;

class TrackFactory extends WatchUi.PickerFactory {

	var tracks;
	
	function initialize(tracks_, options) {
        PickerFactory.initialize();

        tracks = tracks_;
    }
    
    function getIndex(value) {

		for(var i = 0; i < tracks.size(); ++i) {
			if(tracks[i].equals(value)) {
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
        return new WatchUi.Text({:text=>tracks[index], :color=>Graphics.COLOR_BLUE, :font=>Graphics.FONT_SMALL, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER});
    }
}