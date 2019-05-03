require "rspec"
require "./mars_rover.rb"

describe MarsRover do
  subject { MarsRover.new(5,6) }

  it "should initialize the plateau and directions" do
    expect(subject.plat_width).to eq 5
    expect(subject.plat_length).to eq 6
    expect(subject.directions).to eq MarsRover::DIRECTIONS
  end

  it "should set the correct position with valid input" do
    subject.set_position_and_direction(1,2,'N')

    expect(subject.pos_x).to eq 1
    expect(subject.pos_y).to eq 2
    expect(subject.current_dir).to eq 'N'
    expect(subject.position).to eq "Position: (1, 2, N)."
  end

  it "should set the default position with invalid x/y input" do
    subject.set_position_and_direction(-1,2,'N')

    expect(subject.pos_x).to eq 0
    expect(subject.pos_y).to eq 0
    expect(subject.current_dir).to eq 'N'
    expect(subject.position).to eq "Position: (0, 0, N)."

    subject.set_position_and_direction(1,-2,'N')

    expect(subject.pos_x).to eq 0
    expect(subject.pos_y).to eq 0
    expect(subject.current_dir).to eq 'N'
    expect(subject.position).to eq "Position: (0, 0, N)."
  end

  it "should set the default position with invalid directional input" do
    subject.set_position_and_direction(1,2,'Z')

    expect(subject.pos_x).to eq 0
    expect(subject.pos_y).to eq 0
    expect(subject.current_dir).to eq 'N'
    expect(subject.position).to eq "Position: (0, 0, N)."
  end

  it "should rove to the correct position" do
    subject.set_position_and_direction(1,2,'N')
    subject.rove('LMLMLMLMM')

    expect(subject.pos_x).to eq 1
    expect(subject.pos_y).to eq 3
    expect(subject.current_dir).to eq 'N'
    expect(subject.position).to eq "Position: (1, 3, N)."
  end

  it "should not rove when instructions are invalid" do
    subject.set_position_and_direction(1,2,'N')
    subject.rove('LMLMLMLX')

    expect(subject.pos_x).to eq 1
    expect(subject.pos_y).to eq 2
    expect(subject.current_dir).to eq 'N'
    expect(subject.position).to eq "Position: (1, 2, N)."
  end

  it "should raise an error when it tries to move out of bounds" do
    subject.set_position_and_direction(1,2,'N')
    subject.rove('LMLMLMLMMMMM')

    expect(subject.pos_x).to eq 1
    expect(subject.pos_y).to eq 6
    expect(subject.current_dir).to eq 'N'
    expect(subject.position).to eq "Position: (1, 6, N)."
  end
end