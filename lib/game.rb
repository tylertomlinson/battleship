require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require_relative 'output'

class Game
  include OutputModule

  attr_reader :board, :cruiser, :submarine, :user, :computer, :user_board, :computer_board

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
    loop do
      puts messages[:msg_2]
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
    # puts messages[:msg_6]
    # sleep 0.5
    cruiser_input
  end

  def cruiser_input
    puts messages[:msg_6]
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_cruiser_input?(user_input)
    @user_board.valid_placement?(@cruiser, user_input)

    @user_board.place(@cruiser, user_input)
    puts @user_board.render(true)
    #board should render here with cruiser placed on whatever coordinates were
    #passed in
    submarine_input
  end

  def submarine_input
    puts messages[:msg_7]
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_submarine_input?(user_input)
    @user_board.valid_placement?(@submarine, user_input)

    @user_board.place(@submarine, user_input)
    puts @user_board.render(true)
    #board should render here with cruiser and submarine placed on whatever
    #coordinates were passed in
    turn
  end


  def turn
    puts messages[:msg_8]
    @computer_board.render
    puts messages[:msg_9]
    @user_board.render(true)

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
    user_input = user_input.upcase.strip.gsub(" ", "").scan(/../)
  end



  def valid_cruiser_input?(user_input)
    if @user_board.valid_placement?(@cruiser, user_input)
    else
      puts messages[:err_msg_4]
      cruiser_input
    end
  end

  def valid_submarine_input?(user_input)
    if @user_board.valid_placement?(@submarine, user_input)
    else
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

#valid input is breaking
#need to loop over placing ship
