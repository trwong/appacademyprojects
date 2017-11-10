const MovingObject = require('./moving_object.js');
const Asteroid = require('./asteroid.js');

const DIM_X = 500;
const DIM_Y = 500;
const NUM_ASTEROIDS = 4;

function Game() {
  this.asteroids = [];
  while (this.asteroids.length < NUM_ASTEROIDS) {
    this.asteroids.push(this.addAsteroids());
  }
}

Game.prototype.addAsteroids = function() {
  return new Asteroid(this.randomPosition(), this);
};

Game.prototype.randomPosition = function() {
  var x = Math.random() * DIM_X;
  var y = Math.random() * DIM_Y;
  return [x, y];
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, DIM_X, DIM_Y);
  // console.log(this.asteroids[0].pos);

  this.asteroids.forEach(function(el) {
    el.draw(ctx);
  });
};

Game.prototype.moveObjects = function(ctx) {
  this.asteroids.forEach(function(el) {
    el.move();
  });
};

Game.prototype.wrap = function(pos) {
  if (pos[0] > DIM_X) {
    pos[0] = 1;
  }
  else if (pos[0] < 0) {
    pos[0] = DIM_X - 1;
  }
  if (pos[1] > DIM_Y) {
    pos[1] = 1;
  }
  else if (pos[1] < 0) {
    pos[1] = DIM_Y - 1;
  }
  return pos;
};

Game.prototype.checkCollisions = function() {
  for (let i = 0; i < this.asteroids.length; i++) {
    for (let j = 0; j < this.asteroids.length; j++) {
      if (i === j) continue;
      if (this.asteroids[i].isCollidedWith(this.asteroids[j])) {
        alert("Collision!");
      }
    }
  }
};

Game.prototype.step = function(ctx) {
  this.moveObjects(ctx);
  this.checkCollisions();
};

Game.prototype.remove = function(asteroid) {
  for (let i = 0; i < this.asteroids.length; i++) {
    if (this.asteroids[i].pos[0] === asteroid.pos[0] && this.asteroids[i].pos[1] === asteroid.pos[1]) {
      this.asteroids.splice(i, 1);
    }
  }
};

module.exports = Game;
