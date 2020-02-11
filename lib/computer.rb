require_relative 'player'

class Computer < Player
  attr_reader :computer_board, :user_board, :cruiser, :cruiser_options, :submarine, :submarine_options

  def initialize
    @computer_board = Board.new
    @user_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @cruiser_options = [["A1", "A2", "A3"], ["C2", "C3", "C4"]].sample
    @submarine = Ship.new("Submarine", 2)
    @submarine_options = [["D1", "D2"], ["A4", "B4"]].sample
    super
  end

  def computer_cruiser_placement
    @cruiser_options.each {|cell| @computer_board.cells[cell].place_ship(@cruiser)}
  end

  def computer_submarine_placement
    @submarine_options.each {|cell| @computer_board.cells[cell].place_ship(@submarine)}
  end

  def computer_take_turn
    @user_board.cells.keys.shuffle[0]
  end
end
