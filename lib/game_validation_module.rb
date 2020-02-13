module GameValidationModule

  def valid_cruiser_input?(user_input)
    while !@player_board.valid_placement?(@cruiser, user_input)
      nap_time
      puts error_messages[:invalid_coord1]
      cruiser_input
    end
  end

  def cruiser_coordinates
    blinking
    puts messages[:cruiser_coord]
    cruiser_input
  end

  def cruiser_input
    user_input = gets.chomp
    user_input = sanitized_input(user_input)
    valid_cruiser_input?(user_input)
    @player_board.valid_placement?(@cruiser, user_input)
    @player_board.place(@cruiser, user_input)
    puts @player_board.render(true)
    submarine_coordinates
  end

  def submarine_coordinates
    blinking
    puts messages[:sub_coord]
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
      nap_time
      puts error_messages[:invalid_coord2]
      submarine_input
    end
  end

  def sanitized_input(user_input)
    user_input = user_input.upcase.squeeze.strip.gsub(" ", "").scan(/../)
  end
end
