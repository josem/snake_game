class Game

  def initialize(width = 100, height = 20)
    size = Point.new(width, height)

    @output = Output.new(size)
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
      @output.set_title(" Score: #{@snake.score} ")
    end
    @output.close
    puts('----- GAME OVER -----')
    puts('----- Score: #{@snake.score} -----')
  end
end
