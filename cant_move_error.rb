module Errors
  class CantMoveError < StandardError
    def message
      "Could not move to position since it was out of bounds."
    end
  end
end