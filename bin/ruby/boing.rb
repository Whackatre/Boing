require 'java'
require './lib/lwjgl.jar'
require './lib/slick.jar'

java_import 'org.newdawn.slick.AppGameContainer'
java_import 'org.newdawn.slick.BasicGame'
java_import 'org.newdawn.slick.Color'
java_import 'org.newdawn.slick.GameContainer'
java_import 'org.newdawn.slick.Graphics'
java_import 'org.newdawn.slick.Image'
java_import 'org.newdawn.slick.SlickException'

class Boing < BasicGame

	def initialize(name)
		super(name)
		puts 'Boing is starting..'
	end

	def init(container)
	end

	def render(container, g)
		g.set_background(Color::green)
	end

	def update(container, delta)
	end

end

class Main
	def start_game
		container = AppGameContainer.new(Boing.new('Boing'), 512, 512, false)
		container.set_always_render(true)
		container.set_show_fps(false)
		container.set_target_frame_rate(60)
		container.set_vsync(true)
		container.start
	end
end

Main.new.start_game




