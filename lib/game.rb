require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require './lib/computer'
require_relative 'output_module'

class Game
  include OutputModule

  attr_reader :user_board, :cruiser, :submarine, :user, :computer, :computer_board

  def initialize
    @user_board = Board.new
    @computer_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @user = Player.new
    @computer = Computer.new
  end

  def main_menu
    puts messages[:msg_1]
    # sleep 2
    puts messages[:msg_2]
    loop do
      user_input = gets.chomp
      menu_options(user_input)
    end
    start
  end

  def start
    @computer.computer_cruiser_placement
    @computer.computer_submarine_placement
    puts messages[:msg_3]
    # sleep 1.5
    puts messages[:msg_4]
    # sleep 1.5
    puts messages[:msg_5]
    # sleep 1.5
    cruiser_coordinates
  end

  def cruiser_coordinates
    puts messages[:msg_6]
    # sleep 0.5
    cruiser_input
    puts messages[:msg_6]
    # sleep 0.5
    cruiser_input
  end

  def cruiser_input
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_cruiser_input?(user_input)
    @user_board.valid_placement?(@cruiser, user_input)

    @user_board.place(@cruiser, user_input)
    puts @user_board.render(true)
    #board should render here with cruiser placed on whatever coordinates were
    #passed in
    submarine_coordinates
  end

  def submarine_coordinates
    puts messages[:msg_7]
    # sleep 0.5
    submarine_input
  end

  def submarine_input
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_submarine_input?(user_input)
    @user_board.place(@submarine, user_input)
    puts @user_board.render(true)
    @user_board.place(@submarine, user_input)
    turn
  end

  def turn
    puts messages[:msg_8]
    puts @computer_board.render
    puts messages[:msg_9]
    puts @user_board.render(true)
    puts  messages[:msg_10]
    user_guess = [] << gets.chomp.upcase
    @user.valid_guess?(user_guess)
    @user.take_turn(user_guess)
    @computer.computer_take_turn

    # until @user.valid_guess?(user_guess)
    #   puts messages[:err_msg_3]
    #   user_guess = [] << gets.chomp.upcase
    # end
    turn
  end

  def sanitized_input(user_input)
    user_input = user_input.upcase.squeeze.strip.gsub(" ", "").scan(/../)
  end

  def valid_cruiser_input?(user_input)
    while !@user_board.valid_placement?(@cruiser, user_input)
      puts messages[:err_msg_4]
      cruiser_input
    end
  end

  def valid_submarine_input?(user_input)
    while !@user_board.valid_placement?(@submarine, user_input)
      puts messages[:err_msg_4]
      submarine_input
    end
  end

  def menu_options(user_input)
    if user_input == "p"
      start
    elsif user_input == "q"
      puts messages[:ai_msg_6]
      Process.exit!(true)
    else
      puts messages[:err_msg_1]
    end
  end

  def end_game
    return "You won!" if health(@computer_board) == 0
    return "I won!" if health(@player_board) == 0
    return "You ended the game" if end_game
  end
end
