# A blueprint of a ball.

class Ball
  attr_accessor :x, :y, :vx, :vy, :stuck, :color, :bsize

  # The constructor of this class.
  def initialize(color, bsize)
    @color = color
    @bsize = bsize

    # The start location should be at the center.
    @x = BOARD_X / 2
    @y = BOARD_Y / 2

    # Set velocity of zero.
    @vx = 0
    @vy = 0

    # Unused.. so far.
    @stuck = false
  end
end