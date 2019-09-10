using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;

class ProfileTrackView  extends WatchUi.View {

	var index;
	
    function initialize() {
        View.initialize();
        var trackKey = Application.getApp().getProperty(Config.TRACKS_KEY);
        index = getIndex(DataTracks.Tracks,trackKey);
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        var drawableTrackProfile  = new DrawableTrackProfile({
        	:track 	=> DataTracks.Tracks[index],
        	:width 	=> 187, 
        	:height => 118,
        	:y 		=> dc.getHeight()-50,
        	:x 		=> 20
        	});
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        drawableTrackProfile.draw(dc);
    }
    
    function getIndex(tracks,value) {
        for(var i = 0; i < tracks.size(); ++i) {
        	if(tracks[i].name.equals(value)){
        		return i;
        	}
        }
        return 0;
    }
}

class ProfileTrackDelegate extends ScreenDelegate {

	function initialize(session_, index) {
        ScreenDelegate.initialize(session_, index);
    }
}