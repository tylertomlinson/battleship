require_relative 'test_helper'
require 'mocha/minitest'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/computer'

class Test < Minitest::Test

  def setup
    @computer = Computer.new
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_computer_can_place_cruiser
    @computer.stubs(:computer_place_cruiser).returns(["A1", "A2", "A3"])
    @computer.stubs(:computer_place_cruiser).returns(["C2", "C3", "C4"])
  end

  def test_computer_can_place_submarine
    @computer.stubs(:computer_place_submarine).returns(["D1", "D2"])
    @computer.stubs(:computer_place_submarine).returns(["A4", "B4"])
  end

  def test_computer_can_take_turn
    @computer.stubs(:gets).returns("C3")
  end
end
