class_name TreeBuilderRoot
extends Node2D
## Nod that acts as a proxy for the tree controller in 2D space.
## Is called upon by the controller to render nodes from data

@onready var pos_west := $West
@onready var area_west := $WestArea
@onready var pos_north := $North
@onready var area_north := $NorthArea
@onready var pos_south := $South
@onready var area_south := $SouthArea
@onready var pos_east := $East
@onready var area_east := $EastArea
