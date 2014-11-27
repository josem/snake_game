require 'set'

class Snake
  SYMBOL = 'O'
  attr_reader :length, :last_part

  def initialize
    @body = [[4,10], [4,9], [4,8]]
    @length = @body.length
  end

  def x
    @body[0][0]
  end

  def y
    @body[0][1]
  end

  def grow
    @length +=1
  end

  def move_to(x,y)
    @body.insert(0, [x, y])
    trim
  end

  def include?(elem)
    @body.include?(elem)
  end

  def [](idx)
    @body[idx]
  end

  def crashed?
    visited = Set.new

    @body.each_with_index do |position, i|
      if visited.include?(position)
        return true
      else
        visited << position
      end
    end

    return false
  end

  private

  def trim
    @last_part = @body.pop while @length < @body.length
  end

end
