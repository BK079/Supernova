extends Node2D




func _on_player_star_absorbed(body):
	$PlayerStar/RemoteTransform2D.reparent(body)
