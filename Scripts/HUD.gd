extends CanvasLayer

onready var timer := $Timer as Timer
var tempoMin
var tempoSec
var tempo
var coins = 0

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
	if coins > 0:
		$EndCoins.text = "Você pegou %s moeda(s)!" % [$Coins.text]
	$Button.show()
	$Coins.hide()

func _startGame():
	tempo = 180
	coins = 0
	_setLabelTempo()
	_runTimer(true)
	$Button.hide()
	$Coins.show()
	$Mortes.text = ""
	$Mensagem.text = ""
	$EndCoins.text = ""
	$Placar.text = "0"
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
	print("Coins")
	coins += 1
	_setCoins()

func _setCoins():
	$Coins.text = "%s" % [coins]
