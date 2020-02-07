require './lib/board'
require './lib/ship'
require './lib/cell'

class Game
  attr_reader :board, :cruiser, :submarine
  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end
  def main_menu
    puts "Welcome to BATTLESHIP\n"
    loop do
    puts "Enter p to play. Enter q to quit."
    user_input = gets.chomp
    if  user_input == "p"
      start
    elsif user_input == "q"
      kernel.quit
    else "Invalid input please enter (q) or (p)"
    end
  end
  start
  end

  def start
    puts "I have now laid out my ships on the grid.\n"
    puts "You now need to lay out your two ships.\n"
    puts "The Cruiser is three units long and the Submarine is two units long.\n"
    puts @board.render
    input
  end

  def input
    puts "Enter the squares for the Cruiser (3 spaces):"
    user_input = gets.chomp.split(",")
    # user_input
    # valid_input?(user_input)
    # until user_input == @board.valid_placement?(@cruiser, user_input)
    #   puts "Those are invalid coordinates. Please try again:"
    #   # user_input = valid_input?
    # end
    puts @board.render(true)
    #board should render here with cruiser placed on whatever coordinates were
    #passed in
    puts "Enter the squares for the Submarine (2 spaces):"
    user_input = gets.chomp
    # until valid_placement?(user_input)
    #   puts "Those are invalid coordinates. Please try again:"
    #   user_input = gets.chomp
    # end
    #board should render here with cruiser and submarine placed on whatever
    #coordinates were passed in
    turn
  end


  def turn
    puts "=============COMPUTER BOARD=============\n"
    #this should display the computers board, but not its ships
    puts "==============PLAYER BOARD==============\n"
    #this should display the players board with its ships

    puts "Enter the coordinate for your shot:\n"
    shot_coordinate = gets.chomp.upcase
    #this until should check if shot_coordinate is a rendered cell
    until valid_coordinate?(shot_coordinate)
      puts "Please enter a valid coordinate:\n"
      shot_coordinate = gets.chomp.upcase
    end
    puts "Your shot on #{shot_coordinate} was a miss."
    puts "My shot on #{computer_shot_coordinate} was a miss"
    turn
  end

  def sanitized_input(user_input)
    user_input.upcase.strip.gsub(" ", "").scan(/../)
  end

  def valid_input?(user_input)
    if sanitized_input(user_input).length <= 3
      true
    else
      puts "This isn't a valid input, try again."
      input
    end
  end

  def error_messages(coordinates)
		raise "You cannot place a ship outside of the grid" if # coordinate not on grid
		raise "You cannot place a ship on another ship" if @board.ships_overlap?(coordinates)
	end
end
