using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView extends BaseView {

	var dataFields;
	
    function initialize(fields) {
        BaseView.initialize();
        dataFields = new DrawableDataFields({:dataFields => fields});
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
		dc.clear();
		dataFields.draw(dc);
		BaseView.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
}


