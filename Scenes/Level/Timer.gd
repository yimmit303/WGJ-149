extends Label

signal time_out

var timer_time = 5 * 60
var started = false

func _process(delta):
	if started:
		timer_time -= delta
		if timer_time <= 0:
			timer_time = 0
			self.text = "0:00"
			emit_signal("time_out")
			return
		format_and_set(timer_time)


func format_and_set(time):
	var str_time = str(time/60)
	if str_time.count(".") == 0:
		str_time += ".0"
	var minutes = float(str_time.split(".")[0])
	var seconds = float(str_time) - minutes
	seconds = seconds * 60
	seconds = round(seconds)
	var sec_str = str(seconds)
	if len(sec_str) == 1:
		sec_str = "0" + sec_str
	self.text = str(minutes) + ":" + sec_str


func _on_Level_camera_finsished():
	started = true
