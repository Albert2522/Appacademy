
function sum(...args){
  return args.reduce( (acc, el) => {
    return acc + el;
  });
}

// console.log(sum(1, 2, 3, 4));
// console.log(sum(1, 2, 3, 4, 5));

Function.prototype.myBind = function (context, ...bindArgs) {
  return (...allArgs) => {
    this.apply(context, bindArgs.concat(allArgs));
  };
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

markov.says("meow", "Ned");
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(breakfast, "meow", "Kush")();
// Breakfast says meow to Kush!
// true

markov.says.myBind(breakfast)("meow", "a tree");
