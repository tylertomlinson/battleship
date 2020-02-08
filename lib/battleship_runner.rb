require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'


@board = Board.new
@cruiser = Ship.new("Cruiser", 3)
@submarine = Ship.new("Submarine", 2)
@game = Game.new
@game.main_menu
