extends Node

const CENA_CARROS = preload("res://Scene/Carros.tscn")
const CENA_COINS = preload("res://Scene/Coin.tscn")

var pistas_rapidas = [104, 272, 488]
var pistas_lentas = [160, 216, 324, 384, 438, 544, 600]
var score = 0
var coinsScreen = 0

func _ready():
	$AudioTema.play()
	$HUD._startGame()
	$Player._Reset()
	randomize()

func _on_TimerCarrosRapido_timeout():
	var novo_carro = CENA_CARROS.instance()
	add_child(novo_carro)
	var pista = pistas_rapidas[randi() % pistas_rapidas.size()]
	novo_carro.position = Vector2(-10, pista)
	novo_carro.linear_velocity.x = rand_range(700, 710)
	novo_carro.linear_damp = -1
	
func _on_TimerCarrosLento_timeout():
	var novo_carro = CENA_CARROS.instance()
	add_child(novo_carro)
	var pista = pistas_lentas[randi() % pistas_lentas.size()]
	novo_carro.position = Vector2(-10, pista)
	novo_carro.linear_velocity.x = rand_range(300, 310)
	novo_carro.linear_damp = -1

func _on_Player_pontua():
	score += 1
	$HUD/Placar.text = str(score)
	$AudioPonto.play()
	if $TimerCoins.wait_time <= 0.75:
		$TimerCoins.wait_time -= 0.25

func _on_HUD_reinicia():
	score = 0
	$TimerCoins.wait_time = 5
	$AudioTema.play()
	$TimerCarrosRapido.start()
	$TimerCarrosLento.start()
	$TimerCoins.start()
	$HUD._startGame()
	$Player._Reset()

func _on_HUD_tempoAcabou():
	$AudioTema.stop()
	$TimerCarrosRapido.stop()
	$TimerCarrosLento.stop()
	$TimerCoins.stop()
	$HUD._endGame($Player.mortes)
	$Player._Play(false)
	$AudioVitoria.play()

func _on_TimerCoins_timeout():
	if coinsScreen <= 50:
		var novo_coin = CENA_COINS.instance()
		add_child(novo_coin)
		novo_coin.position = Vector2((randi() % 1080)+100, (randi() % 500)+110)
		coinsScreen += 1

func _on_Player_plusCoin():
	coinsScreen -= 1
	$AudioCoin.play()
