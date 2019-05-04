require "rspec"
require "./mars_rover.rb"
require "./mars_plateau.rb"

describe MarsRover do
  subject { MarsRover.new(@plateau) }

  before(:all) do
    @plateau = MarsPlateau.new(5,6)
  end

  it "should initialize the position to nil" do
    expect(subject.position).to eq({ x: nil, y: nil, dir: nil })
  end

  it "should set the correct position with valid input" do
    subject.set_position_and_direction(1,2,'N')

    expect(subject.position).to eq({ x: 1, y: 2, dir: 'N' })
  end

  it "should set the default position with invalid x/y input" do
    subject.set_position_and_direction(-1,2,'N')

    expect(subject.position).to eq({ x: 0, y: 0, dir: 'N' })

    subject.set_position_and_direction(1,-2,'N')

    expect(subject.position).to eq({ x: 0, y: 0, dir: 'N' })
  end

  it "should set the default position with invalid directional input" do
    subject.set_position_and_direction(1,2,'Z')

    expect(subject.position).to eq({ x: 0, y: 0, dir: 'N' })
  end

  it "should rove to the correct position" do
    @plateau.grid = []

    subject.set_position_and_direction(1,2,'N')
    subject.rove 'LMLMLMLMM'

    expect(subject.position).to eq({ x: 1, y: 3, dir: 'N' })
    expect(@plateau.grid).to include subject.xy_position
  end

  it "should not rove when instructions are invalid" do
    @plateau.grid = []

    subject.set_position_and_direction(1,2,'N')
    subject.rove 'LMLMLMLX'

    expect(subject.position).to eq({ x: 1, y: 2, dir: 'N' })
    expect(@plateau.grid).not_to include subject.xy_position
  end

  it "should stop when it tries to move out of bounds" do
    @plateau.grid = []

    subject.set_position_and_direction(1,2,'N')
    subject.rove 'LMLMLMLMMMMM'

    expect(subject.position).to eq({ x: 1, y: 6, dir: 'N' })
    expect(@plateau.grid).to include subject.xy_position
  end

  it "should stop when it tries to move into a taken grid" do
    @plateau.grid = [[1,3]]

    subject.set_position_and_direction(1,2,'N')
    subject.rove 'M'

    expect(subject.position).to eq({ x: 1, y: 2, dir: 'N' })
    expect(@plateau.grid).to eq [[1,3], [1,2]]
  end
end