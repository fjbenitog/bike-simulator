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
            WatchUi.pushView(new TrackPicker(), new TrackPickerDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
        else if (item == :start) {
            WatchUi.pushView(new DataFieldsView(), new DataFieldsDelegate(null,1), WatchUi.SLIDE_IMMEDIATE);
        }
        
    }
}
