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
    assert_instance_of Board, @game.board
    assert_instance_of Ship, @game.cruiser
    assert_instance_of Ship, @game.submarine
  end

  def test_sanitized_input
    assert_equal ["A1","A2","A3"], @game.sanitized_input("a1a2a3")
    assert_equal ["B1", "B2", "B3"], @game.sanitized_input("b  1  b2   b  3")
    assert_equal ["C1", "C2"], @game.sanitized_input("aaC   1  c2  aa")
  end

  def test_menu_options
    assert_equal messages[:err_msg_1], @game.menu_options("w")
    # assert_equal @game.start, @game.menu_options("p")
  end

  def test_valid_input
    # assert_equal true, @game.valid_input?("a1a2a3")
    # assert_equal false, @game.valid_input?("a1a1a1")
  end
end
