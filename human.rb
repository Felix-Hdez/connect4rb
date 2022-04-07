
class HumanPlayer
  attr_accessor :name, :move_prompt

  def initialize
    @name = 'Human player'
    @move_prompt = ''
  end

  def make_move(board)
    move = player_input until valid_input? move, board
    move
  end

  def valid_input?(input, board)
    return false if input.nil? || !input.between?(0, 6)

    column = board.map { |row| row[input] }
    column[0].zero?
  end

  def player_input
    print 'Choose a move: '
    gets.to_i - 1
  end
end
