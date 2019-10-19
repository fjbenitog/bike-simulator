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
	var stopTimer;
	
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
            view = DataFields.createView1();
        }else if(2 == index){
            view = DataFields.createView2();
        }else {
        	view = DataFields.createView3();
        }
		currentView = view;
        return view;
    }

    function onSelect() {
		var status = record.handle();
		if(status == Activity.Started){
			hideSensors();
		}
		if(status == Activity.Stopped){
			fireStopMenu();
		}
		stateRecording(status);
		return true;
	}
	
	function onBack() {
		if(!record.isSessionStart()){
			return false;
		}
		else if(record.isRecording()){
			lap();
			return true;
		}
		else{
			pushStopMenu();
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
    
    private function lap(){
    	var lapValues = record.lap();
		if(lapValues!=null){
			activityAlert.lapAlert(lapValues.get(:lapNumber),lapValues.get(:speedLap),lapValues.get(:distanceLap));
		}
    }
    
    private function changeZoom(){
    	if(currentView has :changeZoom){
    		currentView.changeZoom();
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
    	if(currentView has :hideSensors){
    		currentView.hideSensors();
    		return false;
    	}else{
    		return true;
    	}
    }
    
    private function stateRecording(state){
    	if(currentView has :start && state == Activity.Started){
    		currentView.start();
    	}
    	if(currentView has :stop && state == Activity.Stopped){
    		currentView.stop();
    	}
    }
    
    private function fireStopMenu(){
		if(stopTimer!=null){
			stopTimer.stop();
		}
		stopTimer = new Timer.Timer();
	    stopTimer.start(method(:pushStopMenu),1500,false);
	}
		
	function pushStopMenu(){
		if(!record.isRecording()){
			var stopMenu = new Rez.Menus.StopMenu();
			var title = ActivityValues.calculateTime()+" - "+ActivityValues.calculateDistance();
			stopMenu.setTitle(title);
			WatchUi.pushView(
				stopMenu,
			 	new StopMenuDelegate(
			 		record.method(:discard),
			 		record.method(:handle),
			 		record.method(:save),
			 		method(:release)
			 		),
			  	WatchUi.SLIDE_IMMEDIATE);
		 }
	}
	
	function release(){
		if(activityRefreshTimer!=null){
			activityRefreshTimer.stop();
		}
	}
    
    
    
    
}