class Universe

  def initialize(size)
    @size = size
    @population = Set.new
  end

  attr_reader :size

  def resident_at(point)
    @population.select {|being| being.include?(point)}.first
  end

  def next_to(point, direction)
    (point + direction) % @size
  end

  def add(being)
    @population.add(being)
  end

  def delete(being)
    @population.delete(being)
  end

  def move
    @population.clone.each {|being| being.move}
  end

end