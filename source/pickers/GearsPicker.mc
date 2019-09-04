using Toybox.Graphics;
using Toybox.WatchUi;

class GearsPicker extends DigitPicker {


    function initialize() {
        var gears = Application.getApp().getProperty(Config.GEAR_KEY);

        DigitPicker.initialize(WatchUi.loadResource(Rez.Strings.gears),1,12,1,gears);
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class GearsPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onAccept(values) {
    	Application.getApp().setProperty(Config.GEAR_KEY, values[0]);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}