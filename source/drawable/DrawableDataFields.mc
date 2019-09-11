using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

class DrawableDataFields extends WatchUi.Drawable {

	var dataFields;
	
	function initialize(options) {
		Drawable.initialize(options);
		var fields = options.get(:dataFields);
		dataFields = new [fields.size()];
		for(var i = 0 ; i < dataFields.size() ; i++){
			dataFields[i] = new DataField({:name => fields[i][0], :value => fields[i][1]});
		}
	}
	
	function draw(dc) {
		dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(2);
		var height = dc.getHeight()/3;
		var width = dc.getWidth()/2;
		dc.drawLine(0, height, dc.getWidth(), height);
		dc.drawLine(0, 2*height, dc.getWidth(), 2*height);
		dc.drawLine(width, height, width, 2*height);
		dc.setPenWidth(1);
		
		dataFields[0].setSize(dc.getWidth(), height);
		dataFields[0].draw(dc);
		
		dataFields[1].setLocation(0, height);
		dataFields[1].setSize(width, height);
		dataFields[1].draw(dc);
		
		dataFields[2].setLocation(width, height);
		dataFields[2].setSize(width, height);
		dataFields[2].draw(dc);
		
		dataFields[3].setLocation(0, 2 * height);
		dataFields[3].setSize(dc.getWidth(), height);
		dataFields[3].draw(dc);
	}
}