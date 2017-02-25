/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	__webpack_require__(3);
	__webpack_require__(4);
	__webpack_require__(5);
	__webpack_require__(6);
	__webpack_require__(7);
	__webpack_require__(8);
	module.exports = __webpack_require__(2);


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(2);
	const MovingObject = __webpack_require__(7);

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


/***/ },
/* 2 */
/***/ function(module, exports) {

	const Util = {
	  inherits (childClass, parentClass) {
	    function Surrogate() {}
	    Surrogate.prototype = parentClass.prototype;
	    childClass.prototype = new Surrogate();
	    childClass.prototype.constructor = childClass;
	  },

	  scale (vec, m) {
	    return [vec[0] * m, vec[1] * m];
	  }
	};

	module.exports = Util;


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const GameView = __webpack_require__(6);

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


/***/ },
/* 4 */
/***/ function(module, exports) {

	

/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	const Asteroid = __webpack_require__(1);
	const Ship = __webpack_require__(8);

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


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	const Game = __webpack_require__(5);

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


/***/ },
/* 7 */
/***/ function(module, exports) {

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


/***/ },
/* 8 */
/***/ function(module, exports, __webpack_require__) {

	const Utils = __webpack_require__(2);
	const MovingObject = __webpack_require__(7);

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


/***/ }
/******/ ]);