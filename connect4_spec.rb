require_relative 'connect4'
require_relative 'string colors'
require_relative 'human'
require_relative 'computer'

describe Connect4 do
  let(:human_move) { 5 }
  let(:computer_move) { 5 }
  let(:human_player) { instance_double(HumanPlayer, make_move: human_move, move_prompt: '') }
  let(:computer_player) { instance_double(HumanPlayer, make_move: computer_move, move_prompt: 'The computer moves') }
  subject(:game) { described_class.new(human_player, computer_player) }
  let(:player1_piece) { '●' }
  let(:player2_piece) { '●' }
  let(:empty_piece) { '_' }

  describe '#initialize' do
    it 'creates new empty board' do
      board = [[0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0]]
      expect(game.board).to eq(board)
    end
    context 'when no arguments are passed' do
      it 'sets current player as 0' do
        current_player = game.instance_variable_get(:@current_player)
        expect(current_player).to eq(0)
      end
      context 'first piece' do
        it 'is default value' do
          piece = game.instance_variable_get(:@pieces)[1]
          expect(piece).to include(player1_piece)
        end
      end
      context 'second piece' do
        it 'is default value' do
          piece = game.instance_variable_get(:@pieces)[2]
          expect(piece).to include(player2_piece)
        end
      end
      context 'empty piece' do
        it 'is default value' do
          piece = game.instance_variable_get(:@pieces)[0]
          expect(piece).to include(empty_piece)
        end
      end
      it 'creates array @player_controller with 2 items' do
        controllers = game.instance_variable_get(:@player_controller)
        expect(controllers).to be_an(Array)
        expect(controllers).to have_attributes(size: 2)
      end
    end
  end

  describe '#play' do
    let(:board_stdout_example) { 'board stdout example' }
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:print)
      allow(game).to receive(:make_move).and_return(4)
      allow(game).to receive(:board_stdout).and_return(board_stdout_example)
      allow(game).to receive(:show_results)
    end
    context 'when game_over? is false once' do
      before do
        allow(game).to receive(:game_over?).and_return(false, true)
      end
      it 'calls #make_move once' do
        expect(game).to receive(:make_move).once
        game.play
      end
      it 'calls #puts with board_stoud output twice' do
        expect(game).to receive(:puts).with(board_stdout_example).twice
        game.play
      end
      it 'calls #show_results once' do
        expect(game).to receive(:show_results).once
        game.play
      end
    end
    context 'when game_over? is false twice' do
      before do
        allow(game).to receive(:game_over?).and_return(false, false, true)
      end
      it 'calls #make_move twice' do
        expect(game).to receive(:make_move).twice
        game.play
      end
      it 'calls #puts with board_stoud output once' do
        expect(game).to receive(:puts).with(board_stdout_example).exactly(3).times
        game.play
      end
      it 'calls #show_results once' do
        expect(game).to receive(:show_results).once
        game.play
      end
    end
  end

  describe '#board_stdout' do
    before do
      allow(game).to receive(:row_stdout).and_return('row_stdout')
    end

    it 'calls row_stdout 6 times' do
      expect(game).to receive(:row_stdout).exactly(6).times
      game.board_stdout
    end
  end

  describe '#row_stdout' do
    context 'when the row is empty' do
      before do
        allow(game).to receive(:piece_stdout).and_return(empty_piece)
      end

      it 'calls piece_stdout 7 times' do
        expect(game).to receive(:piece_stdout).exactly(7).times
        game.row_stdout(game.board[0])
      end

      it 'returns correct row output with empty row' do
        row_output = '|' + (empty_piece * 7)
        row_input = [0, 0, 0, 0, 0, 0, 0]
        expect(game.row_stdout(row_input)).to eq(row_output)
      end
    end
  end

  describe '#piece_stdout' do
    it 'inlcudes the empty piece when the piece type is 0' do
      expect(game.piece_stdout(0)).to include(empty_piece)
    end
    it 'includes the player1 piece when the piece type is 1' do
      expect(game.piece_stdout(1)).to include(player1_piece)
    end
    it 'inlcudes the player2 piece when the piece type is 1' do
      expect(game.piece_stdout(2)).to include(player2_piece)
    end
  end

  describe '#switch_curr_player' do
    context 'when the current player is 0' do
      before do
        game.instance_variable_set(:@current_player, 0)
      end
      it 'changes the current player to 1' do
        game.switch_curr_player
        current_player = game.instance_variable_get(:@current_player)
        expect(current_player).to eq(1)
      end
    end
    context 'when the current player is 1' do
      before do
        game.instance_variable_set(:@current_player, 1)
      end
      it 'changes the current player to 0' do
        game.switch_curr_player
        current_player = game.instance_variable_get(:@current_player)
        expect(current_player).to eq(0)
      end
    end
  end

  describe '#make_move' do
    before do
      allow(game).to receive(:insert_piece)
      allow(human_player).to receive(:move_prompt)
      allow(computer_player).to receive(:move_prompt)
    end
    context 'when @current_player is 0' do
      before do
        game.instance_variable_set(:@current_player, 0)
      end
      it 'calls #make_move for the first @player_controller' do
        first_controller = game.instance_variable_get(:@player_controller)[0]
        expect(first_controller).to receive(:make_move)
        game.make_move
      end
      it 'calls #insert_piece with the piece number' do
        move = human_move
        expect(game).to receive(:insert_piece).with(move, 1)
        game.make_move
      end
    end
    context 'when @current_player is 1' do
      before do
        game.instance_variable_set(:@current_player, 1)
      end
      it 'calls #make_move for the second @player_controller' do
        second_controller = game.instance_variable_get(:@player_controller)[1]
        expect(second_controller).to receive(:make_move)
        game.make_move
      end
    end
  end

  describe '#insert_piece' do
    context 'when @board is empty' do
      it 'inserts the piece correctly' do
        expected_board = [[0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 1, 0, 0, 0]]
        game.insert_piece(3, 1)
        new_board = game.instance_variable_get(:@board)
        expect(new_board).to eq(expected_board)
      end
    end
    context 'when @board is half filled' do
      it 'inserts the piece correctly' do
        filled_board = [[0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0],
                        [0, 2, 1, 2, 0, 1, 2],
                        [2, 1, 2, 1, 2, 1, 1],
                        [1, 2, 1, 2, 2, 1, 1],
                        [1, 2, 2, 1, 1, 2, 1]]
        game.instance_variable_set(:@board, filled_board)
        expected_board = [[0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 2, 1, 2, 1, 1, 2],
                          [2, 1, 2, 1, 2, 1, 1],
                          [1, 2, 1, 2, 2, 1, 1],
                          [1, 2, 2, 1, 1, 2, 1]]
        game.insert_piece(4, 1)
        new_board = game.instance_variable_get(:@board)
        expect(new_board).to eq(expected_board)
      end
    end
  end

  describe '#show_results' do
    context 'when winner is 0' do
      let(:player1_name) { 'Human player' }
      let(:player2_name) { 'Computer' }
      before do
        controllers = [instance_double(HumanPlayer, name: player1_name),
                       instance_double(ComputerPlayer, name: player2_name)]
        game.instance_variable_set(:@player_controller, controllers)
        game.instance_variable_set(:@winner, 0)
      end
      it 'prints the first player as a winner' do
        message = "\n#{player1_name} has won!!!"
        expect(game.show_results).to eql(message)
      end
    end
    context 'when winner is 1' do
      let(:player1_name) { 'Human player' }
      let(:player2_name) { 'Computer' }
      before do
        controllers = [instance_double(HumanPlayer, name: player1_name),
                       instance_double(ComputerPlayer, name: player2_name)]
        game.instance_variable_set(:@player_controller, controllers)
        game.instance_variable_set(:@winner, 1)
      end
      it 'prints the second player as a winner' do
        message = "\n#{player2_name} has won!!!"
        expect(game.show_results).to eql(message)
      end
    end
    context 'when winner is nil (tie)' do
      before do
        game.instance_variable_set(:@winner, nil)
      end
      it 'prints the tie statement' do
        message = "\nTie! Nobody wins\n"
        expect(game.show_results).to eql(message)
      end
    end
  end

  #TODO: implement specific row, column, diagonal and antidiagonal tests.
  describe '#game_over?' do
    context 'not game over' do
      context 'when @board is empty' do
        it 'returns nil' do
          expect(game.game_over?).to be_nil
        end
      end
      context 'when @board is half filled' do
        before do
          board = [[0, 0, 0, 2, 0, 0, 0],
                   [0, 0, 0, 1, 0, 0, 0],
                   [0, 0, 0, 2, 1, 0, 0],
                   [0, 0, 1, 1, 2, 0, 0],
                   [2, 0, 2, 2, 1, 1, 2],
                   [1, 0, 2, 1, 1, 1, 2]]
          game.instance_variable_set(:@board, board)
        end
        it 'returns nil' do
          expect(game.game_over?).to be_nil
        end
      end
    end
    context 'game over' do
      context 'winner is player 0' do
        context 'when @board is half filled' do
          before do
            board = [[0, 0, 0, 2, 0, 0, 0],
                     [0, 0, 0, 1, 0, 0, 0],
                     [0, 0, 0, 2, 1, 0, 1],
                     [0, 0, 1, 1, 2, 1, 2],
                     [2, 0, 2, 2, 1, 1, 2],
                     [1, 0, 2, 1, 1, 1, 2]]
            game.instance_variable_set(:@board, board)
          end
          it 'returns 0' do
            expect(game.game_over?).to eq(0)
          end
        end
        context 'when @board is almost filled' do
          before do
            board = [[1, 1, 2, 1, 0, 1, 2],
                     [2, 1, 2, 1, 2, 1, 2],
                     [1, 2, 1, 2, 1, 2, 1],
                     [2, 1, 2, 1, 2, 1, 2],
                     [2, 1, 2, 1, 2, 1, 2],
                     [1, 2, 1, 2, 1, 2, 1]]
            game.instance_variable_set(:@board, board)
          end
          it 'returns 0' do
            expect(game.game_over?).to eq(0)
          end
        end
        context 'when @board is almost empty' do
          before do
            board = [[0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 2, 2, 2, 0, 0, 0],
                     [0, 1, 1, 1, 1, 0, 0]]
            game.instance_variable_set(:@board, board)
          end
          it 'returns 0' do
            expect(game.game_over?).to eq(0)
          end
        end
      end
      context 'winner is player 1' do
        context 'when @board is half filled' do
          before do
            board = [[0, 0, 0, 1, 0, 0, 0],
                     [0, 0, 0, 2, 0, 0, 0],
                     [0, 0, 0, 1, 2, 0, 2],
                     [0, 0, 2, 2, 1, 2, 1],
                     [1, 0, 1, 1, 2, 2, 1],
                     [2, 0, 1, 2, 2, 2, 1]]
            game.instance_variable_set(:@board, board)
          end
          it 'returns 1' do
            expect(game.game_over?).to eq(1)
          end
        end
        context 'when @board is almost filled' do
          before do
            board = [[2, 2, 1, 2, 0, 2, 1],
                     [1, 2, 1, 2, 1, 2, 1],
                     [2, 1, 2, 1, 2, 1, 2],
                     [1, 2, 1, 2, 1, 2, 1],
                     [1, 2, 1, 2, 1, 2, 1],
                     [2, 1, 2, 1, 2, 1, 2]]
            game.instance_variable_set(:@board, board)
          end
          it 'returns 1' do
            expect(game.game_over?).to eq(1)
          end
        end
        context 'when @board is almost empty' do
          before do
            board = [[0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0, 0],
                     [0, 0, 1, 1, 1, 0, 0],
                     [0, 2, 2, 2, 2, 1, 0]]
            game.instance_variable_set(:@board, board)
          end
          it 'returns 1' do
            expect(game.game_over?).to eq(1)
          end
        end
      end
    end
  end
end
