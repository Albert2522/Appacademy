const Util = require("./utils");
const MovingObject = require("./moving_object");

function randomVec (length) {
  const deg = 2 * Math.PI * Math.random();
  return Util.scale([Math.sin(deg), Math.cos(deg)], length);
}
// Scale the length of a vector by the given amount.

function Asteroid(hash) {
  hash["radius"] = 10;
  hash["color"] = "red";
  hash["vel"] = randomVec(5);
  MovingObject.call(this, hash);
}

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;
