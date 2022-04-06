require_relative 'string colors'

class Connect4
  attr_accessor :board
  attr_reader :pieces, :nil_piece

  def initialize(player1 = HumanPlayer.new, player2 = ComputerPlayer.new)
    @player_controller = [player1, player2]
    @current_player = 0
    @columns = 7
    @rows = 6
    @board = Array.new(@rows) { Array.new(@columns) { 0 } }
    @pieces = [' ', '●'.red, '●'.brown]
    # @board and @pieces CODE:
    # 0: empty
    # 1: player 1
    # 2: player 2
    @winner = nil
  end

  def play
    until game_over?
      print board_stdout
      make_move
      switch_curr_player
    end
    print show_results
  end

  def board_stdout
    output = ''
    @board.each do |row|
      output += row_stdout(row)
    end
  end

  def row_stdout(board_row)
    row_stdout = '|'
    board_row.each do |piece_type|
      piece = piece_stdout(piece_type)
      row_stdout += piece
    end
    row_stdout += '|'
    row_stdout
  end

  def piece_stdout(piece_type)
    @pieces[piece_type]
  end

  def make_move
    move = @player_controller[@current_player].make_move(@board)
    piece = @current_player + 1
    insert_piece(move, piece)
  end

  def switch_curr_player
    @current_player = { 0 => 1, 1 => 0 }[@current_player]
  end

  def insert_piece(position, piece)
    column = board.map { |row| row[position] }
    filled_column = column.select(&:positive?)
    insert_row = @rows - filled_column.size - 1
    @board[insert_row][position] = piece
  end

  def show_results
    return "\nTie! Nobody wins\n" if @winner.nil?

    winner_name = @player_controller[@winner].name
    "\n#{winner_name} has won!!!"
  end

end
