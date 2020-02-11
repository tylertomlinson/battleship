require_relative 'test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'

class Test < Minitest::Test

  def setup
    @player1 = Player.new
    @player2 = Player.new
    @ship = Ship.new("Cruiser", 3)
    @coordinates = ["A1", "A2", "A3"]
    @cruiser_options = [["A1", "A2", "A3"], ["C2", "C3", "C4"]].sample
    @sub_options = [["D1", "D2"], ["A4", "B4"]].sample
  end

  def test_it_exists
    assert_instance_of Player, @player1
    assert_instance_of Player, @player2

  end

  def test_player_has_own_board_and_opponent_board
    assert_instance_of Board , @player1.board
    assert_instance_of Board, @player1.board

    assert_instance_of Board, @player2.board
    assert_instance_of Board, @player2.board
  end

  def test_user_has_entered_valid_coordinates
    assert @player1.valid_ship_placement(@ship, @coordinates)

    test_coordinates = ["A2", "C4", "B1"]

    refute @player1.valid_ship_placement(@ship, test_coordinates)
  end

  def test_opponent_has_entered_valid_coordinates
    assert @player2.valid_ship_placement(@ship, @cruiser_options)

    test_coordinates = ["A2", "C4", "B1"]

    refute @player2.valid_ship_placement(@ship, test_coordinates)
  end

  def test_player_can_place_ship_and_board_renders
    @player1.valid_ship_placement(@ship, @coordinates)
    @player1.ship_placement(@ship, @coordinates)

    assert @player1.board.render(true).include?("S")
  end

  def test_player_can_take_turn
    @player1.take_turn(["A1"])

    assert @player1.board.cells["A1"].fired_upon?
  end
end
