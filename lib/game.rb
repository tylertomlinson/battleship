require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require './lib/computer'
require_relative 'output_module'

class Game
  include OutputModule

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
    @computer.computer_cruiser_placement(@computer_board)
    @computer.computer_submarine_placement(@computer_board)
    puts messages[:msg_3]
    # sleep 1.5
    puts messages[:msg_4]
    # sleep 1.5
    puts messages[:msg_5]
    # sleep 1.5
    cruiser_coordinates
  end
  # until @player.all_ships_sunk? || @computer.all_ships_sunk? do

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
    puts messages[:msg_8]
    puts @computer_board.render
    puts messages[:msg_9]
    puts @player_board.render(true)
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

  def player_feedback(user_guess)
    if @computer_board.cells[user_guess[0]].render == "M"
      puts "Your shot on #{user_guess[0]} was a miss!"
    elsif @computer_board.cells[user_guess[0]].render == "H"
      puts "Your shot on #{user_guess[0]} was a hit!"
    elsif @computer_board.cells[user_guess[0]].render == "X"
      puts "Your shot on #{user_guess[0]} sunk my battleship!!"
    end
  end

  def computer_feedback
    if @player_board.cells[@computer.shot_guesses.last].render == "M"
      puts "My shot on #{@computer.shot_guesses.last} was a miss!"
    elsif @player_board.cells[@computer.shot_guesses.last].render == "H"
      puts "My shot on #{@computer.shot_guesses.last} was a hit!"
    elsif @player_board.cells[@computer.shot_guesses.last].render == "X"
      puts "My shot on #{@computer.shot_guesses.last} sunk your battleship!!"
    end
  end

  def sanitized_input(user_input)
    user_input = user_input.upcase.squeeze.strip.gsub(" ", "").scan(/../)
  end

  def valid_cruiser_input?(user_input)
    while !@player_board.valid_placement?(@cruiser, user_input)
      puts messages[:err_msg_4]
      cruiser_input
    end
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
    @player_board.valid_placement?(@cruiser, user_input)

    @player_board.place(@cruiser, user_input)
    puts @player_board.render(true)
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
    @player_board.place(@submarine, user_input)
    puts @player_board.render(true)
    @player_board.place(@submarine, user_input)
    turn
  end

  def valid_submarine_input?(user_input)
    while !@player_board.valid_placement?(@submarine, user_input)
      puts messages[:err_msg_4]
      submarine_input
    end
  end
end
