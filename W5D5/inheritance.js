Function.prototype.inherits = function(parent) {
  function Surrogate(){
  }

  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject () {}

function Ship () {}
// Ship.inherits(MovingObject);

function Asteroid () {
  MovingObject.call(this);
}
Asteroid.prototype = Object.create(MovingObject.prototype);
Asteroid.prototype.constructor = Asteroid;
// Asteroid.inherits(MovingObject);

Asteroid.prototype.move = function() {
  console.log("ship moves");
};

const a = new Asteroid();
const s = new Ship();
const m = new MovingObject();

s.move();
a.move();
m.move();
