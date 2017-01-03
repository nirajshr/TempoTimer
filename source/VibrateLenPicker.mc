using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

const TWODIGIT_FORMAT = "%02d";

class VibrateIntensityPicker extends Ui.Picker {
    function initialize(curr_rate) {
        var title = new Ui.Text({
        	:text=>Rez.Strings.vib_intensity_picker_title, 
        	:locX=>Ui.LAYOUT_HALIGN_CENTER, 
        	:locY=>Ui.LAYOUT_VALIGN_BOTTOM, 
        	:color=>Gfx.COLOR_WHITE
        });
        var factories = new [1];
        factories[0] = new NumberFactory(0, 100, 10, {:format=>TWODIGIT_FORMAT});	
		
		var defaults = null;
		
		if (curr_rate != null) {
			defaults = [
				factories[0].getIndex(curr_rate)
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

class VibrateIntensityPickerDelegate extends Ui.PickerDelegate {
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
    	var intensity = values[0];
        m_settings.m_vibrate_intensity = intensity;
        m_vibrator.setIntensity(intensity);
		
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
}
