require 'pastel'
require 'tty-font'

module OutputModule

  def color
    Pastel.new
  end

  def font_type(font)
    TTY::Font.new(font)
  end

  def huge_text(font, text)
    color.green(font_type(font).write(text))
  end

  def messages
    {
      msg_1: "\n Welcome to \n#{huge_text("doom","BATTLESHIP")}\n",
      msg_2: "Enter #{color.green("P")} to play. Enter #{color.red("Q")} to quit.",
      msg_3: "\nI have laid out my ships on the grid. \n",
      msg_4: "Now It's your turn... place them strategically!\n\n",
      msg_5: "The Cruiser is three units long and the Submarine is two units long.\n",
      msg_6: "Enter the coordinates for the Cruiser (3 spaces):\n",
      msg_7: "Enter the squares for the Submarine (2 spaces):\n",
      msg_8: "#{color.green("=============COMPUTER BOARD=============")}\n",
      msg_9: "==============PLAYER BOARD==============\n",
      msg_10: "Enter the coordinate for your shot:\n",
      msg_11: "Your shot on  was a miss.",
      msg_12: "Your shot on  was a hit.",
      msg_13: "Your shot on  sunk my !",
      msg_14: "My shot on  was a miss.",
      msg_15: "My shot on  was a hit.",
      msg_16: "My shot on  sunk your !",
      msg_17: "You won!",
      msg_18: "I won!",
      err_msg_1: "Invalid input please enter (q) or (p)\n",
      err_msg_2: "Those are invalid coordinates. Please try again:\n",
      err_msg_3: "Please enter a valid coordinate:\n",
      err_msg_4: "This isn't a valid input, try again.\n",
    }
  end
end
