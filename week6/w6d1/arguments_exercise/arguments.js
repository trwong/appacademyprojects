// function sum() {
//   let args = Array.from(arguments);
//
//   return args.reduce(function(total, currentValue) {
//     return total + currentValue;
//   });
// }
//
// //console.log(sum(1,2,3,4));
//
// function restsum(...args) {
//   return args.reduce(function(total, currentValue) {
//     return total + currentValue;
//   });
// }
//
// //console.log(restsum(1,2,3,4));
//
//
// class Cat {
//   constructor(name) {
//     this.name = name;
//   }
//
//   says(sound, person) {
//     console.log(`${this.name} says ${sound} to ${person}!`);
//     return true;
//   }
// }
//
// // Function.prototype.myBind = function () {
// //   let bindargs = Array.from(arguments);
// //   let ctx = bindargs.shift();
// //   return (...callargs) => {
// //     return this.apply(ctx, bindargs.concat(callargs));
// //   };
// // };
// Function.prototype.myBind = function (...bindargs) {
//   let ctx = bindargs.shift();
//   return (...callargs) => {
//     return this.apply(ctx, bindargs.concat(callargs));
//   };
// };
//
// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");
//
// markov.says("meow", "Ned");
// // Markov says meow to Ned!
// // true
//
// // bind time args are "meow" and "Kush", no call time args
// markov.says.myBind(breakfast, "meow", "Kush")();
// // Breakfast says meow to Kush!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// markov.says.myBind(breakfast)("meow", "a tree");
// // Breakfast says meow to a tree!
// // true
//
// // bind time arg is "meow", call time arg is "Markov"
// markov.says.myBind(breakfast, "meow")("Markov");
// // Breakfast says meow to Markov!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");
// // Breakfast says meow to me!
// // true

// function curriedSum(numArgs) {
//   let numbers = [];
//   return function _curriedSum(num) {
//     numbers.push(num);
//     if (numbers.length === numArgs) {
//       return numbers.reduce(function(total, el) {
//         return total + el;
//       });
//     }
//     else {
//       return _curriedSum;
//     }
//   };
// }
//
// let sum = curriedSum(3);
// console.log(sum);
//
// sum = sum(1);
// console.log(sum);
//
// sum = sum(2);
// console.log(sum);
//
// sum = sum(3);
// console.log(sum);

Function.prototype.curry = function(numArgs) {
  let args = [];
  let that = this;
  return function _curry(arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return that.apply(that,args);
    }
    else {
      return _curry;
    }
  };
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

console.log(sumThree.curry(3)(4)(20)(6)); // == 30
