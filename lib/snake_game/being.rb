class Being

  def initialize(universe, point, output)
    @universe, @output = universe, output
    @body = [point]
    @alive = true
  end

  def include?(point)
    @body.include?(point)
  end

  def kill
    @alive = false
    @universe.delete(self)
  end

  def alive?
    @alive
  end

  def move

  end

  protected

  attr_reader :universe, :output, :body

  def head
    @body[0]
  end


end