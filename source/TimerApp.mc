//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Settings {	
	var m_tempo = 2000; // millisec
	var m_vibrate = true;	
	var m_vibrate_length = 200; //millisec
	var m_vibrate_intensity = 70; //[0-100]
	
	function initialize() {
		var app = App.getApp();
		var tempo = app.getProperty("tempo_rate");
		var vibrate = app.getProperty("vibrate");
		var vibrate_i = app.getProperty("vibrate_intensity");
		var vibrate_l = app.getProperty("vibrate_length");
		
		if (tempo != null) {
			m_tempo = tempo;
		}
		if (vibrate != null) {
			m_vibrate = vibrate;
		}
		if (vibrate_i != null) {
			m_vibrate_intensity = vibrate_i;
		}
		if (vibrate_l != null) {
			m_vibrate_length = vibrate_l;
		}
	}
	
	function save() {
		var app = App.getApp();
		app.setProperty("tempo_rate", m_tempo);
		app.setProperty("vibrate", m_vibrate);
		app.setProperty("vibrate_intensity", m_vibrate_intensity);
		app.setProperty("vibrate_length", m_vibrate_length);
	} 
}

enum {
	TEMPO_STOPPED,
	TEMPO_RUNNING
}


function updateUi() {
	Ui.requestUpdate();	
}

class TimerApp extends App.AppBase {
	var m_tempo_timer;
	var m_vibrator;
	var m_settings;
	
	function initialize() {
		AppBase.initialize();
		
		m_settings = new Settings();
		m_tempo_timer = new TempoTimer(m_settings.m_tempo);
		m_vibrator = new TempoVibrator(
			m_settings.m_vibrate_length, 
			m_settings.m_vibrate_intensity);
	}
	
    // onStart() is called on application start up
    function onStart(state) {
    	m_tempo_timer.subscribe(method(:updateUi));
    	m_tempo_timer.subscribe(m_vibrator.method(:vibrate));
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	m_tempo_timer.clearSubscribers();
    	m_settings.save();
    }
	
    // Return the initial view of your application here
    function getInitialView() {    	
        var view = new TimerView(m_tempo_timer);
        var input = new InputDelegate(m_tempo_timer, m_vibrator, m_settings);
        
        return [ view, input ];
    }

}
