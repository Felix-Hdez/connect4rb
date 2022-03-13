class Connect4
  attr_accessor :board
  attr_reader :pieces

  def initialize
    @board = Array.new(6) { Array.new(7) }
    @pieces = ['●', '●']
  end
end
