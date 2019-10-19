using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

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
    	var settings = System.getDeviceSettings(); 
    	var options = 	{
    					:track 		=> getValue(index),
    					:width 		=> settings.screenWidth - 44, 
			        	:height 	=> settings.screenHeight/2 - 55,
			        	:y 			=> 3 * settings.screenHeight/4 ,
			        	:x 			=> 22,
			        	:padding	=> 8,
			        	:font		=> Graphics.FONT_SYSTEM_TINY
    					};
    	var drawableTrack = new DrawableTrack(options);
        return drawableTrack;
    }
}