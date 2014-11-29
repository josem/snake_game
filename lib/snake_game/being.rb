class Being

  def initialize(universe, point )
    @universe = universe
    @body = [point]
    @alive = true
  end

  def include?(point)
    @body.include?(point)
  end

  def kill
    @alive = false
    @universe.leave(self)
  end

  def alive?
    @alive
  end

  protected

  attr_reader :universe, :body

  def head
    @body[0]
  end

end