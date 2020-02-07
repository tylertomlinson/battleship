require_relative 'test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_board_has_cells
    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells["A1"]
  end

  def test_board_can_check_valid_coordinate
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

#HELPER METHOD TESTS FOR VALID_PLACEMENT?
  #
  # def test_ship_length_is_the_same_as_input_coordinates
  #   assert_equal true, @board.consecutive?(["A1", "A2"])
  #   assert_equal true, @board.consecutive?(["C3", "C4"])
  #   assert_equal true, @board.consecutive?(["A1", "B1"])
  #   assert_equal false, @board.consecutive?(["B1", "B2", "C3", "D4"])
  # end
  # #
  # def test_letters_can_be_converted_to_ordinal_numbers
  #   skip
  #   assert_equal [66,67,68], @board.letter_ordinates(["B1", "C1", "D1"])
  # end
  #
  # def test_letter_coordinates_are_consecutive
  #   skip
  #   assert @board.lettersconsecutive?(["A1", "A2", "A3"])
  #   assert_equal false, @board.consecutive?(["A1", "B1", "C1"])
  # end
  #
  # def test_letter_coordinates_are_consecutive
  #   skip
  #   assert @board.letters_consecutive?(["A1", "B1", "C1"])
  #   assert_equal false, @board.letters_consecutive?(["A1", "A2", "B1"])
  # end
  #
  # def test_number_coordinates_are_consecutive
  #   skip
  #   assert @board.numbers_consecutive?(["A1", "A2", "A3"])
  #   assert_equal false, @board.numbers_consecutive?(["A1", "A3", "A4"])
  # end
  #
  # def test_horizontal_placement_has_is_correct
  #   assert_equal false, @board.horizontal_placement?(["A1", "A2", "A4"])
  #   assert_equal  @board.horizontal_placement?(["A1", "A2", "A3"])
  # end
  #
  # def test_vertical_placement_has_unique_letter
  #
  # end
#-----------------------------------------------------------------------------

  def test_board_can_check_valid_placement
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_board_can_check_if_valid_placement_is_consecutive
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_board_can_check_valid_placement_is_not_diagonal
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_ship_is_able_to_be_placed_on_board_and_can_occupy_multiple_cells
    @board.place(@cruiser, ["A1", "A2", "A3"])

    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_instance_of Ship, cell_1.ship
    assert_instance_of Ship, cell_2.ship
    assert_instance_of Ship, cell_3.ship
  end

end
