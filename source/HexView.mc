using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;

class HexView extends WatchUi.WatchFace {
	var width, height;
	var timeLabel, dateLabel;
	var font = WatchUi.loadResource($.displayFont);
	var dirty = true;
	var spacer = " ";
	
	var lines;
	var text_height;

    function initialize() {
        WatchFace.initialize();
        self.width = System.getDeviceSettings().screenWidth;
        self.height = System.getDeviceSettings().screenHeight;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
    
    function updateData(dc) {		
		self.font = WatchUi.loadResource($.displayFont);
		
		self.timeLabel = new WatchUi.Text({
        	:color => colors.get(:time),
        	:backgroundColor => colors.get(:bg),
        	:font => font,
        	:justification => Graphics.TEXT_JUSTIFY_CENTER,
        	:locX => width / 2,
        });
        self.dateLabel = new WatchUi.Text({
        	:color => colors.get(:date),
        	:backgroundColor => colors.get(:bg),
        	:font => font,
        	:justification => Graphics.TEXT_JUSTIFY_CENTER,
        	:locX => width / 2,
        });
		
	    var dim = dc.getTextDimensions("FF"+spacer, font);
	    var t_width = dim[0];
	    var length = (width / t_width).toNumber();
	    length = length % 2 == 0 ? length : length + 1;
	    var t_height = dim[1];
	    
	    var centerRow = (height / t_height * 0.5).toNumber() * t_height;
	    self.timeLabel.setLocation(self.timeLabel.locX, centerRow);
	    self.timeLabel.setSize(height, t_width);
	    
	    self.dateLabel.setLocation(self.dateLabel.locX, centerRow - t_height);
	    self.dateLabel.setSize(height, t_width);
	       
	    // generate the random hex pairs
	    var centerX = width / 2;
	    lines = new [(height / t_height).toNumber() + 1];
	    for (var i = 0; i < lines.size(); i++) {
	    	var line = utils.getHexLine(length, spacer);
	    	lines[i] = line;
	    }	
	    self.text_height = t_height;
    }

    // Update the view
    function onUpdate(dc) {
    	WatchFace.onUpdate(dc);
    	
    	if (self.dirty) {
    		self.dirty = false;
    		self.updateData(dc);
    	}
    	
    	var centerX = self.width / 2;
    	var i = 0;
    	dc.setColor(colors.get(:text), colors.get(:bg));
    	for (var y = 0; y < self.height; y += self.text_height) {
    		dc.drawText(centerX, y, font, lines[i], Graphics.TEXT_JUSTIFY_CENTER);
    		i++;
    	}
    	
        // Get and show the current time
        var clockTime = System.getClockTime();
        var gregorian = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		
		var text = utils.toHex(clockTime.hour) + spacer + utils.toHex(clockTime.min);
		self.timeLabel.setText(text);
		self.timeLabel.draw(dc);
		
		var date = utils.toHex(gregorian.month) + spacer + utils.toHex(gregorian.day);
		self.dateLabel.setText(date);
		self.dateLabel.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
