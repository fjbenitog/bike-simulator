using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;


class ProfileTrackView  extends BaseView {

	var trackProfileScreen;

	function onLayout(dc) {
		BaseView.onLayout(dc);
		var layout = Rez.Layouts.ProfileTrackView(dc);
		trackProfileScreen = layout[0];
		setLayout(layout);
	}
	
    function onHide() {
    	BaseView.onHide();
    	resetZoom();
    }
    

   	function changeZoom(){
   		return trackProfileScreen.changeZoom();
	}
    
    function resetZoom(){
		return trackProfileScreen.resetZoom();
	}
	
	function isZoom(){
		return trackProfileScreen.isZoom();
	}
    
}
