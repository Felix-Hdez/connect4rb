require_relative 'connect4'

describe Connect4 do
  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'creates new empty board' do
      board = [[nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil]]
      expect(game.board).to eq(board)
    end
    context 'when no arguments are passed' do
      context 'first piece' do
        it 'is default value' do
          pieces = game.instance_variable_get(:@pieces)[0]
          expect(pieces[0]).to eq('●')
        end
      end
      context 'second piece' do
        it 'is default value' do
          pieces = game.instance_variable_get(:@pieces)[1]
          expect(pieces[0]).to eq('●')
        end
      end
    end
  end

  describe '#play' do
    before do
      allow(game).to receive(:print_board)
    end
    it 'it calls #print_board' do
      expect(game).to receive(:print_board)
      game.play
    end
  end
end
