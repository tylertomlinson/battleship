require_relative 'test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'

class Test < Minitest::Test

  def setup
    @computer_board = Board.new
    @player_board = Board.new
    @player = Player.new(@player_board, @computer_board)
    @ship = Ship.new("Cruiser", 3)
    @coordinates = ["A1", "A2", "A3"]
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_player_has_attributes
    assert_equal @computer_board, @player.computer_board
    assert_equal @player_board, @player.player_board
  end

  def test_player_has_entered_valid_coordinates
    assert @player.valid_player_placement(@ship, @coordinates)

    test_coordinates = ["A2", "C4", "B1"]

    refute @player.valid_player_placement(@ship, test_coordinates)
  end
end
