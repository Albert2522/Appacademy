function curriedSum(numberArgs) {
  let numbers = [ ];
  function _curriedSum(number) {
    numbers.push(number);
    if (numbers.length === numberArgs) {
      let answer = numbers.reduce( (acc, el) => acc + el );
      console.log(answer);
      return;
    }
    else
      return _curriedSum;
  }
  return _curriedSum;
}




Function.prototype.curry = function (numArgs) {
  let args = [];
  function _curriedArgs(arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return Function.prototype.curry.call(this, 0, ...args);
    }
    else
      return _curriedArgs;
  }
  if (numArgs === 0) {
    let args1 = Array.from(arguments);
    let sum = 0;
    for (let i = 1; i < args1.length; i++)
      sum += args1[i];
    console.log(sum);
    return;
  }else {
    return _curriedArgs;
  }
};

const sum = Function.prototype.curry(4);
sum(5)(30)(20)(1);
