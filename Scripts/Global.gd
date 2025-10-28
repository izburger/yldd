extends Node

var bodies_collection = {
	"01" : preload("res://Assets/body.png")
}

var hair_collection = {
	"none" : null, 
	"01" : preload("res://Assets/hair.png"),
	"02" : preload("res://Assets/hair2.png"),

}
var outfit_collection = {
	"01" : preload("res://Assets/outfitdress.png"),
	"02" : preload("res://Assets/outfitsuit.png"),
}

#big collections for char creator
var bodies_collection_BIG = {
	"01" : preload("res://Assets/big assets/basespritesheet.png")
}

var hair_collection_BIG = {
	"none" : null, 
	"01" : preload("res://Assets/big assets/hairspritesheet.png"),
	"02" : preload("res://Assets/big assets/ponytailsprite.png"),

}
var outfit_collection_BIG = {
	"01" : preload("res://Assets/big assets/dressspritesheet.png"),
	"02" : preload("res://Assets/big assets/suitspritesheet.png"),
}


var body_colour_options = [
	Color(0.96, 0.88, 0.69), #light skin
	Color(0.72, 0.54, 0.39), #medium skin
	Color(0.45, 0.34, 0.27), #brown skin
]

var hair_colour_options = [
	Color(0.1, 0.1, 0.1), #Black
	Color(0.4, 0.2, 0.1), #Brown
	Color(0.9, 0.6, 0.2), #Blonde
	Color(0.5, 0.25, 0), #Aubrun
	Color(0.9, 0.8, 1), #Greyish Purple?
]

var colour_options = [
	Color(1, 1, 1), #Default
	Color(1, 0, 0), #Red
	Color(0, 1, 0), #Green
	Color(0, 0, 1), #Blue
	Color(0, 0, 0), #Black
	Color(1, 1, 1), #White
]

#selected values
var selected_body = ""
var selected_hair = ""
var selected_outfit = ""

#big for character creation
var selected_body_BIG := "01"
var selected_hair_BIG := "none"
var selected_outfit_BIG := "01"

var selected_body_colour_BIG = body_colour_options[0]
var selected_hair_colour_BIG = hair_colour_options[0]

######

var selected_body_colour = ""
var selected_hair_colour = ""


var player_name = ""


