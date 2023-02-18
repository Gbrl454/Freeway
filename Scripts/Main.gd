extends Control

var idPlayer = 0
var idPlayerMax = 7

func _ready():
	_changePlayer()

func _on_Play_pressed():
	$AudioPlay.play()
	$Play.hide()
	$Ante.hide()
	$Prox.hide()
	$LabelAnte.hide()
	$LabelProx.hide()

func _on_AudioPlay_finished():
	get_tree().change_scene("res://Scene/Jogo.tscn")
	$Play.show()
	$Ante.show()
	$Prox.show()
	$LabelAnte.show()
	$LabelProx.show()

func _changePlayer():
	if idPlayer == idPlayerMax:
		idPlayer = 0
	$Player.animation = "%s" % idPlayer
	$Player.play()

func _on_Prox_pressed():
	idPlayer += 1
	_changePlayer()

func _on_Ante_pressed():
	idPlayer -= 1
	_changePlayer()
