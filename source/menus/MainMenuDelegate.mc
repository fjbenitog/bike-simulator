using Toybox.WatchUi;
using Toybox.System;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		if (item == :config) {
            WatchUi.pushView(new Rez.Menus.ConfigMenu(), new ConfigMenuDelegate(), WatchUi.SLIDE_LEFT);
        } else if (item == :tracks) {
        	var ownPickerDelegate = new TrackPickerDelegate(new TrackFactory(DataTracks.AllTracks()),Properties.activeTrack());
            WatchUi.pushView(new OwnPicker(ownPickerDelegate), ownPickerDelegate, WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :start) {
        	var initView = new ProfileTrackView();
            WatchUi.pushView(initView , new ScreenDelegate(0,initView), WatchUi.SLIDE_IMMEDIATE);
        }
        
    }
}
