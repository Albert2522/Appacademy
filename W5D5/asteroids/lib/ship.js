const Utils = require('./utils');
const MovingObject = require('./moving_object');

function Ship (){
  let hash = {};
  hash.radius = 10;
  hash.color = "green";
  hash.pos = [300,250];
  hash.vel = [0,0];
  MovingObject.call(this, hash);
}

Ship.prototype.relocate = function () {
  this.pos = [300,250];
};
Ship.prototype.power = function (impulse) {
  alert("FFF");
  this.vel[0] = impulse[0];
  this.vel[1] = impulse[1];
  this.move();
};

Utils.inherits(Ship, MovingObject);

module.exports = Ship;
