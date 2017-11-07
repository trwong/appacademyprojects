import _ from 'lodash';

const GameView = require('./gameview.js');

document.addEventListener("DOMContentLoaded", function() {
  const canvasEl = document.getElementById("game-canvas");

  const ctx = canvasEl.getContext("2d");
  let gameViewEl = new GameView(ctx);
  gameViewEl.start();

});
