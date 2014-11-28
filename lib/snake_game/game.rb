require 'curses'

class Game
  INVISIBLE_CURSOR = 0

  attr_reader :window, :snake

  def initialize
    @window = TermWindow.new
    @snake = Snake.new()
    @key_to_direction = {
      Curses::KEY_DOWN => Direction::DOWN,
      Curses::KEY_UP => Direction::UP,
      Curses::KEY_LEFT => Direction::LEFT,
      Curses::KEY_RIGHT => Direction::RIGHT }
  end

  def create
    Curses.init_screen()
    Curses.cbreak()
    Curses.noecho
    Curses.curs_set(INVISIBLE_CURSOR)

    run
  end

  private
  def run

    key = Curses::KEY_RIGHT
    score = 0

    food = Food.new(window)
    food.relocate_without_conflict!(@snake)

    window.paint_food(food)

    while (key != 27)
      window.setpos(0, (window.width / 2) - 10)
      window.addstr(" Score: #{score.to_s} ")
      window.timeout = 150

      prev_key = key
      event = window.getch()
      key = event == -1 ? key : event

      @snake.set_direction(@key_to_direction[key]) if @key_to_direction.include?(key)

      @snake.tick

      @snake[0][0] = (window.width.to_i - 2) if @snake[0][0] == 0
      @snake[0][1] = (window.height.to_i - 2) if @snake[0][1] == 0
      @snake[0][0] = 1 if @snake[0][0] == window.width - 1
      @snake[0][1] = 1 if @snake[0][1] == window.height - 1

      if snake.crashed?
        break
      end

      if food.has_been_eaten_by?(@snake)
        @snake.grow
        score += food.points
        food = Food.new(window)
        food.relocate_without_conflict!(@snake)
        window.paint_food(food)
      else
        last_part = @snake.last_part
        if (last_part!=nil)
          window.setpos(last_part[1], last_part[0])
          window.addstr(' ')
        end
      end

      window.paint_snake(@snake)
    end

    window.close
    Curses.close_screen

    puts("----- GAME OVER -----")
    puts("----- Score: #{score} -----")
  end
end
