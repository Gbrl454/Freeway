extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_changePlayer()

func _on_Play_pressed():
	$AudioPlay.play()
	$Play.hide()
	$Ante.hide()
	$Prox.hide()
	$LabelAnte.hide()
	$LabelProx.hide()

func _on_AudioPlay_finished():
	Global.coins = 0
	Global.mortes = 0
	Global.score = 0
	Global.scene = get_tree().change_scene("res://Scene/Jogo.tscn")
	$Play.show()
	$Ante.show()
	$Prox.show()
	$LabelAnte.show()
	$LabelProx.show()

func _changePlayer():
	if Global.idPlayer == Global.idPlayerMax:
		Global.idPlayer = 0
	$Player.animation = "%s" % Global.idPlayer
	$Player.play()

func _on_Prox_pressed():
	Global.idPlayer += 1
	_changePlayer()

func _on_Ante_pressed():
	Global.idPlayer -= 1
	_changePlayer()
