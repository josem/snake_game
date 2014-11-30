class Game


  def initialize(width = 100, height = 20)
    size = Point.new(width, height)
    size_with_frame = size + Point.new(2,2)
    @output = Output.new(size_with_frame.x, size_with_frame.y)
    @input = Input.new(@output.window)

    @universe = Universe.new(size)
    @snake = Snake.new(@universe, @output, @input)
    @universe.add(@snake)
    mouse = Mouse.new(@universe, @output)
    @universe.add(mouse)
  end


  def run
    loop do
      @input.scan
      break if @input.exit? or not @snake.alive?
      @universe.move
    end
  end
end
