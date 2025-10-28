extends MarginContainer

var ChoiceButton = load("res://Scenes/button.tscn")

signal choice_selected(index)

var _buttons = []

func create_choices(choices):
	for choice in choices:
		var button = ChoiceButton.instantiate()
		button.text = choice.text
		button.connect("pressed", Callable(self, "_button_pressed").bind(button))

		_buttons.append(button)
		$ChoiceVBoxContainer.add_child(button)


func _button_pressed(button):
	var index = _buttons.find(button)

	if index != -1:
		emit_signal("choice_selected", index)
