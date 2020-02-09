require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require_relative 'output'

class Game
  include OutputModule

  attr_reader :board, :cruiser, :submarine, :user, :computer

  def initialize
    @user_board = Board.new
    @player_board = Board.new
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
      loop do
      user_input = gets.chomp
      menu_options(user_input)
    end
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

    #board should render here with cruiser and submarine placed on whatever
    #coordinates were passed in
    turn
  end


  def turn
    puts messages[:msg_8]
    #this should display the computers board, but not its
    #ships
    puts @board.render
    puts messages[:msg_9]
    #this should display the players board with its ships
    puts @board.render(true)

    puts  messages[:msg_10]

    shot_coordinate = gets.chomp.upcase
    @user.take_turn(shot_coordinate)
    guess = @computer.take_turn
    # need to use render method and have feedback display what the shot did
    puts "#{(guess)}"
    puts "#{(coordinate)}"
    #this until should check if shot_coordinate is a rendered cell
    until valid_input?(shot_coordinate)
    puts messages[:err_msg_3]
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
       messages[:err_msg_4]
      input
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

#valid input is breaking
#need to loop over placing ship
