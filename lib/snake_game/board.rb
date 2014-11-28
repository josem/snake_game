class Board
  DEFAULT_WIDTH = 100
  DEFAULT_HEIGHT = 20

  attr_accessor :width, :height

  def initialize(height = DEFAULT_HEIGHT, width = DEFAULT_WIDTH)
    @width, @height = width, height
  end


  def occupied?(cell)
  end

  def occupy(cell, who)
  end

  def release(cell)
  end

  def next_to(cell, direction)
    new_pos = [cell[0] + direction[0], cell[1] + direction[1]]
    new_pos[0] = @width - 2  if new_pos[0] == 0
    new_pos[1] = @height - 2 if new_pos[1] == 0
    new_pos[0] = 1 if new_pos[0] == @width - 1
    new_pos[1] = 1 if new_pos[1] == @height - 1
    new_pos
  end

end
