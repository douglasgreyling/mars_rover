# Mars Rover Challenge :rocket:

## Setup:

Clone the repo, navigate to the directory and run `irb -r './mars_rover.rb'` to load the file into IRB.

## Use:

Initialize the class and set the plateau by running `MarsRover.new(x,y)` where x and y are the plateau dimensions.

For convenience you can run both examples as provided on Google by running `MarsRover.new(x,y).quick_run`.

To run your own mission you can do the following:

```ruby
r = MarsRover.new(5,5)
r.set_position_and_direction(1,2,'N')
r.rove('LMLMLMLMM')
```

## Rspec:

First make sure that rspec is installed, if not then bundle it. To run all the specs: `rspec spec/mars_rover_spec.rb`.
