using ActivityValues;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

class DataField extends WatchUi.Drawable{

	var name;
	var value;
	
	function initialize(options){
		Drawable.initialize(options);
		name = options.get(:name);
		value = options.get(:value);
	}
	
	function draw(dc) {
		var v = new Lang.Method(ActivityValues, value); 
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(locX + width/2, locY, Graphics.FONT_SYSTEM_TINY, name, Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(locX + width/2, locY + dc.getFontHeight(Graphics.FONT_SYSTEM_TINY)/2, Graphics.FONT_NUMBER_MEDIUM, v.invoke(), Graphics.TEXT_JUSTIFY_CENTER);
	}

}