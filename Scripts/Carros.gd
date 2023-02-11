extends RigidBody2D

func _ready():
	var tipos_carros = $Anim.frames.get_animation_names()
	var carro = tipos_carros[randi() % tipos_carros.size()]
	$Anim.animation = carro

func _on_Notificador_screen_exited():
	queue_free()
