extends CanvasLayer

signal reinicia
func _on_Button_pressed():
	emit_signal("reinicia")

func _Stats(mortes_player):
	$Mensagem.text = "Você Ganhou!"
	$Mortes.text = "Morreu %s vezes" % [mortes_player]
	$Button.show()

func _Reset():
	$Button.hide()
	$Mortes.text = ""
	$Mensagem.text = ""
	$Placar.text = "0"
	
