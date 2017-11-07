const Util = require('./util.js');
const MovingObject = require('./moving_object.js');

function Asteroid (posx, posy, COLOR = 'gray', RADIUS = 5) {
  let options = {
    color: COLOR,
    radius: RADIUS,
    posx: posx,
    posy: posy,
    vel: Util.randomVec(5)
  };
  MovingObject.call(this, options);
}

Util.inherits(Asteroid, MovingObject);




module.exports = Asteroid;
