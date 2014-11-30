class Direction

  RIGHT = Point.new(1, 0)
  LEFT = Point.new(-1, 0)
  UP = Point.new(0, -1)
  DOWN = Point.new(0, 1)
  NONE = Point.new(0, 0)

  def self.are_opposite?(first, second)
    (first * -1) == second
  end

end
