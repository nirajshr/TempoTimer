using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class SettingsMenuDelegate extends Ui.MenuInputDelegate {
	var m_tempo_timer;
	var m_vibrator;
	var m_settings;
	
    function initialize(tempo_timer, vibrator, settings) {
        MenuInputDelegate.initialize();
        
        self.m_tempo_timer = tempo_timer;
        self.m_vibrator = vibrator;
        self.m_settings = settings;
    }

    function onMenuItem(item) {
        if (item == :item_tempo) {
        	pushTempoPicker();
        } else if (item == :item_vib_intensity) {
            pushVibIntensityPicker();
        } else if (item == :item_vib_length) {
            pushVibLengthPicker();
        }
    }
    
    function pushTempoPicker() {
        Ui.pushView(
        	new TempoPicker(self.m_tempo_timer.getRate()), 
        	new TempoPickerDelegate(self.m_tempo_timer, m_settings), Ui.SLIDE_IMMEDIATE);
        return true;
    }
    
    function pushVibIntensityPicker() {
        Ui.pushView(
        	new VibrateIntensityPicker(self.m_vibrator.getIntensity()), 
        	new VibrateIntensityPickerDelegate(self.m_vibrator, m_settings), Ui.SLIDE_IMMEDIATE);
        return true;
    }
    
    function pushVibLengthPicker() {
        Ui.pushView(
        	new VibrateLenPicker(self.m_vibrator.getLength()), 
        	new VibrateLenPickerDelegate(self.m_vibrator, m_settings), Ui.SLIDE_IMMEDIATE);
        return true;
    }
}