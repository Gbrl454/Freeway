extends CanvasLayer

onready var timer := $Timer as Timer
var tempoMin
var tempoSec

signal reinicia
signal tempoAcabou
func _on_Button_pressed():
	emit_signal("reinicia")

func _runTimer(on):
	if on == true:
		$Tempo.show()
		timer.start()
	else:
		timer.stop()
		$Tempo.hide()

func _endGame(mortes_player):
	_runTimer(false)
	$Mensagem.text = "Você marcou %s ponto(s)!" % [$Placar.text]
	$Mortes.text = "Morreu %s vezes" % [mortes_player]
	$Button.show()

func _startGame():
	tempoMin = 0
	tempoSec = 3
	_setLabelTempo()
	_runTimer(true)
	$Button.hide()
	$Mortes.text = ""
	$Mensagem.text = ""
	$Placar.text = "0"
	

func _on_Timer_timeout():
	_setTempo()

func _setTempo():
	if tempoSec == 0:
		tempoMin -= 1
		tempoSec = 59
	else:
		tempoSec -= 1
	
	if tempoMin == 0 and tempoSec == 0:	
		emit_signal("tempoAcabou")
	_setLabelTempo()

func _setLabelTempo():
	$Tempo.text = " %s:%s" % [tempoMin,tempoSec]
