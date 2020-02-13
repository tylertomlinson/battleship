require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require './lib/computer'
require_relative 'output_module'
require_relative 'game_validation_module'

class Game
  include OutputModule
  include GameValidationModule

  attr_reader :cruiser, :submarine, :user, :computer

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @user = Player.new
    @computer = Computer.new
  end

  def main_menu
    line
    line
    print_welcome_start
    blinking
    line
    nap_time
    puts messages[:welcome]
    blinking
    puts messages[:play_quit]
    loop do
      user_input = gets.chomp
      menu_options(user_input)
    end
    start
  end

  def start
    @computer.computer_cruiser_placement(@computer_board)
    @computer.computer_submarine_placement(@computer_board)
    line
    opening_message_1
    line
    resting
    opening_message_2
    line
    resting
    opening_message_3
    line
    resting
    cruiser_coordinates
    line
  end

  def turn
    computer_board
    player_board
    until game_over? do
    nap_time
    puts  messages[:coord_input]
    user_guess = [] << gets.chomp.upcase
    until @user.valid_guess?(user_guess, @computer_board)
      sample_invalid_messages
      user_guess = [] << gets.chomp.upcase
    end
    @user.take_turn(user_guess, @computer_board)
    comp_guess = @player_board.cells.keys.sample
    @computer.take_turn(@player_board, comp_guess)
    print_slowly_dots
    blinking
    line
    computer_board
    player_feedback(user_guess)
    line
    player_board
    computer_feedback
    line
    end
  end

  def game_over?
      if @user.ships.all? { |ship| ship.sunk? }
        puts "I WON!"
        sleep 2
        Process.exit!(true)
      return true
      end
      if @computer.ships.all? { |ship| ship.sunk? }
        puts "YOU WON!"
        sleep 2
        Process.exit!(true)
      return true
      end
    false
  end

  def menu_options(user_input)
    if user_input == "p"
      start
    elsif user_input == "q"
      blinking
      sample_quit_msgs
      Process.exit!(true)
    else
      blinking
      puts error_messages[:invalid_start]
    end
  end
end
