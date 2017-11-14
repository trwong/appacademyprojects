const Util = require('./util.js');
const MovingObject = require('./moving_object.js');

function Asteroid (pos, game, COLOR = 'gray', RADIUS = 20) {
  let options = {
    game: game,
    color: COLOR,
    radius: RADIUS,
    pos: pos,
    vel: Util.randomVec(3)
  };
  MovingObject.call(this, options);
}

Util.inherits(Asteroid, MovingObject);




module.exports = Asteroid;
