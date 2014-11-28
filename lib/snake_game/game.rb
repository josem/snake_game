require 'curses'

class Game
  INVISIBLE_CURSOR = 0

  attr_reader :window, :snake

  def initialize
    @window = TermWindow.new
    @board = Board.new
    @snake = Snake.new(@board)
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

      event = window.getch()
      key = event == -1 ? key : event

      @snake.set_direction(@key_to_direction[key]) if @key_to_direction.include?(key)

      @snake.tick


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
