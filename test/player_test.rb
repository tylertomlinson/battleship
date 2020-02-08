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
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_player_has_attributes
    assert_equal @computer_board, @player.computer_board
    assert_equal @player_board, @player.player_board
  end
end
