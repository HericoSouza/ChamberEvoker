class_name Globals
extends Node

static var bridge: PackedScene = preload("res://Spawnables/ponte.tscn")
static var rope: PackedScene = preload("res://Spawnables/corda.tscn")
static var wall: PackedScene = preload("res://Spawnables/parede.tscn")

static var skele: PackedScene = preload("res://Enemies/Esqueleto/esqueleto.tscn")
static var zumbi: PackedScene = preload("res://Enemies/Zumbi/zumbi.tscn")

static var ghost_bridge: PackedScene = preload("res://Spawnables/Ghosts/ghost_bridge.tscn")
static var ghost_rope: PackedScene = preload("res://Spawnables/Ghosts/ghost_rope.tscn")
#static var ghost_cage: PackedScene = preload("res://Spawnables/Ghosts/ghost_rope.tscn")
static var ghost_wall: PackedScene = preload("res://Spawnables/Ghosts/ghost_wall.tscn")

static var main_menu_path: String = "res://Menus/main_menu.tscn"
static var win_screen_path: String = "res://Menus/win_screen.tscn"
static var current_level: int = -1
static var levels: Array[String] = [
	"res://Levels/TutorialLevels/tutorial_objective.tscn",
	"res://Levels/TutorialLevels/tutorial_bridge.tscn",
	"res://Levels/TutorialLevels/tutorial_rope.tscn",
	"res://Levels/TutorialLevels/tutorial_button.tscn",

	"res://Levels/Levels1-4/AliveOrAlive.tscn",
	"res://Levels/Levels1-4/Big_Pit.tscn",
	"res://Levels/Levels1-4/FoeOrBuddy.tscn",
	"res://Levels/Levels1-4/SideToSide.tscn"
]

static func next_level() -> void:
	if (current_level < levels.size()):
		current_level += 1
static func get_current_level_path() -> String:
	if (current_level < levels.size()):
		return levels[current_level]
	else:
		current_level = -1
		return main_menu_path
