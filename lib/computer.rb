require_relative 'player'

class Computer < Player
  attr_reader :cruiser, :cruiser_options, :submarine, :submarine_options

  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @cruiser_options = [["A1", "A2", "A3"], ["C2", "C3", "C4"]].sample
    @submarine = Ship.new("Submarine", 2)
    @submarine_options = [["D1", "D2"], ["A4", "B4"]].sample
    super
  end

  def computer_cruiser_placement(computer_board)
    @cruiser_options.each {|cell| computer_board.cells[cell].place_ship(@cruiser)}
  end

  def computer_submarine_placement(computer_board)
    @submarine_options.each {|cell| computer_board.cells[cell].place_ship(@submarine)}
  end

  def computer_shot_coordinate(player_board)
  player_board.cells.keys.shuffle.pop
  end

  def take_turn(player_board)
    computer_guess = computer_shot_coordinate(player_board)
    player_board.cells[computer_guess].fire_upon
    return computer_shot_coordinate(player_board)
  end
end
