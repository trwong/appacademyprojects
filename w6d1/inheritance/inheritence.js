// Function.prototype.inherits = function(parent) {
//   function Surrogate() {}
//   Surrogate.prototype = parent.prototype;
//   this.prototype = new Surrogate();
//   this.prototype.constructor = this;
// };

Function.prototype.inherits = function(parent) {
  this.prototype = Object.create(parent.prototype);
  this.prototype.constructor = this;
};

function MovingObject () {}

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);

MovingObject.prototype.move = function() {
  console.log("I'm moving (movingobject)");
};


let m = new MovingObject;
let s = new Ship;
let a = new Asteroid;
m.move();
s.move();
a.move();

Ship.prototype.ship = function() {
  console.log("Imma ship!");
};

s.ship();
// m.ship();
// a.ship();
