using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;


class TrackPickerDelegate extends OwnPickerDelegate {

    function initialize(pickerFactory,index) {
        OwnPickerDelegate.initialize(pickerFactory,index);
    }

    
    function onAccept(value) {
    	Properties.storeActiveTrack(value.id);
    	DataTracks.activeTrack = value;
    	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
    
    function onMenuAction(value){

    	var reversed = value.profile.reverse();
    	var result = [];
    	for(var i = 0 ; i < reversed.size(); i++){
    		result.add(-1 * reversed[i]);
    	}
    	value.profile =  result;
    	value.drawPoints = value.drawPoints.reverse();
    	value.reversed = !value.reversed;
    	WatchUi.requestUpdate();
	}
}
