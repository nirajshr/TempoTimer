using Toybox.System as Sys;

class TempoTimer {
	hidden var m_rate;
	hidden var m_status;
	hidden var m_count;
	hidden var m_timer;
	
	hidden var m_listeners;
	
	function initialize(rate) {
		self.m_rate = rate;
		self.m_status = TEMPO_STOPPED;
		self.m_count = 0;
		self.m_timer = new Timer.Timer();
		
		self.m_listeners = new [0];
	}
	
	function getRate() {
		return self.m_rate;
	}
	
	function resetRate(rate) {
		self.m_rate = rate;
		stopWithoutNotify();
		self.m_count = 0;
		//notify();
	}
	
	function getStatus() {
		return self.m_status;
	}
	
	function getCount() {
		return self.m_count;
	}
	
	function subscribe(cbk) {
		m_listeners.add(cbk);
	}
	
	function clearSubscribers() {
		m_listeners = new [0];
	}
	
	function callback() {
		self.m_count += 1;
		onTimerNotify();
	}
	
	function onTimerNotify() {
		for(var i=0; i<m_listeners.size(); ++i) {
			m_listeners[i].invoke();
		}
	}
	
	function start() {
		Sys.println("tempo timer started");
		self.m_timer.start(method(:callback), self.m_rate, true);
		self.m_status = TEMPO_RUNNING;
		self.m_count = 0;
		//notify();
	} 
	
	hidden function stopWithoutNotify() {
		Sys.println("tempo timer stopped");
		self.m_timer.stop();
		self.m_status = TEMPO_STOPPED;
		//notify();
	}	
	function stop() {
		stopWithoutNotify();
		//notify();
	}
	
	function toggle() {
		if (self.m_status == TEMPO_STOPPED) {
			self.start();
		}
		else {
			self.stop();
		}
	}			
}