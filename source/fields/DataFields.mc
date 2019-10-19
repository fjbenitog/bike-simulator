using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;
using Toybox.Lang;


class DataFieldsView extends BaseView {
	
		var fields;
		
	    function initialize(fields_) {
	        BaseView.initialize();
	        fields = fields_;
	        
	    }
	    
	    // Load your resources here
    	function onLayout(dc) {
    		BaseView.onLayout(dc);
    		setLayout([new DrawableDataFields({:dataFields => fields})]);
    	}
	
	    // Update the view
	    function onUpdate(dc) {
			BaseView.onUpdate(dc);
	    }
	    
}

