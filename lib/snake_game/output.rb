require 'curses'

class Output

  INVISIBLE_CURSOR = 0

  attr_reader :window

  def initialize(size)
    Curses.init_screen
    Curses.cbreak
    Curses.noecho
    Curses.curs_set(INVISIBLE_CURSOR)

    size_with_frame = size + Point.new(2, 2)
    @window = Curses::Window.new(size_with_frame.y, size_with_frame.x, 0, 0)
    @window.box(?|, ?-)
    @window.keypad(true)
    @window.timeout = 150

    @title_position = Point.new((size_with_frame.x / 2) - 10, -1)
  end

  def getch
    @window.getch
  end

  def clear(point)
    draw(' ', point)
  end

  def draw(symbol, point)
    point +=Point.new(1, 1)
    @window.setpos(point.y, point.x)
    @window.addstr(symbol)
    @window.refresh
  end

  def set_title(title)
    draw(title, @title_position)
  end

  def close
    @window.close
    Curses.close_screen
  end

end