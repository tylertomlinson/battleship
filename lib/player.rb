class Player
    attr_reader :player_board, :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
  end
end
