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

  def print_slowly
    "...........".split(//).each do |c|
      sleep 0.4
      print c
    end
  end

  def blinking
    sleep 0.5
  end

  def nap_time
    sleep 1
  end

  def resting
    sleep 1.5
  end

  def super_sleepy
    sleep 2
  end

  def messages
    {
      welcome: "\n Welcome to \n#{huge_text("doom","BATTLESHIP")}\n",
      play_quit: "Enter #{color.green("P")} to play. Enter #{color.red("Q")} to quit.",
      comp_layout1: "\nI have laid out my ships on the grid. \n",
      comp_layout2: "Now It's your turn... place them strategically!\n\n",
      user_layout: "The Cruiser is three units long and the Submarine is two units long.\n",
      cruiser_coord: "Enter the coordinates for the Cruiser (3 spaces):\n",
      sub_coord: "Enter the coordinates for the Submarine (2 spaces):\n",
      comp_board: "#{color.green("=============COMPUTER BOARD=============")}\n",
      user_board: "==============PLAYER BOARD==============\n",
      coord_input: "Enter the coordinate for your shot:\n",
      msg_17: "You won! Next time I'll play with my eyes open.",
      msg_18: "I WON! Next time you should try.",
      game_time: "    #{color.blue("GAMETIME")}",
      #smart AI
      ai_msg_1: "Another MISS! I'm beginning to think this will end quickly.",
      ai_msg_2: "Target aquired. I'm on the hunt now!",
      ai_msg_3: "Just warming up",
      ai_msg_4: "",
      ai_msg_5: "Try your luck again? This time I will take it easy.",
    }
  end

  def error_messages
    {
      invalid_start: "Oh boy! This should be interesting. Even my 1.238421 year old brother can press a button. Please enter #{color.green("(p)")} or #{color.red("(q)")}\n",
      invalid_coord1: "Its 3 coordinates... How hard can this be. Enter 3 valid coordinates:",
      invalid_coord2: "Are you even looking at the board? Those are invalid coordinates. Lets try this again:\n",
      err_msg_3: "Please enter a valid coordinate:\n",
      err_msg_4: "This isn't a valid input, try again.\n",
    }
  end

  def miss_defense_messages
    {
      miss1: "Another MISS! I'm beginning to think this will end quickly.",
      miss2: "SPLISH SPLASH",
      miss3: "Maybe you should calibrate your bazooka!",
      miss4: "Should I give you a hint to make this fair???"
    }
  end

  def hit_defense_messages
    {
      hit1: "They're heating up!",
      hit2: "Getting lucky I see"
    }
  end

  def ai_offense_messages
    {
      offense1: "Target aquired. I'm on the hunt now!",
      offense2: "I'm Just warming up",
    }
  end

  def ai_quit_messages
    {
      quit1: "I wouldn't want to lose either. See ya next time!",
      quit2: "Comon... I was looking forward to an easy win.",
      quit3: "I usually ask twice but today I have plans. See ya!",
      quit4: "Quitter never win",
      quit5: "I'm off to hack the turing mainframe database. Just need to get the username and password... any ideas??"
    }
  end

  def invalid_coord_messages
    {
      invalid1: "You can't miss a shot if it's not on the board. Focus up now! This time enter a valid coordinate.",
      invalid2: "Do you even know what you're doing? Enter a coordinate on the board.",
      invalid3: "Are we even playing the same game. You want to hit my ships.... THAT ARE ON THE BOARD. Enter a valid coordinate.",
      invalid4: "Maybe I should speel it out. #{print_slowly_2}"
    }
  end

  def print_slowly_2
    "Valid coordinate".split(//).each do |c|
      sleep 0.1
      print c
    end
  end

  def sample_invalid_messages
    puts invalid_coord_messages[invalid_coord_messages.keys.sample]
  end

  def sample_quit_msgs
    puts ai_quit_messages[ai_quit_messages.keys.sample]
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


end
