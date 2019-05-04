require "rspec"
require "./mars_mission.rb"

describe MarsMission do
  subject { MarsMission.new(5,5) }

  it "should initialize with no rovers and the correct plateua dims" do
    expect(subject.plateau.width).to eq 5
    expect(subject.plateau.length).to eq 5
    expect(subject.rovers).to eq []
  end

  it "should config rovers correctly" do
    configs = [[1,2,'N'], [3,3,'E']]

    subject.config_rovers configs

    subject.rovers.each_with_index do |rover, i|
      expect(rover.position[:x]).to eq configs[i][0]
      expect(rover.position[:y]).to eq configs[i][1]
      expect(rover.position[:dir]).to eq configs[i][2]
    end
  end

  it "should launch rovers correctly" do
    configs      = [[1,2,'N'], [3,3,'E']]
    instructions = ['LMLMLMLMM', 'MMRMMRMRRM']
    final_pos    = [[1,3,'N'], [5,1,'E']]

    subject.config_rovers configs
    subject.launch_rovers instructions

    subject.rovers.each_with_index do |rover, i|
      expect(rover.position[:x]).to eq final_pos[i][0]
      expect(rover.position[:y]).to eq final_pos[i][1]
      expect(rover.position[:dir]).to eq final_pos[i][2]
    end
  end

  it "should launch a quick mission correctly" do
    final_pos = [[1,3,'N'], [5,1,'E']]

    subject.quick_mission

    subject.rovers.each_with_index do |rover, i|
      expect(rover.position[:x]).to eq final_pos[i][0]
      expect(rover.position[:y]).to eq final_pos[i][1]
      expect(rover.position[:dir]).to eq final_pos[i][2]
    end
  end
end