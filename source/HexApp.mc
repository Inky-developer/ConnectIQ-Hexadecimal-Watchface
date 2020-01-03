using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;

var colors = new utils.ColorScheme();

class HexApp extends Application.AppBase {
	var view;
	
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	readSettings();
    	self.view = new HexView();
        return [ self.view ];
    }
    
    function onSettingsChanged() {
    	self.readSettings();
    	self.view.redraw();
    	WatchUi.requestUpdate();
    }
    
    function readSettings() {
    	var app = Application.getApp();
    	colors.set(:bg, readKeyInt(app, "colorBackground", Graphics.COLOR_BLACK));
    	colors.set(:text, readKeyInt(app, "colorDefault", Graphics.COLOR_WHITE));
    	colors.set(:date, readKeyInt(app, "colorDate", Graphics.COLOR_WHITE));
    	colors.set(:time, readKeyInt(app, "colorTime", Graphics.COLOR_DK_GREEN));
    }
    
    function readKeyInt(myApp,key,thisDefault) {
	    var value = myApp.getProperty(key);
	    if(value == null || !(value instanceof Number)) {
	        if(value != null) {
	            value = value.toNumber();
	        } else {
	            value = thisDefault;
	        }
	    }
	    return value;
	}

}