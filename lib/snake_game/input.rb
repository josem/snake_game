require 'curses'

class Input

  ESCAPE_KEY = 27
  KEY_TO_DIRECTION = {
      Curses::KEY_DOWN => Direction::DOWN,
      Curses::KEY_UP => Direction::UP,
      Curses::KEY_LEFT => Direction::LEFT,
      Curses::KEY_RIGHT => Direction::RIGHT}

  def initialize(window)
    @window = window
    @key = nil
    @direction = Direction::RIGHT
  end

  def scan
    @key = @window.getch
  end

  def direction
    candidate = KEY_TO_DIRECTION[@key]
    if candidate!= nil && !Direction.are_opposite?(candidate, @direction)
      @direction = candidate
    end
    @direction
  end

  def exit?
    @key==ESCAPE_KEY
  end

end