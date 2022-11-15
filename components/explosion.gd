extends Node2D



func emit(vector, time = 10):
	position = vector;
	$Particles2D.emitting = true;

	yield(create_timer(time), "timeout");

	queue_free();

func create_timer(time):
	var timer = Timer.new();
	
	timer.set_wait_time(time);
	timer.set_one_shot(true);
	
	add_child(timer);
	
	timer.start();
	
	return timer;
