using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class VibrateLenPicker extends Ui.Picker {
    function initialize(curr_val) {
        var title = new Ui.Text({
        	:text=>Rez.Strings.vib_length_picker_title, 
        	:locX=>Ui.LAYOUT_HALIGN_CENTER, 
        	:locY=>Ui.LAYOUT_VALIGN_BOTTOM, 
        	:color=>Gfx.COLOR_WHITE
        });
        var factories = new [1];
        factories[0] = new NumberFactory(0, 1000, 50, {:format=>TWODIGIT_FORMAT});	
		
		var defaults = null;
		
		if (curr_val != null) {
			defaults = [
				factories[0].getIndex(curr_val)
			];
		}
		
        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class VibrateLenPickerDelegate extends Ui.PickerDelegate {
	var m_vibrator;
	var m_settings;
    function initialize(vibrator, settings) {
        PickerDelegate.initialize();
        
        m_vibrator = vibrator;
        m_settings = settings;
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
    	var val = values[0];
    	
    	m_settings.m_vibrate_length = val;
        m_vibrator.setLength(val);
		
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
}
