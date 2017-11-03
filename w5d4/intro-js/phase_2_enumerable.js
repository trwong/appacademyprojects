const NUMS = [1, 2, 3, 4, 5];

Array.prototype.myEach = function(callBack) {
  for (let i = 0; i < this.length; i++) {
    callBack(this[i]);
  }
}

// NUMS.myEach(function(el) {
//   console.log(el);
// })


Array.prototype.myMap = function(callBack) {
  var result = []
  this.myEach(function(el) {
    result.push(callBack(el))
  })
  console.log(result)
  return result
}


// NUMS.myMap(function(el) {
//   return el * 2
// })

Array.prototype.myReduce = function (callBack, initialValue) {
  let acc = this[0]
  let startIndex = 1
  if (initialValue) {
    acc = initialValue
    startIndex = 0
  }
  for (let i = startIndex; i < this.length; i++) {
    acc = callBack(acc, this[i])
  }
  console.log(acc)
  return acc
}

NUMS.myReduce(function(acc, el) {
  return acc + el
}, 5)
