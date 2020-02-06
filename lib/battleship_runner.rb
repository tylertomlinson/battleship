require './lib/board'
require './lib/ship'
require './lib/cell'

@board = Board.new
@cruiser = Ship.new("Cruiser", 3)
@submarine = Ship.new("Submarine", 2)

def main_menu
  puts "Welcome to BATTLESHIP\n"
  puts "Enter p to play. Enter q to quit."
  user_input = gets.chomp.downcase
  if  user_input == "p"
    start
  elsif user_input == "q"

  else "Invalid input please enter (q) or (p)"
  end
end

def start
  puts "I have now laid out my ships on the grid.\n"
  puts "You now need to lay out your two ships.\n"
  puts "The Cruiser is three units long and the Submarine is two units long.\n"
  puts @board.render
  puts "Enter the squares for the Cruiser (3 spaces):"
  cruiser_cells = gets.chomp
  until cruiser_cells.valid_placement?
    puts "Those are invalid coordinates. Please try again:"
    cruiser_cells = gets.chomp.upcase
  end
  #board should render here with cruiser placed on whatever coordinates were
  #passed in
  puts "Enter the squares for the Submarine (2 spaces):"
  submarine_cells = gets.chomp
  until submarine_cells.valid_placement?
    puts "Those are invalid coordinates. Please try again:"
    submarine_cells = gets.chomp.upcase
  end
  #board should render here with cruiser and submarine placed on whatever
  #coordinates were passed in
  turn
end
main_menu

def turn
  puts "=============COMPUTER BOARD=============\n"
  #this should display the computers board, but not its ships
  puts "==============PLAYER BOARD==============\n"
  #this should display the players board with its ships

  puts "Enter the coordinate for your shot:\n"
  shot_coordinate = gets.chomp.upcase
  #this until should check if shot_coordinate is a rendered cell
  until shot_coordinate
    puts "Please enter a valid coordinate:\n"
    shot_coordinate = gets.chomp.upcase
  end
  turn
end
