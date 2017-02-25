const Game = require("./game");

function GameView(ctx) {
  this.game = new Game();
  this.ctx = ctx;
}

GameView.prototype.start = function () {
  this.bindKeyHandlers();
  setInterval( () => {
    this.game.step();
    this.game.wrap();
    this.game.draw(this.ctx);
  }, 20);
};

GameView.prototype.bindKeyHandlers = function () {
  key('up', function(){ this.game.ship.power([0, -1]); });
  key('down', function(){ this.game.ship.power([0, 1]) });
  key('left', function(){ this.game.ship.power([-1, 0]) });
  key('right', function(){ this.game.ship.power([1, 0]) });
  // key('space', function(){ this.game.ship.power([0, 1]) });
};

module.exports = GameView;
