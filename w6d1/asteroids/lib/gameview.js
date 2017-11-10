const Game = require('./game.js');
// const Ship = require('./ship.js');

function GameView(ctx) {
  this.game = new Game();
  this.ctx = ctx;
}

GameView.prototype.start = function() {
  setInterval(this.game.step.bind(this.game, this.ctx), 20);
  setInterval(this.game.draw.bind(this.game, this.ctx), 20);
};

module.exports = GameView;
