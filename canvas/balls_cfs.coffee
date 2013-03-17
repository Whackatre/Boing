'''
Boing! - Coffeescript Version
by Justin Z
'''

amtOfBalls = 24
ballSize = 32
gravity = 0.166
defaultSpeed = 6
colorDepthMin = 105
colorDepthMax = 245
trans = 0.9

c = document.getElementById 'ballCanvas'
ctx = c.getContext '2d'

class Ball
	constructor: (@color, @radius) ->
		@x = c.width / 2
		@y = c.height / 2
		@vx = 0
		@vy = 0

initBalls = (balls) ->
	for i in [0..amtOfBalls]
		b = new Ball randColor trans, ballSize
		b.vx = randFloat -1 * defaultSpeed, defaultSpeed
		b.vy = randFloat -1 * defaultSpeed, defaultSpeed
		balls[i] = b

randInt = (min, max) ->
	Math.floor(Math.random() * (max - min + 1) + min)

randFloat = (min, max) ->
	Math.random() * (max - min + 1) + min

randColor = (trans) ->
	red = randInt colorDepthMin, colorDepthMax
	green = randInt colorDepthMin, colorDepthMax
	blue = randInt colorDepthMin, colorDepthMax
	"rgba(#{red}, #{green}, #{blue}, #{trans})"

balls = new Array()

window.requestAnimFrame = ((callback) ->
	window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame
)()

initBalls balls

update = ->
	for b, i in balls
		b.x += b.vx
		b.y += b.vy
		if b.x < 0 + ballSize
			b.x = 0 + ballSize
			b.vx *= -1
		if b.y < 0
			b.y = 0
			b.vy *= -1
		if b.x > c.width - ballSize
			b.x = c.width - ballSize
			b.vx *= -1
		if b.y > c.height - ballSize
			b.y  = c.height - ballSize
			b.vy *= -1
		b.vy += gravity if Math.abs(b.vy) > 0

animate = ->
	update()
	ctx.clearRect 0, 0, c.width, c.height
	ctx.strokeStyle = 'black'
	ctx.strokeRect 0, 0, c.width, c.height
	ctx.fillStyle = 'rgb(0, 0, 50)'
	ctx.fillRect 0, 0, c.width, c.height
	for b, i in balls
		ctx.fillStyle = b.color
		ctx.beginPath()
		ctx.arc b.x, b.y, ballSize, 0, Math.PI * 2
		ctx.fill()
	ctx.fillStyle = 'yellow'
	ctx.font = '24px Helvetica'
	ctx.fillText 'Boing! - Coffee', 10, 30
	ctx.fillText 'by Whackatre', 10, 70
	requestAnimFrame -> animate()

animate()