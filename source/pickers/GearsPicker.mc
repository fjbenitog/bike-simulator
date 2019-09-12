using Toybox.Graphics;
using Toybox.WatchUi;

class GearsPicker extends DigitPicker {


    function initialize() {
        DigitPicker.initialize(WatchUi.loadResource(Rez.Strings.gears),1,20,1,Properties.gears());
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
    	Properties.storeGears(values[0]);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}