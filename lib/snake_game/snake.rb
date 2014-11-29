require 'set'

class Snake < Being

  def initialize(universe, point = Point.new(4,10), length = 3 )
    super.initialize(universe, point)
    @length = length
    @current_direction = Direction::RIGHT
    @alive = true
    move until body.length==length
  end

  def set_direction(direction)
    @current_direction = direction unless Direction.are_opposite?(@current_direction, direction)
  end

  def move
    move_by(@current_direction)
  end

  private

  def move_by(direction)
    position = universe.next_to(head, direction)
    move_to(position)
  end

  def move_to(position)
    cell = universe.cell_at(position)
    eat(cell.resident)
    body.unshift(position)
    trim
  end

  def eat(other)
    other.kill
    self.grow
  end

  def grow
    @length +=1
  end

  def trim
    body.pop while @length < body.length
  end

end