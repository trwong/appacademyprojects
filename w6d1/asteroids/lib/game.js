const MovingObject = require('./moving_object.js');
const Asteroid = require('./asteroid.js');

const DIM_X = 500;
const DIM_Y = 500;
const NUM_ASTEROIDS = 10;

function Game() {
  this.asteroids = [];
  while (this.asteroids.length < NUM_ASTEROIDS) {
    this.asteroids.push(this.addAsteroids());
  }
}

Game.prototype.addAsteroids = function() {
  let x = this.randomPosition();
  let y = this.randomPosition();
  // console.log("type of rand", randPos[0]);
  // console.log(randPos);
  let z = new Asteroid(x, y);
  // console.log(x);

  return z;
};

Game.prototype.randomPosition = function() {
  var x = Math.floor(Math.random() * DIM_X);
  return x;
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
  
};

module.exports = Game;
