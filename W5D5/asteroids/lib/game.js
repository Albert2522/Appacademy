const Asteroid = require('./asteroid');
const Ship = require('./ship');

function randomPosition() {
  let pos1 = Math.round((Math.random() * 1000000) % 300);
  let pos2 = Math.round((Math.random() * 1000000) % 500);
  return { pos: [pos1, pos2]};
}

function Game() {
  const DIM_X = 300;
  const DIM_Y = 500;
  const NUM_ASTEROIDS = 10;
  this.asteroids = [ ];

  this.addAsteroids = function () {
    for (let i = 0; i < NUM_ASTEROIDS; i++) {
      console.log(randomPosition());
      this.asteroids.push(new Asteroid(randomPosition()));
    }
  };
  this.ship = new Ship();
  this.addAsteroids();
}

Game.prototype.step = function step() {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.checkCollisions = function () {
  for (var i = 0; i < this.asteroids.length; i++) {
    // this.ship.isCollidedWith(this.asteroids[i]);
    for (var j = i; j < this.asteroids.length; j++) {
      if (this.asteroids[i].isCollidedWith(this.asteroids[j]) && i != j) {
        this.collide_asteroids(this.asteroids[i], this.asteroids[j]);
      }
    }
  }
};

Game.prototype.wrap = function() {
  this.asteroids.forEach( function(asteroid) {
    if(asteroid.pos[0] <= 0) {
      asteroid.pos[0] = 0;
      asteroid.vel[0] *= -1;
    } else if (asteroid.pos[0] >= 500) {
      asteroid.pos[0] = 500;
      asteroid.vel[0] *= -1;
    }
    if(asteroid.pos[1] <= 0) {
      asteroid.pos[1] = 0;
      asteroid.vel[1] *= -1;
    } else if (asteroid.pos[1] >= 300) {
      asteroid.pos[1] = 300;
      asteroid.vel[1] *= -1;
    }

  });
};

Game.prototype.remove_aster = function (asteroid) {
  let ind = this.asteroids.indexOf(asteroid);
  this.asteroids.splice(ind, ind + 1);
};

Game.prototype.collide_asteroids = function(ast1, ast2) {
    if ( (ast1 instanceof Asteroid) && (ast2 instanceof Asteroid) ) {
      ast1.vel[0] *= -1;
      ast1.vel[1] *= -1;
      ast2.vel[0] *= -1;
      ast2.vel[1] *= -1;
    }
    else {
      if (ast1 instanceof Asteroid) {
        this.remove_aster(ast1);
        ast2.relocate();
      } else {
        this.remove_aster(ast2);
        ast1.relocate();
      }
    }
};



Game.prototype.draw = function (ctx) {
  ctx.clearRect(0, 0, 500, 300);
  this.ship.draw(ctx);
  this.asteroids.forEach(  (el) => el.draw(ctx));
};

Game.prototype.moveObjects = function () {
  this.asteroids.forEach( (el) => el.move());
};

module.exports = Game;
