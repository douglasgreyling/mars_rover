class MarsRover
  attr_reader :position

  DIRECTIONS = ['N', 'E', 'S', 'W']
  TURNS      = ['L', 'R']
  MOVES      = ['M']
  ACTIONS    = MOVES + TURNS

  def initialize(plateau)
    @plateau    = plateau
    @directions = DIRECTIONS.clone
    @position   = { x: nil, y: nil, dir: nil }
  end

  def set_position_and_direction(x, y, dir)
    dir.upcase!

    if valid_position?(x,y) && valid_direction?(dir)
      @position[:x] = x
      @position[:y] = y

      # Set the directions arr for rotational movement 
      until @directions.first == dir do
        @directions.rotate!
      end
    else
      # Invalid position/direction defaults to (0,0,N)
      @position[:x] = 0
      @position[:y] = 0
    end

    @position[:dir] = @directions.first

    print_position
  end

  def rove(instructions)
    instructions.upcase!

    return position if !valid_instructions? instructions

    # Follow all of the instructions
    instructions.split('').each do |instruction|
      can_move?(instruction) ? move(instruction) : break
    end

    @plateau.grid << xy_position
    print_position

    @position
  end

  def print_position
    puts "Position: (#{@position[:x]}, #{@position[:y]}, #{@position[:dir]})."
  end

  def xy_position
    [@position[:x], @position[:y]]
  end

  private

  def valid_position?(x, y)
    return false if x.nil? || !x.between?(0, @plateau.width)
    return false if y.nil? || !y.between?(0, @plateau.length)
    
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
    # Check if instructed to turn
    if TURNS.include? instruction
      # Set the turn adjustment based on the instruction
      adjust          = (instruction == 'L' ? -1 : 1)
      @position[:dir] = @directions.rotate!(adjust).first
    else
      case @position[:dir]
      when 'N'
        @position[:y] += 1
      when 'E'
        @position[:x] += 1
      when 'S'
        @position[:y] -= 1
      when 'W'
        @position[:x] -= 1
      end
    end

    position
  end

  def can_move?(instruction)
    if instruction == MOVES.first
      return false unless next_move.between?(0, end_point) && next_move_not_taken?
    end

    true
  end

  # Calculate the end point based on the next move
  def end_point
    if ['N','S'].include? @position[:dir]
      @plateau.length
    elsif ['E', 'W'].include? @position[:dir]
      @plateau.width
    end
  end

  def next_move_not_taken?
    !@plateau.grid.include? xy_position
  end

  # Calculate the postion based on the next move
  def next_move
    case @position[:dir]
    when 'N'
      @position[:y] + 1
    when 'E'
      @position[:x] + 1
    when 'S'
      @position[:y] - 1
    when 'W'
      @position[:y] - 1
    end
  end
end