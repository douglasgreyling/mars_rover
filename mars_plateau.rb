class MarsPlateau
  attr_reader :width, :length
  attr_accessor :grid

  def initialize(x, y)
    if valid_dimensions?(x,y)
      @width  = x
      @length = y
    else
      @width  = 5
      @length = 5
    end
    
    @grid = []
  end  

  def valid_dimensions?(x, y)
    return true if x >= 0 && y >= 0
  end
end