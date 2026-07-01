extends ProgressBar

@onready var wisp = get_parent()

func _ready():
	max_value = wisp.max_health
	value = wisp.health

func _process(_delta):
	value = wisp.health
