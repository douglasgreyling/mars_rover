require "rspec"
require "./mars_plateau.rb"

describe MarsPlateau do
  subject { MarsPlateau.new(5,6) }

  it "should initialize the correct length and grid with valid input" do
    expect(subject.width).to eq 5
    expect(subject.length).to eq 6
    expect(subject.grid).to eq []
  end

  it "should initialize the default length and grid with invalid input" do
    bad_plateau = MarsPlateau.new(5,-6)

    expect(bad_plateau.width).to eq 5
    expect(bad_plateau.length).to eq 5
    expect(bad_plateau.grid).to eq []
  end
end