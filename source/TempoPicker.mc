using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

const MILLISEC_FORMAT = "%02d";

class TempoPicker extends Ui.Picker {
    function initialize(curr_rate) {
        var title = new Ui.Text({
        	:text=>Rez.Strings.tempo_picker_title, 
        	:locX=>Ui.LAYOUT_HALIGN_CENTER, 
        	:locY=>Ui.LAYOUT_VALIGN_BOTTOM, 
        	:color=>Gfx.COLOR_WHITE
        });
        var factories = new [2];
        factories[0] = new NumberFactory(0, 9, 1, {});
        factories[1] = new NumberFactory(0, 99, 1, {:format=>MILLISEC_FORMAT});		
		
		var defaults = null;
		
		if (curr_rate != null) {
			var sec_msec = splitTempoToSecAndMsec(curr_rate);
			defaults = [
				factories[0].getIndex(sec_msec[0]), 
				factories[1].getIndex(sec_msec[1])
			];
		}
		
        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }

	function splitTempoToSecAndMsec(tempo_rate) {
		var sec = (tempo_rate / 1000.00);
		var num_of_sec = sec.toNumber();
		var decimal_part = sec - num_of_sec;
		var two_msec_digits = (decimal_part * 100).toNumber();
		
		return [ num_of_sec, two_msec_digits ]; 
	}
}

class TempoPickerDelegate extends Ui.PickerDelegate {
	var m_tempo_timer;
	var m_settings;
	
    function initialize(tempo_timer, settings) {
        PickerDelegate.initialize();
        
        m_tempo_timer = tempo_timer;
        m_settings = settings;
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
    	var tempo = (values[0] * 1000) + (values[1] * 10);
    	m_settings.m_tempo = tempo;
        m_tempo_timer.resetRate(tempo);

        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
}
