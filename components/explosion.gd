extends Node2D



func emit(vector, color, amount = 10, time = 5):
	if (vector):
		position = vector;

	$Particles2D.amount = amount;
	$Particles2D.emitting = true;
	$Particles2D.process_material.set_color(color);

	yield(create_timer(time), "timeout");

	queue_free();

func create_timer(time):
	var timer = Timer.new();
	
	timer.set_wait_time(time);
	timer.set_one_shot(true);
	
	add_child(timer);
	
	timer.start();
	
	return timer;
