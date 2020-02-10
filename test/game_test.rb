require_relative 'test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'

class Gametest < Minitest::Test
  include OutputModule

  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_instance_of Board, @game.user_board
    assert_instance_of Ship, @game.cruiser
    assert_instance_of Ship, @game.submarine
  end

  def test_sanitized_input
    assert_equal ["A1","A2","A3"], @game.sanitized_input("a1a2a3")
    assert_equal ["B1", "B2", "B3"], @game.sanitized_input("b  1  b2   b  3")
  end

  def test_valid_cruiser_input

  end

  def test_menu_options
  end

  def test_valid_input
    # assert_equal true, @game.valid_input?("a1a2a3")
    # assert_equal false, @game.valid_input?("a1a1a1")
  end
end