function MovingObject(options) {
  this.posx = options['posx'];
  this.posy = options['posy'];
  this.vel  = options['vel'];
  this.radius = options['radius'];
  this.color = 'black';
}

MovingObject.prototype.draw = function(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();
  ctx.arc(
    this.posx, // CHECK HERE FOR ISSUES WITH X, Y COORDS
    this.posy,
    this.radius,
    0,
    2 * Math.PI,
    false
  );
  ctx.fill();
};

MovingObject.prototype.move = function() {
  this.posx += this.vel[0]; // CHECK HERE FOR ISSUES WITH X, Y COORDS
  this.posy += this.vel[1];
};

module.exports = MovingObject;
