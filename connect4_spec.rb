require_relative 'connect4'

describe Connect4 do
  subject(:game) { described_class.new }

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
          expect(piece).to eq('●'.red)
        end
      end
      context 'second piece' do
        it 'is default value' do
          piece = game.instance_variable_get(:@pieces)[2]
          expect(piece).to eq('●'.green)
        end
      end
      it 'creates default empty piece' do
        piece = game.instance_variable_get(:@pieces)[0]
        expect(piece).to eq(' ')
      end
    end
  end

  describe '#play' do
    let(:board_stdout_example) { 'board stdout example' }
    before do
      allow(game).to receive(:print)
      allow(game).to receive(:board_stdout).and_return(board_stdout_example)
    end
    it 'it calls #print with board_stoud output' do
      expect(game).to receive(:print).with(board_stdout_example)
      game.play
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
    it 'calls piece_stdout 7 times' do
      expect(game).to receive(:piece_stdout).exactly(7).times
      game.row_stdout(game.board[0])
    end
  end

  describe '#piece_stdout' do
    ## TODO: implement tests
  end
end
