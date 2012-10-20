require 'java'
require './lib/lwjgl.jar'
require './lib/slick.jar'

SRC_PATH = './src/'
require "#{SRC_PATH}ball.rb"
require "#{SRC_PATH}constants.rb"
require "#{SRC_PATH}utils.rb"

java_import 'java.lang.Runtime'
java_import 'org.newdawn.slick.AppGameContainer'
java_import 'org.newdawn.slick.BasicGame'
java_import 'org.newdawn.slick.Color'
java_import 'org.newdawn.slick.GameContainer'
java_import 'org.newdawn.slick.Graphics'
java_import 'org.newdawn.slick.Image'
java_import 'org.newdawn.slick.SlickException'
java_import 'org.newdawn.slick.geom.Circle'

# The main application event handling
# which extends Slick's BasicGame class.
#
# @author Whackatre

class Boing < BasicGame

  # The constructor of this class.
  def initialize(name)
    super(name)
    @balls = []
    @runtime = Runtime::get_runtime
    puts 'Boing is starting..'
  end

  # Called at the start of the application.
  def init(container)
    @container = container

    # Initialize the balls.
    AMT_OF_BALLS.times do |i|
      b = Ball.new(random_color.brighter(B_BRIGHT), BALL_SIZE)
      b.vx = randomf_range(-1 * SPEED, SPEED)
      b.vy = randomf_range(-1 * SPEED, SPEED)
      @balls.push(b)
    end

    # Initialize the image resources.
    @duke = @dark_duke = Image.new(DUKE_IMG)
    @java_logo = Image.new(JAVA_IMG)
    @java_logo_x = BOARD_X - @java_logo.get_width - 5
    @java_logo_y = 5
  end

  # Draws stuff.
  def render(container, g)
    init_time = container.get_time
    g.set_anti_alias(true)

    # Draw the colorful gradient.
    # SLOW!!! (removed).
    '''
    BOARD_Y.times do |i|
      g.draw_gradient_line(0, i, Color::blue.darker(GRAD_DARK), \
        BOARD_X, i, Color::magenta.darker(GRAD_DARK))
    end
    '''

    # This should be OK for now.
    g.set_background(Color::blue.darker(GRAD_DARK))

    # Draw the balls.
    # TODO: Redo handling for the duke and the dark duke.
    @balls.each do |b|
      if @balls.index(b) > @balls.size - 3
        if @balls.index(b) == @balls.size - 1
          g.draw_image(@duke, b.x, b.y)
        else
          @dark_duke.draw_flash(b.x, b.y, @dark_duke.get_width, \
            @dark_duke.get_height, Color::black)
        end
      else
        circle = Circle.new(b.x, b.y, b.bsize / 2)
        g.set_color(b.color)
        g.fill(circle)
      end
    end

    # Print text.
    g.set_color(Color::green)
    g.draw_string('Boing!', 5, 5)
    g.set_color(Color::yellow)
    g.draw_string('by Whackatre', 5, 25)

    # Draw the Java logo.
    # TODO: Add a Ruby logo since this
    # is now programmed in mostly Ruby? :P
    g.draw_image(@java_logo, @java_logo_x, @java_logo_y)

    # Draw memory-related details.
    g.set_color(Color::white)
    mem = @runtime.free_memory
    total = @runtime.total_memory

    g.draw_string('Memory Used: ' + ((total - mem) / 1024).to_s + 'K', 5, 55)
    g.draw_string('Total Mem: ' + (total / 1024).to_s + 'K', 5, 75)

    # How slow is this?
    g.draw_string('Draw Time: ' + (container.get_time - init_time).to_s, 5, 95)
  end

  # Handles logic.
  def update(container, delta)
    @balls.each do |b|

      # Don't bother if the ball is stuck.
      next if b.stuck

      # Move the ball.
      b.x += b.vx
      b.y += b.vy

      # Check boundaries.
      b.x = 0 and b.vx *= -1 if b.x < 0
      b.y = 0 and b.vy *= -1 if b.y < 0
      b.x = BOARD_X and b.vx *= -1 if b.x > BOARD_X
      b.y = BOARD_Y and b.vy *= -1 if b.y > BOARD_Y
      b.vy += GRAVITY if b.vy.abs > 0
    end
  end

  # Handle mouse clicks.
  # Note: Must be camelCase and not snake_case for some reason.
  def mouseClicked(button, x, y, count)
    # Reverse everything if the user clicked the Java cup!
    if x > @java_logo_x && x < @java_logo_x + @java_logo.get_width \
      && y > @java_logo_y && y < @java_logo_y + @java_logo.get_height
      @balls.each do |b|
        b.vx *= -1
        b.vy *= -1
      end
      return
    end

    # If not, reinit the game container.
    # TODO: Use the proper reinit method?
    @balls = []
    init(@container)
    @balls.each do |b|
      b.x = x
      b.y = y
    end
  end

  # Returns a random opaque color.
  def random_color
    return Color.new(random(COL_DEP), random(COL_DEP), random(COL_DEP), 255)
  end

end

# The main class which does the actual launching.

class Main

  # Starts the application.
  def start_app
    container = AppGameContainer.new(Boing.new(NAME), BOARD_X, BOARD_Y, false)
    container.set_always_render(true)
    container.set_show_fps(false)
    container.set_target_frame_rate(TARGET_FPS)
    container.set_vsync(true)
    container.start
  end
end

Main.new.start_app

