require_relative 'test_helper'
require 'mocha/minitest'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/computer'

class ComputerTest < Minitest::Test

  def setup
    @computer = Computer.new
    @player_board = Board.new
    @computer_board = Board.new
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_computer_can_place_cruiser
    possible_results = [["A1", "A2", "A3"], ["C2", "C3", "C4"]]

    assert_equal true, possible_results.include?(@computer.computer_cruiser_placement(@computer_board))
  end

  def test_computer_can_place_submarine
    possible_results = [["D1", "D2"], ["A4", "B4"]]

    assert_equal true, possible_results.include?(@computer.computer_submarine_placement(@computer_board))
  end

  def test_computer_takes_random_turn
    comp_guess = @player_board.cells.keys.sample
    @computer.take_turn(@player_board, comp_guess)

    assert @player_board.render.include?("M")
    refute @player_board.render.include?("H")
    refute @player_board.render.include?("X")
  end
end
