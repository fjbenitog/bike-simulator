using Toybox.Graphics;
using Toybox.WatchUi;

class TrackPicker extends WatchUi.Picker {

	function initialize(){
		var profile1 = [1,2,3,5,7,9,12,15,12,9,8,7,4,3,3,2,3,4,4,1,1,2,3,5,7,9,12,15,12,9,8,7,4,3,3,2,3,4,4,1,1,2,3,5,7,9,12,15,12,9,8,7,4,3,3,2,3,4,4,1];
		var profile2 = [1,2,2,2,3,3,3,4,4,6,7,9,7,7,6,6,3,1,1,2,2,2,3,3,3,4,4,6,7,9,7,7,6,6,3,1,2,3,5,6,7,7,8,7,6,5,5,7,9,12,15,12,9,8,7,4,3,3,2,3,4,4,1];
		var title = new WatchUi.Text({:text=>WatchUi.loadResource(Rez.Strings.tracks), 
			:locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_RED});
		var factory = new TrackFactory([new Track("Track 1",profile1,{}),new Track("Track 2",profile2,{})]);
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
    	Application.getApp().setProperty(Config.TRACKS_KEY, values[0]);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
