require 'curses'

class Game
  INVISIBLE_CURSOR = 0

  attr_reader :window, :snake

  def initialize
    @window = TermWindow.new
    @snake = Snake.new()
    @directions = {Curses::KEY_DOWN => [0,1], Curses::KEY_UP => [0,-1], Curses::KEY_LEFT => [-1,0], Curses::KEY_RIGHT => [1,0] }
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

      key = prev_key unless [Curses::KEY_DOWN, Curses::KEY_UP, Curses::KEY_RIGHT, Curses::KEY_LEFT, 27].include?(key)

      if @directions.include?(key)
        @snake.move_by(@directions[key])
      end

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
