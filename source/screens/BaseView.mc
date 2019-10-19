using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math;
using Toybox.System;
using ActivityValues;
using Toybox.Timer;

class BaseView extends WatchUi.View {
	
	private var heartIcon;
	private var speedIcon;
	private var cadenceIcon;
	
	private var sensorTimer;
	
	private var displaySensors = false;
	
	private var blinking = true;
	
	private var starting = false;
	private var stopping  = false;
	
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	if(ActivityValues.time()<=0){
	    	heartIcon = WatchUi.loadResource(Rez.Drawables.HeartIcon);
	    	speedIcon = WatchUi.loadResource(Rez.Drawables.SpeedIcon);
	    	cadenceIcon = WatchUi.loadResource(Rez.Drawables.CadenceIcon);
    	
	    	sensorTimer = new Timer.Timer();
	        sensorTimer.start(method(:showSensors),2000,false); 
        }
        
    }

    // Update the view
    function onUpdate(dc) {

    	if(displaySensors){
        	drawSensorsInfo(dc);
        	drawBattery(dc);
        }
    	drawStartingIcon(dc);
    	drawStoppingIcon(dc);
    }
    
    private function drawStartingIcon(dc){

    	if(starting){
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
			var size = min(dc.getWidth(),dc.getHeight())/2;
			
			dc.fillPolygon(
			[
				[(dc.getWidth() - size)/2, (dc.getHeight()-size)/2],
				[(dc.getWidth() + size)/2, dc.getHeight()/2],
				[(dc.getWidth() - size)/2, (dc.getHeight() + size)/2],
			]);
			dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
			dc.fillPolygon(
			[
				[(dc.getWidth()- size)/2 + 5, (dc.getHeight()-size)/2+ 8],
				[(dc.getWidth() + size)/2 - 10, dc.getHeight()/2],
				[(dc.getWidth() - size)/2 + 5, (dc.getHeight() + size)/2 - 8],
			]);
		}
    
    }
    
    private function drawStoppingIcon(dc){
    	if(stopping){
    		var size = min(dc.getWidth(),dc.getHeight())/2;
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
			dc.fillRectangle((dc.getWidth() - size)/2, (dc.getHeight()-size)/2, size, size);
			dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
			dc.fillRectangle((dc.getWidth() - size)/2 + 5, (dc.getHeight()-size)/2 + 5, size - 10, size -10);
		}
    
    }
    
    private function drawSensorsInfo(dc){
    	var height = dc.getHeight()/3;
    	var column = dc.getWidth()/4;
    	var marging = 35;
    	
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0,0,dc.getWidth(),height);
    	dc.setPenWidth(2);
    	dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
    	dc.drawLine(0, height, dc.getWidth(), height);
    	if(blinking || Activity.heartRateActive){
    		dc.drawBitmap(column -11 , height - marging, heartIcon);
    	}
    	if(blinking || Activity.bikeSpeedActive){
    		dc.drawBitmap(column*2 - 11, height - marging, speedIcon);
    	}
    	if(blinking || Activity.bikeCadenceActive){
    		dc.drawBitmap(column*3 -11 , height - marging, cadenceIcon);
    	}
    }
    
    private function drawBattery(dc){
    	var battery = System.getSystemStats().battery;
    	dc.setPenWidth(1);
    	var width = 30;
    	var height = dc.getHeight()/6 - 25;
    	var x = (dc.getWidth() - width)/2 - 1;
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	dc.drawRectangle(x,height,width,15);
    	dc.fillRectangle(x+2,height+2,((width - 4) * battery)/100,11);
    	dc.fillRectangle(x + width, height + 4, 2, 8);
    }
    
    

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	starting = false;
    	stopping = false;
    	if(sensorTimer!=null){
    		sensorTimer.stop();
    	}
    }
    
    function hideSensors(){
    	displaySensors = false;
    }
    
    function showSensors(){
    	displaySensors = true;
    	WatchUi.requestUpdate();
    	sensorTimer = new Timer.Timer();
        sensorTimer.start(method(:changeStateBlininkg),1000,true); 
    }
    
    function changeStateBlininkg(){
    	blinking = !blinking;
    }
    
    function start(){
    	starting = true;
    	if(sensorTimer!=null){
    		sensorTimer.stop();
    		stopped();

    	}
    	sensorTimer = new Timer.Timer();
    	sensorTimer.start(method(:started),2000,false); 
    	
    }
    
    function stop(){
    	stopping = true;
    	if(sensorTimer!=null){
    		started();
    		sensorTimer.stop();

    	}
    	sensorTimer = new Timer.Timer();
    	sensorTimer.start(method(:stopped),2000,false); 
    	
    }
    
    function started(){
    	starting = false;
    	WatchUi.requestUpdate();
    }
    
    function stopped(){
    	stopping = false;
    	WatchUi.requestUpdate();
    }
    
    function min(val1, val2){
		if(val1>val2){
			return val2;
		}else{
			return val1;
		}
    }
    
    
}


