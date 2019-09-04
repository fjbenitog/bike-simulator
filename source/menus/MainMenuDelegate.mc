 using Toybox.WatchUi;
using Toybox.System;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		if (item == :config) {
            WatchUi.pushView(new Rez.Menus.ConfigMenu(), new ConfigMenuDelegate(), WatchUi.SLIDE_LEFT);
        } 
    }
}
