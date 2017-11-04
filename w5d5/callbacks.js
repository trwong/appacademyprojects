console.reset = function () {
return process.stdout.write('\033c');
}

class Clock {
  constructor() {
    // 1. Create a Date object.
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.
    var date = new Date();
    this.hours = date.getHours();
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();
    this.printTime();
    setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
  }

  _tick() {
    // 1. Increment the time by one second.
    // 2. Call printTime.
    console.reset

    this.seconds += 1;
    if (this.seconds >= 60) {
      this.minutes += 1;
      this.seconds -= 60;
    }
    if (this.minutes >= 60) {
      this.hours += 1;
      this.minutes -= 60;
    }
    if (this.hours >= 24) {
      this.hours -= 24;
    }
    this.printTime();
  }
}

// const clock = new Clock();

const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function addNumbers(sum = 0, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Pick a number: ", function(user_input) {
      sum += parseInt(user_input, 10);
      console.log(sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    })
  } else if (numsLeft === 0) {
    completionCallback(sum)
    reader.close()
  }
}

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));




// Write this first.
function askIfGreaterThan(el1, el2, callback) {
  // Prompt user to tell us whether el1 > el2; pass true back to the
  // callback if true; else false.
  reader.question(`Is ${el1} greater than ${el2}? `, function(answer) {
    if (answer === "yes") {
      callback(true)
    } else {
      callback(false)
    }
    // reader.close();
  });
}

// Once you're done testing askIfGreaterThan with dummy arguments, write this.
function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  // Do an "async loop":
  // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
  //    know whether any swap was made.
  // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
  //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
  //    continue the inner loop. You'll want to increment i for the
  //    next call, and possibly switch madeAnySwaps if you did swap.
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i + 1], function(isGreaterThan) {
      if (isGreaterThan) {
        [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop)
    });
  // console.log(i);

  } else {
      outerBubbleSortLoop(madeAnySwaps);
  }
};

// console.log(innerBubbleSortLoop([5,4,3,2,1], 0, false));

// Once you're done testing innerBubbleSortLoop, write outerBubbleSortLoop.
// Once you're done testing outerBubbleSortLoop, write absurdBubbleSort.

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    // Begin an inner loop if you made any swaps. Otherwise, call
    // `sortCompletionCallback`.
    console.log('in outer loop');
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
outerBubbleSortLoop(true);
  // Kick the first outer loop off, starting `madeAnySwaps` as true.
}

// absurdBubbleSort([3, 2, 1], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
//   reader.close();
// });

function myBind(scope) {
  
}



class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function() {
   console.log("Turning on " + this.name);
}

const lamp = new Lamp();

turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
// const myBoundTurnOn = turnOn.myBind(lamp);

boundTurnOn(); // should say "Turning on a lamp"
// myBoundTurnOn(); // should say "Turning on a lamp"
