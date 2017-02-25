function MovingObject(optHash) {
  this.pos = optHash["pos"];
  this.vel = optHash["vel"];
  this.radius = optHash["radius"];
  this.color = optHash["color"];
}

MovingObject.prototype.draw = function(ctx) {
  ctx.beginPath();
  ctx.arc(this.pos[0], this.pos[1],this.radius,50,0,2*Math.PI);
  ctx.fillStyle = this.color;
  ctx.fill();
};

MovingObject.prototype.move = function () {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

const mo = new MovingObject(
  { pos: [30, 30], vel: [10, 10], radius: 5, color: "#00FF00"}
);

MovingObject.prototype.isCollidedWith = function (otherObject) {
  let xSquare = Math.pow((otherObject.pos[0] - this.pos[0]), 2);
  let ySquare = Math.pow((otherObject.pos[1] - this.pos[1]), 2);

  let hypotenuse = Math.sqrt(xSquare + ySquare);
  return (hypotenuse < (this.radius + otherObject.radius));
};

module.exports = MovingObject;
