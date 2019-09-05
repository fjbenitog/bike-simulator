using Toybox.Graphics;
using Toybox.WatchUi;

class LevelPicker extends DigitPicker {


    function initialize() {
        var level = Application.getApp().getProperty(Config.LEVEL_KEY);

        DigitPicker.initialize(WatchUi.loadResource(Rez.Strings.level),1,10,1,level);
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class LevelPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onAccept(values) {
    	Application.getApp().setProperty(Config.LEVEL_KEY, values[0]);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}