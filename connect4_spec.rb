require_relative 'connect4'
require_relative 'string colors'

describe Connect4 do
  subject(:game) { described_class.new }
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
      it 'creates default empty piece' do
        piece = game.instance_variable_get(:@pieces)[0]
        expect(piece).to eq(empty_piece)
      end
    end
  end

  describe '#play' do
    let(:board_stdout_example) { 'board stdout example' }
    context 'when game_over? is false once' do
      before do
        allow(game).to receive(:game_over?).and_return(false, true  )
        allow(game).to receive(:print)
        allow(game).to receive(:board_stdout).and_return(board_stdout_example)
      end
      it 'it calls #print with board_stoud output once' do
        expect(game).to receive(:print).with(board_stdout_example).once
        game.play
      end
    end
    context 'when game_over? is false twice' do
      before do
        allow(game).to receive(:game_over?).and_return(false, false, true  )
        allow(game).to receive(:print)
        allow(game).to receive(:board_stdout).and_return(board_stdout_example)
      end
      it 'it calls #print with board_stoud output once' do
        expect(game).to receive(:print).with(board_stdout_example).twice
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
end
