require_relative 'controller_spec'
require_relative 'computer'

srand RSpec.configuration.seed

describe ComputerPlayer do
  subject(:player) { described_class.new }
  let(:board) do
    [[0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0]]
  end

  include_examples 'player controller'

  describe '#make_move' do
    it 'returns a number between 0 and 6' do
      expect(player.make_move(board)).to be_between(0, 6)
    end
  end
end