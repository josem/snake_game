require 'test/unit'
require_relative '../snake_game/snake'

class SnakeTest < Test::Unit::TestCase

  def test_construction
    snake = Snake.new
    assert_equal(3, snake.length)
  end

end
