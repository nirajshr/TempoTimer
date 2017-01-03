//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class InputDelegate extends Ui.BehaviorDelegate {
	var m_tempo_timer;
	var m_vibrator;
	var m_settings;
	
	function initialize(tempo_timer, vibrator, settings) {
		Ui.BehaviorDelegate.initialize(); 
		self.m_tempo_timer = tempo_timer;
		self.m_vibrator = vibrator;
		self.m_settings = settings;
	}
    
    function onBack() {
     	self.m_tempo_timer.stop();
    	return false;
    }
    
    function onMenu() {
    	Ui.pushView(
    		new Rez.Menus.SettingsMainMenu(), 
    		new SettingsMenuDelegate(m_tempo_timer, m_vibrator, m_settings), 
    		Ui.SLIDE_UP);
        return true;
    }
    
    function onKey(evt) {
    	var key = evt.getKey();

    	if (key == Ui.KEY_ENTER) {
    		self.m_tempo_timer.toggle();
    		Ui.requestUpdate();	
    		return true;
    	}	
    	return false;
	}
}