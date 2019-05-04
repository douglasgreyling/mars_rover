class MarsPlateau
  attr_reader :width, :length
  attr_accessor :grid

  def initialize(x, y)
    @width  = x
    @length = y
    @grid   = []
  end  
end