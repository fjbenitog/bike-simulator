using Toybox.Graphics;
using Toybox.WatchUi;

class GearsPicker extends DigitPicker {


    function initialize() {
        var gears = Application.getApp().getProperty(Config.GEARS_KEY);

        DigitPicker.initialize(WatchUi.loadResource(Rez.Strings.gears),1,20,1,gears);
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
    	Application.getApp().setProperty(Config.GEARS_KEY, values[0]);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}