extends Control

@onready var fps_label : Label = $MarginContainer/VBoxContainer/FPSLabel

func _process(_delta: float) -> void:
	fps_label.text = ("Fps: " + str(Engine.get_frames_per_second()))
