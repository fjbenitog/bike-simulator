using Toybox.Attention;

module SoundAndVibration{

	function playingTone(tone){
		try{
			if(Attention has :playTone){
				Attention.playTone(tone);
			}
		} catch (e instanceof Lang.Exception) {
				WatchUi.requestUpdate();
		}
	}
	
	function vibrating(){
		try {
			if (Attention has :vibrate) {
				var vibeData =
					[
						new Attention.VibeProfile(50, 250)
					];
				Attention.vibrate(vibeData);
			}
		} catch (e instanceof Lang.Exception) {
				WatchUi.requestUpdate();
		}	
	}
	
	function playStart(){
		try {
			if(Attention has :TONE_START){
				playingTone(Attention.TONE_START);
			}
			vibrating();
		} catch (e instanceof Lang.Exception) {
				WatchUi.requestUpdate();
		}
	
	}
	
	function playStop(){
		try{
			if(Attention has :TONE_STOP){
				playingTone(Attention.TONE_STOP);
			}
			vibrating();
		} catch (e instanceof Lang.Exception) {
				WatchUi.requestUpdate();
		}
	}
	
	function playAlert(){
		try{
			if(Attention has :TONE_INTERVAL_ALERT){
				playingTone(Attention.TONE_INTERVAL_ALERT);
			}
			vibrating();
		} catch (e instanceof Lang.Exception) {
				WatchUi.requestUpdate();
		}
	}
	
}