class Point
  def initialize(x,y)
    @x, @y = x,y
  end

  attr_reader :x, :y

  def +(point)
    Point.new(self.x + point.x, self.y + point.y)
  end

  # modulo operation
  def %(size)
    Point.new(self.x % size.x, self.y % size.y)
  end

  #scalar multiplication
  def *(number)
    Point.new(self.x * number, slef.y * number)
  end

  def ==(point)
    (self.x == point.x) and (self.y == pont.y)
  end

end
