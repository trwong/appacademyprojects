function MovingObject(options) {
  this.pos = options['pos'];
  this.vel  = options['vel'];
  this.radius = options['radius'];
  this.color = options['color'];
  this.game = options['game'];
}

MovingObject.prototype.draw = function(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();
  ctx.arc(
    this.pos[0], // CHECK HERE FOR ISSUES WITH X, Y COORDS
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );
  ctx.fill();
};

MovingObject.prototype.move = function() {
  this.pos[0] += this.vel[0]; // CHECK HERE FOR ISSUES WITH X, Y COORDS
  this.pos[1] += this.vel[1];
  this.pos = this.game.wrap(this.pos);
};

MovingObject.prototype.isCollidedWith = function(otherObject) {
  //Dist between formula
  //Dist([x_1, y_1], [x_2, y_2]) = sqrt((x_1 - x_2) ** 2 + (y_1 - y_2) ** 2)

  let xDiff = this.pos[0] - otherObject.pos[0];
  let yDiff = this.pos[1] - otherObject.pos[1];
  let distance = Math.sqrt(Math.pow(xDiff, 2) + Math.pow(yDiff, 2));
  if (distance < this.radius + otherObject.radius) {
    return true;
  }
  return false;
};

module.exports = MovingObject;
