extends CanvasLayer

onready var timer := $Timer as Timer
var tempoMin
var tempoSec
var tempo

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

func _endGame():
	_runTimer(false)
	$Mensagem.text = "Você marcou %s ponto(s)!" % [$Placar.text]
	$Mortes.text = "Morreu %s vezes" % [Global.mortes]
	if Global.coins > 0:
		$EndCoins.text = "Você pegou %s moeda(s)!" % [$Coins.text]
	$Button.show()
	$Coins.hide()

func _startGame():
	tempo = Global.tempoInit
	_setLabelTempo()
	_runTimer(true)
	$Button.hide()
	$Coins.show()
	$Mortes.text = ""
	$Mensagem.text = ""
	$EndCoins.text = ""
	_setCoins()

func _on_Timer_timeout():
	_setLabelTempo()

func _setTempo():
	tempo -=1
	
	tempoMin = int (tempo/60)
	tempoSec = tempo - (tempoMin*60)
	
	if tempoMin == 0 and tempoSec == 0:	
		emit_signal("tempoAcabou")

func _setLabelTempo():
	_setTempo()
	$Tempo.text = " %s:%s" % [tempoMin,tempoSec]

func _on_Player_plusCoin():
	Global.coins += 1
	_setCoins()

func _setCoins():
	$Coins.text = "%s" % [Global.coins]
