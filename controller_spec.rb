

RSpec.shared_examples 'player controller' do
  describe '#name' do
    it 'returns a string' do
      expect(player.name).to be_a(String)
    end
  end

  describe '#move_prompt' do
    it 'returns a string' do
      expect(player.move_prompt).to be_a(String)
    end
  end

  it 'has #make_move' do
    expect(player).to respond_to(:make_move)
  end
end