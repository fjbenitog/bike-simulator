using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class TrackPicker extends WatchUi.Picker {

	function initialize(){
		var profile1 = [4,5,0,5,4,5,2,3,6,4,6,3,10,11,9,10,7,5,10,4];
		var profile2 = [1,1,1,1,1,1,1,1,2,2,1,0,0,0,-1,-1,-1,-1,-1,-2,
						4,5,0,5,4,5,2,3,6,4,6,3,10,11,9,10,7,5,10,4,
						-4,-10,-5,-7,-10,-9,-11,-10,-3,-6,-4,-6,-3,-3,-5,-4,0,-5,-4,
						2,1,0,0,0,3,1,-1,-2,-1,0,1,2,3,1,-1,-1,0,
						1,1,1,1,1,1,1,1,2,2,1,0,0,0,-1,-1,-1,-1,-1,-2,
						4,5,0,5,4,5,2,3,6,4,6,3,10,11,9,10,7,5,10,4,
						-4,-10,-5,-7,-10,-9,-11,-10,-3,-6,-4,-6,-3,-3,-5,-4,0,-5,-4,
						2,1,0,0,0,3,1,-1,-2,-1,0,1,2,3,1,-1,-1,0,
						1,1,1,1,1,1,1,1,2,2,1,0,0,0,-1,-1,-1,-1,-1,-2,
						4,5,0,5,4,5,2,3,6,4,6,3,10,11,9,10,7,5,10,4,
						-4,-10,-5,-7,-10,-9,-11,-10,-3,-6,-4,-6,-3,-3,-5,-4,0,-5,-4,
						2,1,0,0,0,3,1,-1,-2,-1,0,1,2,3,1,-1,-1,0];
		
		var title = new WatchUi.Text({:text=>WatchUi.loadResource(Rez.Strings.tracks), 
			:locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_RED});
		var factory = new TrackFactory([new Track("Covatilla",profile1,{}),new Track("Track 2",profile2,{})]);
		var confirm = new WatchUi.Bitmap({:rezId=>Rez.Drawables.ConfirmIcon, :locX => WatchUi.LAYOUT_HALIGN_CENTER, :locY => WatchUi.LAYOUT_VALIGN_CENTER});
		
		var value = Application.getApp().getProperty(Config.TRACKS_KEY);
		var defaults = null;
        if(value != null) {
            defaults = [ factory.getIndex(value) ];
        }
		
		Picker.initialize({:title=>title, :pattern=>[factory],:confirm=>confirm,:defaults=>defaults});
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
    	System.println(values);
    	Application.getApp().setProperty(Config.TRACKS_KEY, values[0].name);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
