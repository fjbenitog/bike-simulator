using Toybox.WatchUi;
using Toybox.Graphics;
using ActivityValues;
using Toybox.Lang;


class DataFieldsView1 extends BaseView {

    	function onLayout(dc) {
    		BaseView.onLayout(dc);
    		setLayout(Rez.Layouts.DataFieldsView1(dc));
    	}
    	
}

class DataFieldsView2 extends BaseView {
	
    	function onLayout(dc) {
    		BaseView.onLayout(dc);
    		setLayout(Rez.Layouts.DataFieldsView2(dc));
    	}
	    
}
class DataFieldsView3 extends BaseView {
	
	    // Load your resources here
    	function onLayout(dc) {
    		BaseView.onLayout(dc);
    		setLayout(Rez.Layouts.DataFieldsView3(dc));
    	}
	    
}

