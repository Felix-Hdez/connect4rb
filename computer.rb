
class ComputerPlayer
  attr_accessor :name, :move_prompt

  def initialize
    @name = 'Computer'
    @move_prompt = "The computer will make their move\n"
  end

  def make_move(board)
    to_sample = get_possible_moves(board)
    to_sample.sample
  end

  private

  def get_possible_moves(board)
    filtered_index = []
    board[0].each_with_index do |e, index|
      filtered_index.append(index) if e.zero?
    end
    filtered_index
  end
end