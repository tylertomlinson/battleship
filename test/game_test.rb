require_relative 'test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class Gametest < Minitest::Test

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
end
