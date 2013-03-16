/*
 * Boing! - HTML5/Canvas Version
 * by Justin Z
 */

// Constants.
var amtOfBalls = 24;
var ballSize = 32;
var gravity = 0.166;
var defaultSpeed = 6;
var colorDepthMin = 105;
var colorDepthMax = 245;
var trans = 0.9;

// Canvas variables.
var c = document.getElementById("ballCanvas");
var ctx = c.getContext("2d");

// The ball class.
function Ball(color, radius) {
	this.color = color;
	this.radius = radius;
	this.x = c.width / 2;
	this.y = c.height / 2;
	this.vx = 0;
	this.vy = 0;
}

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
	var rest = this.slice((to || from) + 1 || this.length);
	this.length = from < 0 ? this.length + from : from;
	return this.push.apply(this, rest);
};

Array.prototype.contains = function(obj) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == obj) {
			return true;
		}
	}
	return false;
}

Ball.prototype.isTouching = function(other) {
	var distX = Math.abs(this.x - other.x);
	var distY = Math.abs(this.y - other.y);
	return distX < ballSize && distY < ballSize;
}

// Initializes the balls.
function initBalls(balls) {
	for (var i = 0; i < amtOfBalls; i++) {
		balls[i] = new Ball(randColor(trans), ballSize);
		balls[i].vx = randFloat(-1 * defaultSpeed, defaultSpeed);
		balls[i].vy = randFloat(-1 * defaultSpeed, defaultSpeed);
	}
}

function randInt(min, max) {
	return Math.floor(Math.random() * (max - min + 1) + min);
}

function randFloat(min, max) {
	return Math.random() * (max - min + 1) + min;
}

function randColor(trans) {
	var red = randInt(colorDepthMin, colorDepthMax);
	var green = randInt(colorDepthMin, colorDepthMax);
	var blue = randInt(colorDepthMin, colorDepthMax);
	return "rgba(" + red + ", " + green + ", " + blue + ", " + trans + ")";
}

// Instance variables.
var balls = new Array();

// var bouncingBalls = new Array();

window.requestAnimFrame = (function(callback) {
	return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame;
})();

initBalls(balls);

// Updates anim/game logic.
function update() {
	// var newBouncingBalls = [];
	for (var i = 0; i < balls.length; i++) {
		balls[i].x += balls[i].vx;
		balls[i].y += balls[i].vy;
		if (balls[i].x < 0 + ballSize) {
			balls[i].x = 0 + ballSize;
			balls[i].vx *= -1;
		}
		if (balls[i].y < 0) {
			balls[i].y = 0;
			balls[i].vy *= -1;
		}
		if (balls[i].x > c.width - ballSize) {
			balls[i].x = c.width - ballSize;
			balls[i].vx *= -1;
		}
		if (balls[i].y > c.height - ballSize) {
			balls[i].y = c.height - ballSize;
			balls[i].vy *= -1;
		}
		if (Math.abs(balls[i].vy) > 0) {
			balls[i].vy += gravity;
		}
		/*
		for (var j = 0; j < balls.length; j++) {
			if (i == j) {
				break;
			}
			if (balls[i].isTouching(balls[j])) {
				newBouncingBalls.push([balls[i], balls[j]]);
			}
		}
		*/
	}
	/*
	for (var i = 0; i < bouncingBalls.length; i++) {
		if (bouncingBalls.contains(newBouncingBalls[i])) {
			balls[bouncingBalls[i][0]].vx *= -1;
			balls[bouncingBalls[i][0]].vy *= -1;
			balls[bouncingBalls[i][1]].vx *= -1;
			balls[bouncingBalls[i][1]].vy *= -1;
			bouncingBalls.remove(bouncingBalls[i]);
		} else {
			bouncingBalls.push([balls[i], balls[j]]);
		}
	}
	*/
}

// The animation loop.
function animate() {
	// Update.
	update();

	// Clear the screen.
	ctx.clearRect(0, 0, c.width, c.height);

	// Draw borders.
	ctx.strokeStyle = "black";
	ctx.strokeRect(0, 0, c.width, c.height);

	// Draw background.
	ctx.fillStyle = "rgb(0, 0, 50)";
	ctx.fillRect(0, 0, c.width, c.height);

	for (var i = 0; i < balls.length; i++) {
		ctx.fillStyle = balls[i].color;
		ctx.beginPath();
		ctx.arc(balls[i].x, balls[i].y, ballSize, 0, Math.PI * 2);
		// ctx.fillRect(balls[i].x, balls[i].y, ballSize, ballSize);
		ctx.fill();
	}

	ctx.fillStyle = "yellow";
	ctx.font = "24px Helvetica";
	ctx.fillText("Boing! - HTML5", 10, 30);
	ctx.fillText("by Whackatre", 10, 70);

	requestAnimFrame(function() {
		animate();
	});
}
animate();