require 'curses'

class Output

  INVISIBLE_CURSOR = 0

  def self.config
    Curses.init_screen
    Curses.cbreak
    Curses.noecho
    Curses.curs_set(INVISIBLE_CURSOR)
  end

  attr_reader :window

  def initialize(width, height)
    @window = Curses::Window.new(height, width, 0, 0)
    @window.box(?|, ?-)
    @window.keypad(true)
    @window.timeout = 150
  end

  def getch
    @window.getch
  end

  def clear(point)
    draw(' ', point)
  end

  def draw(symbol, point)
    point +=Point.new(1,1)
    @window.setpos(point.y, point.x)
    @window.addstr(symbol)
    @window.refresh
  end

end