require_relative 'test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/player'

class PlayerTest < Minitest::Test

  def setup
    @player = Player.new
    @ship = Ship.new("Cruiser", 3)
    @coordinates = ["A1", "A2", "A3"]
    @computer_board = Board.new
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_player_has_own_board_and_opponent_board
    assert_instance_of Board, @player.board
  end

  def test_user_has_entered_valid_coordinates
    assert @player.valid_ship_placement(@ship, @coordinates)

    test_coordinates = ["A2", "C4", "B1"]

    refute @player.valid_ship_placement(@ship, test_coordinates)
  end
  
  def test_player_can_place_ship_and_board_renders
    @player.valid_ship_placement(@ship, @coordinates)
    @player.ship_placement(@ship, @coordinates)

    assert @player.board.render(true).include?("S")
  end

  def test_player_can_take_turn
    @player.take_turn(["A1"], @computer_board)

    assert @computer_board.cells["A1"].fired_upon?
  end
end
