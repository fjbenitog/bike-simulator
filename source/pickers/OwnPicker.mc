using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;


class OwnPicker extends WatchUi.View {
	
	private var padding = 10;
	private var arrowSize = 20;
	private var delegate;
    function initialize(delegate_) {
        View.initialize();
        delegate = delegate_;
    }

    // Load your resources here
    function onLayout(dc) {
        
    }

    // onShow() is called when this View is brought to the foreground
    function onShow() {
    }

    // onUpdate() is called periodically to update the View
    function onUpdate(dc) {
        View.onUpdate(dc);
    	drawTitle(dc);
    	
    	drawArrowUp(dc);
    	var drawableTrack = delegate.getDrawable();
    	drawableTrack.draw(dc);
    	
    	drawArrowDown(dc);
    }
    
    function drawTitle(dc){
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	dc.setPenWidth(2);
    	dc.drawLine(0, dc.getHeight()/4, dc.getWidth(), dc.getHeight()/4);
		dc.setPenWidth(1);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.drawText(dc.getWidth()/2 , dc.getHeight()/8, 
			Graphics.FONT_SYSTEM_MEDIUM, WatchUi.loadResource(Rez.Strings.tracks),
			Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    function drawArrowUp(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon([
    					[(dc.getWidth() - arrowSize)/2 	, dc.getHeight()/4 + padding + arrowSize/2	],
    					[dc.getWidth()/2				, dc.getHeight()/4 + padding				],
    					[(dc.getWidth() + arrowSize)/2	, dc.getHeight()/4 + padding + arrowSize/2	]
    					]);
    }
    
    function drawArrowDown(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon([
    					[(dc.getWidth() - arrowSize)/2 	, dc.getHeight() - padding - arrowSize/2	],
    					[dc.getWidth()/2				, dc.getHeight() - padding 					],
    					[(dc.getWidth() + arrowSize)/2	, dc.getHeight() - padding - arrowSize/2	]
    					]);
    }

    // onHide() is called when this View is removed from the screen
    function onHide() {
    }
    
}

class OwnPickerDelegate extends WatchUi.BehaviorDelegate {
	private var pickerFactory;
	private var index = 0;
	
    function initialize(pickerFactory_,index_) {
        BehaviorDelegate.initialize();
        pickerFactory = pickerFactory_;
        index = index_;
        if(index<0 || index>pickerFactory.getSize()-1){
        	index = 0;
        }
    }
    
    function onNextPage() {
        index = (index + 1) % pickerFactory.getSize();
        WatchUi.requestUpdate();
    }

    function onPreviousPage() {
        index = index - 1;
        if (index < 0) {
            index = pickerFactory.getSize()-1;
        }
        index = index % pickerFactory.getSize();
        WatchUi.requestUpdate();
    }
    
    function onKey(evt) {
        var key = evt.getKey();
        if (WatchUi.KEY_DOWN == key) {
            onNextPage();
        } else if (WatchUi.KEY_UP == key) {
            onPreviousPage();
        }
    }
    
    function getDrawable(){
    	return pickerFactory.getDrawable(index, true);
    }

	function onAccept(values) {
	}

    function onSelect() {
    	onAccept(pickerFactory.getValue(index));
    	return true;
	}
	
}