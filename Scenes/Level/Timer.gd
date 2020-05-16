extends Label


var timer_time = 5 * 60

func _process(delta):
	timer_time -= delta
	format_and_set(timer_time)

func format_and_set(time):
	var str_time = str(time/60)
	if str_time.count(".") == 0:
		str_time += ".0"
	var minutes = float(str_time.split(".")[0])
	var seconds = float(str_time) - minutes
	seconds = seconds * 60
	seconds = round(seconds)
	self.text = str(minutes) + ":" + str(seconds)
