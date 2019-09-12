using Toybox.Graphics;
using Toybox.WatchUi;

class PowerPicker extends DigitPicker {


    function initialize() {
        DigitPicker.initialize(WatchUi.loadResource(Rez.Strings.power),1,100,1,Properties.power());
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
    	Properties.storePower(values[0]);
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}