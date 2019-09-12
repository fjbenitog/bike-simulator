using Toybox.Application;
using Toybox.Lang;
module Properties{

	module Config{

		const GEARS_KEY = "gears";
	
		const POWER_KEY = "power";
	
		const TRACKS_KEY = "tracks";
	
		const LEVEL_KEY = "level";
	}

	function activeTrack(){
		var value = Application.getApp().getProperty(Config.TRACKS_KEY);
		if(value !=null && value instanceof Lang.Number) {
			return value;
		}else{
			return 0;
		}
	}
	
	function storeActiveTrack(activeTrack){
    	Application.getApp().setProperty(Config.TRACKS_KEY, activeTrack);
	}
	
	function gears(){
		var gears = Application.getApp().getProperty(Config.GEARS_KEY);
		if(gears !=null && gears instanceof Lang.Number) {
			return gears;
		}else{
			return 8;
		}
	}
	
	function storeGears(gears){
    	Application.getApp().setProperty(Config.GEARS_KEY, gears);
	}
	
	function power(){
  		var power = Application.getApp().getProperty(Config.POWER_KEY);
		if(power !=null && power instanceof Lang.Number) {
			return power;
		}else{
			return 10;
		}
	}
	
	function storePower(power){
    	Application.getApp().setProperty(Config.POWER_KEY, power);
	}
	
	function level(){
  		var level = Application.getApp().getProperty(Config.LEVEL_KEY);
		if(level !=null && level instanceof Lang.Number) {
			return level;
		}else{
			return 5;
		}
	}
	
	function storeLevel(level){
    	Application.getApp().setProperty(Config.LEVEL_KEY, level);
	}
	

}