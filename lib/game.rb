require './lib/board'
require './lib/ship'
require './lib/cell'
require_relative 'output'

class Game
  include OutputModule

  attr_reader :board, :cruiser, :submarine
  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    # @messages = {
    #   msg_1: "Welcome to BATTLESHIP\n",
    #   msg_2: "Enter p to play. Enter q to quit.",
    #   msg_3: "I have now laid out my ships on the grid.\n",
    #   msg_4: "You now need to lay out your two ships.\n",
    #   msg_5: "The Cruiser is three units long and the Submarine is two units long.\n",
    #   msg_6: "Enter the squares for the Cruiser (3 spaces):\n",
    #   msg_7: "Enter the squares for the Submarine (2 spaces):\n",
    #   msg_8: "=============COMPUTER BOARD=============\n",
    #   msg_9: "==============PLAYER BOARD==============\n",
    #   msg_10: "Enter the coordinate for your shot:\n",
    #   msg_11: "Your shot on  was a miss.",
    #   msg_12: "Your shot on  was a hit.",
    #   msg_13: "Your shot on  sunk my !",
    #   msg_14: "My shot on  was a miss.",
    #   msg_15: "My shot on  was a hit.",
    #   msg_16: "My shot on  sunk your !",
    #   msg_17: "You won!",
    #   msg_18: "I won!",
    #   err_msg_1: "Invalid input please enter (q) or (p)\n",
    #   err_msg_2: "Those are invalid coordinates. Please try again:\n",
    #   err_msg_3: "Please enter a valid coordinate:\n",
    #   err_msg_4: "This isn't a valid input, try again.\n"
    # }
  end

  def main_menu
    puts messages[:msg_1]
    sleep 2
    loop do
      puts messages[:msg_2]
      user_input = gets.chomp
      menu_options(user_input)
    end
    start
  end

  def start
    puts messages[:msg_3]
    sleep 1.5
    puts messages[:msg_4]
    sleep 1.5
    puts messages[:msg_5]
    sleep 1.5
    puts messages[:msg_6]
    sleep 0.5
    input
  end

  def input
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_input?(user_input)
    @board.valid_placement?(@cruiser, user_input)

    @board.place(@cruiser, user_input)
    puts @board.render(true)
    #board should render here with cruiser placed on whatever coordinates were
    #passed in
    puts messages[:msg_7]
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_input?(user_input)
    @board.valid_placement?(@submarine, user_input)

    @board.place(@submarine, user_input)
    puts messages[:msg_8]
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
    if @board.valid_placement?(@cruiser, user_input) || @board.valid_placement?(@submarine, user_input)
      true
    else
      puts "This isn't a valid input, try again."
      input
    end
  end

  def menu_options(user_input)
    if  user_input == "p"
      start
    elsif user_input == "q"
      exit
    else puts messages[:err_msg_1]
    end
  end
end
