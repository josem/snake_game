#uses flyweight pattern
class Cell

  def initialize(point, board)
    @position = point
    @board = board
  end

  attr_reader :position

  def resident
    @board.residents{current | current.include?(@position)}.first
  end

  def occupied?
    resident!=nil
  end

end
