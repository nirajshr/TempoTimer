using Toybox.Attention as Att;
using Toybox.System as Sys;

class TempoVibrator {
	var m_vibe;
	var m_length;
	var m_intensity;
	
	function initialize(length, intensity) {		
		m_length = length;
		m_intensity = intensity;
		update();
	}
	function getLength() {
		return m_length;
	}
	
	function setLength(len) {
		m_length = len;
		update();
	}
	
	function getIntensity() {
		return m_intensity;
	}
	
	function setIntensity(intensity) {
		m_intensity = intensity;
		update();
	}
	
	hidden function update() {
		m_vibe = new Att.VibeProfile(m_intensity, m_length);
	}
	
	function vibrate() {
		Att.vibrate([
			m_vibe
		]);
		Sys.println("Vibration Duty: " + m_intensity + ", len: " + m_length);
	}
}