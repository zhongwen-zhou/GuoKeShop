json.array! @games do |channel_game|
	json.id = channel_game.game_id.to_s
	json.name = channel_game.game.name
end