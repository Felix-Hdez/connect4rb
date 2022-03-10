require_relative 'connect4'

describe Connect4 do
  subject(:game) { described_class.new }

  describe "initialize" do
    it 'creates new empty board' do
      board = [[nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil],
               [nil, nil, nil, nil, nil, nil, nil]]
      expect(game.board).to eq(board)
    end
  end
end