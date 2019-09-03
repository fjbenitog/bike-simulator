using Toybox.Graphics;
using Toybox.WatchUi;

class TrackPicker extends WatchUi.Picker {

    function initialize() {
        var title = new WatchUi.Text({:text=>Rez.Strings.tracksTitle, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_RED});
        var factory = new TrackFactory(["Track1","Track2"], {:font=>Graphics.FONT_SMALL});
        Picker.initialize({:title=>title, :pattern=>[factory]});
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class TrackPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}