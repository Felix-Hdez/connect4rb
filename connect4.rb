require_relative 'string colors'
require_relative 'human'
require_relative 'computer'

class Connect4
  attr_accessor :board
  attr_reader :pieces, :nil_piece

  def initialize(player1 = HumanPlayer.new, player2 = ComputerPlayer.new)
    @player_controller = [player1, player2]
    @current_player = 0
    @rows = 6
    @columns = 7
    @board = Array.new(@rows) { Array.new(@columns) { 0 } }
    @pieces = ['_', '●'.green, '●'.red]
    # @board and @pieces CODE:
    # 0: empty
    # 1: player 1
    # 2: player 2
    @winner = nil
  end

  def play
    until (@winner = game_over?)
      puts board_stdout
      print current_controller.move_prompt
      make_move
      switch_curr_player
    end
    puts board_stdout
    puts show_results
  end

  def board_stdout
    output = " 1 2 3 4 5 6 7\n"
    @board.each do |row|
      output += "#{row_stdout(row)}\n"
    end
    output[0...-1]
  end

  def row_stdout(board_row)
    row_stdout = '|'
    board_row.each do |piece_type|
      piece = piece_stdout(piece_type)
      row_stdout += piece
    end
    row_stdout
  end

  def piece_stdout(piece_type)
    @pieces[piece_type] + '|'
  end

  def make_move
    move = current_controller.make_move(@board)
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

  def game_over?
    winner = nil

    @rows.times do |row|
      @columns.times do |column|
        # rows -
        if row <= @rows - 4
          line = 4.times.map { |i| @board[row + i][column] }
          winner ||= winner_line?(line)
        end
        # columns |
        if column <= @columns - 4
          line = 4.times.map { |i| @board[row][column + i] }
          winner ||= winner_line?(line)
        end
        # diagonals \
        if (column <= @columns - 4) && (row <= @rows - 4)
          line = 4.times.map { |i| @board[row + i][column + i] }
          winner ||= winner_line?(line)
        end
        # antidiagonals /
        if (column > @columns - 4) && (row <= @rows - 4)
          line = 4.times.map { |i| @board[row + i][column - i] }
          winner ||= winner_line?(line)
        end
      end
    end
    winner -= 1 unless winner.nil?
    winner
  end

  private

  def current_controller
    @player_controller[@current_player]
  end

  def winner_line?(line)
    line = line.uniq
    return line[0] if line.size == 1 && line != [0]
  end
end
