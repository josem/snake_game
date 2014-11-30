class Mouse < Being

  def initialize(universe, output)
    point = free_random_point(universe)
    super(universe, point, output)
    output.draw('x', point)
  end


  def kill
    super
    new_mouse = Mouse.new(@universe, output)
    universe.add(new_mouse)
    output.clear(head)
  end

  private

  def free_random_point(universe)
    loop do
      x = Random.rand(0..universe.size.x-1)
      y = Random.rand(0..universe.size.y-1)
      point = Point.new(x, y)
      if universe.resident_at(point).nil?
        return point
      end
    end
  end

end