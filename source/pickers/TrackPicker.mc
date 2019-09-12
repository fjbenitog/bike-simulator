using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class TrackPicker extends WatchUi.Picker {

	function initialize(){
		
		var title = new WatchUi.Text({:text=>WatchUi.loadResource(Rez.Strings.tracks), 
			:locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_RED});
		var factory = new TrackFactory(DataTracks.Tracks);
		var confirm = new WatchUi.Bitmap({:rezId=>Rez.Drawables.ConfirmIcon, :locX => WatchUi.LAYOUT_HALIGN_CENTER, :locY => WatchUi.LAYOUT_VALIGN_CENTER});
		
		Picker.initialize({:title=>title, :pattern=>[factory],:confirm=>confirm,:defaults => [Properties.activeTrack()]});
	}
	
	function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class TrackPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onAccept(values) {
    	Properties.storeActiveTrack(DataTracks.getIndex(values[0].name));
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
