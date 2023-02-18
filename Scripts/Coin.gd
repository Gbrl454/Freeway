extends Area2D

func _process(delta):
	if Global.playing == false:
		var _i = delta
		queue_free()

func _ready():
	$Anim.play("coin")

func _on_Coin_area_entered(area):
	if area.has_method("_getCoin"):
		area._getCoin()
		queue_free()
