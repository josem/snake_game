class Universe

  def initialize(size = Point.new(100, 20))
    @size = size
    @population = Set.new
  end

  def cell_at(point)
    Cell.new(point, self)
  end

  def next_to(point, direction)
    (point + direction) % size
  end

  def leave(being)
    @population.delete(being)
  end

end