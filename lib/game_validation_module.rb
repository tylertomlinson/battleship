module GameValidationModule

  def valid_cruiser_input?(user_input)
    while !@player_board.valid_placement?(@cruiser, user_input)
      nap_time
      sample_cruiser_messages
      cruiser_input
    end
  end

  def cruiser_coordinates
    blinking
    opening_message_4
    line
    cruiser_input
  end

  def cruiser_input
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_cruiser_input?(user_input)
    @player_board.valid_placement?(@cruiser, user_input)
    @player_board.place(@cruiser, user_input)
    print_lines
    line
    player_board
    submarine_coordinates
  end

  def submarine_coordinates
    nap_time
    line
    opening_message_5
    line
    submarine_input
  end

  def submarine_input
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_submarine_input?(user_input)
    @player_board.place(@submarine, user_input)
    print_lines
    line
    player_board
    line
    @player_board.place(@submarine, user_input)
    new_window
    blinking
    puts messages[:compressing_data]
    print_slowly
    game_time
    turn
  end

  def valid_submarine_input?(user_input)
    while !@player_board.valid_placement?(@submarine, user_input)
      nap_time
      sample_submarine_messages
      submarine_input
    end
  end

  def sanitized_input(user_input)
    user_input = user_input.upcase.squeeze.strip.gsub(" ", "").scan(/../)
  end
end
