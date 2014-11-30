require 'set'

class Snake < Being

  def initialize(universe, output, input, point = Point.new(4,10), initial_length = 3 )
    super(universe, point, output)
    @length = @initial_length = initial_length
    @alive = true
    @input = input
    #move until body.length==length
  end


  def move
    move_by(@input.direction)
  end

  def score
    @length -  @initial_length
  end

  private

  def move_by(direction)
    position = universe.next_to(head, direction)
    move_to(position)
  end

  def move_to(position)
    other = universe.resident_at(position)
    eat(other) unless other.nil?
    body.unshift(position)
    trim
    @output.draw('O', position)
  end

  def eat(other)
    other.kill
    grow
  end

  def grow
    @length +=1
  end

  def trim
    while body.length > @length
      left_point = body.pop
      @output.clear(left_point)
    end
  end

end