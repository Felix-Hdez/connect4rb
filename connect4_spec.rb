require_relative 'connect4'
require_relative 'string colors'
require_relative 'human'
require_relative 'computer'

describe Connect4 do
  let(:human_move) { 5 }
  let(:computer_move) { 5 }
  let(:human_player) { instance_double(HumanPlayer, make_move: human_move) }
  let(:computer_player) { instance_double(HumanPlayer, make_move: computer_move) }
  subject(:game) { described_class.new(human_player, computer_player) }
  let(:player1_piece) { '●'.red }
  let(:player2_piece) { '●'.brown }
  let(:empty_piece) { ' ' }

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
          expect(piece).to eq(player1_piece)
        end
      end
      context 'second piece' do
        it 'is default value' do
          piece = game.instance_variable_get(:@pieces)[2]
          expect(piece).to eq(player2_piece)
        end
      end
      context 'empty piece' do
        it 'is default value' do
          piece = game.instance_variable_get(:@pieces)[0]
          expect(piece).to eq(empty_piece)
        end
      end
    end
  end

  describe '#play' do
    let(:board_stdout_example) { 'board stdout example' }
    context 'when game_over? is false once' do
      before do
        allow(game).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:print)
        allow(game).to receive(:make_move).and_return(4)
        allow(game).to receive(:board_stdout).and_return(board_stdout_example)
      end
      it 'calls #make_move once' do
        expect(game).to receive(:make_move).once
        game.play
      end
      it 'calls #print with board_stoud output once' do
        expect(game).to receive(:print).with(board_stdout_example).once
        game.play
      end
    end
    context 'when game_over? is false twice' do
      before do
        allow(game).to receive(:game_over?).and_return(false, false, true)
        allow(game).to receive(:print)
        allow(game).to receive(:make_move).and_return(4, 4)
        allow(game).to receive(:board_stdout).and_return(board_stdout_example)
      end
      it 'calls #make_move twice' do
        expect(game).to receive(:make_move).twice
        game.play
      end
      it 'calls #print with board_stoud output once' do
        expect(game).to receive(:print).with(board_stdout_example).twice
        game.play
      end
    end
    # TODO: if game is over, loop ends, displays who won.
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
        row_output = '|       |'
        row_input = [0, 0, 0, 0, 0, 0, 0]
        expect(game.row_stdout(row_input)).to eq(row_output)
      end
    end
  end

  describe '#piece_stdout' do
    it 'returns the empty piece when the piece type is 0' do
      expect(game.piece_stdout(0)).to eq(empty_piece)
    end
    it 'returns the player1 piece when the piece type is 1' do
      expect(game.piece_stdout(1)).to eq(player1_piece)
    end
    it 'returns the player2 piece when the piece type is 1' do
      expect(game.piece_stdout(2)).to eq(player2_piece)
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
    # TODO: cover with tests
  end
end
