using Toybox.WatchUi;
using Toybox.System;

class ConfigMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		if (item == :gears) {
            WatchUi.pushView(new GearsPicker(), new GearsPickerDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }else if (item == :power) {
            WatchUi.pushView(new PowerPicker(), new PowerPickerDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }else if (item == :level) {
            WatchUi.pushView(new LevelPicker(), new LevelPickerDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
        
    }
}
