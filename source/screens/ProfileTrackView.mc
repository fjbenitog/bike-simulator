using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;

class ProfileTrackView  extends WatchUi.View {

	var drawableTrackProfile;
	
    function initialize() {
        View.initialize();
        drawableTrackProfile = new DrawableTrackProfile({:track => DataTracks.Tracks[0]});
        
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
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        drawableTrackProfile.setY(dc.getHeight()-20);
        drawableTrackProfile.draw(dc);
    }
}

class ProfileTrackDelegate extends ScreenDelegate {

	function initialize(session_, index) {
        ScreenDelegate.initialize(session_, index);
    }
}