# A list of constants.

NAME = 'Boing2D'

# The path to the resources.
RESOURCES = './res/'

# The specific paths for each resource.
DUKE_IMG = "#{RESOURCES}duke.gif"
JAVA_IMG = "#{RESOURCES}java_logo.png"

# The amount of balls.
AMT_OF_BALLS = 24

# The target FPS.
TARGET_FPS = 60

# The dimensions.
BOARD_X = 512
BOARD_Y = 512

# The size of the ball.
BALL_SIZE = BOARD_X / 8

# The gravity. Note: Balls do eventually
# fall with the default gravity (0.166)!
GRAVITY = 0.166

# The speed at which the balls move.
SPEED = 6

# The boosted darkness level of the
# gradient, which is out of 1.
GRAD_DARK = 0.6

# The boosted brightness level of the
# balls, which is out of 1.
B_BRIGHT = 0.05

# The default value for the depth of the
# red, green, and blue values (out of 255).
COL_DEP = 245 # 0.2
