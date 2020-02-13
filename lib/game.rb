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
    puts messages[:welcome]
    # sleep 2
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
    puts messages[:comp_layout1]
    resting
    puts messages[:comp_layout2]
    resting
    puts messages[:user_layout]
    resting
    cruiser_coordinates
  end

  def turn
    until game_over? do
    boards
    puts  messages[:msg_10]
    user_guess = [] << gets.chomp.upcase
    until @user.valid_guess?(user_guess, @computer_board)
      puts messages[:err_msg_3]
      user_guess = [] << gets.chomp.upcase
    end
    @user.take_turn(user_guess, @computer_board)
    comp_guess = @player_board.cells.keys.sample
    @computer.take_turn(@player_board, comp_guess)
    player_feedback(user_guess)
    computer_feedback
    end
  end

  def game_over?
      if @user.ships.all? { |ship| ship.sunk? }
        puts "I WON!"
        sleep 2
        Process.exit!(true)
      return  true
      end
      if @computer.ships.all? { |ship| ship.sunk? }
        puts "YOU WON!"
        sleep 2
        Process.exit!(true)
      return  true
      end
    false
  end

  def boards
    puts messages[:comp_board]
    puts @computer_board.render
    puts messages[:user_board]
    puts @player_board.render(true)
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
