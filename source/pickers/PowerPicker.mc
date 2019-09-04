using Toybox.Graphics;
using Toybox.WatchUi;

class PowerPicker extends DigitPicker {


    function initialize() {
        var gears = Application.getApp().getProperty(Config.POWER_KEY);

        DigitPicker.initialize(WatchUi.loadResource(Rez.Strings.power),1,100,1,gears);
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class PowerPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onAccept(values) {
    	Application.getApp().setProperty(Config.POWER_KEY, values[0]);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}