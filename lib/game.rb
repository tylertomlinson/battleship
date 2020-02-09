require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/player'
require_relative 'output'

class Game
  include OutputModule

  attr_reader :board, :cruiser, :submarine
  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player = Player.new
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
    puts messages[:msg_8]
    @player.opponent_board.render
    puts messages[:msg_9]
    @player.your_board.render(true)

    puts  messages[:msg_10]
    shot_coordinate = gets.chomp.upcase
    #this until should check if shot_coordinate is a rendered cell
    until valid_input?(shot_coordinate)
    puts   messages[:err_msg_3]
      shot_coordinate = gets.chomp.upcase
    end
    puts "Your shot on #{shot_coordinate} was a miss."
    puts "My shot on #{computer_shot_coordinate} was a miss"
    turn
  end

  def sanitized_input(user_input)
    user_input = user_input.upcase.strip.gsub(" ", "").scan(/../)
    fixed_input = []
    user_input.each do |input|
      if @board.cells.keys.include?(input)
        fixed_input << input
      end
    end
    fixed_input
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
       Process.exit!(true)
    else p messages[:err_msg_1]
    end
  end
end
