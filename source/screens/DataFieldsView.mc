using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;

class DataFieldsView extends BaseView {

	var dataFields;
	
    function initialize(fields) {
        BaseView.initialize();
        dataFields = new DrawableDataFields({:dataFields => fields});
    }



    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
		dc.clear();
		dataFields.draw(dc);
		BaseView.onUpdate(dc);
    }


    
}


