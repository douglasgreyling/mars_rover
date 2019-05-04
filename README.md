# Mars Rover Challenge :rocket:

This is my attempt at the Google Mars Rover Code Challenge.
You can read about the challenge here: https://code.google.com/archive/p/marsrovertechchallenge/

## Setup:

All you need to do is clone the repo, navigate to the directory and run `irb -r './mars_mission.rb'` to load the file into IRB.
You might need to install Rspec or Bundler if it's not installed already.

## How it works:

Initialize the class and set the plateau by running `MarsMission.new(x,y)` where x and y are the plateau dimensions.

For convenience you can run both examples as provided on Google by running `MarsMission.new(5,5).quick_mission`.

To run your own mission you can do the following:

```ruby
configs      = [[1,2,'N'], [3,3,'E']]
instructions = ['LMLMLMLMM', 'MMRMMRMRRM']

m = MarsMission.new(5,5)
m.config_rovers configs
m.launch_rovers instructions

=>Position: (1, 3, N).
=>Position: (5, 1, E).
```

## Rspec:

Run `rspec` to check that all the tests pass fine.
