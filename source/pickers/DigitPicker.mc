using Toybox.Graphics;
using Toybox.WatchUi;

class DigitPicker extends WatchUi.Picker {

    function initialize(title_,start,stop,increment,value) {
        var title = new WatchUi.Text({:text=>title_, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_RED});
        var factory = new DigitFactory(start,stop,increment, {:font=>Application.getApp().getProperty("pickerFont")});
        var confirm = new WatchUi.Bitmap({:rezId=>Rez.Drawables.ConfirmIcon, :locX => WatchUi.LAYOUT_HALIGN_CENTER, :locY => WatchUi.LAYOUT_VALIGN_CENTER});
        
        var defaults = null;
        if(value != null) {
            defaults = [ factory.getIndex(value) ];
        }
        
        Picker.initialize({:title=>title, :pattern=>[factory],:confirm=>confirm,:defaults=>defaults});
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}