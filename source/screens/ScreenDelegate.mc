using Toybox.WatchUi;
using SoundAndVibration as SV;
using Activity;


class ScreenDelegate extends WatchUi.BehaviorDelegate {
	
	private const numSreens = 3;
	
	var index;
	var record;
	var currentView;
	
	function initialize(index_, currentView_) {
        BehaviorDelegate.initialize();
        index = index_;
        currentView = currentView_;
        record = new Activity.Record();
    }
    
    
    function onNextPage() {
        index = (index + 1) % numSreens;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_LEFT);
        resetZoom();
    }

    function onPreviousPage() {
        index = index - 1;
        if (index < 0) {
            index = numSreens-1;
        }
        index = index % numSreens;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_RIGHT);
        resetZoom();
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
		currentView = view;
        return view;
    }

    function onSelect() {
		record.handle();
		return true;
	}
	
	function onBack() {
		if(!record.isSessionStart()){
			return false;
		}
		else if(record.isRecording()){
			record.lap();
			return true;
		}
		else{
			record.pushStopMenu();
    		return true;                  
    	}

    }
    
    function onMenu() {
    	if(changeZoom()){
    		return true;
    	}else{
    		return BehaviorDelegate.onMenu();
    	}
    }
    
    private function changeZoom(){
    	if(currentView has :changeZoom){
    		currentView.changeZoom();
    		WatchUi.requestUpdate();
    		return true;
    	}
    	return false;

    }
    
    private function resetZoom(){
    	if(currentView has :resetZoom){
    		currentView.resetZoom();
    		return true;
    	}else{
    		return false;
    	}
    }
    
    
}