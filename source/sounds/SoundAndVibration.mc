using Toybox.Attention;

module SoundAndVibration{

	function playingTone(tone){
		if(Attention has :playTone){
			Attention.playTone(tone);
		}
	}
	
	function vibrating(){
		if (Attention has :vibrate) {
			var vibeData =
				[
					new Attention.VibeProfile(50, 250)
				];
			Attention.vibrate(vibeData);
		}	
	}
	
	function playStart(){
		if(Attention has :TONE_START){
			playingTone(Attention.TONE_START);
		}
		vibrating();
	
	}
	
	function playStop(){
		if(Attention has :TONE_STOP){
			playingTone(Attention.TONE_STOP);
		}
		vibrating();
	}
	
	function playAlert(){
		if(Attention has :TONE_INTERVAL_ALERT){
			playingTone(Attention.TONE_INTERVAL_ALERT);
		}
		vibrating();
	}
	
}