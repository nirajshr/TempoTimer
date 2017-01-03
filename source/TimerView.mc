//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

class TempoStatusStr {
	var on;
	var off;
	
	function initialize() {
		on = Ui.loadResource(Rez.Strings.tempo_status_on);
		off = Ui.loadResource(Rez.Strings.tempo_status_off);
	}
	
	function getStr(tempo_status) { 
		if (tempo_status == TEMPO_RUNNING) {
			return on;
		}
		else if (tempo_status == TEMPO_STOPPED) {
			return off;
		}
		else {
			return "(Unknown)";
		}
	}
}

function getTempoRateStr(num) {
	return (num / 1000.00).format("%.2f");
}

class TimerView extends Ui.View {
	hidden var m_tempo_timer;
	hidden var m_ui_tempo_rate;
	hidden var m_ui_tempo_count;
	hidden var m_ui_tempo_status;
	hidden var m_tempo_status_str;
	
    function initialize(tempo_timer) {
    	Ui.View.initialize();
    	self.m_tempo_timer = tempo_timer;
    	
    	self.m_tempo_status_str = new TempoStatusStr();
    }

    function onLayout(dc) {
    	setLayout(Rez.Layouts.MainLayout(dc));
    	
    	m_ui_tempo_rate = View.findDrawableById("TempoLabel");
    	m_ui_tempo_count = View.findDrawableById("TempoCount");
    	m_ui_tempo_status = View.findDrawableById("TempoStatus"); 
    }

    function onUpdate(dc) {
        var t = self.m_tempo_timer; 
 		
 		m_ui_tempo_rate.setText(
 			getTempoRateStr(t.getRate()) );
 			

 		m_ui_tempo_count.setText(t.getCount().format("%d"));
 		m_ui_tempo_status.setText(
 			self.m_tempo_status_str.getStr(t.getStatus()) );
        //dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        
        View.onUpdate(dc);
    }
    
    function onShow() {
    }
    
    function onHide() {
    }
}
