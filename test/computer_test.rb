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
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_computer_can_place_cruiser
    possible_results = [["A1", "A2", "A3"], ["C2", "C3", "C4"]]

    assert_equal true, possible_results.include?(@computer.computer_cruiser_placement)
  end

  def test_computer_can_place_submarine
    possible_results = [["D1", "D2"], ["A4", "B4"]]

    assert_equal true, possible_results.include?(@computer.computer_submarine_placement)
  end

  # def test_computer_can_take_turn
  #     Array.stubs(:shuffle).returns("C3")
  #   assert_equal "C3", @computer.computer_take_turn
  # end

  # def test_computer_can_take_turn
  #   assert_instance_of Cell,
  # end
end
