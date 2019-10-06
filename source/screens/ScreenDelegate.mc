using Toybox.WatchUi;
using SoundAndVibration as SV;
using Activity;


var zoom = false;

class ScreenDelegate extends WatchUi.BehaviorDelegate {
	
	private const numSreens = 3;
	
	var index;


	var record;
	
	function initialize(index_) {
        BehaviorDelegate.initialize();
        index = index_;
        record = new Activity.Record();
    }
    
    
    function onNextPage() {
        index = (index + 1) % numSreens;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_LEFT);
        zoom = false;
    }

    function onPreviousPage() {
        index = index - 1;
        if (index < 0) {
            index = numSreens-1;
        }
        index = index % numSreens;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_RIGHT);
        zoom = false;
    }
    
    function onKey(evt) {
        var key = evt.getKey();
        if (WatchUi.KEY_DOWN == key) {
            onNextPage();
        } else if (WatchUi.KEY_UP == key) {
            onPreviousPage();
        }
    }

    private function getView(index) {
        var view;

        if (0 == index) {
            view = new ProfileTrackView();
        } else if(1 == index){
            view = new DataFieldsView1();
        }else {
        	view = new DataFieldsView2();
        }

        return view;
    }

    function onSelect() {
		record.handle();
		return true;
	}
	
	function onBack() {
		if(record.isRecording()){
			return true;
		}else{
			record.pushStopMenu();
    		return true;                  
    	}

    }
    
    function onMenu() {
    	if(index == 0){
    		zoom = !zoom;
    		WatchUi.requestUpdate();
    		return true;
    	}
    	return BehaviorDelegate.onMenu();
    }
    
    
}