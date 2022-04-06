
class HumanPlayer
  attr_accessor :name

  def initialize
    @name = 'Human player'
  end

  def make_move(board)
    move = player_input until valid_input? move, board
  end

  def valid_input?(input, board)
    return false if input.nil? || !input.between?(0, 6)

    column = board.map { |row| row[input] }
    column[-1].zero?
  end
end
