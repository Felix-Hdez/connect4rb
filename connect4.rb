require_relative 'string colors'

class Connect4
  attr_accessor :board
  attr_reader :pieces, :nil_piece

  def initialize
    # @board and @pieces CODE:
    # 0: empty
    # 1: player 1
    # 2: player 2
    @board = Array.new(6) { Array.new(7) { 0 } }
    @pieces = [' ', '●'.red, '●'.green]
  end

  def play
    print(board_stdout)
  end

  def board_stdout
    output = ''
    @board.each do |row|
      output += row_stdout(row)
    end
  end

  def row_stdout(board_row)
    row_stdout = '|'
    board_row.each do |peice_type|
      piece = piece_stdout(peice_type)
      row_stdout += "#{piece}|"
    end
    row_stdout
  end

  def piece_stdout(_piece_type)
    ''
  end
end
