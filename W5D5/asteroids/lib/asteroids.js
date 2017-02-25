const GameView = require('./game_view');

// document.addEventListener("DOMContentLoaded", function(event) {
//   const c = document.getElementById("game-canvas").getContext("2d");
//
//   const g = new GameView(c);
//   g.start();
// });

const c = document.getElementById("game-canvas").getContext("2d");

const g = new GameView(c);
g.start();
console.log(g.game);
