extends Area2D

func _ready():
	$Anim.play("coin")

func _on_Coin_area_entered(area):
	if area.has_method("_getCoin"):
		area._getCoin()
		queue_free()
