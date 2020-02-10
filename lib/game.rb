require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require_relative 'output_module'

class Game
  include OutputModule

  attr_accessor :user_board, :computer_board
  attr_reader :user_board, :computer_board, :cruiser, :submarine, :user, :computer, :cruiser_options, :sub_options

  def initialize
    @user_board = Board.new
    @computer_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @user = Player.new
    @computer = Player.new
    @cruiser_options = [["A1", "A2", "A3"], ["C2", "C3", "C4"]].sample
    @sub_options = [["D1", "D2"], ["A4", "B4"]].sample
  end

  def main_menu
    puts messages[:msg_1]
    # sleep 2
    puts messages[:msg_2]
    user_input = gets.chomp
    menu_options(user_input)
    start
  end

  def start
    @computer.ship_placement(@cruiser, @cruiser_options)
    @computer.ship_placement(@submarine, @sub_options)

    puts messages[:msg_3]
    # sleep 1.5
    puts messages[:msg_4]
    # sleep 1.5
    puts messages[:msg_5]
    # sleep 1.5
    puts messages[:msg_6]
    # sleep 0.5
    input
  end

  def input
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_input?(user_input)
    @user_board.valid_placement?(@cruiser, user_input)

    @user_board.place(@cruiser, user_input)
    puts @user_board.render(true)
    #board should render here with cruiser placed on whatever coordinates were
    #passed in
    puts messages[:msg_7]
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_input?(user_input)
    @user_board.valid_placement?(@submarine, user_input)

    @user_board.place(@submarine, user_input)
    #board should render here with cruiser and submarine placed on whatever
    #coordinates were passed in before turn starts?
    turn
  end


  def turn
    puts messages[:msg_8]
    puts @computer_board.render
    puts messages[:msg_9]
    puts @user_board.render(true)
    puts  messages[:msg_10]
    user_guess = [] << gets.chomp.upcase
    @user.take_turn(user_guess)
    computer_guess = @computer.take_turn(user_guess)


    until valid_guess?(user_guess)
      puts messages[:err_msg_3]
      user_guess = [] << gets.chomp.upcase
    end
    display_shot_results(computer_guess)
    turn
  end

    #render boards could be its own method which is called within turn. need to test

    def sanitized_input(user_input)
      user_input.upcase.strip.gsub(" ", "").scan(/../)
    end

    def valid_input?(user_input)
      if @user_board.valid_placement?(@cruiser, user_input) || @user_board.valid_placement?(@submarine, user_input)
        true
      else
        messages[:err_msg_4]
        input
      end
    end

    def valid_guess?(coordinate)
      @computer_board.valid_coordinate?(coordinate[0])
      # @computer_board.cell.fired_upon? == false

    #cell hasn't been fired upon
    # true
    # else
    #prompt user that the guess is invalid and let them know what their guess was
    end

    def display_shot_results(computer_guess)
      require "pry"; binding.pry
      if @user_board.cells[computer_guess].render == 'M'
        "My shot on #{computer_guess} was a miss."
      elsif @user_board.cells[computer_guess].render == 'H'
        "My shot on #{computer_guess} was a hit."
      elsif @user_board.cells[computer_guess].render == 'X'
        "My shot on #{computer_guess} sunk your" #needs to display ship that was sunk.
      end
    end


    def user_ship_name(coordinate)
      @user_board.cells[coordinate].ship.name
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
      #use message hash for outputs
      return "You won!" if health(@computer_board) == 0
      return "I won!" if health(@user_board) == 0
      return "You ended the game" if end_game
    end
  end

  #THIS IS BROKEN. HAVE NO IDEA WHAT IS GOING ON.
