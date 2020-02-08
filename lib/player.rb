class Player
    attr_reader :player_board, :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
  end

  def valid_player_placement(ship, coordinates)
    # require "pry"; binding.pry
    @player_board.valid_placement?(ship, coordinates)
  end


end
