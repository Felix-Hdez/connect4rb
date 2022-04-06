require_relative 'human'

describe HumanPlayer do
  subject(:player) { described_class.new }
  let(:board) do
    [[0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0]]
  end
  describe '#make_move' do
    context 'when #player_input returns two invalid values and then a valid one' do
      before do
        allow(player).to receive(:player_input).and_return(-1, 9, 0)
        allow(player).to receive(:valid_input?).and_return(false, false, false, true)
      end
      it 'calls #player_input until it returns a valid_input' do
        expect(player).to receive(:player_input).exactly(3).times
        player.make_move(board)
      end
      it 'calls #valid_input? with until it returns true' do
        expect(player).to receive(:valid_input?).exactly(4).times
        player.make_move(board)
      end
    end
  end

  describe '#valid_input?' do
    context 'invalid input' do
      it 'returns false if input is nil' do
        expect(player.valid_input?(nil, board)).to be(false)
      end
      it 'returns false if input is -1' do
        expect(player.valid_input?(-1, board)).to be(false)
      end
    end
    context 'valid input in empty board' do
      it 'returns true with 0' do
        expect(player.valid_input?(0, board)).to be(true)
      end
      it 'returns true with 6' do
        expect(player.valid_input?(6, board)).to be(true)
      end
    end
    context 'with a filled board' do
      let(:filled_board) do
        [[0, 0, 0, 2, 0, 0, 0],
         [0, 0, 0, 1, 0, 0, 0],
         [0, 0, 0, 2, 0, 0, 0],
         [0, 0, 0, 1, 0, 0, 0],
         [2, 0, 1, 2, 0, 0, 0],
         [2, 0, 2, 1, 0, 1, 1]]
      end
      it 'returns false when the chosen column is filled' do
        expect(player.valid_input?(3, filled_board)).to be false
      end
    end
  end

  describe '#player_input' do
    #  only contains print/gets statements -> no need for testing
  end
end