require './mars_plateau'
require './mars_rover'

class MarsMission
  attr_accessor :rovers, :plateau

  def initialize(x, y)
    @plateau = MarsPlateau.new(x,y)
    @rovers  = []
  end

  # Configs must be a 2D array which holds x, y, and
  # current direction (in that order) for each rover
  def config_rovers(configs)
    configs.each do |config|
      r = MarsRover.new @plateau
      r.set_position_and_direction(*config)
      rovers << r
    end
  end

  # Instructions must be an array of instructions
  def launch_rovers(instructions)
    rovers.each_with_index do |rover, i|
      rover.rove instructions[i]
    end
  end

  def quick_mission
    configs      = [[1,2,'N'], [3,3,'E']]
    instructions = ['LMLMLMLMM', 'MMRMMRMRRM']

    config_rovers configs
    launch_rovers instructions
  end
end