
class Computer
  attr_reader :cruiser, :cruiser_options, :submarine, :submarine_options, :shot_guesses

  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @cruiser_options = [["A1", "A2", "A3"], ["C2", "C3", "C4"]].sample
    @submarine = Ship.new("Submarine", 2)
    @submarine_options = [["D1", "D2"], ["A4", "B4"]].sample
    @shot_guesses = []
  end

  def ships
    @ships = [@cruiser, @submarine]
  end

  def computer_cruiser_placement(computer_board)
    @cruiser_options.each {|cell| computer_board.cells[cell].place_ship(@cruiser)}
  end

  def computer_submarine_placement(computer_board)
    @submarine_options.each {|cell| computer_board.cells[cell].place_ship(@submarine)}
  end

  def take_turn(player_board, comp_guess)
    until !@shot_guesses.include?(comp_guess)
      comp_guess = player_board.cells.keys.sample
    end
    player_board.cells[comp_guess].fire_upon
    @shot_guesses << comp_guess
  end
end
