class MarsRover
  attr_reader :plat_width, :plat_length, :pos_x, :pos_y, :directions, :current_dir

  DIRECTIONS = ['N', 'E', 'S', 'W']
  TURNS      = ['L', 'R']
  MOVES      = ['M']
  ACTIONS    = MOVES + TURNS

  def initialize(plat_width, plat_length)
    @plat_width  = plat_width
    @plat_length = plat_length
    @directions  = DIRECTIONS
  end

  def set_position_and_direction(x, y, dir)
    dir.upcase!

    if valid_position?(x,y) && valid_direction?(dir)
      @pos_x = x
      @pos_y = y

      # Set the directions arr for rotational movement 
      until @directions.first == dir do
        @directions.rotate!
      end
    else
      # Invalid position/direction defaults to (0,0,N)
      @pos_x = 0
      @pos_y = 0
    end

    @current_dir = @directions.first

    position
  end

  def rove(instructions)
    instructions.upcase!

    return position if !valid_instructions? instructions

    instructions.split('').each do |instruction|
      can_move?(instruction) ? move(instruction) : break
    end

    position
  end

  def position
    "Position: (#{@pos_x}, #{@pos_y}, #{@current_dir})."
  end

  def quick_run
    set_position_and_direction(1,2,'N')
    rove('LMLMLMLMM')
    set_position_and_direction(3,3,'E')
    rove('MMRMMRMRRM')
  end

  private

  def valid_position?(x, y)
    return false if x.nil? || !x.between?(0, @plat_width)
    return false if y.nil? || !y.between?(0, @plat_length)
    
    true
  end

  def valid_direction?(dir)
    @directions.include? dir
  end

  def valid_instructions?(instructions)
    instructions.split('').each do |ins|
      return false unless ACTIONS.include?(ins)
    end

    true
  end

  def move(instruction)
    if TURNS.include? instruction
      adjust       = (instruction == 'L' ? -1 : 1)
      @current_dir = @directions.rotate!(adjust).first
    else
      case @current_dir
      when 'N'
        @pos_y += 1
      when 'E'
        @pos_x += 1
      when 'S'
        @pos_y -= 1
      when 'W'
        @pos_x -= 1
      else
        puts 'Invalid direction!'
      end
    end

    position
  end

  def can_move?(instruction)
    if instruction == MOVES.first
      return false unless next_move.between?(0, end_point)
    end

    true
  end

  def end_point
    if ['N','S'].include? current_dir
      plat_length
    elsif ['E', 'W'].include? current_dir
      plat_width
    end
  end

  def next_move
    case current_dir
    when 'N'
      @pos_y + 1
    when 'E'
      @pos_x + 1
    when 'S'
      @pos_y - 1
    when 'W'
      @pos_x - 1
    end
  end
end