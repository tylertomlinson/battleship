require './lib/board'
require './lib/ship'
require './lib/cell'

class Game

  attr_reader :board, :cruiser, :submarine
  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @messages = {
      msg_1: "Welcome to BATTLESHIP\n",
      msg_2: "Enter p to play. Enter q to quit.",
      msg_3: "I have now laid out my ships on the grid.\n",
      msg_4: "You now need to lay out your two ships.\n",
      msg_5: "The Cruiser is three units long and the Submarine is two units long.\n",
      #msg_6: @board.render,
      msg_7: "Enter the squares for the Cruiser (3 spaces):\n",
      #msg_8: @board.render(true)
      msg_9: "Enter the squares for the Submarine (2 spaces):\n",
      msg_10: "=============COMPUTER BOARD=============\n",
      msg_11: "==============PLAYER BOARD==============\n",
      msg_12: "Enter the coordinate for your shot:\n",
      msg_13: "Your shot on #{user_input} was a miss.",
      msg_14: "Your shot on #{user_input} was a hit.",
      msg_15: "Your shot on #{user_input} sunk my #{ship}!",
      msg_16: "My shot on #{computer_shot} was a miss.",
      msg_17: "My shot on #{computer_shot} was a hit.",
      msg_18: "My shot on #{computer_shot} sunk your #{ship}!",
      msg_19: "You won!",
      msg_20: "I won!",
      err_msg_1: "Invalid input please enter (q) or (p)\n",
      err_msg_2: "Those are invalid coordinates. Please try again:\n",
      err_msg_3: "Please enter a valid coordinate:\n",
      err_msg_4: "This isn't a valid input, try again.\n"
    }
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
    user_input = gets.chomp.split(" ")
    valid_input?(user_input)
    # until user_input == @board.valid_placement?(@cruiser, user_input)
    #   puts "Those are invalid coordinates. Please try again:"
    #   # user_input = valid_input?
    # end
    @board.place(@cruiser, user_input)
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
    if user_input.length <= 3
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
