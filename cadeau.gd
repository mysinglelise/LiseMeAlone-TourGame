extends Control

@onready var keep_playing_button: Button = $HBoxContainer/VBoxContainer/keep_playing_button
@onready var exit_button: Button = $HBoxContainer/VBoxContainer/exit_button
@onready var copy_button: Button = $HBoxContainer/VBoxContainer/copy_button
@onready var code_box: TextEdit = $HBoxContainer/code_box
@onready var text_label: Label = $text

func _ready():
	print("🎁 PAGE CADEAU CHARGÉE!")
	print("🔍 Script cadeau._ready() appelé")
	
	# Vérification de sécurité
	if not text_label:
		push_error("❌ text_label n'est pas trouvé!")
	if not keep_playing_button or not exit_button or not copy_button:
		push_error("❌ Un des boutons n'est pas trouvé!")
		return
	if not code_box:
		push_error("❌ code_box n'est pas trouvé!")
		return
	
	print("✅ Tous les nœuds trouvés!")
	
	# Connexions boutons
	keep_playing_button.pressed.connect(on_keep_playing_pressed)
	exit_button.pressed.connect(on_exit_pressed)
	copy_button.pressed.connect(on_copy_pressed)
	
	print("✅ Boutons connectés!")
	
	# Configuration code box
	code_box.editable = false
	code_box.selecting_enabled = true  # Changé de selectable à selecting_enabled
	
	print("🔍 Contenu du code_box: '", code_box.text, "'")
	print("📏 Longueur: ", code_box.text.length(), " caractères")

func on_copy_pressed() -> void:
	print("🖱️ ========== BOUTON COPY CLIQUÉ! ==========")
	
	if code_box and code_box.text != "":
		var code_to_copy = code_box.text
		print("📝 Texte à copier: '", code_to_copy, "'")
		print("📏 Longueur: ", code_to_copy.length(), " caractères")
		
		# Copie dans le presse-papier
		DisplayServer.clipboard_set(code_to_copy)
		print("✅ DisplayServer.clipboard_set() appelé")
		
		# Vérification
		await get_tree().create_timer(0.1).timeout
		
		var clipboard_content = DisplayServer.clipboard_get()
		print("📋 Contenu du presse-papier: '", clipboard_content, "'")
		
		if clipboard_content == code_to_copy:
			print("✅✅✅ COPIE RÉUSSIE!")
			copy_button.text = "✓ Copied!"
		else:
			print("⚠️ Copie échouée, sélection du texte")
			copy_button.text = "Press Ctrl+C"
			code_box.select_all()
	else:
		print("⚠️ code_box vide ou null!")

func on_keep_playing_pressed() -> void:
	print("🎮 Retour au jeu...")
	Global.lives = Global.max_lives
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func on_exit_pressed() -> void:
	print("👋 Fermeture du jeu...")
	get_tree().quit()
