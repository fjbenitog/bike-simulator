using Toybox.WatchUi;
using SoundAndVibration as SV;
using Activity;


class ScreenDelegate extends WatchUi.BehaviorDelegate {
	
	private const numSreens = 4;
	
	var index;
	var record;
	var currentView;
	var activityRefreshTimer;
	var activityAlert = new ActivityAlert(DataTracks.getActiveTrack().profile.size());
	
	function initialize(index_, currentView_) {
        BehaviorDelegate.initialize();
        index = index_;
        currentView = currentView_;
        record = new Activity.Record();
        
        activityRefreshTimer = new Timer.Timer();
        activityRefreshTimer.start(method(:refreshValues),1000,true);
    }
    
    function refreshValues(){
		try {
			var isAlert = activityAlert.checkAlert(!isZoom());	
			if(isAlert){
				record.collectData();
			}
			WatchUi.requestUpdate();
		} catch (e instanceof Lang.Exception) {
			WatchUi.requestUpdate();
		}
    	
	}
    
    
    function onNextPage() {
        index = (index + 1) % numSreens;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_LEFT);
    }

    function onPreviousPage() {
        index = index - 1;
        if (index < 0) {
            index = numSreens-1;
        }
        index = index % numSreens;
        WatchUi.switchToView(getView(index), self, WatchUi.SLIDE_RIGHT);
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
        }else if(2 == index){
            view = new DataFieldsView2();
        }else {
        	view = new DataFieldsView3();
        }
		currentView = view;
        return view;
    }

    function onSelect() {
		record.handle();
//		refreshValues(); TODO: Maybe not necessary
		hideSensors();
		stateRecording();
		return true;
	}
	
	function onBack() {
		if(!record.isSessionStart()){
			return false;
		}
		else if(record.isRecording()){
			var lapValues = record.lap();
			if(lapValues!=null){
				activityAlert.lapAlert(lapValues.get(:lapNumber),lapValues.get(:speedLap),lapValues.get(:distanceLap));
			}
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
//    		record.setZoomMode(zoomMode);
    		return true;
    	}
    	return false;

    }
    
    
    private function isZoom(){
    	if(currentView has :isZoom){
    		return currentView.isZoom();
    	}
    	return false;

    }
    
    private function hideSensors(){
    	if(currentView has :hideSensors && record.isRecording()){
    		currentView.hideSensors();
    		return false;
    	}else{
    		return true;
    	}
    }
    
    private function stateRecording(){
    	if(currentView has :start && record.isRecording()){
    		currentView.start();
    	}
    	if(currentView has :stop && !record.isRecording()){
    		currentView.stop();
    	}
    }
    
    
    
    
}